#include "msp.h"
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "inc/clock.h"

#include "tasks/task1.h"
#include "tasks/task2.h"
#include "tasks/task3.h"


/**
 * main.c
 */
void main(void)
{
    /* DO NOT TOUCH STUFF HERE */
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;
    Clock_Init48MHz();

    char task1_t1[] = "akz";

    char task1_t2[] = "tithree";

    if( hash(task1_t1,3) != 0x1AAE6) printf("HASH TEST1 FAILED WRONG ANSWER %X\n", hash(task1_t1,3));
    if( hash(task1_t2,7) != 0xDEBF45B5) printf("HASH TEST2 FAILED WRONG ANSWER %X\n", hash(task1_t2,7));

    encrypt(task1_t1,3,3);
    if ( strcmp(task1_t1, "dnc") != 0) printf("ENCRYPT TEST1 FAILED WRONG ANSWER %s\n", task1_t1);

    encrypt(task1_t2,7,6);
    if ( strcmp(task1_t2, "zoznxkk") != 0) printf("ENCRYPT TEST2 FAILED WRONG ANSWER %s\n", task1_t2);

    float init = 3000;
    float income1[] = {1000.00,1000.00,1000.00};
    float income2[] = {1200.00,1100.00,1000.00};
    float interest = 0.05;
    int years = 3;
    float result = 0.00;
    result = npv(init,income1,years,interest);
    if ( fabs(fabs(result) - 276.75) > 0.1) printf("NPV TEST1 FAILED WRONG ANSWER %f\n", result);
    result = npv(init,income2,years,interest);
    if ( fabs(fabs(result) - 4.42) > 0.1) printf("NPV TEST2 FAILED WRONG ANSWER %f\n", result);

    printf("IF NO TEST FAILED, YOU ARE DONE :)\n");


    /* DO NOT TOUCH STUFF HERE */
    while(1) __asm__("  nop");
}
