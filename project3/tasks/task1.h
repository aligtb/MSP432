#ifndef TASKS_TASK1_H_
#define TASKS_TASK1_H_
#include <stdint.h>

void delay(uint32_t delay);
uint8_t array_cmpn(uint8_t* x, uint8_t* y, uint32_t len);
void rng(uint32_t seed, uint8_t* destination, uint32_t amount);

#endif /* TASKS_TASK1_H_ */
