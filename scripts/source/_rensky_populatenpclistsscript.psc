Scriptname _RenSky_PopulateNPCListsScript extends Quest  


Formlist property FactionsFL auto
Formlist property NPCsFL auto

Event OnInit()
debug.notification("Populating Ren'Sky NPCs.")
int outerindex = 0
while outerindex < FactionsFL.getsize()

	Faction currFaction = FactionsFL.getat(outerindex) as Faction
	Formlist currFL = NPCsFL.getat(Outerindex) as Formlist
	;debug.messagebox(currfaction)
	;debug.messagebox(currFL)
	int innerindex = 0

	while innerindex < currFL.getsize()
		actor thisref = currFL.getat(innerindex) as actor
		;debug.messagebox(currfaction)
		;debug.messagebox(thisref)
		thisref.addtofaction(currFaction)
		innerindex = innerindex + 1
	endwhile
	
	outerindex = outerindex + 1

	endwhile
Endevent