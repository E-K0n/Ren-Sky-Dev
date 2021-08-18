Scriptname _RenSky_RandomFactionAddScript extends activemagiceffect  
Formlist property PFL auto
Formlist property IFL auto

Event oneffectstart(actor aktarget, actor akcaster)

int findex1 = 0
int findex2 = 0
bool found1
bool found2

findindex(findex1, found1, IFL, akcaster)

findindex(findex2, found2, PFL, akcaster)

Endevent

Function findindex(int index, bool found, formlist FL, actor caster)

while index < FL.getsize() && found == false

	Faction currfaction = FL.getat(index) as Faction

	if caster.isinfaction(currfaction)

		found = true
		else
		index = index + 1 

	endif

endwhile

if !found

		index = osanative.randomint(1, FL.getsize()) 
		index = index - 1
		caster.addtofaction(FL.getat(index) as Faction)
		;debug.messagebox("No faction found, adding to " + index)

endif


Endfunction

