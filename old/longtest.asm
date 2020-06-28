.gba
.open "zm.gba","test.gba",0x8000000
 
.org 8031890h 
 push lr
 ldr     r1,=3000738h                            
    ldr     r0,=82E8CE0h                            
  str     r0,[r1,18h]  ;写入OAM                           
  mov     r0,0h                                   
    strb    r0,[r1,1Ch]                             
  strh    r0,[r1,16h]                             
    mov     r2,r1                                   
    add     r2,24h                                  
   mov     r0,9h        ;pose写入9h  
   bl gotos  
pop r15   
.pool
  
.org 8304054h
   gotos:
   
       strb    r0,[r2]                                 
  ldr     r0,=0FF8Ch                              
     strh    r0,[r1,0Ah]  ;写入上部分界FF8c                           
   add     r0,8h                                   
   strh    r0,[r1,0Ch]  ;写入下部分界8h                           
   bx      r14                       
  
  .pool
  .close


Make sure you are playing on Slot C!

The first part of the setup is saving as you leave Sector 1. The door on the right must be the last door used before saving. If you accidentally enter the navigation room, you have to run back to the recharge room first, so you can enter from the right side. Do not save at any other point in the run. Saving here sets up one of the memory corruptions.

The second part involves breaking blocks in Sector 4. Make sure you break the same blocks as shown in the video. Breaking the last two missile blocks sets up the other memory corruption. After this point, you don't have to worry about which blocks you break.

After getting power bombs, return to the large room with wavers and enter the door on the bottom right. Keep re-entering the large room until the waver spawns facing left. After it bounces back toward the right, jump while it's at the peak of its arc, letting it slam into the wall. Freeze it, then quickly get into the exact position shown in the video. Once you're lined up, lay a power bomb, and do a spin jump into the corner. Turn around and hold left while the power bomb goes off. If you don't go into the ceiling, you were probably too far away from the wall. You can re-enter the room and try again.

Once you're out of bounds, morph, then hold left, then hold A. At this point, you need to count the number of times you see the morph ball cross the screen in the top-left corner. Right before you appear on screen for the 4th time, lay a power bomb. If timed correctly, it will set the area ID in the save data to 0, meaning you'll spawn on the Main Deck. Because the door value stays the same (the one you used in the save room), it will spawn you in the destroyed hallway.

Right before you appear on screen for the 12th time, lay another power bomb. If timed correctly, it will set the event value to 128 (based on the setup done in Sector 4 earlier).

If you want to be really safe, stop a bit early, lay a power bomb, move a few blocks, and lay another one. Do this two or three times for each one.

Shortly after you appear on screen for the 16th time (not immediately after, give it a couple extra bounces), start holding right. This is necessary to make it back in bounds. If you stop bouncing and you're not back in bounds, you're softlocked and you'll have to reset. Once back in bounds, reload the game by dying. Soft-resetting the game will not work. If you spawn in Sector 1 and not in the destroyed hallway, you mistimed the first power bomb. However, the event value may still have been corrupted, so you can still head toward the ship to beat the game. To check if the event value was corrupted, you can pause the game and press A. If you see German text, then it was successfully corrupted. If you spawn in the destroyed hallway, but it reverts to the pre-destroyed hallway when you re-enter from the left, then you mistimed the second power bomb. In this case, you'll have to try again from the save in Sector 1 (or just completely reset if you're aiming for a competitive time).


游戏 
银河战士 融合 - 2002 (YouTube 游戏)
 
  
  
  This trick involves using memory corruption to overwrite the event value stored in save data, allowing you to skip more than a third of the game. The memory corruption is done by getting out of bounds and laying power bombs. Whenever you lay a power bomb, the game checks which blocks are affected by the power bomb explosion. It reads the block's clipdata value and changes it if necessary. Clipdata determines how Samus interacts with a block. Some examples include hatches, missile tanks, and bomb blocks. Depending on the clipdata value, the power bomb explosion might also affect the background 1 value of the block, which determines its appearance. For example, if a power bomb explosion touches a hidden speed booster block, the background 1 value will change to reveal that it's a speed booster block. For clipdata, most values are changed to 0. However, for background 1, many values are changed to 0x8000. The goal of this trick is to change the event value to 0x80 (128 in decimal). Normally, the highest event value in the game is 109.

The clipdata values for the current room start at 0x2026000 in RAM, while the background 1 values start at 0x202C000. Note that these are 0x6000 bytes apart. When a power bomb explosion touches a block, it uses the following formula to find the address of its clipdata value:

0x2026000 + ((y_position / 64) * room_width + (x_position / 64)) * 2

Background 1 uses the same formula, except with 0x202C000 instead of 0x2026000. If you go out of bounds, your X and Y position will be much higher than normal. This means that laying power bombs while out of bounds will access memory addresses that are way past the clipdata and background 1 values. In particular, save data starts at 0x2038200, which can be reached by using this trick. As it turns out, the event value for Slot C is stored at 0x203CA21, and 0x6000 bytes before this contains the blocks that have been broken in Sector 4. Whenever a block is broken that never respawns, three bytes are written to this area: the room ID, the X position of the block, and the Y position of the block.

Clipdata and background 1 values are two bytes. For this trick to work, the two-byte value at 0x2036A20 needs to be a value that the power bomb explosion will interpret as a block that needs to be revealed, thus modifying the value 0x6000 bytes away at 0x203CA20 (where the event value is stored). Since we have control over which blocks to break, we have control over what this value will be. After investigating all of the possibilities, the only value that works is 0x0D05 (which is interpreted as a screw attack block). This is obtained by first breaking 10 blocks, then breaking a block with a Y position of 0x05, then breaking a block in room 0x0D. Conveniently, there are two blocks with a Y position of 0x05 in room 0x0D, and all of these blocks can be broken during the first trip to Sector 4. Once all of these blocks are broken, the correct values will be in memory and no further setup is needed.

At some point during the game before performing the memory corruption, the game needs to be saved at least once, preferably as close to the ship as possible. Technically, the game can be saved in the ship at the very start. For this video, I saved on the Main Deck shortly before getting power bombs.

After obtaining power bombs, all that matters is getting out of bounds in a room that's wide enough (remember that room width is part of the equation for determining the address to check). Getting out of bounds involves freezing an enemy close to a ceiling corner, getting wedged in the corner, and jumping while unmorphing (the game doesn't check for ceilings if you jump while unmorphing). Once out of bounds, I navigate to 0x2038A20 and lay a power bomb, which changes the event value to 0x80. After this, I have to reload the save by dying. If I were to reset the game, the save data would be reloaded from external memory and copy over the memory corruption.

After reloading the save, the game thinks I'm in a state where the Omega Metroid is already dead. Regardless, the game always tries to spawn the Omega Metroid, since the door is supposed to lock behind you and you can't re-enter. If you allow it to spawn, you'll get softlocked because the SA-X will never show up. However, you can trick the game into triggering the Omega Metroid's death by visiting the room twice, which causes the ship to arrive. I have to go two rooms back, because only the destroyed version of the hallway leads to the destroyed version of the docking bay.

This trick is possible in real-time (it's not TAS-only), but it requires careful counting during the out of bounds portion. I know this trick is very complex and hard to explain, so I'll try to answer any questions in the comments.