; ------------------------------------------------------------------------------
; Team Name to Integer
; Param 1: Entry ID
; Param 2: 0 if leader entry, 1 if partner entry (r7)
; Returns: 
; * 0 if not a number.
; * 1 if the number inputted is too big.
; * 2 if successful. The Species ID will be placed in the global variable specified in the first argument.
; Made by Mond (Who was too modest to credit themselves in their own ASM)
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel SpeciesIDToStore, 0x20AFEFC

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		; r7: Process param 0 -> species ID
		; r6: process param 1 -> 0 for leader, 1 if partner, NEVER USE ANY OTHER VALUE
		mov r2, r7 ; Species ID
		mov r6, r6, lsl 1h
		ldr r0,=SpeciesIDToStore
		strh r2, [r0, r6]
; Setting up the demo entry
		ldr r1,=20A68C8h ; Demo teams
		add r0, r1, r6 ; r6 is 2 if it's a partner
		mov r1, #0 ; Loop counter
@@demo_loop:
		strh r2, [r0, r1]
		cmp r1, #68 ; 18 entries in demo teams
		addlt r1, r1, #4
		blt @@demo_loop
		bl 0x2065C48 ; RandomizeDemoActors
		b ProcJumpAddress
		.pool
	.endarea
.close