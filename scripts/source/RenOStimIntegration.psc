ScriptName RenOStimIntegration Extends quest Hidden

function StartScene(actor npc) Global
	osexintegrationmain ostim = OUtils.GetOStim()

	ostim.StartScene(game.GetPlayer(), npc)
EndFunction