#include <stdio.h>
#include <stdlib.h>
#include <tgmath.h>

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
