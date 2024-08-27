.relativeinclude on
.nds
.arm
; ------------------------------------------------------------------------------
; MoveText2TopScreen
; Moves the text box to the top screen!
; Param 1: 1 for top screen, 0 for bottom screen
; Returns: 0 = screen not pressed, 1 = screen pressed
; "Baked" by Hecka in 7 minutes
; ------------------------------------------------------------------------------



.definelabel MaxSize, 0x810
.definelabel ENUM_SCREEN_MAIN, 0
.definelabel ENUM_SCREEN_SUB, 1

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel DIALOGUE_DBOX_DEFAULT_WINDOW_PARAMS, 0x209AF2C

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel DIALOGUE_DBOX_DEFAULT_WINDOW_PARAMS, 0x0209B468

; File creation
.create "./code_out.bin", 0x022E7248
    .org ProcStartAddress
    .area MaxSize ; Define the size of the area
        ; Usable Variables: 
        ; r7 = New Default DBOX Location (0 to reset to normal)
        ; r6 = New Default DBOX Size (0 to reset to normal)
        ; Returns: 
        ; r0 = User Defined Value
        ; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
        
        ; Change location/size.
        ldr   r2,=DIALOGUE_DBOX_DEFAULT_WINDOW_PARAMS
        cmp   r6,ENUM_SCREEN_MAIN
        movne r6,ENUM_SCREEN_SUB
        strb  r6,[r2,#0x8]
        
        ; Always branch at the end
        b ProcJumpAddress
        .pool
    .endarea
.close