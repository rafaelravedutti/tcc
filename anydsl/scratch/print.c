#include <stdio.h>

void print(char *s) {
  fprintf(stdout, "%s\n", s);
}

void print_integer(int i) {
  fprintf(stdout, "%d\n", i);
}

int read_integer() {
  int i;

  fscanf(stdin, "%d", &i);
  return i;
}
