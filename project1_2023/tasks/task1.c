#include "task1.h"

int prime(unsigned int x) {
    if (x == 0 || x == 1){
        return 0;
    }

    if (x == 2){
        return 1;
    }
    unsigned int i = 3;
    while (i<x){
        if (x % i == 0){
            return 0;
        }
        i=i+2;
    }
   return 1;
}
