Scriptname _RenSkyApplyCooldown extends activemagiceffect  

Spell property CDspell auto

Spell property factionspell auto

Event oneffectstart(actor aktarget, actor akcaster)
	factionspell.cast(akcaster)
	float speech = papyrusutil.clampfloat(game.getplayer().getav("Speechcraft"), 0.0, 100.0 )
	speech /= 2
	speech +=  25

	int random = osanative.randomint(0, 100)
	float speechint = speech as int
	;debug.messagebox(speechint)
	if random > speechint
	;debug.messagebox("triggered")
		debug.notification("Your partner seems exhausted of conversation.")
		akcaster.addspell(CDspell)
	endif

endevent