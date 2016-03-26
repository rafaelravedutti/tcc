#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <sys/time.h>
#include <opencv2/opencv.hpp>
//---
#include "hipacc.hpp"

#ifndef BH_MODE
#  define BH_MODE           CLAMP
#endif

#define PIXEL_CAST(a)       (pixel_t)(a)
#define TMP_PIXEL_CAST(a)   (tmp_pixel_t)(a)

#define pixel_t             uchar
#define tmp_pixel_t         float

#define USE_LAMBDA

using namespace hipacc;

// Obtêm o timestamp
double time_ms () {
  struct timeval tv;
  gettimeofday (&tv, NULL);
  return ((double)(tv.tv_sec) * 1e+3 + (double)(tv.tv_usec) * 1e-3);
}

/* Kernel do filtro Sobel */
class SobelFilter : public Kernel<pixel_t> {
  private:
    Accessor<pixel_t> &input;
    Mask<float> &mask_x;
    Mask<float> &mask_y;

  public:
    SobelFilter(IterationSpace<pixel_t> &iter, Accessor<pixel_t> &input, Mask<float> &mask_x, Mask<float> &mask_y) : Kernel(iter), input(input), mask_x(mask_x), mask_y(mask_y) {
      add_accessor(&input);
    }

    #ifdef USE_LAMBDA

    void kernel() {
      float sum_x, sum_y;

      sum_x = PIXEL_CAST(convolve(mask_x, Reduce::SUM, [&] () -> float {
        return mask_x() * input(mask_x);
      }));

      sum_y = PIXEL_CAST(convolve(mask_y, Reduce::SUM, [&] () -> float {
        return mask_y() * input(mask_y);
      }));

      output() = PIXEL_CAST(sqrt(sum_x * sum_x + sum_y * sum_y));
    }

    #else

    void kernel() {
      const int anchor = SIZE >> 1;
      float sum_x = 0.0f, sum_y = 0.0f;

      for (int yf = -anchor; yf <= anchor; ++yf) {
        for (int xf = -anchor_x; xf <= anchor; ++xf) {
          sum_x += mask_x(xf, yf) * input(xf, yf);
        }
      }

      for (int yf = -anchor; yf <= anchor; ++yf) {
        for (int xf = -anchor; xf <= anchor; ++xf) {
          sum_y += mask_y(xf, yf) * input(xf, yf);
        }
      }

      output() = PIXEL_CAST(sqrt(sum_x * sum_x + sum_y * sum_y));
    }

    #endif
};

int main(int argc, const char *argv[]) {
    cv::Mat frame;                        /* Matriz OpenCV */
    std::string outputfn;                 /* Nome do arquivo resultado */
    std::vector<int> compression_params;  /* Vetor de parâmetros de compressão JPEG */
    float timing = 0;                     /* Tempo */
    unsigned int width, height;           /* Dimensões da imagem */

    /* Verifica parâmetros */
    if(argc < 2) {
      std::cerr << "Uso: " << argv[0] << " [imagem de entrada]" << std::endl;
      return 0;
    }

    /* Coeficientes de filtros */
    float filter_x[3][3] = {
      {-1,   0,   1},
      {-2,   0,   2},
      {-1,   0,   1}
    };

    float filter_y[3][3] = {
      {-1,  -2,  -1},
      { 0,   0,   0},
      { 1,   2,   1}
    };

    /* Carrega imagem do arquivo e converte-a para escala de cinza */
    frame = cv::imread(argv[1], CV_LOAD_IMAGE_COLOR);
    cvtColor(frame, frame, CV_BGR2GRAY);

    /* Define dimensões da imagem */
    width = frame.cols;
    height = frame.rows;

    /* Imagens de entrada e saída HIPACC */
    Image<pixel_t> input(width, height);
    Image<pixel_t> output(width, height);

    /* Atribui o buffer de entrada da imagem à imagem de entrada do HIPACC */
    input = frame.data;

    /* Define as máscaras usando as matrizes de coeficientes */
    Mask<float> mask_x(filter_x);
    Mask<float> mask_y(filter_y);

    /* Espaço de iteração da imagem de saída */
    IterationSpace<pixel_t> iter_out(output);

    /* Condições de fronteira da imagem */
    BoundaryCondition<pixel_t> cond(input, mask_x, Boundary::BH_MODE);
    Accessor<pixel_t> acc(cond);

    /* Especificação e execução do kernel */
    SobelFilter S(iter_out, acc, mask_x, mask_y);
    S.execute();

    /* Calcula tempo de execução */
    timing = hipacc_last_kernel_timing();

    /* Exibe resultados */
    std::cerr << "Timing: " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;

    /* Carrega o resultado da imagem HIPACC para a matriz OpenCV */
    frame.data = output.data();

    /* Gera o nome do arquivo de saída */
    outputfn = argv[1];
    outputfn = outputfn.substr(0, outputfn.find_last_of(".")) + "-filtered.jpg";

    /* Parâmetros de compressão/qualidade da imagem JPEG */
    compression_params.push_back(CV_IMWRITE_JPEG_QUALITY);
    compression_params.push_back(100);

    /* Escreve a imagem OpenCV */
    try {
      cv::imwrite(outputfn, frame, compression_params);
    } catch(std::runtime_error &ex) {
      std::cerr << "JPEG compression exception: " << ex.what() << std::endl;
      return 1;
    }

    /* Cria uma nova janela do OpenCV */
    cv::namedWindow("Result", cv::WINDOW_NORMAL);

    /* Exibe a imagem resultado na mesma */
    cv::imshow("Result", frame);

    /* Aguarda o usuário pressionar alguma tecla */
    cv::waitKey(0);

    fprintf(stdout, "Done!\n");
    return 0;
}
