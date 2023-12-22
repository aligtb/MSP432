#include "msp.h"
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "inc/clock.h"

#include "tasks/task1.h"
#include "tasks/task2.h"
#include "tasks/task3.h"


void game_main() {
    uint8_t seq[32];
    rng(0xC0CAC01A,seq,32); // Change the seed if you want another combination
    ledInit();
    bumperInit();

    printf("ATTENTION: I will now show you the colors for BMP0, BMP2, BMP3, BMP5. Type 1 in CIO and press enter to start\n");
    uint32_t dummy = 0;
    scanf("%d",&dummy);
    uint8_t testseq[] = {0,1,2,3};
    blinkSequence(testseq, 4);
    delay(0xFFFFF);
    printf("The game will start now!\n");
    delay(0xFFFFF);

    uint8_t loopresult = 0;
    for(int i = 1; i < 32; i++) {
       printf("Round %d\n",i);
       loopresult = gameloop(seq,i);
       if (loopresult == 0) {
           printf("Wrong. You lost!\n");
           break;
       }
       if(i == 31) {
           printf("You won!\n");
       }
    }

    printf("Please restart the robot to try again\n");
    while(1);
}

void debug_main() {
    uint8_t cmp1[3] = {1,2,3};
    uint8_t cmp2[3] = {1,2,4};
    uint8_t seq[3];
    uint8_t seq2[4] = {0,1,2,3};
    ledInit();
    bumperInit();
    printf("LEDs and Bumper are initialized!\n");
    uint32_t input = 0;
    printf("Debug options:\n(1) delay, (2) array_cmpn, (3) rng\n");
    printf("(4) ledOut, (5) blinkSequence, (6) bumperAwait, (7) bumperReadSequence\n");
    printf("To debug gameloop, restart the robot and enter game mode\n");
    while(1) {
        printf("What do you want to debug? Enter number in CIO and press enter:\n");
        scanf("%d", &input);
        switch(input) {
        case 1:
            printf("The following messages should pop up with a bit of delay\n");
            delay(0xAFFFFF);
            printf("delayed...\n");
            delay(0xAFFFFF);
            printf("delayed...\n");
            delay(0xAFFFFF);
            break;
        case 2:
            printf("{1,2,3} ==? {1,2,4} for len=2: %d (EXPECTED: 1)\n",array_cmpn(cmp1,cmp2,2));
            printf("{1,2,3} ==? {1,2,4} for len=3: %d (EXPECTED: 0)\n",array_cmpn(cmp1,cmp2,3));
            break;
        case 3:
            rng(0xC0CAC01A,seq,3);
            printf("RNG(0xC0CAC01A,SEQ,3) = {%d, %d, %d} (EXPECTED: 2,1,3)\n", seq[0],seq[1],seq[2]);
            break;
        case 4:
            printf("Cycling through all colors\n");
            for(int i = 1; i < 8; i++) {
                delay(0x1FFFFF);
                ledOut(i);
                delay(0x1FFFFF);
            }
            ledOut(0);
            break;
        case 5:
            printf("Blinking out sequence 0,1,2,3,4. Remember 0 should be a color in this case!\n");
            blinkSequence(seq2,4);
            break;
        case 6:
            printf("Press a button\n");
            input = bumperAwait();
            printf("Pressed %d. Press another button!\n", input);
            input = bumperAwait();
            printf("Pressed %d. If this appears without you pressing a second button adjust the delay or you have an error in your code! Only press the button for a short time!\n", input);
            break;
        case 7:
            printf("Press 3 buttons\n");
            bumperReadSequence(seq,3);
            printf("Pressed: %d %d %d\n",seq[0],seq[1],seq[2]);
            break;
        default:
            printf("Unknown option. Try again!\n");
            break;
        }
    }
}
/**
 * main.c
 */
void main(void)
{
    /* DO NOT TOUCH STUFF HERE */
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;
    Clock_Init48MHz();

    uint32_t input = 0;
    printf("Do you want to debug (1) or play (2)? Enter number in CIO and press enter:\n");
    scanf("%d", &input);
    switch(input) {
    case 1:
        debug_main();
        break;
    case 2:
        game_main();
    default:
        printf("Unknown option. Try again!\n");
        break;
    }


    /* DO NOT TOUCH STUFF HERE */
    printf("Restart the robot!\n");
    while(1) __asm__("  nop");
}
