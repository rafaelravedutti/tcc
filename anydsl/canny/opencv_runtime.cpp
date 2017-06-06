#include <iostream>
#include <list>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#ifdef DEVICE_TYPE_GPU
#include <opencv2/cudafilters.hpp>
#include <opencv2/cudaimgproc.hpp>
#endif

static std::list<cv::Mat> mat_list;

typedef float pixel_t;

extern "C" {
  pixel_t *load_image(const char *path, int *width, int *height);
  pixel_t *opencv_gaussian(pixel_t *img, unsigned char mask_size, bool display);
  pixel_t *opencv_sobel(pixel_t *img, int sx, int sy, int aperture_size, bool display);
  pixel_t *opencv_canny(const char *filename, pixel_t low_threshold, pixel_t high_threshold, double *opencv_time);
  void display_image(pixel_t *img, const char *title, bool wait);
  void write_image(pixel_t *img, const char *filename);

  double impala_time();
}

cv::Mat GetImageMat(pixel_t *img, int *found) {
  std::list<cv::Mat>::iterator mat;

  *found = 0;

  for(mat = mat_list.begin(); mat != mat_list.end(); ++mat) {
    if(mat->ptr<pixel_t>(0) == img) {
      *found = 1;
      return *mat;
    }
  }

  return *mat;
}

pixel_t *load_image(const char *path, int *width, int *height) {
  cv::Mat img_mat;

  img_mat = cv::imread(path, CV_LOAD_IMAGE_GRAYSCALE);

  if(img_mat.data != NULL) {
    img_mat.convertTo(img_mat, CV_32FC1);

    *width = img_mat.cols;
    *height = img_mat.rows;

    mat_list.push_back(img_mat);

    return img_mat.ptr<pixel_t>(0);
  }

  return NULL;
}

void write_image(pixel_t *img, const char *filename) {
  cv::Mat img_mat;
  std::vector<int> compression_params;
  int found;

  img_mat = GetImageMat(img, &found);

  if(found != 0) {
    compression_params.push_back(CV_IMWRITE_PNG_COMPRESSION);
    compression_params.push_back(9);
    cv::imwrite(filename, img_mat, compression_params);
  }
}

pixel_t *opencv_gaussian(pixel_t *img, unsigned char mask_size, bool display) {
  cv::Mat img_mat, buffer;
  int found;

  img_mat = GetImageMat(img, &found);

  if(found != 0) {
    buffer.create(img_mat.size(), img_mat.type());

    cv::GaussianBlur(img_mat, buffer, cv::Size(mask_size, mask_size), 0, 0);

    if(display) {
      cv::namedWindow("gaussian_result", cv::WINDOW_NORMAL);
      cv::imshow("gaussian_result", buffer);
    }

    mat_list.push_back(buffer);

    return buffer.ptr<pixel_t>(0);
  }

  return NULL;
}

pixel_t *opencv_sobel(pixel_t *img, int sx, int sy, int aperture_size, bool display) {
  cv::Mat img_mat, buffer;
  int found;

  img_mat = GetImageMat(img, &found);

  if(found != 0) {
    buffer.create(img_mat.size(), img_mat.type());

    cv::Sobel(img_mat, buffer, CV_64F, sx, sy, aperture_size, 1, 0, cv::BORDER_REPLICATE);

    if(display) {
      cv::namedWindow("sobel_result", cv::WINDOW_NORMAL);
      cv::imshow("sobel_result", buffer);
    }

    mat_list.push_back(buffer);

    return buffer.ptr<pixel_t>(0);
  }

  return NULL;
}

#ifdef DEVICE_TYPE_GPU

pixel_t *opencv_canny(
  const char *filename,
  pixel_t low_threshold,
  pixel_t high_threshold,
  double *opencv_time
) {
  cv::Mat img_mat;
  cv::cuda::GpuMat cuda_mat, result;
  cv::Ptr<cv::cuda::Filter> gaussian;
  cv::Ptr<cv::cuda::CannyEdgeDetector> canny_edg;

  img_mat = cv::imread(filename, CV_LOAD_IMAGE_GRAYSCALE);

  if(img_mat.data != NULL) {
    gaussian = cv::cuda::createGaussianFilter(
      img_mat.type(), img_mat.type(), cv::Size(5, 5), 1.1, 1.1
    );

    canny_edg = cv::cuda::createCannyEdgeDetector(
      low_threshold, high_threshold, 3, true
    );

    *opencv_time = impala_time();

    cuda_mat.upload(img_mat);
    gaussian->apply(cuda_mat, result);
    canny_edg->detect(result, cuda_mat);

    img_mat = cv::Mat(cuda_mat);
    mat_list.push_back(img_mat);

    cuda_mat.release();
    result.release();

    *opencv_time = impala_time() - *opencv_time;

    return img_mat.ptr<pixel_t>(0);
  }

  return NULL;
}

#else

pixel_t *opencv_canny(
  const char *filename,
  pixel_t low_threshold,
  pixel_t high_threshold,
  double *opencv_time
) {
  cv::Mat img_mat, buffer;

  img_mat = cv::imread(filename, CV_LOAD_IMAGE_GRAYSCALE);

  if(img_mat.data != NULL) {
    buffer.create(img_mat.size(), img_mat.type());

    *opencv_time = impala_time();

    cv::GaussianBlur(img_mat, buffer, cv::Size(5, 5), 0, 0);
    cv::Canny(buffer, img_mat, low_threshold, high_threshold, 3, true);

    *opencv_time = impala_time() - *opencv_time;

    mat_list.push_back(img_mat);

    return img_mat.ptr<pixel_t>(0);
  }

  return NULL;
}

#endif

void display_image(pixel_t *img, const char *title, bool wait) {
  cv::Mat img_mat;
  int found;

  img_mat = GetImageMat(img, &found);

  if(found != 0) {
    cv::namedWindow(title, cv::WINDOW_NORMAL);
    cv::imshow(title, img_mat);

    if(wait) {
      cv::waitKey(0);
    }
  }
}
