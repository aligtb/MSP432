#include "task2.h"

void reverse(char* in,char* out, int len) {
    for (int i = len - 1; i >= 0; i--) {
        out[len - i - 1] = in[i];
    }
}
