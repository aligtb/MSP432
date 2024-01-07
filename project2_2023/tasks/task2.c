#include "task2.h"

void encrypt(char* str, int len, int key) {
    /* YOUR CODE HERE. CALL ENCRYPTOP TO PERFORM ENCRYPT OPERATION */
    int i;

    for (i = 0; i < len; i++) {
        encryptop(&str[i], key);
    }
    ;
}
