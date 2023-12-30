#include "msp.h"
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "inc/clock.h"

#include "tasks/task1.h"
#include "tasks/task2.h"
#include "tasks/task3.h"
#include "tasks/task4.h"

/**
 * main.c
 */
void main(void)
{
    /* DO NOT TOUCH STUFF HERE */
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;
    Clock_Init48MHz();

    if( !prime(5) ) printf("PRIME TEST1 FAILED WRONG ANSWER\n");
    if( prime(10) ) printf("PRIME TEST2 FAILED WRONG ANSWER\n");
    if( !prime(5813) ) printf("PRIME TEST3 FAILED WRONG ANSWER\n");

    char task2_t1[] = "Hallo";
    char task2_t1_out[6] = {0};
    char task2_t2[] = "RUB";
    char task2_t2_out[4] = {0};

    reverse(task2_t1,task2_t1_out,5);
    reverse(task2_t2,task2_t2_out,3);

    if (strcmp(task2_t1_out, "ollaH") != 0) printf("REVERSE TEST1 FAILED WRONG ANSWER %s\n", task2_t1_out);
    if (strcmp(task2_t2_out, "BUR") != 0) printf("REVERSE TEST2 FAILED WRONG ANSWER %s\n", task2_t2_out);

    int task3[] = {1000,3,1210,915,813,1600};
    if (findSum(task3,6) != 983730) printf("FINDSUM TEST1 FAILED WRONG ANSWER %d\n", findSum(task3,6));

    float task4 = 35549;
    float task4_result = sqrt(task4,20);
    task4_result -= 188.544;
    if (task4_result < 0.00) task4_result *= -1.00;
    if( task4_result > 0.1) printf("SQRT TEST1 FAILED WRONG ANSWER %f\n", sqrt(task4,20));

    printf("IF NO TEST FAILED, YOU ARE DONE :)\n");

    /* DO NOT TOUCH STUFF HERE */
    while(1) __asm__("  nop");
}
