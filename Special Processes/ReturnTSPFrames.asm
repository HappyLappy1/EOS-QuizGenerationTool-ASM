; ------------------------------------------------------------------------------
; ReturnTSPFrames
; Returns the amount of Frames the Touchscreen is being pressed in HEX
; No Params
; Returns: HEX values
; Made by Argonien
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel Frames, 0x22A35EC
.definelabel Overflow, 0x22A35ED

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel Frames, 0x22A3F2C
;.definelabel Overflow, 0x22A3F2D

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU change address to: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		ldr r10,=Frames
		ldrb r10,[r10]
		ldr r11,=Overflow
		ldrb r11,[r11]
		mov r0, 0x0000
		mov r4, #0
		mov r5, #0
		mov r0, r10
		mov r4, r11
		@@OverflowCalcReturn:
		cmp r4, 0x00
		bgt @@OverflowCalc
		beq @@FrameCalc
		@@OverflowCalc:
		add r5, #1
		sub r4, 0x01
		b @@OverflowCalcReturn
		@@FrameCalc:
		;b @@end
		cmp r5, #0
		beq @@end
		add r0, 0xFF
		sub r5, #1
		b @@FrameCalc
		@@end:
		b ProcJumpAddress
		.pool
	.endarea
.close