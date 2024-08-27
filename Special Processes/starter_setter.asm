.relativeinclude on
.nds
.arm
; ------------------------------------------------------------------------------
; Set Starter
; Assigns a starter of the specified ID to either the hero or partner:
; Param 1: 0 for hero, 1 for partner
; Param 2: Species ID of the pokemon you want to set for the starter
; Made by Adex... or Hecka... or Irdkwia... Can one of you claim this please? - Lappy
; ------------------------------------------------------------------------------

; Uncomment/comment the following labels depending on your version.

; for US
.definelabel MaxSize, 0x810
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel DEFAULT_HERO_ADDR, 0x20AFEFC
.definelabel DEFAULT_PARTNER_ADDR, 0x20AFEFE

; for EU
;.definelabel MaxSize, 0x810
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel DEFAULT_HERO_ADDR, 0x20B0818
;.definelabel DEFAULT_PARTNER_ADDR, 0x20B081A

.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		cmp    r7,#0
        ldreq  r1,=DEFAULT_HERO_ADDR
        ldrne  r1,=DEFAULT_PARTNER_ADDR
        strh   r6,[r1,#0x0]
        mov    r0,r6
        
		b ProcJumpAddress
		.pool
	.endarea
.close
