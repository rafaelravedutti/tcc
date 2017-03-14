#include <stdio.h>
#include <stdlib.h>
//--
#include <opencv/cv.h>
#include <opencv/highgui.h>

/* Image allocation */
double *allocate_image_data(int width, int height) {
  if(width > 0 && height > 0) {
    return (double *) malloc(width * height * sizeof(double));
  }

  return NULL;
}

/* Image deallocation */
void free_image_data(double *data) {
  free(data);
}

/* Synthetical image printing */
void print_image_data(double *data, int width, int height) {
  unsigned int i, j;

  for(j = 0; j < height; ++j) {
    for(i = 0; i < width; ++i) {
      fprintf(stdout, "%.4f ", data[j * width + i]);
    }

    fprintf(stdout, "\n");;
  }

  fprintf(stdout, "\n");
}

/* Loads image from file */
double *load_image(const char *path, int *width, int *height) {
  CvMat *img;

  img = cvLoadImage(path);
  cvCvtColor(img, img, CV_64FC1);

  *width = img->cols;
  *height = img->rows;
  return img->data.db;
}

/* Displays image */
void display_image(const char *title, CvMat *img) {
  cvCvtColor(img, img, CV_8U);
  cvShowImage(title, img);
  cvWaitKey(0);
}
