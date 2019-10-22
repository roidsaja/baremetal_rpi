.section .init
.global _start
@------------------
@SETUP VALUES
@------------------
.equ BASE,  0x3f200000 @Base address
.equ GPFSEL2, 0x08			@FSEL2 register offset 
.equ GPSET0,  0x1c			@GPSET0 register offset
.equ GPCLR0,0x28			@GPCLR0 register offset
.equ SET_BIT3,   0x08		@sets bit three b0000 1000
.equ SET_BIT21,  0x200000 	@sets bit 21 b0010 0000 0000 0000 0000 0000

_start:

ldr r0,=BASE                @load register with BASE

ldr r1,=SET_BIT3            @Set bit 3 in GPFSEL2
str r1,[r0,#GPFSEL2]		@write back the bit 0x08 to the address of GPFSEL2

ldr r1,=SET_BIT21           @Set bit 21 in GPSET0
str r1,[r0,#GPSET0]         
