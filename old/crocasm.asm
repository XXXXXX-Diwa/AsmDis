.gba
.open "zm.gba","croco.gba",0x8000000

.org 0x0875EAE8                 
.word CroAI+1

;.definelabel samusmaxenergy, 0x3001530                              
.definelabel CurrentEnemyData_CurEnemy_pose, 0x300075C              ;当前敌人的pose
.definelabel CurrentEnemyData_candraw,  0x3000762
.definelabel Line2Move, 0x0300070C
.definelabel CurrentEnemyData_CurEnemy_health, 0x300074C            ;敌人当前血量
.definelabel CurrentEnemyData_CurEnemy_X_position,0x300073C
.definelabel CurrentEnemyData_CurEnemy_Y_position, 0x300073A        ;当前敌人坐标
.definelabel CurrentEnemyData_orientation2, 0x300076A             
.definelabel CurrentEnemyData, 0x3000738
.definelabel CurrentEnemyData_CurEnemy_top_boundary_offset, 0x3000738+0xa
.definelabel CurrentEnemyData_CurEnemy_bottom_boundary_offset,0x3000738+ 0xc 
;.definelabel CurrentEnemyData_CurEnemy_right_boundary_offset,0x3000738+ 0xe
;.definelabel CurrentEnemyData_CurEnemy_left_boundary_offset, 0x3000738+0x10
.definelabel CurrentEnemyData_CurEnemy_left_boundary_offset,0x3000738+ 0xe
.definelabel CurrentEnemyData_CurEnemy_right_boundary_offset, 0x3000738+0x10
.definelabel CurrentEnemyX, 0x03000714
.definelabel CurrentEnemyY, 0x03000712 
;.definelabel CurrentEnemyData_CurEnemy_invincibility_timer,0x3000738+0x2c
.definelabel CurrentEnemyData_CurEnemy_invincibility_timer,0x3000738+0x2b
.definelabel dword_2037E00, 0x2037E00                                ;事件地址???
.definelabel off_830401c, 0x830401c                                  ;sub r6,b4h
.definelabel word_30006b4, 0x30006b4                                 ;第十八个敌人的数据起始
.definelabel unk, 0x30001AC                                          ;当前第一个敌人数据起始
.definelabel SpawnSprite, 0x0800E258                                 ;生产第二精灵
.definelabel maxenergty, 0x03001530                                  ;samus最大血量

.definelabel currentenergey, 0x03001536                              ;当前血量

.definelabel currentenemydata_field_34,  0x3000738+ 0x34             ;变色???

.definelabel currentenemydata_curenemy_animation,  0x3000738+0x16    ;当前动画

.definelabel off_8304034, 0x8304034                                  ;sub r7,8Ch

;.definelabel currentenemydata_anonymous_8,  0x3000738+0x2b
.definelabel currentenemydata_anonymous_8,  0x3000738+0x2C

.definelabel currentenemydata_curenemy_id,  0x3000738+0x1D

;.definelabel currentenemydata_curenemy_x_position_spawn,  0x3000738+0x6
.definelabel currentenemydata_curenemy_x_position_spawn,  0x3000738+0x8

.definelabel enemystattable, 0x82B0D68                               ;敌人基础数据起始

.definelabel maxmovements, 0x03000718                                ;有可能错误

.definelabel movementindex, 0x03000710

.definelabel byte_300071a, 0x300071a

.definelabel byte_3000719, 0x3000719

.definelabel currentenemydata_curenemy_spriteset_slot,  0x3000738+0x1e   ;不是这个意思

.definelabel currentenemydata_curenemy_spriteset_gfx_slot,  0x3000738+0x1f

.definelabel SetMovementIndex, 0x08011330
.definelabel XYByIndexTable, 0x08043D88

.org 0x8801000

