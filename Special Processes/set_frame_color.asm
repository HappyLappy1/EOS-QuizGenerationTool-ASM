.relativeinclude on
.nds
.arm
; ------------------------------------------------------------------------------
; Get Favorite Color
; Changes the text frame color to the specified gender
; Param 1: 0 for blue, 1 for pink, 2 for yellow? Idk never tried 2 - Lappy
; Made by Irdkwia
; ------------------------------------------------------------------------------

; Uncomment/comment the following labels depending on your version.

; for US
.definelabel MaxSize, 0x810
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel ChangeGlobalBorderColor, 0x02027A80


; for EU
;.definelabel MaxSize, 0x810
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel ChangeGlobalBorderColor, 0x02027D74

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		mov r0,r7
		bl ChangeGlobalBorderColor
		
		b ProcJumpAddress
		.pool
	.endarea
.close
