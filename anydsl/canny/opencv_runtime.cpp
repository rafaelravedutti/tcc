#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

static cv::Mat img;
static cv::Mat dest;

typedef int pixel_t;

extern "C" {
  pixel_t *load_image(const char *path, int *width, int *height);
  pixel_t *opencv_canny(unsigned char threshold, bool display);
  void display_image(const char *title);
  void release_images();
}

pixel_t *load_image(const char *path, int *width, int *height) {
  img = cv::imread(path, CV_LOAD_IMAGE_GRAYSCALE);

  *width = img.cols;
  *height = img.rows;

  return img.ptr<pixel_t>(0);
}

pixel_t *opencv_canny(unsigned char threshold, bool display) {
  dest.create(img.size(), img.type());

  cv::blur(img, dest, cv::Size(3,3));
  cv::Canny(dest, dest, threshold, threshold * 3, 3);

  if(display) {
    cv::namedWindow("canny_result", cv::WINDOW_NORMAL);
    cv::imshow("canny_result", dest);
    cv::waitKey(0);
  }

  return dest.ptr<pixel_t>(0);
}

void display_image(const char *title) {
  cv::namedWindow(title, cv::WINDOW_NORMAL);
  cv::imshow(title, img);
  cv::waitKey(0);
}
