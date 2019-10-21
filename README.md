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

## License
This project is licensed by MIT
