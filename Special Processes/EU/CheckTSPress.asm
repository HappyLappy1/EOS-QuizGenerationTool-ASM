; ------------------------------------------------------------------------------
; CheckTSPress
; Checks if the Screen is pressed anywhere
; No Params
; Returns: 0 = screen not pressed, 1 = screen pressed
; Made by Argonien
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm


; Uncomment/comment the following labels depending on your version.


; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x022E7B88
.definelabel ProcJumpAddress, 0x022E8400
.definelabel Pressed, 0x22A3F24 

; File creation
.create "./code_out.bin", 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		ldr r10,=Pressed
		ldrb r10,[r10]
		cmp r10,0x00
		beq @@notPressed
		mov r0, #1
		b @@end
		@@notPressed:
		mov r0,#0 
		@@end:
		b ProcJumpAddress
		.pool
	.endarea
.close
