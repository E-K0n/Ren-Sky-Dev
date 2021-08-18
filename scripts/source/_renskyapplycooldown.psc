Scriptname _RenSkyApplyCooldown extends activemagiceffect  

Spell property CDspell auto

Spell property factionspell auto

Event oneffectstart(actor aktarget, actor akcaster)
factionspell.cast(akcaster)
float speech = game.getplayer().getav("Speechcraft")
if speech >= 100.0
speech = 100.0
endif

speech = speech/2
speech = speech + 25

int random = utility.randomint(0, 100)
float speechint = speech as int
;debug.messagebox(speechint)
if random > speechint
;debug.messagebox("triggered")
debug.notification("Your partner seems exhausted of conversation.")
akcaster.addspell(CDspell)
endif

endevent