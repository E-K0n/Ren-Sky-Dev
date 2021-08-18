Scriptname _RenSky_ItemListenerScript extends activemagiceffect  
actor caster
globalvariable property costscalevar auto

Formlist property FactionFL auto
Formlist property ContainerFL auto
faction property lovefaction auto
bool hasbeengiven
spell property factionadder auto
Event oneffectstart(actor aktarget, actor akcaster)
caster = akcaster
factionadder.cast(aktarget)

endevent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
if aksourcecontainer == game.getplayer() as objectreference 

int costscale = costscalevar.getvalue() as int
if hasbeengiven == false
caster.removeitem(akbaseitem, aiitemcount)
hasbeengiven = true

;self.dispel()
	;Debug.messagebox("Added")

	if !caster.isinfaction(lovefaction)
		caster.addtofaction(lovefaction)
	endif

	;first, find item's worth in gold. 
	
	int itemworth = akbaseitem.getgoldvalue()


	;Check the target's interest faction

	int Factionindex = 0
	bool factionfound

	while Factionindex < FactionFL.getsize() && factionfound == false

		Faction currfaction = FactionFL.getat(Factionindex) as Faction

		if caster.isinfaction(currfaction)

			factionfound = true
			else
			Factionindex = Factionindex + 1 

		endif

	endwhile

	;Now that faction index is found, can check for appropriate keywords
	
	;if no faction was found, assign a faction at random

	if factionfound == false

		Factionindex = utility.randomint(1, FactionFL.getsize()) 
		Factionindex = factionindex - 1
		caster.addtofaction(FactionFL.getat(Factionindex) as Faction)
		;debug.messagebox("No faction found, adding to " + factionindex)
	endif

	;Now, iterate through Formlist of Formlists to find appropriate KYWD Formlist

	Formlist KWDFL = containerFL.getat(Factionindex) as Formlist

	int index = 0
	bool matched

	while index < KWDFL.getsize() && matched == false
	
		if akBaseItem.haskeyword(KWDFL.getat(index) as keyword)

			matched = true
	
		else

			index = index + 1

		endif

	endwhile

	;if keyword found, triple the item value
	if matched

	Itemworth = itemworth *2

	endif


	;Now, run calculations to find chance that they actually like your present
	;chance gift is liked is 1 - (200/(200+itemvalue))
	;i.e. an item with a value of 200 would have a 1 - (200/400) = 0.5 = 50% chance of being liked
	;an item of value 400 would have a 1-(200/600) = 0.6666 = 66% chance of being liked

	float chance = costscale+itemworth
	chance = costscale/chance
	;debug.messagebox(chance)
	chance = 1-chance

	chance = chance*100
	;debug.messagebox(chance)
	int chanceint = chance as int
	;debug.messagebox(chanceint)
	int random = utility.randomint(0, 100)

	if random < chanceint

		if caster.getfactionrank(lovefaction) < 9
			caster.modfactionrank(lovefaction, 1)

		endif
		debug.notification("Your gift is well recieved!")

	else

	debug.notification("Your gift fails to impress.")


	endif


else
debug.messagebox("You may only give each person one gift per day.")
game.getplayer().additem(akbaseitem, aiitemcount)
endif

endif

Endevent