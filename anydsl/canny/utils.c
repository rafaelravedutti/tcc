#include <stdio.h>
#include <stdlib.h>
//--
#include <opencv/cv.h>
#include <opencv/highgui.h>

typedef int pixel_t;

static struct cvmat_ptr *cvmat_ptr_list = NULL;

/* Double matrix allocation */
double *allocate_double_matrix(int width, int height) {
  if(width > 0 && height > 0) {
    return (double *) malloc(width * height * sizeof(double));
  }

  return NULL;
}

/* Double matrix deallocation */
void free_double_matrix(pixel_t *data) {
  free(data);
}

/* Image allocation */
pixel_t *allocate_image_data(int width, int height) {
  if(width > 0 && height > 0) {
    return (pixel_t *) malloc(width * height * sizeof(pixel_t));
  }

  return NULL;
}

/* Image deallocation */
void free_image_data(pixel_t *data) {
  free(data);
}

/* Synthetical image printing */
void print_image_data(pixel_t *data, int width, int height) {
  unsigned int i, j;

  for(j = 0; j < height; ++j) {
    for(i = 0; i < width; ++i) {
      fprintf(stdout, "%d ", data[j * width + i]);
    }

    fprintf(stdout, "\n");;
  }

  fprintf(stdout, "\n");
}

/* Integer printing */
void print_integer(int value) {
  fprintf(stdout, "%d\n", value);
}
