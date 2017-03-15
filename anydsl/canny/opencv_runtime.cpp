#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

static cv::Mat img;

extern "C" {
  double *load_image(const char *path, int *width, int *height);
  void display_image(const char *title);
}

double *load_image(const char *path, int *width, int *height) {
  img = cv::imread(path, CV_LOAD_IMAGE_COLOR);
  //cvtColor(img, img, CV_BGR2GRAY);

  *width = img.cols;
  *height = img.rows;

  return (double *) img.data;
}

void display_image(const char *title) {
  cv::namedWindow(title, cv::WINDOW_NORMAL);
  cv::imshow(title, img);
  cv::waitKey(0);
}

void release_images() {

}
