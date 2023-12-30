#include "task4.h"

float sqrt(float x, int max_iterations) {
    float y = (x+1)/2;
    int i = 0;
    while(i <= max_iterations && x > 0){
        y = 0.5*(y+x/y);
        i++;
    }
    return y;
}
