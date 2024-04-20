--Q1
Fix or improve the name and the implementation of the below method

function do_sth_with_PlayerParty(playerId, membername)
player = Player(playerId)
local party = player:getParty()

for k,v in pairs(party:getMembers()) do
if v == Player(membername) then
party:removeMember(Player(membername))
end
end
end

--Fixed

function removePlayerFromParty(playerId, playerName)
    local player = Player(playerId)
    
    -- Check if the player is in a party
    if player:getParty() == nil then
        print("Player is not in a party.")
        return
    end
    else
    local party = player:getParty()
    
    -- Iterate through party members to find the specified player
    for _, member in ipairs(party:getMembers()) do
        if member:getName() == playerName then
            -- Remove the specified player from the party
            party:removeMember(member)
            print("Player " .. playerName .. " removed from the party.")
            return
        end
    end
    end
    -- If the specified player is not found in the party
    print("Player " .. playerName .. " is not in the party.")
end

