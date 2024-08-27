; ------------------------------------------------------------------------------
; Get Favorite Color
; Stores the firmware user's favorite color in the variable $COLOR_CONFIG_KIND!
; No Params
; Made by Adex
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
.definelabel GetDsUserFirmwareSettingsVeneer, 0x02004F74
.definelabel SaveScriptVariableValue, 0x0204B820

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetDsUserFirmwareSettingsVeneer, 0x02004F74
;.definelabel SaveScriptVariableValue, 0x0204BB58


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		sub r13,r13,#0x54
		mov r0,r13
		bl GetDsUserFirmwareSettingsVeneer
		ldrb r2,[r13,#0x1]
		mov r0,#0
		mov r1,#0x45
		bl SaveScriptVariableValue
		add r13,r13,#0x54
		b ProcJumpAddress
		.pool
	.endarea
.close
