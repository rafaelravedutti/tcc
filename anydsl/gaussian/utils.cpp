#include <iostream>

/* Image allocation */
int *allocate_image_data(int width, int height) {
  if(width > 0 && height > 0) {
    return new int[width * height];
  }

  return NULL;
}

/* Image deallocation */
void free_image_data(int *data) {
  delete[] data;
}

/* Synthetical image printing */
void print_image_data(int *data, int width, int height) {
  unsigned int i, j;

  for(j = 0; j < height; ++j) {
    for(i = 0; i < width; ++i) {
      std::cout << data[j * width + i] << " ";
    }

    std::cout << std::endl;
  }
}
