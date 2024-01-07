#include "task1.h"

uint32_t hash(uint8_t* k, uint32_t length) {
    /* YOUR CODE HERE. CALL HASHOP TO PERFORM HASH OPERATION */
    uint32_t hash_value = 0;
    uint32_t i;

    /* Initialize hash with 0 then loop over the array to calculate the hash */

    for (i = 0; i < length; i++) {
        hash_value = hashop(hash_value, k, i);
    }

    return hash_value;
}
