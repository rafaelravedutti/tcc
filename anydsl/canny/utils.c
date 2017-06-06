#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

/* Stack length */
#define STACK_LENGTH    (2 * 2073600)

/* Stack */
static int stack[STACK_LENGTH];
static int stack_size = 0;

/* Show command usage */
void display_usage(const char *command) {
  fprintf(stderr, "Usage: %s [image]\n", command);
  exit(-1);
}

/* Get current time */
double impala_time() {
  struct timeval tp;
  gettimeofday(&tp, NULL);
  return ((double)(tp.tv_sec + tp.tv_usec / 1000000.0));
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
