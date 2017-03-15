#include <stdio.h>
#include <stdlib.h>
//--
#include <opencv/cv.h>
#include <opencv/highgui.h>

struct cvmat_ptr {
  CvMat *mat;
  double *ptr;
  struct cvmat_ptr *next;
};

static struct cvmat_ptr *cvmat_ptr_list = NULL;

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

/* Prints image dimensions */
void print_dimensions(int width, int height) {
  fprintf(stdout, "Width: %i - Height: %i\n", width, height);
}

/* Gets double pointer respective CvMat */
CvMat *find_cvmat_by_ptr(double *ptr) {
  struct cvmat_ptr *p;

  for(p = cvmat_ptr_list; p != NULL; p = p->next) {
    if(p->ptr == ptr) {
      return p->mat;
    }
  }

  return NULL;
}

/*
double *load_image(const char *path, int *width, int *height) {
  CvMat *img;
  struct cvmat_ptr *cvmat_ptr_node;

  img = cvLoadImage(path);

  cvmat_ptr_node = (struct cvmat_ptr *) malloc(sizeof(struct cvmat_ptr));

  if(cvmat_ptr_node != NULL) {
    cvmat_ptr_node->mat = img;
    cvmat_ptr_node->ptr = img->data.db;
    cvmat_ptr_node->next = cvmat_ptr_list;
    cvmat_ptr_list = cvmat_ptr_node;
  }

  fprintf(stdout, "%d %d\n", img->cols, img->rows);

  *width = img->cols;
  *height = img->rows;
  return img->data.db;
}

void display_image(const char *title, double *ptr) {
  CvMat *img;

  if((img = find_cvmat_by_ptr(ptr)) != NULL) {
    cvCvtColor(img, img, CV_8U);
    cvShowImage(title, img);
    cvWaitKey(0);
  }
}

void release_images() {
  struct cvmat_ptr *p, *prev;

  p = cvmat_ptr_list;

  while(p != NULL) {
    prev = p;
    p = p->next;
    cvReleaseMat(&(prev->mat));
    free(prev);
  }
}
*/
