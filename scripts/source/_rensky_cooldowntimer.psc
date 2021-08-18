Scriptname _RenSky_CooldownTimer extends activemagiceffect  

Actor caster
actor target
spell property thisspell auto
Event oneffectstart(actor aktarget, actor akcaster)

caster = akcaster
target = aktarget

RegisterForSingleUpdateGameTime(24)

Endevent

Event onupdategametime()

caster.removespell(thisspell)

endevent

Event oneffectFinish(actor aktarget, actor akcaster)

;debug.messagebox("effect removed")

Endevent