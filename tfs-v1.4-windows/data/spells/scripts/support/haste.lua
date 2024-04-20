local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)

function onGetFormulaValues(player, skill, attack, factor)
    local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
    local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local speed = 25
local range = 7

function charge_calculate_next_pos(direction, pos)
    if direction == 0 then
         return Position(pos.x, pos.y - 1, pos.z)

    elseif direction == 1 then
         return Position(pos.x + 1, pos.y, pos.z)

    elseif direction == 2 then
         return Position(pos.x, pos.y + 1, pos.z)

    elseif direction == 3 then
         return Position(pos.x - 1, pos.y, pos.z)

    elseif direction == 4 then
         return Position(pos.x - 1, pos.y + 1, pos.z)

    elseif direction == 5 then
            return Position(pos.x + 1, pos.y + 1, pos.z)

    elseif direction == 6 then
            return Position(pos.x - 1, pos.y - 1, pos.z)

    elseif direction == 7 then
            return Position(pos.x + 1, pos.y - 1, pos.z)
    end
end

function charge_move(cid, path, key, variant)
    local creature = Creature(cid)
    local player = Player(cid)
    
    if player == nil and creature == nil then
        return false
    end

    if key == 1 then
        creature:setMovementBlocked(true)
    end

    local newPos = creature:getPosition()
    local tempPos = newPos
    for i = 1, 4 do
        if key <= #path then
            newPos = charge_calculate_next_pos(path[key], newPos)

            local tile = Tile(newPos)
            if tile ~= nil and tile:getCreatureCount() > 0 then
                creature:teleportTo(tempPos, true)
                creature:setMovementBlocked(false)
                creature:setDirection(path[key])
                return true
            end

            tempPos = newPos
            key = key + 1
            newPos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
        end
    end

    creature:teleportTo(newPos, false)

    if key <= #path then
        addEvent(charge_move, speed, cid, path, key, variant)
    else
        local target = creature:getTarget()
    
        if player and target then
            doChallengeCreature(player, target)
        end
        creature:setMovementBlocked(false)
        combat:execute(creature, variant)
    end
    return true
end

function charge(creature, variant)
    local target = creature:getTarget()
    local direction = creature:getDirection()
    local position = creature:getPosition()
    
    if target ~= nil then
        local path = creature:getPathTo(target:getPosition(), 0, 1, true, true, range)
        if path and #path > 0 then
            charge_move(creature:getId(), path, 1, variant)
        end
        return true
    end

    return RETURNVALUE_NOTPOSSIBLE
end

function onCastSpell(creature, variant)
    local oldPos = creature:getPosition()
    local returnValue = charge(creature, variant)
    local newPos = creature:getPosition()

    if returnValue == RETURNVALUE_NOTPOSSIBLE or oldPos == newPos then
        creature:sendCancelMessage(returnValue)
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    return true
end