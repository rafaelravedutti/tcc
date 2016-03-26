#include "hipacc_cu.hpp"

#include "cuSobelFilterS.cu"
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <sys/time.h>
#include <opencv2/opencv.hpp>
//---

#ifndef BH_MODE
#  define BH_MODE           CLAMP
#endif

#define PIXEL_CAST(a)       (pixel_t)(a)
#define TMP_PIXEL_CAST(a)   (tmp_pixel_t)(a)

#define pixel_t             uchar
#define tmp_pixel_t         float

#define USE_LAMBDA


// Obtêm o timestamp
double time_ms () {
  struct timeval tv;
  gettimeofday (&tv, NULL);
  return ((double)(tv.tv_sec) * 1e+3 + (double)(tv.tv_usec) * 1e-3);
}

/* Kernel do filtro Sobel */

int main(int argc, const char *argv[]) {
    hipaccInitCUDA();
    
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
    HipaccImage input = hipaccCreateMemory<uchar>(NULL, width, height, 256);
    HipaccImage output = hipaccCreateMemory<uchar>(NULL, width, height, 256);

    /* Atribui o buffer de entrada da imagem à imagem de entrada do HIPACC */
    hipaccWriteMemory(input, frame.data);

    /* Define as máscaras usando as matrizes de coeficientes */
    hipaccWriteSymbol<float>((const void *)&_constmask_xS, (float *)filter_x, 3, 3);
    hipaccWriteSymbol<float>((const void *)&_constmask_yS, (float *)filter_y, 3, 3);

    /* Espaço de iteração da imagem de saída */
    HipaccAccessor iter_out(output);

    /* Condições de fronteira da imagem */
    
    HipaccAccessor acc(input);

    /* Especificação e execução do kernel */
    
    hipacc_launch_info S_info0(1, 1, iter_out, 8, 1);
    dim3 block0(32, 1);
    dim3 grid0(hipaccCalcGridFromBlock(S_info0, block0));

    hipaccPrepareKernelLaunch(S_info0, block0);
    hipaccConfigureCall(grid0, block0);

    size_t offset0 = 0;
    cudaGetTextureReference(&_texinputSRef, &_texinputS);
    hipaccBindTexture<uchar>(Linear1D, _texinputSRef, acc.img);
    hipaccSetupArgument(&iter_out.img.mem, sizeof(uchar *), offset0);
    hipaccSetupArgument(&iter_out.width, sizeof(const int), offset0);
    hipaccSetupArgument(&iter_out.height, sizeof(const int), offset0);
    hipaccSetupArgument(&iter_out.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.width, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.height, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&S_info0.bh_start_left, sizeof(const int), offset0);
    hipaccSetupArgument(&S_info0.bh_start_right, sizeof(const int), offset0);
    hipaccSetupArgument(&S_info0.bh_start_top, sizeof(const int), offset0);
    hipaccSetupArgument(&S_info0.bh_start_bottom, sizeof(const int), offset0);
    hipaccSetupArgument(&S_info0.bh_fall_back, sizeof(const int), offset0);
    
    hipaccLaunchKernel((const void *)&cuSobelFilterSKernel, "cuSobelFilterSKernel", grid0, block0);

    /* Calcula tempo de execução */
    timing = hipacc_last_kernel_timing();

    /* Exibe resultados */
    std::cerr << "Timing: " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;

    /* Carrega o resultado da imagem HIPACC para a matriz OpenCV */
    frame.data = hipaccReadMemory<uchar>(output);

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
    hipaccReleaseMemory<uchar>(input);
    hipaccReleaseMemory<uchar>(output);
    return 0;
}
