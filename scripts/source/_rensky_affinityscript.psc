Scriptname _RenSky_AffinityScript extends activemagiceffect  
Faction property lovefaction auto
bool property ispositive auto
float property multiplier auto
spell property CDSpell auto
miscobject property gold auto
miscobject property garlic auto
Formlist property PersonalityList auto
Formlist property InterestList auto
actor playerref

Keyword property JewelKYWD auto
quest property bardquest auto

Spell Property LotharioAB auto
Spell Property GallantAB auto
Spell Property MeekAB auto
Spell Property DepravedAB auto

;[Formlist Indices]
;[Interests]
;[1: Alchemy]
;[2: Commerce]
;[3: Fashion]
;[4: Gourmet]
;[5: Humanities]
;[6: Hunting]
;[7: Magic]
;[8: War]

;[Personality]
;[1: Dignified]
;[2: Irritable]
;[3: Outgoing]
;[4: Seductive]
;[5: Shy]
;[6: Tomboyish]
;[7: Maternal]


Event oneffectstart(actor aktarget, actor akcaster)
	; Cache, each call to game.getplayer takes an entire frame
	playerref = game.GetPlayer()

	;[If the target isn't in the love faction, add it to love faction]

	if !akcaster.isinfaction(lovefaction)
		akcaster.addtofaction(lovefaction)
	endif

	;[get player speech value. If greater than 100, truncate to 100]

	float speech = playerref.getav("Speechcraft")
	if speech >= 100.0
		speech = 100.0
	endif

	;[Using a base value of 10%, add 20% of your speech level as bonus chance (Max 30%)]

	speech = speech/5
	speech = speech + 10
	;speech = speech * multiplier

	;[Apply Personality and Interest Checks, up to 20% each (Max 70%)]

	int PersonalityIndex = CheckFactionindex(akcaster, Personalitylist)
	int InterestIndex = CheckFactionindex(akcaster, Interestlist)

	Int Personalityresult = PersonalityHandler(PersonalityIndex)
	Int Interestresult = InterestHandler(InterestIndex)

	If personalityresult > 20
		personalityresult = 20
	endif

	If interestresult > 20
		interestresult = 20
	endif

	if speech > 30
		speech = 30
	endif

	speech = speech + Personalityresult + InterestResult


	;[Uses congealed speech value to run a check, if the ispositive property is true. Otherwise, ALWAYS run negative effect]

	int random = utility.randomint(0, 100)
	float speechint = speech as int

	if ispositive && random< speech
		modfactionrankboth(akcaster)
	elseif !ispositive
		modfactionrankboth(akcaster)
	endif


endevent


;/
--------------------------------------------------------------------------------------------------------------------
/;

	;[Function to modify relationship rank, positive increments also increase speech skill]



Function modfactionrankboth(actor thisactor)

	if thisactor.getfactionrank(lovefaction) < 0
		thisactor.setfactionrank(lovefaction, 0)
	endif

	if ispositive

		if thisactor.getfactionrank(lovefaction) < 9
			float skillinc = playerref.getav("Speechcraft")
			skillinc = skillinc * 10
			Game.AdvanceSkill("Speechcraft", skillinc)
			thisactor.modfactionrank(lovefaction, 1)

			debug.notification("Your affinity has increased!")

		endif

	elseif thisactor.getfactionrank(lovefaction) > 0

		thisactor.modfactionrank(lovefaction, -1)

		debug.notification("Your affinity has decreased!")
		CDSpell.cast(thisactor)

	endif

endfunction



;/
--------------------------------------------------------------------------------------------------------------------
/;

	;[Faction Check Function, returns faction index]


Int Function CheckFactionindex(actor thisactor, Formlist tocheck)

	int index = 0

	while index < tocheck.getsize()

	Faction currFac = tocheck.getat(index) as faction

	if thisactor.isinfaction(currFac)
		return index
	endif

	index = index + 1



	endwhile

	return -1


Endfunction




;/
--------------------------------------------------------------------------------------------------------------------
/;

	;[Personality Handler]

Int Function PersonalityHandler(Int PIndex)
int toreturn = 0
;/
Diginified
 ----------------------------------------------------------------------------------------------
/;

If PIndex == 0

	If playerref.hasspell(GallantAB)
	toreturn += 20
	Endif



Endif

;/
Irritable
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 1

	If playerref.hasspell(LotharioAB)
	toreturn += 20
	Endif


Endif

;/
Outgoing
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 2

	If playerref.hasspell(GallantAB)
	toreturn += 20
	Endif


Endif

;/
Seductive
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 3

	If playerref.hasspell(LotharioAB) || playerref.hasspell(MeekAB)
	toreturn += 20
	Endif


Endif

;/
Shy
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 4

	If playerref.hasspell(LotharioAB) || playerref.hasspell(GallantAB)
	toreturn += 20
	Endif

Endif

;/
Tomboyish
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 5

	If playerref.hasspell(MeekAB) || playerref.hasspell(GallantAB)
	toreturn += 20
	Endif

Endif

;/
Maternal
 ----------------------------------------------------------------------------------------------
/;


If PIndex == 6

	If playerref.hasspell(MeekAB)
	toreturn += 20
	Endif

Endif

return toreturn
Endfunction














;/
--------------------------------------------------------------------------------------------------------------------
/;

	;[Interest Handler]

Int Function InterestHandler(Int IIndex)

int toreturn = 0

;/
Alchemy
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 0
	float ALCH = playerref.getactorvalue("Alchemy")
	ALCH = ALCH/5
	int AlchInt = AlCH as Int

	toreturn = toreturn + AlchInt

Endif

;/
Commerce
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 1
	int goldcount = playerref.getitemcount(Gold)

	if goldcount >= 5000
	goldcount = 5000
	endif
	
	goldcount = goldcount/250

	toreturn = toreturn + goldcount


Endif

;/
Fashion
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 2

if playerref.wornhaskeyword(JewelKYWD)

toreturn += 20

endif


endif

;/
Gourmet
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 3

	int goldcount = playerref.getitemcount(garlic)

	if goldcount >= 40
	goldcount = 40
	endif
	
	goldcount = goldcount/2

	toreturn = toreturn + goldcount




endif

;/
Humanities
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 4
if Bardquest.iscompleted()
toreturn += 20

endif

Endif




;/
Hunting
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 5

	float ALCH = playerref.getactorvalue("Marksman")
	ALCH = ALCH/5
	int AlchInt = AlCH as Int

	toreturn = toreturn + AlchInt

endif


;/
Magic
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 6

	float DES = playerref.getactorvalue("Destruction")
	float CON = playerref.getactorvalue("Conjuration")
	float ALT = playerref.getactorvalue("Alteration")
	float RES = playerref.getactorvalue("Restoration")
	float ILL = playerref.getactorvalue("Illusion")
	float ENCH = playerref.getactorvalue("Enchanting")
	
	if CON < DES
	DES = Con

	endif

	if ALT < DES
	DES = ALT

	endif

	if RES < DES

	DES = RES

	endif

	if ILL < DES

	DES = ILL
	
	endif

	if ENCH < DES

	DES = ENCH

	endif








	DES = DES/5
	int AlchInt = DES as Int











	toreturn = toreturn + AlchInt

endif

;/
Magic
 ----------------------------------------------------------------------------------------------
/;


If IIndex == 7

	float DES = playerref.getactorvalue("Onehanded")
	float CON = playerref.getactorvalue("Twohanded")
	float ALT = playerref.getactorvalue("Heavyarmor")
	float RES = playerref.getactorvalue("Lightarmor")
	
	if CON < DES
	DES = Con

	endif

	if ALT < DES
	DES = ALT

	endif

	if RES < DES

	DES = RES

	endif

	DES = DES/5
	int AlchInt = DES as Int

	toreturn = toreturn + AlchInt

endif



















return toreturn
Endfunction