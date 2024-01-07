#ifndef TASKS_TASK1_H_
#define TASKS_TASK1_H_
#include <stdint.h>

uint32_t hash(uint8_t* k, uint32_t length);
extern uint32_t hashop(uint32_t hash, uint8_t* k, uint32_t index);

#endif /* TASKS_TASK1_H_ */
