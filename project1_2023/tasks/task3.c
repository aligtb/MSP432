#include "task3.h"

int findSum(int* x, int len) {
    for (int i = 0; i <=len; i++){
        for (int j=0; j<=i; j++){
            if (x[i] + x[j] == 2023){
                return x[i]*x[j];
            }
        }
    }
    return 0;
}
