; ------------------------------------------------------------------------------
; Get Favorite Color
; Stores the firmware user's favorite color, mac address, or a specified value
; in the variable $COLOR_CONFIG_KIND, depending on parameters.
; Parameter 0 (r7): 0 = DS Favorite color, 1+ = DS Mac Address
; Made by Adex, Tweaked by happylappy to also use the mac address!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm
.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.


; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x022E7B88
.definelabel ProcJumpAddress, 0x022E8400
.definelabel GetDsUserFirmwareSettingsVeneer, 0x02004F74
.definelabel SaveScriptVariableValue, 0x0204BB58
.definelabel GetDsMacAddress, 0x0204A4D0

; File creation
.create "./code_out.bin", 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		sub r13,r13,#0x54
		cmp r7, #0x1;
		bge MacAddress;	If >=1, use Mac Address
		mov r0,r13
		bl GetDsUserFirmwareSettingsVeneer
		ldrb r2,[r13,#0x1]
		b ConfigSave
	MacAddress:
		mov r0,r13
		bl GetDsMacAddress
		ldrb r2,[r13,#5]
		and r2, #0xF
	ConfigSave:
		mov r0,#0
		mov r1,#0x45
		bl SaveScriptVariableValue
		ldr r0, [r13, #2]
	GetOut:
		add r13,r13,#0x54
		b ProcJumpAddress
		.pool
	.endarea
.close
