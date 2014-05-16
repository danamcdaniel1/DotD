^!p::Pause

#MaxThreadsPerHotkey 3
^!a:: 
#MaxThreadsPerHotkey 1
if RaidBool
{
	RaidBool := false
    return
}
RaidBool := true
Loop
{
    if not RaidBool
        break
		
	click
	sleep 1500
}
return

^!q::
Quest()
return

^!r::
Raid()
return

^!w::
WorldRaid()
return

^!v::
MouseGetPos, x, y
Invasion(x,y)
return

Quest()
{
	Loop 100
	{
		click 890 890
		sleep 1200
		
		PixelGetColor, color, 1122, 903
		if (color > 0x9C0000 and color < 0xA80000) {		;battle!
			Loop
			{
				click 496 905
				sleep 1200
				
				PixelGetColor, color, 745, 684
				if (color < 0x300000 and color > 0x280000) { ;victory
					click 1108 772
					break
				}
			}
		}
		
		PixelGetColor, color, 745, 684
		if (color < 0x300000 and color > 0x280000) { 		;stale victory page
			click 1108 772
			sleep 1200
		}
		
		PixelGetColor, color, 604, 585
		if (color = 0xFEFEFE) { 							;Quest Complete
			click 1100 895
			break
		}
		
		PixelGetColor, color, 798, 653
		;msgbox %color%
		if (color = 0xD9AA69 or color = 0xCFA159) { 		;Not Enough Energy
			click 927 647
			sleep 2000
			click 1100 895
			break
		}
	}
}

Raid()
{
	type := 3
	Loop 1000
	{
		if (type = 3) {			;20
			click 837 917
			sleep 1200
		}
		if (type = 2) {			;5
			click 790 917
			sleep 1200
		}
		if (type = 1) {			;1
			click 735 917
			sleep 1200
		}
		
		PixelGetColor, color, 799, 654
		if (color = 0x2DA3E0 or color = 0x2FA0DE) { 	;Health refill
			click 720 650
			sleep 2000
			click 750 640
			sleep 1000
		}
		
		PixelGetColor, color, 798, 653
		if (color = 0xD9AA69 or color = 0xCFA159) { 	;Not Enough Stamina
			click 927 647
			sleep 2000
			type := type - 1
		}
		PixelGetColor, color, 731, 669
		if (color = 0x96ACBC or color = 0x8AA0B0) { 	;Not Enough Honor
			click 835 635
			sleep 2000
			type := type - 1
		}
		
		if(type <= 0) {
			click 1150 910
			break
		}
	}
}

WorldRaid()
{
	Loop
	{
		PixelGetColor, color, 1387, 138
		if(color != 0x99A9B5 and color != 0xA1B1BD){ ;Not Armor Games
			sleep 6000	;poll every 10 seconds
			continue
		}
		
		click 80 50							;chrome refresh
		sleep 20000
		;check for daily loot
		
		click 945 310						;RAID
		sleep 2000
		click 675 440						;ACTIVE RAIDS
		sleep 1000
		
		PixelGetColor, color, 761, 503
		if(color != 0x010101 and color != 0x475154){	;not a world raid
			sleep 600000
			break
		}
		
		Loop 2		;loop twice in case of level
		{
			click 680 570		;engage
			sleep 2000
			Raid()							;stamina
			sleep 1000
			click 680 570		;engage
			sleep 1000
			click 960 910
			sleep 1000
			Raid()							;energy
			sleep 1000
			click 680 570		;engage
			sleep 1000
			click 1000 910
			sleep 1000
			Raid()							;honor
			sleep 1000
		}
		
		sleep 900000						;wait 15 min
	}
}

Invasion(x, y)
{
	Loop 50
	{
		click %x% %y%
		sleep 1000
		click 750 890								;scout
		sleep 1000
		
		PixelGetColor, color, 723, 668
		if (color = 0xA0B6C6) { 					;attacking error
			click 810 630
			sleep 1000
		}
		PixelGetColor, color, 552, 718
		if (color = 0x626C6B) { 					;message wall?
			click 1180 375
			sleep 1000
		}
		PixelGetColor, color, 704, 666
		if (color = 0xA4BACB) { 					;out of tickets
			click 880 640
			sleep 1000
			click 900 900
			break
		}
		
		click 620 800			;slot 1
		sleep 200
		click 800 650			;army 1
		sleep 200
		click 850 730			;slot 2
		sleep 200
		click 800 580			;army 2
		sleep 200
		click 999 800			;slot 3
		sleep 200
		click 800 510			;army 3
		sleep 200
		click 750 890			;attack
		sleep 1000
		click 800 850			;close
		sleep 1000
	}
}