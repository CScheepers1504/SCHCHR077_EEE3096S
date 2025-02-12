/*
 * assembly.s
 *
 */

 @ DO NOT EDIT
	.syntax unified
    .text
    .global ASM_Main
    .thumb_func

@ DO NOT EDIT
vectors:
	.word 0x20002000
	.word ASM_Main + 1

@ DO NOT EDIT label ASM_Main
ASM_Main:

	@ Some code is given below for you to start with
	LDR R0, RCC_BASE  		@ Enable clock for GPIOA and B by setting bit 17 and 18 in RCC_AHBENR
	LDR R1, [R0, #0x14]
	LDR R2, AHBENR_GPIOAB	@ AHBENR_GPIOAB is defined under LITERALS at the end of the code
	ORRS R1, R1, R2
	STR R1, [R0, #0x14]

	LDR R0, GPIOA_BASE		@ Enable pull-up resistors for pushbuttons
	MOVS R1, #0b01010101
	STR R1, [R0, #0x0C]
	LDR R1, GPIOB_BASE  	@ Set pins connected to LEDs to outputs
	LDR R2, MODER_OUTPUT
	STR R2, [R1, #0]
	MOVS R2, #0         	@ NOTE: R2 will be dedicated to holding the value on the LEDs



@ TODO: Add code, labels and logic for button checks and LED patterns

main_loop:
	BL check_buttons             @ Call the button check function
	B led_logic                  @ Go to the LED logic after button checks


@ Check PA0-PA3 pushbuttons function
check_buttons:
	LDR R0, GPIOA_BASE           @ Reload GPIOA base address into R0
	LDR R4, [R0, #0x10]          @ Load GPIOA_IDR into R4 to check the button states

	@ Check if no buttons are pressed
	MOVS R5, #0b1111             @ Use R5 for masking PA0-PA3
	ANDS R4, R4, R5              @ Mask only PA0-PA3 pins
	CMP R4, #0b1111              @ Compare if all buttons are high (no buttons pressed)
	BEQ default_led_increment    @ If no buttons are pressed, jump to default increment

	@ Check if PA0 (SW0) is pressed
	CMP R4, #0b1110              @ Compare if PA0 is low (button pressed)
	BEQ led_increment_by_two     @ If PA0 is pressed, increment by 2

	@ Check if PA1 (SW1) is pressed
	CMP R4, #0b1101              @ Compare if PA1 is low (button pressed)
	BEQ use_short_delay          @ If PA1 is pressed, set short delay

	@ Check if PA2 (SW2) is pressed
	CMP R4, #0b1011              @ Compare if PA2 is low (button pressed)
	BEQ set_leds_pattern         @ If PA2 is pressed, set LED pattern to 0xAA

	@ Check if PA3 is pressed
	CMP R4, #0b0111              @ Compare if PA3 is low (button pressed)
	BEQ check_frozen_leds        @ If PA3 is pressed, check if LEDs should freeze

	@ Check if both PA0 and PA1 are pressed
	CMP R4, #0b1100              @ Compare if both PA0 and PA1 are pressed
	BEQ increment_by_two_short_delay  @ Increment by 2 with short delay if both are pressed

	BX LR                        @ Return to the main loop


led_logic:
	B mask_led_values            @ Mask LEDs and continue the process

check_frozen_leds:
    LDR R0, frozen_state         @ Load the address of the frozen state into R0
    LDR R1, [R0]                 @ Load the value at the frozen state address into R1
    CMP R1, #0                   @ Compare the frozen state value with 0
    BEQ mask_led_values          @ If frozen state is 0 (not frozen), continue with LED update
    B main_loop                  @ If frozen state is not 0, skip LED update


led_increment_by_two:
	ADDS R2, R2, #2              @ Increment LED value by 2
	BL long_delay                @ Use long delay for 0.7 seconds
	B mask_led_values            @ Go to mask LEDs


use_short_delay:
	ADDS R2, R2, #1              @ Increment LED value by 1
	BL short_delay               @ Use short delay (0.3 seconds)
	B mask_led_values            @ Go to mask LEDs

set_leds_pattern:
	MOVS R3, #0xAA               @ Set LED pattern to 0xAA
	LDR R1, GPIOB_BASE           @ Load GPIOB base address into R1
	STR R3, [R1, #0x14]          @ Write 0xAA to GPIOB ODR (LEDs)
	B main_loop                  @ Return to main loop

increment_by_two_short_delay:
	ADDS R2, R2, #2              @ Increment LED value by 2
	BL short_delay               @ Use short delay (0.3 seconds)
	B mask_led_values            @ Go to mask LEDs

default_led_increment:
	ADDS R2, R2, #1              @ Default increment by 1
	BL long_delay                @ Use long delay for 0.7 seconds
	B mask_led_values            @ Go to mask LEDs

mask_led_values:
	MOVS R3, #0xFF               @ Load mask value (0xFF)
	ANDS R2, R2, R3              @ Mask off any overflow (restrict to 8 bits)
	B update_leds


update_leds:
	LDR R1, GPIOB_BASE           @ Reload GPIOB base address into R1
	STR R2, [R1, #0x14]          @ Write LED value to GPIOB ODR
	B main_loop                  @ Return to main loop


@ Long Delay function
long_delay:
    LDR R0, LONG_DELAY_CNT      @ Load long delay counter value into R0
delay_loop:
    SUBS R0, R0, #1            @ Decrement delay counter
    BNE delay_loop             @ Continue loop if not zero
    BX LR                      @ Return to main loop

@ Short Delay function
short_delay:
    LDR R0, SHORT_DELAY_CNT     @ Load short delay counter value into R0
short_delay_loop:
    SUBS R0, R0, #1            @ Decrement short delay counter
    BNE short_delay_loop       @ Continue loop if not zero
    BX LR                      @ Return to main loop


@ LITERALS
.align
RCC_BASE:           .word 0x40021000
AHBENR_GPIOAB:      .word 0b1100000000000000000
GPIOA_BASE:         .word 0x48000000
GPIOB_BASE:         .word 0x48000400
MODER_OUTPUT:       .word 0x5555
LONG_DELAY_CNT:     .word 1400000    @ 0.7 second delay
SHORT_DELAY_CNT:    .word 600000     @ 0.3 second delay
frozen_state:       .word 0          @ 0 - not frozen, 1 - frozen
