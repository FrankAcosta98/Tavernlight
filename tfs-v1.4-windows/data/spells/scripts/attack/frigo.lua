local combat = Combat()
--modified parameters of spell to show ice particles
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_WAVEFrigo))

function onGetFormulaValues(player, level, magicLevel)
	doAreaCombat(cid, COMBAT_FIREDAMAGE, position, 0, -100, -100, CONST_ME_EXPLOSIONHIT)

	local min = (level / 5) + (magicLevel * 4.5) + 35
	local max = (level / 5) + (magicLevel * 7.3) + 55
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
