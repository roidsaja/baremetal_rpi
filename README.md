# baremetal_rpi

## First and foremost what is bare metal programming?
To try to generalize my opinion of this I would start by saying that
bare metal programming means you are talking to the hardware directly,
bypassing an operating system, or certainly if you have no real/formal
operating system running.  Processors/computers do not require operating
systems to run.  Operating systems are just programs anyway themselves
perhaps being considered bare metal programming.


To begin bare metal programming you start by understanding how the
processor boots, how and where it loads and executes its first
instruciton, and then making programs that fit that model, placing the
first instruction of your program such that the processor executes it
when it boots.

The second generalization I will make is that with bare metal programming
you are often programming registers and memory for peripherals directly.
For example printf() is not bare metal, there are way too many layers of
stuff often landing in system calls which are often tied to an operating
system.  That doesnt mean you cant rig up a printf that works in a bare
metal environment, but it does contradict the concept of bare metal.
This of course is a gray area for the definition.  For example if you
wanted to read items off of or write things to the sd card, using a
filesystem most programmers even if they create all the code from
scratch are going to end up with some sort of layered approach, at one
end is low level bare metal talking to registers that wiggle things on a
bus somewhere on the other end some sort of open file or create file,
read file, close file, etc.  Being your own creation it doesnt have to
conform to any other file function call standard fopen(), fclose(),
etc.  So what happens when one person writes some bare metal code, no
operating system involved, that can open, read, write, close files on
the sd card on the Raspberry Pi, then shares that code?  Is that bare
metal? Tough question.
- - - -
## Explanation of program
The RaspberryPi 3 has 53 registers controlling I/O pins(peripherals). The pins are grouped together and each group is assigned to a register(bank). As for the GPIO the SELECT,SET and CLEAR registers are necessary. To access these registers we need the physical address' of these registers. From the datasheet the offset of the address will be added to the base address in order to access physical adress. The datasheet only lists the virtual address which are values that the OS assigns. Since there's no Operating System involved, as in a Debian img, we do not need the virtual addressing and directly use the physical address.

#### Base Address of I/O:
The PDF on page 6 states the base address to be 0x3F000000, however this address doesn't seemed to work therefore use 0x3F200000.

#### Offset of FSEL2(SELECT):
Not the whole address stated on the PDF. The PDF lists FSEL2 at 0x7E200008 but this addess refers to the virtual addressing. The virtual addressing uses 0x7E20 and its offset will be whatever is on the other side of the nibble. In this case the FSEL2 offset is 0x08.

#### Offset of GPSET0(SET): 0x1c

#### Offset of GPCLR0(CLEAR): 0x28

So you probably noticed that the data-sheet lists 4 SELECT registers, 2 SET registers, and 2 CLEAR registers so why did I choose the ones I did? This is because we want to use GPIO 21 and FSEL2 controls GPIO 20-29, SET0 and CLR0 controls GPIO 0-31. The FSEL registers assigns three bits for every GPIO pin. Since we are using FSEL2 that means bits 0-2 control GPIO 20, and bits 3-5 control GPIO 21 and so on. The Set and CLR registers assign a single bit to every pin. For example, bit 0 in SET0 and CLR0 controls GPIO 1. To control GPIO 21 you would set bit 21 in SET0 and CLR0.

* FSEL2 register will be used to set GPIO 21 to output. To set a pin to output you need to set the lo order bit of the three bits to 1. So if bits 3-5 control GPIO 21 that means we need to set the first bit, bit 3 to 1. This will tell the pi that we want to use GPIO 21 as an output. So if we were to look at the 3 bits for GPIO 21 they should look like this after we set it to output, b001.
* GPSET0 tells the pi to turn on the pin(output a voltage). To do this we just toggle the bit that corresponds with the GPIO pin we want. In our, case bit 21.
* GPCLR0 tells the pi to turn off the pin(no voltage). To turn off the pin set the bit to the corresponding GPIO pin. In our case bit 21

## License
This project is licensed by MIT
