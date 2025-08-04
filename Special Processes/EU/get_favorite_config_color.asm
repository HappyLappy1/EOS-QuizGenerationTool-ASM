; ------------------------------------------------------------------------------
; Get Favorite Color
; Stores the firmware user's favorite color, mac address, or a specified value
; in the variable $COLOR_CONFIG_KIND, depending on parameters.
; Parameter 0 (r7): 0 = DS Favorite color, 1 = DS Mac Address, 2+ = Parameter 1 
; Parameter 1 (r6): Output value for $CONFIG_COLOR_KIND if r7 is 2+
; Made by Adex, Tweaked by happylappy to also use the mac address!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm


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
		bgt GetOut; if >1, Do nothing.
		beq MacAddress;	If 1, use Mac Address
		movlt r2, r6;
		blt ConfigSave;
	MacAddress:
		mov r0,r13
		bl GetDsMacAddress
		ldrb r2,[r13,#0x0]
		and r2, #0xF
		b ConfigSave
	Color:
		mov r0,r13
		bl GetDsUserFirmwareSettingsVeneer
		ldrb r2,[r13,#0x1]
	ConfigSave:
		mov r0,#0
		mov r1,#0x45
		bl SaveScriptVariableValue
	GetOut:
		add r13,r13,#0x54
		b ProcJumpAddress
		.pool
	.endarea
.close
