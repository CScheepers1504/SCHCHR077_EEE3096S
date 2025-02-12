# EEE3096S
This is a repository for the UCT 3rd-year course, Embedded Systems II created and written by Abdul-Mateen Kader and Chris Scheepers.

The course is described as follows:
"This course integrates aspects of embedded systems and computer architecture by building on EEE2046S (2nd-year Embedded Systems I), which provided introductory knowledge of digital electronics, microcontrollers, and C programming. Embedded Systems II introduces students to: microprocessor architecture fundamentals, embedded operating systems architectures, Linux, memory technologies, a bit of Hardware Descriptive Languages (HDL), and common embedded communication protocols." (UCT)

## Prac 1
In this practical, C code (and the HAL libraries) is used to interface with a microcontroller board (STM32) to flash LEDs in a pattern. This changes at a specified interval defined by timer settings. Furthermore, it uses pushbuttons to alternate the delay timing. Learning objectives:   

● STM32CubeIDE and the HAL libraries (documentation is available [here](https://www.st.com/resource/en/user_manual/um1785-description-of-stm32f0-hal-and-lowlayer-drivers-stmicroelectronics.pdf)). 

● LEDs and pushbuttons  

● Timers and timer interrupts  

[Practical 1 PDF](Prac1/EEE3096S%202024%20Practical%201%20template.pdf)

## Prac 2
In this practical, C code (and the HAL libraries) is used to interface a microcontroller board (STM32) with a low-pass filter circuit that is built in the lab. Look-up tables (LUTs) are used to represent a few different analogue waveforms and two timers are set on the dev board (one timer for generating the PWM signal and one for cycling through the LUT values periodically). An oscilloscope is then used to monitor the output from the LP filter. The aim of this is to use the LUT values to vary the CCR (Capture/Compare Register) value, effectively changing the duty cycle. Learning objectives:

• DACs  

• Filtering  

• PWM  

• Pushbutton interrupts  

[Practical 2 PDF](Prac2/EEE3096S%202024%20Practical%202.pdf)

## Prac 3
In this practical, C code (and the HAL libraries) is used to read the voltage on a potentiometer's wiper using the on-board ADC on an STM32 board. This value will then be used to calculate the duty cycle of a PWM signal to control the brightness of a built-in LED, and a pushbutton interrupt will be used to control the change the toggling frequency of another LED with precise timing. Finally, this practical will use Serial Peripheral Interface (SPI) to write data to the EEPROM (non-volatile memory that retains its contents after power cycling) chip on an STM board, and then read this data back later to write to the LCD. Learning objectives:

• ADCs

• SPI

• Interfacing with an LCD

[Practical 3 PDF](Prac3/EEE3096S%202024%20Practical%203.pdf)
