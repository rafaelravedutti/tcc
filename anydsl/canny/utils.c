#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int *alloc_int(int size) {
  return (int *) malloc(size);
}

void free_int(int *ptr) {
  free(ptr);
}

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
