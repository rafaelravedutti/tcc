#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

static cv::Mat img;

typedef int pixel_t;

extern "C" {
  pixel_t *load_image(const char *path, int *width, int *height);
  void display_image(const char *title);
  void release_images();
}

pixel_t *load_image(const char *path, int *width, int *height) {
  img = cv::imread(path, CV_LOAD_IMAGE_GRAYSCALE);

  *width = img.cols;
  *height = img.rows;

  return img.ptr<pixel_t>(0);
}

void display_image(const char *title) {
  cv::namedWindow(title, cv::WINDOW_NORMAL);
  cv::imshow(title, img);
  cv::waitKey(0);
}


void release_images() {

}
