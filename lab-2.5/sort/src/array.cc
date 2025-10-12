#include <iostream>

void exchange(int* xs, int p, int q) {
  int x = xs[p];
  xs[p] = xs[q];
  xs[q] = x;
}

void reverse(int* xs, int length) {
    int i = 0;
    int j = length;
    while (i < j) { exchange(xs, i++, --j); }
}

void quicksort(int* start, int length) {
  int* pivot = start;
  for (int i = 0; i < length; i += 1){
    int* curr_val = start + i;
    
  }
}
