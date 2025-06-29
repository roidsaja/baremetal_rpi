.section .init
.global _start

.equ BASE,  0x3f200000 @Base address
.equ GPFSEL2, 0x08			@FSEL2 register offset 
.equ GPSET0,  0x1c			@GPSET0 register offset
.equ GPCLR0,0x28			@GPCLR0 register offset
.equ SET_BIT3,   0x08		@sets bit three b1000		
.equ SET_BIT21,  0x200000 	@sets bit 21
.equ COUNTER, 0xf0000

_start:

ldr r0,=BASE
ldr r2,=COUNTER
ldr r1,=SET_BIT3
str r1,[r0,#GPFSEL2]
ldr r1,=SET_BIT21
str r1,[r0,#GPSET0]

Infinite_loop:
	@TURN ON
	str r1,[r0,#GPSET0]	
	@DELAY
	mov r10,#0
	delay:@loop to large number
		add r10,r10,#1
		cmp r10,r2	
		bne delay
	@TURN OFF	
	str r1,[r0,#GPCLR0]
	@DELAY2
	mov r10,#0
	delay2:
		add r10,r10,#1
		cmp r10,r2	
		bne delay2
b Infinite_loop
