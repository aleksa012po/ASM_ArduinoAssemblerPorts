; ulazniPortovi.asm
;
; Created: 12.05.2022. 13:08:50
; Author : aleksandar.bogda
; Ulazni portovi

.include "m328pdef.inc"
.org 0x00

.equ on = 0xFF
.equ off = 0x00

start:	LDI R20, off	;Load Immediate value 0x00 into R20, uses only memory location adress (Loads an 8-bit constant directly to register 16 to 31, 16 ? d ? 31, 0 ? K ? 255, 1 cycle)
		OUT DDRD, R20	;Store Register to I/O Location, all DDRD pins as INPUT, sets value 0x00 to DDRD, uses I/O adress (0 ? r ? 31, 0 ? A ? 63, 1 cycle) 
		LDI R22, on	;Load Immediate value 0xFF into R22, uses only memory location adress (Loads an 8-bit constant directly to register 16 to 31, 16 ? d ? 31, 0 ? K ? 255, 1 cycle)
		OUT PIND, R22	;Store Register to I/O Location, sets value 0xFF to PIND, uses I/O adress (0 ? r ? 31, 0 ? A ? 63, 1 cycle) 
uslov:	SBIC PIND, 0b00000010	;Skip if Bit in I/O Register is Cleared, if the bit in 0b00000010 is cleared, skip the next instruction
		RJMP nijeAkt	;Relative Jump to subroutine nijeAkt, Cycles 2
		RJMP aktivno	;Relative Jump to subroutine aktivno, Cycles 2
nijeAkt:CPI R20, off	;Compare with Immediate, this instruction performs a compare between register and a constant, Cycles 1
		BREQ uslov		;Branch if Equal, cycles 1 if condition is false, 2 if condition is true
		RET				;Return from Subroutine, the return address is loaded from the STACK
aktivno:LDI R21, on	;Load Immediate value 0xFF into R21, uses only memory location adress (Loads an 8-bit constant directly to register 16 to 31, 16 ? d ? 31, 0 ? K ? 255, 1 cycle)
		OUT DDRB, R21	;Store Register to I/O Location, all DDRB pins as OUTPUT, sets value 0xFF to DDRB, uses I/O adress (0 ? r ? 31, 0 ? A ? 63, 1 cycle) 
		LDI R23, on	;Load Immediate value 0xFF into R23, uses only memory location adress (Loads an 8-bit constant directly to register 16 to 31, 16 ? d ? 31, 0 ? K ? 255, 1 cycle)
		OUT PINB, R23	;Store Register to I/O Location, sets value 0xFF to PINB, uses I/O adress (0 ? r ? 31, 0 ? A ? 63, 1 cycle) 
		RJMP start		;Relative Jump to subroutine start, Cycles 2