#include <iostream>
#include <list>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

static std::list<cv::Mat> mat_list;

typedef double pixel_t;

extern "C" {
  pixel_t *load_image(const char *path, int *width, int *height);
  pixel_t *opencv_gaussian(pixel_t *img, unsigned char mask_size, bool display);
  pixel_t *opencv_canny(const char *filename, pixel_t low_threshold, pixel_t high_threshold);
  void display_image(pixel_t *img, const char *title, bool wait);
  void write_image(pixel_t *img, const char *filename);
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
    img_mat.convertTo(img_mat, CV_64FC1);

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

pixel_t *opencv_canny(
  const char *filename,
  pixel_t low_threshold,
  pixel_t high_threshold 
) {
  cv::Mat img_mat, buffer;

  img_mat = cv::imread(filename, CV_LOAD_IMAGE_GRAYSCALE);

  if(img_mat.data != NULL) {
    buffer.create(img_mat.size(), img_mat.type());

    cv::GaussianBlur(img_mat, buffer, cv::Size(5, 5), 0, 0);
    cv::Canny(buffer, img_mat, low_threshold, high_threshold, 3, true);

    mat_list.push_back(img_mat);

    return img_mat.ptr<pixel_t>(0);
  }

  return NULL;
}

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
