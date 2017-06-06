#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

/* Stack length */
#define STACK_LENGTH    (2 * 2073600)

typedef int pixel_t;

/* Stack */
static int stack[STACK_LENGTH];
static int stack_size = 0;

/* Show command usage */
void display_usage(const char *command) {
  fprintf(stderr, "Usage: %s [image]\n", command);
  exit(-1);
}

/* Double matrix allocation */
double *allocate_double_matrix(int width, int height) {
  if(width > 0 && height > 0) {
    return (double *) malloc(width * height * sizeof(double));
  }

  return NULL;
}

/* Double matrix deallocation */
void free_double_matrix(double *data) {
  free(data);
}

/* Image allocation */
pixel_t *allocate_uchar_matrix(int width, int height) {
  if(width > 0 && height > 0) {
    return (pixel_t *) malloc(width * height * sizeof(pixel_t));
  }

  return NULL;
}

/* Image deallocation */
void free_uchar_matrix(pixel_t *data) {
  free(data);
}

/* Synthetical image printing */
void print_uchar_matrix(pixel_t *data, int width, int height) {
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

/* Double printing */
void print_f64(double value) {
  fprintf(stdout, "%f\n", value);
}

/* Angle test printing */
void print_angle_test(double angle, int result) {
  fprintf(stdout, "ROUND(%.6f) = %d\n", angle, result);
}

/* Regular printing */
void impala_print(const char *string) {
  fprintf(stdout, "%s\n", string);
}

/* Get current time */
double impala_time() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  return ((double)(tp.tv_sec + tp.tv_usec / 1000000.0));
}

/* Show statistics */
void show_statistics(int corrects, int false_positives, int false_negatives) {
  int total;
  double correct_percent, fp_percent, fn_percent;

  total = corrects + false_positives + false_negatives;
  correct_percent = (double) corrects / (double) total;
  fp_percent = (double) false_positives / (double) total;
  fn_percent = (double) false_negatives / (double) total;

  fprintf(stdout, "Correct pixels: %.2f (%d/%d)\n"
                  "False positives: %.2f (%d/%d)\n"
                  "False negatives: %.2f (%d/%d)\n"
                  "-------------------------------------\n",
                  correct_percent, corrects, total,
                  fp_percent, false_positives, total,
                  fn_percent, false_negatives, total);
}

/* Show profile */
void show_profile_statistics(
  double gaussian_time, double sobel_time, double nms_time, double hysteresis_time
) {
  fprintf(stdout, "-------------------------------------\n"
                  "Gaussian time: %.5f\n"
                  "Sobel time: %.5f\n"
                  "Non-maximum supression time: %.5f\n"
                  "Hysteresis time: %.5f\n"
                  "-------------------------------------\n",
                  gaussian_time, sobel_time, nms_time, hysteresis_time);
}

/* Show times comparison */
void show_time_statistics(double first_time, double second_time) {
  fprintf(stdout, "OpenCV time: %.5f\n"
                  "AnyDSL time: %.5f\n"
                  "-------------------------------------\n",
                  first_time, second_time);
}

/* Initialize stack */
void stack_init() {
  stack[0] = 0;
  stack[1] = 0;
  stack_size = 2;
}

/* Conditional push */
void push_conditional(int x, int y, int condition) {
  stack[stack_size] = x;
  stack[stack_size + 1] = y;
  stack_size += condition * 2;
}

/* Pop */
int pop(int *x, int *y) {
  *x = stack[stack_size - 2];
  *y = stack[stack_size - 1];
  stack_size -= (stack_size > 2) * 2;
  return stack_size > 2;
}