CroAI:
                PUSH            {LR}
                LDR             R1, =CurrentEnemyData_CurEnemy_pose
                LDRB            R0, [R1]
                CMP             R0, #0
                BEQ             CroAI_InitCroc                   ;POSE 0h
                SUB            R1, #0x10
                LDRH            R0, [R1]
                CMP             R0, #0                           ;检查敌人血量如果为0
                BEQ             CroAI_PoseCOde                   ;死亡pose
                CMP             R0, #0xFF
                BGT             CheckHealth                      ;检查血量如果大于FF跳转 
                MOV            R0, #6
                STRB            R0, [R1,#0x10]                   ;写入POSE 6

CheckHealth:                          
                BL              Returns176

CroAI_PoseCOde:                        
                BL              CrocFinshUp
                B               CrocAI_End

                                      

                B               CrocAI_End


CroAI_InitCroc:                         
                BL              InitCroc
                B               CrocAI_End

                BL              Returns176                

CrocAI_End:                            
				LDR r1, = SetMovementIndex+1
                BX         r1     
                           
				LDR r1, = XYByIndexTable+1
                BX         r1     
                POP             {R0}
                BX              R0 

.pool
.align


Croc_MakeRect_08760E00:
                LDR             R1, =CurrentEnemyData
                LDR             R2, =Line2Move
                LDR             R0, =off_830401C
                STR             R0, [R2]
                MOV            R0, #0x40
                NEG            R0, R0
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_top_boundary_offset - 0x3000738)]
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_left_boundary_offset - 0x3000738)]
                MOV            R0, #0xE0
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_bottom_boundary_offset - 0x3000738)]
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_right_boundary_offset - 0x3000738)]
                LDRB            R0, [R1,#(CurrentEnemyData_CurEnemy_animation - 0x3000738)]
                CMP             R0, #7
                BEQ             loc_8760E24
                CMP             R0, #1
                BEQ             loc_8760E2A
                BX              LR
; ---------------------------------------------------------------------------
               
; ---------------------------------------------------------------------------

loc_8760E24:                
                MOV            R0, #0x40
                STRH            R0, [R1,#(CurrentEnemyData_orientation2 - 0x3000738)]
                BX              LR
; ---------------------------------------------------------------------------

loc_8760E2A :                          
                MOV            R0, #0
                STRH            R0, [R1,#(CurrentEnemyData_orientation2 - 0x3000738)]
                BX              LR

Croc_Movement_08760E40:
                LDR             R2, =CurrentEnemyData
                LDR             R0, =0x8303FEC
                LDR             R1, =Line2Move
                STR             R0, [R1]
                LDRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                SUB            R0, #1
                STRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                MOV            R0, #8
                STRH            R0, [R2,#(CurrentEnemyData_orientation2 - 0x3000738)]
                MOV            R0, #0xFF
                NEG            R0, R0
                STRH            R0, [R2,#(CurrentEnemyData_CurEnemy_left_boundary_offset - 0x3000738)]
                LDRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                LDR             R1, =0x200
                CMP             R0, R1
                BGT             locret_8760E66
                LDR             R1, =MaxEnergty
                MOV            R0, #0
                STRH            R0, [R1,#(CurrentEnergey - 0x3001530)]

locret_8760E66:                        
                BX              LR



Croc_Notsure_08760E80:
                LDR             R2, =Line2Move
                LDR             R0, =off_830401C
                STR             R0, [R2]
                ADD            R2, #0x3A
                MOV            R0, #0xC0
                STRB            R0, [R2]
                ADD            R2, #8
                LDRB            R0, [R2]

loc_8760E90:
                CMP             R0, #1
                BEQ             loc_8760E9A
                CMP             R0, #7
                BEQ             loc_8760E9E
                B               loc_8760EA2
; ---------------------------------------------------------------------------

loc_8760E9A:                            
                MOV            R0, #0
                B               loc_8760EA0
; ---------------------------------------------------------------------------

loc_8760E9E:                            
                MOV            R0, #0x40

loc_8760EA0:                           
                STRB            R0, [R2,#(CurrentEnemyData_orientation2 - 0x300074E)]

loc_8760EA2:                           
                LDRB            R0, [R2,#(CurrentEnemyData_CurEnemy_invincibility_timer - 0x300074E)]
                CMP             R0, #0
                BNE             loc_8760F02
                LDRB            R0, [R2]
                CMP             R0, #2
                BNE             loc_8760EB6
                MOV            R0, #7
                STRB            R0, [R2]
                MOV            R0, #0x40
                STRB            R0, [R2,#(CurrentEnemyData_CurEnemy_invincibility_timer - 0x300074E)]

loc_8760EB6:                             ; CODE XREF: Croc_Notsure_08760E80+2C↑j
                CMP             R0, #3
                BEQ             loc_8760EC4
                CMP             R0, #4
                BEQ             loc_8760EC8
                CMP             R0, #5
                BEQ             loc_8760EC6
                BX              LR
; ---------------------------------------------------------------------------

loc_8760EC4:                            
                ADD            R7, #0x30

loc_8760EC6:
                ADD            R7, #0x30

loc_8760EC8:                            
                ADD            R7, #0x30
                LDR             R1, =CurrentEnemyData
                LDR             R2, =unk
                LDR             R3, =word_30006B4

loc_8760ED0:                           
                LDRB            R0, [R2]
                CMP             R0, #0
                BEQ             loc_8760EDE
                ADD            R2, #0x38
                CMP             R3, R2
                BNE             loc_8760ED0
                B               loc_8760EFE
; ---------------------------------------------------------------------------

loc_8760EDE:                          
                MOV            R0, #3
                STRB            R0, [R2]
                MOV            R0, #8
                STRB            R0, [R2,#0x1D]
                MOV            R0, #0x80
                STRH            R0, [R2,#0x32]
                LDRH            R0, [R1,#(CurrentEnemyData_CurEnemy_Y_position - 0x3000738)]
                ADD            R0, R7, R0
                STRH            R0, [R2,#2]
                LDRH            R0, [R1,#(CurrentEnemyData_CurEnemy_X_position - 0x3000738)]
                ADD            R0, R7, R0
                STRH            R0, [R2,#4]
                MOV            R0, #0
                STRH            R0, [R2,#0x24]
                MOV            R0, #7
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_invincibility_timer - 0x3000738)]

loc_8760EFE:                           
                MOV            R7, #0
                BX              LR
; ---------------------------------------------------------------------------

loc_8760F02:                          
                SUB            R0, #1
                STRB            R0, [R2,#(CurrentEnemyData_CurEnemy_invincibility_timer - 0x300074E)]
                BX              LR


MoveCroc_8760F20:
                LDR             R1, =CurrentEnemyData
                LDR             R2, =unk
                LDR             R3, =word_30006B4
                SUB            R2, #0x1B
                ADD            R3, #0x1D

loc_8760F2A:                           
                ADD            R2, #0x38
                LDRB            R0, [R2]
                CMP             R0, #0x28
                BNE             loc_8760F3E
                MOV            R0, #1
                STRB            R0, [R2,#0x17]
                SUB            R2, #0xF
                MOV            R0, #0
                STRB            R0, [R2]
                ADD            R2, #0xF

loc_8760F3E:                            
                CMP             R3, R2
                BNE             loc_8760F2A
                MOV            R0, #1
                STRH            R0, [R1,#(CurrentEnemyData_field_34 - 0x3000738)]
                LDR             R2, =CurrentEnemyData
                LDR             R1, =Line2Move
                LDR             R0, =0x8304044
                STR             R0, [R1]
                LDRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                SUB            R0, #2
                STRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                LDRH            R0, [R1,#(CurrentEnemyX - 0x300070C)]
                LDR             R1, =0x200
                CMP             R0, R1
                BGT             loc_8760F62
                LDR             R1, =MaxEnergty
                MOV            R0, #0
                STRH            R0, [R1,#(CurrentEnergey - 0x3001530)]

loc_8760F62:                          
                B               loc_8760F6C


loc_8760F6C:                           
                MOV            R0, #0xE
                STRH            R0, [R2,#(CurrentEnemyData_CurEnemy_animation - 0x3000738)]
                MOV            R0, #0
                STRH            R0, [R2,#(CurrentEnemyData_orientation2 - 0x3000738)]
                ADD            R2, #0x2A
                MOV            R0, #0xFF
                STRB            R0, [R2]
                BX              LR






CrocAttack_8760FB0:                
                LDR             R1, =Line2Move
                LDR             R0, =off_8304034
                STR             R0, [R1]
                ADD            R1, #0x50
                LDRB            R0, [R1,#(CurrentEnemyData_anonymous_8 - 0x300075C)]
                CMP             R0, #0x80
                BEQ             loc_8760FC8
                CMP             R0, #0x7F
                BGT             locret_8760FC6
                MOV            R0, #0xFF
                STRB            R0, [R1,#(CurrentEnemyData_anonymous_8 - 0x300075C)]

locret_8760FC6:                         
                BX              LR
; ---------------------------------------------------------------------------

loc_8760FC8:                           
                LDR             R1, =unk
                LDR             R2, =word_30006B4

loc_8760FCC:                           
                LDRH            R0, [R1]
                CMP             R0, #0
                BEQ             loc_8760FD4
                MOV            R0, #0

loc_8760FD4:                           
                STRH            R0, [R1,#0x24]
                STRH            R0, [R1,#0x32]
                STRH            R0, [R1,#0x34]
                MOV            R0, #0x35
                STRB            R0, [R1,#0x1D]
                ADD            R1, #0x38
                CMP             R1, R2
                BNE             loc_8760FCC
                LDR             R1, =CurrentEnemyData
                MOV            R0, #0
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_pose - CurrentEnemyData)]
                MOV            R0, #0x35
                STRB            R0, [R1,#(CurrentEnemyData_CurEnemy_id - CurrentEnemyData)]
                BX              LR

.align 
.pool


CrocFinshUp:                            
                LDR             R0, =CurrentEnemyData_CurEnemy_health
                LDRH            R0, [R0]
                CMP             R0, #0
                BGT             loc_8761174
                MOV            R0, #1
                LDR             R1, =dword_2037E00
                LDR             R1, [R1]
                AND            R1, R0
                CMP             R1, #1
                BEQ             loc_8761174
                EOR            R1, R0
                LDR             R0, =dword_2037E00
                STR             R1, [R0]
                LDR             R1, =0x8760E00

loc_8761174:                            
                LDR             R1, =0x8760E00
                LDR             R0, =CurrentEnemyData_CurEnemy_pose
                LDRB            R0, [R0]
                CMP             R0, #8
                BEQ             CrocFinshUp_Pose8
                CMP             R0, #7
                BEQ             CrocFinshUp_loc_8761190
                CMP             R0, #6
                BEQ             CrocFinshUp_loc_876118E
                CMP             R0, #0x62
                BEQ             loc_876118C
                B               endHiJackAI
; ---------------------------------------------------------------------------

loc_876118C:                          
               BL loc_8760E90
				b endHiJackAI
CrocFinshUp_loc_876118E:                            
               BL loc_8760EA0
				b endHiJackAI
CrocFinshUp_loc_8761190:
CrocFinshUp_Pose8:                             
               bl Croc_Movement_08760E40
endHiJackAI:                         
bx lr


; ---------------------------------------------------------------------------

InitCroc:                              


                PUSH            {R4-R6,LR}
                MOV             R6, R9
                MOV             R5, R8
                PUSH            {R5,R6}
                SUB             SP, SP, #0xC
CrocHijack: 
                LDR             R0, =dword_2037E00
                LDR             R0, [R0]
                MOV           R1, #1
                AND            R0, R1
                CMP             R0, R1
                BEQ             KillCroc
                LDR             R2, =Line2Move
                LDR             R0, =CurrentEnemyData
                MOV             R12, R0
                LDRH            R0, [R0,#(CurrentEnemyData_CurEnemy_Y_position - CurrentEnemyData)]
                MOV           R4, #0
                MOV           R1, #0
                MOV             R8, R1
                STRH            R0, [R2,#(CurrentEnemyY - Line2Move)]
                MOV             R1, R12
                LDRH            R0, [R1,#(CurrentEnemyData_CurEnemy_X_position - CurrentEnemyData)]
                STRH            R0, [R2,#(CurrentEnemyX - Line2Move)]
                LDRH            R0, [R2,#(CurrentEnemyY - Line2Move)]
                MOV             R9, R0
                LDRH            R6, [R2,#(CurrentEnemyX - Line2Move)]
                STRH            R6, [R1,#(CurrentEnemyData_CurEnemy_x_position_spawn - CurrentEnemyData)]
                MOV             R0, R12
                ADD            R0, #0x27
                MOV           R3, #0x20
                STRB            R3, [R0]
                ADD            R1, #0x28
                MOV           R0, #0x18
                STRB            R0, [R1]
                ADD            R1, #1
                MOV           R0, #0x30
                STRB            R0, [R1]
                LDR             R0, =0xFFC0
                MOV             R1, R12
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_top_boundary_offset - CurrentEnemyData)]
                STRH            R3, [R1,#(CurrentEnemyData_CurEnemy_bottom_boundary_offset - CurrentEnemyData)]
                SUB            R0, #0x60
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_left_boundary_offset - CurrentEnemyData)]
                MOV           R0, #0x80
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_right_boundary_offset - CurrentEnemyData)]
                ADD            R1, #0x25
                MOV           R0, #4
                STRB            R0, [R1]
                LDR             R3, =EnemyStattable
       

loc_876107C:                        
                MOV             R0, R12
                LDRB            R1, [R0,#(CurrentEnemyData_CurEnemy_id - 0x3000738)]
                LSL            R0, R1, #3
                ADD            R0, R0, R1
                LSL            R0, R0, #1
                ADD            R0, R0, R3
                LDRH            R0, [R0]
                MOV             R1, R12
                STRH            R0, [R1,#(CurrentEnemyData_CurEnemy_health - 0x3000738)]
                LDR             R0, =off_830401C
                STR             R0, [R2]
                STRB            R4, [R2,#(MaxMovements - 0x300070C)]
                MOV             R0, R8
                STRH            R0, [R2,#(MovementIndex - 0x300070C)]
                STRB            R4, [R2,#(byte_300071A - 0x300070C)]
                STRB            R4, [R2,#(byte_3000719 - 0x300070C)]
                ADD            R1, #0x24
                MOV           R0, #9
                STRB            R0, [R1]
                ADD            R1, #0xF
                MOV           R0, #2
                STRB            R0, [R1]
                MOV           R0, #1
                MOV             R1, R12
                STRB            R0, [R1,#(CurrentEnemyData_CurEnemy_spriteset_slot - 0x3000738)]
                LDRB            R5, [R1,#(CurrentEnemyData_CurEnemy_spriteset_gfx_slot - 0x3000738)]
                MOV             R0, R12
                ADD            R0, #0x23
                LDRB            R4, [R0]
                MOV             R0, R9

ReturnFromHijack:                          
                                        
                STR             R0, [SP]
                STR             R6, [SP, 4]
                MOV             R1, R8
                STR             R1, [SP, 8]
                mov            R0, #0x28
                mov            R1, #0
                mov            R2, R5
                mov            R3, R4
                BL             SpawnSpriteWrapper
                MOV             R0, R9
                STR             R0, [SP]
                STR             R6, [SP, 4]
                MOV             R1, R8
                STR             R1, [SP, 8]
                mov            R0, #0x28
                mov            R1, #2
                mov            R2, R5
                mov            R3, R4
                BL              SpawnSpriteWrapper
                MOV             R0, R9
                STR             R0, [SP]
                STR             R6, [SP, 4]
                MOV             R1, R8
                STR             R1, [SP, 8]
                mov            R0, #0x28
                mov            R1, #3
                mov            R2, R5
                mov            R3, R4
                BL              SpawnSpriteWrapper
                MOV             R0, R9
                STR             R0, [SP]
                STR             R6, [SP, 4]
                MOV             R1, R8
                STR             R1, [SP, 8]
                mov            R0, #0x28
                mov            R1, #4
                mov            R2, R5
                mov            R3, R4
                BL              SpawnSpriteWrapper
                MOV             R0, R9
                STR             R0, [SP]
                STR             R6, [SP, 4]
                MOV             R1, R8
                STR             R1, [SP, 8]
                mov            R0, #0x28
                mov            R1, #5
                mov            R2, R5
                mov            R3, R4
                BL              SpawnSpriteWrapper
				b InitCroc_EndFunc
KillCroc:                               
                LDR             R0, =Line2Move
                MOV           R1, #0
                STR             R1, [R0]
InitCroc_EndFunc:                      
                ADD             SP, SP, #0xC
                POP             {R3,R4}
                MOV             R8, R3
                MOV             R9, R4
                POP             {R4-R6}
                POP             {R0}
                BX              R0

Returns176:                            
                LDR             R1, =CurrentEnemyData_CurEnemy_pose
                LDRB            R0, [R1,#6]
                CMP             R0, #0                                  ;如果3000762的值为0???
                BEQ             loc_8043F1C
                SUB            R0, #(Line2Move+1 - Line2Move)           ;300070
                B               loc_8043F30
; ---------------------------------------------------------------------------

loc_8043F1C:                             ; CODE XREF: Returns176+6↑j
                LDRB            R0, [R1,#0]
                CMP             R0, #8
                BNE             loc_8043F2A
                MOV            R0, #7
                STRB            R0, [R1]
                MOV            R0, #0xB0
                B               loc_8043F30
; ---------------------------------------------------------------------------

loc_8043F2A:                           ;j
                MOV            R0, #8
                STRB            R0, [R1]
                MOV            R0, #0xB0

loc_8043F30:                            
                                       
                STRB            R0, [R1,#(CurrentEnemyData_candraw - CurrentEnemyData_CurEnemy_pose)]
                BX              LR

.pool

SpawnSpriteWrapper:
			LDR r2, =SpawnSprite
			Add R2, 1
			BX r2
			
.pool
.align 2
.close