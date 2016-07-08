#include <stdio.h>
#include <stdlib.h>

/* Image allocation */
int *allocate_image_data(int width, int height) {
  if(width > 0 && height > 0) {
    return (int *) malloc(width * height * sizeof(int));
  }

  return NULL;
}

/* Image deallocation */
void free_image_data(int *data) {
  free(data);
}

/* Synthetical image printing */
void print_image_data(int *data, int width, int height) {
  unsigned int i, j;

  for(j = 0; j < height; ++j) {
    for(i = 0; i < width; ++i) {
      fprintf(stdout, "%d ", data[j * width + i]);
    }

    fprintf(stdout, "\n");;
  }
}
