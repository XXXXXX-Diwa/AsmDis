+===============+
| KNOWN ISSUES: |
+===============+
 	No music will play after completing the Chozo trial. It will begin to replay once you load the next room however.
	The map station in tourian is facing the wrong way!
	SM controls is buggy with charge beam and upwards shots.
	There's some sort of complication involving the SM-Style item grabbing, I haven't figured it out yet so for now it is disabled

+=========================+
| WHAT IS ZM IMPROVEMENT? |
+=========================+
	ZM Improvement is a work-in-progress hack that introduces quality-of-life changes to the North American Metroid Zero Mission ROM.
	It is similar to Super Metroid Project Base in that it is designed from the ground up as a modular base for future Metroid: Zero Mission ROMHacks.
	Every ASM is easily toggleable on and off via commenting them out in Project.asm.

+=========+
| CREDITS:|
+=========+
	biospark -- author of MAGE, provided lots of help putting this together. These were his contributions:
		Customizable 4th minimap color
		Enable Unknown Items (+ GFX / Text)
		Enable use of Power Bombs before Bombs
		Fusion style R-shotting
		Item percentage scaling
		Metroid Prime-style tractor beam (Suck in drops with charge beam)
		Mid-air ballsparking
		Removal of chozo statue hint system
		Remove intro closeup of Samus' face
		SM-style ability toggling in the status screen
		Starting Room
		Two-Line Text Boxes

	Captain Glitch -- Aside from general help with this project, his contributions include:
		Adjustable escape timers
		Better Morphball Rolling
		SM style controls
		SM style item grabbing
		Toggle missile select with R
		gravity suit taking heat damage
		shinespark steering
		speedbooster in morphball
		unlocking of Kraid's doors
		
	Cosmic -- bullied biospark and glitch to make this a thing. Also added:
		Better Rinka Drops (Needs testing)
		Changed the level design (improvement.ips)
		Fixed mothership damage door hatches
		Fixed tiling errors
		Locked an early powerbomb tank in Norfair behind a power bomb block (Did this to prevent skipping a major chunk of the game)

	Passar -- author of the patch that makes borders on tiles less noticeable

	magconst -- The metconst subcommunity dedicated to hacking the GBATroids.

	Metroid Construction -- The #1 source for all things hacking metroid

	Metroid: Zero Mission speedrunners -- provided lots of input on what to change in this hack

+=============+
| Directions: |
+=============+
	If you want to play it as-is:
	◘ Patch the just_play_improvement IPS to a vanilla ZM ROM.

	If you wish to customize your experience:
	◘ Put a vanilla MZM (U) rom in the extracted folder and rename it to [zm.gba].  
	◘ Drag [improvement.asm] over armips.exe and armips should spit out a file named [improvement.gba].
	◘ Apply the ZM Improvement IPS Patch from the IPS folder to improvement.gba.
	◘ (Optional) Apply the maroonless IPS Patch from the IPS folder to improvement.gba.
	◘ To disable an ASM patch, open improvement.asm in a text editor and add a semicolon (;) in front of lines of patches you do not want to have applied. Then, re-run armips. It will overwrite the previous improvement.gba file.
	◘ To disable hex tweaks, open ASM\Tweaks.asm and add a semicolon (;) in front of lines of patches you do not want to have applied. Then, re-run armips. It will overwrite the previous improvement.gba file

	For using the ASM in other hacks:
	◘ Put a vanilla MZM (U) rom in the extracted folder and rename it to [zm.gba].  
	◘ Drag [improvement.asm] over armips.exe and armips should spit out a file named [improvement.gba].
	◘ To disable an ASM patch, open improvement.asm in a text editor and add a semicolon (;) in front of lines of patches you do not want to have applied. Then, re-run armips. It will overwrite the previous improvement.gba file.
	◘ To disable hex tweaks, open ASM\Tweaks.asm and add a semicolon (;) in front of lines of patches you do not want to have applied. Then, re-run armips. It will overwrite the previous improvement.gba file.



+====================+
| Assembly Contents: |
+====================+
	This ASM patch is a combination of:
		Tweaks -- Various hex tweaks. Give them a look!
		BallSpark -- This enables initiating a morph ball shinespark, in midair.
		BetterMorphRoll -- When you are in morph ball form, standing still pauses morph ball's animation.
		GravityHeat -- Even with the gravity suit, Samus will take heat damage without the Varia Suit.
		PBsBeforeBombs -- This lets you use Power Bombs before obtaining Bombs, and prevents a softlock in the status screen for doing so.
		RemoveCloseup -- Samus' Closeup at the beginning of the game is known to mess with graphics in hacks, so this lets hackers disable it with ease.
		itemGrab -- This makes item grabbing more like Super Metroid in that it doesn't take you to the status screen every time.
		itemToggle -- You can toggle abilities on and off with [select] in the status screen, a la super metroid.
		minimapColors -- This is used for animating a fourth minimap color, (in ZM Improvement, the pink heated secret tiles) as well as assigning a slot in the minimap palette for the fourth color.
		noHints -- With this ASM, you will no longer have to worry about unskippable chozo statues. All of the chozo will already be sitting down, usable as recharge stations.
		rShot -- In Fusion, samus could fire a charged beam without interrupting her spin jump by pressing [R]. This ASM brings that functionality back to Zero Mission.
		rToggle -- You can think of this as a lite SM Controls. Instead of having to hold down R to arm missiles or power bombs, the R button toggles them.
		sparkSteering -- Shinesparking is now steerable with the DPAD, within reason. Vertical sparks steer horizontally, Horizontal sparks steer vertically. Diagonal sparks are also effected.
		speedBall -- Samus can now use the morphball to begin speed boosting.
		startingItems -- This lets hackers Configure the ammo, energy, and abilities you start the game with.
		startingRoom -- This is used for hackers to Configure the area, door and music track you start the game at.
		tractorBeam -- With a fully charged beam you can suck in item drops, a la Metroid Prime.
		twoLineTXT -- This makes every item message box 2 lines tall. It's used for faster item grabbing.
		unkItems -- Samus' suit is now compatible with unknown items, right from the start!

	With possibly more to come in the future!



+===============+
| IPS Contents: |
+===============+
The IPS patches are:

ZM Improvement.ips -- QOL changes that are not made with asm
	Two pirates at the very beginning of the stealth sequence have been moved, so that perfect stealth is humanly achievable. 
	Some missile blocks in chozodia have been edited to make 9% hard possible.
	Long beam room has a hard mode spriteset.
	Some enemies in the bottom of kraid's first room spawn correctly now.
	A barrier sprite was removed in norfair, allowing for clearing the game without obtaining power grip.
	The PB Tank in Norfair is now hidden behind PB blocks, to prevent obtaining it too early with the Gravity Suit and skipping most of the game.
	The USA font is replaced with the EUR font. This is to fit more text on screen. (You'll see why once you jump in!)
	A new path has opened for skipping the Mua. This path is a secret, and provides its own challenge.
	Unknown items are skippable.
	Speed Booster is skippable.
	A lot of graphical tiling errors have been fixed.
	The Ridley fight begins immediately. You have to EARN gravity suit!
	Rinka drops have been somewhat improved. This needs testing though!
	Tourian has had some QOL changes, like a map room and a tweaked area map. (Some are still in progress!)
	Mother Brain's room has been made less annoying by making some blocks power grippable.

Maroonless.ips -- This replaces the maroon borders around tilesets with the darkest shade of a tileset. It's not a permanent solution, but looks a lot better than without it. This was made a separate patch, for people who would prefer to have the maroon borders.
