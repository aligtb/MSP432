#ifndef TASKS_TASK2_H_
#define TASKS_TASK2_H_
#include <stdint.h>

void ledInit();
void bumperInit();
void ledOut(uint8_t value);
void blinkSequence(uint8_t* arr, uint32_t len);
uint8_t bumperAwait();
void bumperReadSequence(uint8_t* arr, uint32_t amount);

#endif /* TASKS_TASK2_H_ */
