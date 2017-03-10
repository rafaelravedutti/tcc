#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* Image allocation */
float *allocate_image_data(int width, int height) {
  if(width > 0 && height > 0) {
    return (float *) malloc(width * height * sizeof(float));
  }

  return NULL;
}

/* Image deallocation */
void free_image_data(float *data) {
  free(data);
}

/* Synthetical image printing */
void print_image_data(float *data, int width, int height) {
  unsigned int i, j;

  for(j = 0; j < height; ++j) {
    for(i = 0; i < width; ++i) {
      fprintf(stdout, "%.4f ", data[j * width + i]);
    }

    fprintf(stdout, "\n");;
  }

  fprintf(stdout, "\n");
}

/* Float sqrt */
float impala_sqrtf(float value) {
  return sqrtf(value);
}

/* Float atan2 */
float impala_atan2f(float y, float x) {
  return atan2f(y, x);
}
