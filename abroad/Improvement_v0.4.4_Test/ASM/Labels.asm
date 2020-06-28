.definelabel ArmPosition,0x3000BEC
.definelabel BeamBombActivation,0x300153D
.definelabel ButtonInput,0x300137C
.definelabel ChangedInput,0x3001380
.definelabel ChargeCounter,0x3001419
.definelabel CheckTimerDisplayed,0x8053968
.definelabel CollisionTypes,0x02002000
.definelabel Color1,0x7DBF ;
.definelabel Color2,0x7E5F ; Adjustable colors for 4th animated minimap palette
.definelabel Color3,0x7EFF ; minimapColors.asm uses the 7th slot at $32BA68 for a 4th minimap color. (Pink per my default)
.definelabel Color4,0x7E5F ; $4113E0 for map screen 4th color (static) and $3FD2D0 for the dimmed version (also static)
.definelabel Color5,0x7DBF ;
.definelabel CurrSprite,0x3000738
.definelabel DecompClipdata,0x2027800
.definelabel Difficulty,0x300002C
.definelabel DoorUnlockTimer, 0x300007B
.definelabel Equipment,0x3001530
.definelabel EscapeTimerValues,0x300095E
.definelabel HideHudFlag,0x300004A
.definelabel MaxPercent,100 ; change this line to desired max percent
.definelabel MessageInfo,0x3000C0C
.definelabel Pose,0x30013D4
.definelabel PrevYposition,0x3001602
.definelabel RoomEffect,0x30000CC
.definelabel RoomWidth,0x30000B8
.definelabel SamusData,0x30013D4
.definelabel ShineTimer,0x30013DC
.definelabel Yposition,0x30013E8

.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0

.definelabel PlaySound,8002A18h
.definelabel PlaySound2,8002b20h
.definelabel PlaySound3,8002c80h
.definelabel DirectionTag,800F8E0h       ;检查敌人与samus的左右位置
.definelabel SpriteDataPointers,82b0d68h
.definelabel SamusData,30013d4h
.definelabel CheckRange,800FDE0h
.definelabel CheckBlock,800F688h         ;检查7F1 适合头顶
.definelabel CheckBlock2,800F47Ch        ;检查7F0 适合身下
.definelabel CheckBlock3,800f720h
.definelabel CheckAnimation,800FBC8h
.definelabel CheckAnimation2,800FC00h
.definelabel CurrSprite,3000738h
.definelabel DeathFireWorks,8011084h
.definelabel SpriteDrop,800E3D4h
.definelabel FrozenRoutine,800FFE8h
.definelabel StunSprite,8011280h
.definelabel XTagRAM,30007F0h
.definelabel YTagRAM,30007F1h
.definelabel SpriteAiStart,875e8c0h
.definelabel SpriteRNG,300083Ch
.definelabel BGDataStart,300009Ch
.definelabel SpriteGfxPointers,0x875EBF8
.definelabel SpritePalPointers,0x875EEF0
.definelabel UPOutWaterEffect,80116cch
.definelabel DropInWaterEffect,8011718h
.definelabel MakeWaterEffect,8011620h

.definelabel ReRooMusic,80039F4h
.definelabel CheckRange,800FDE0h
.definelabel CheckEvent,80608bch
.definelabel MainSpriteDateStart,82b0d68h
.definelabel RandomDirection,800F80Ch
.definelabel XShake,8055378h
.definelabel YShake,8055344h

.definelabel StopRoomMusic,8003A98h
.definelabel GfxEffect,80540ECh
.definelabel SpawnNewPrimarySprite,800E31Ch