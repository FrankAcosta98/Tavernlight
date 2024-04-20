--Q1
local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
    addEvent(releaseStorage, 1000, player)
end
    return true
end

--Fixed

-- Made the storage size more easly resizable
local standarStorage=1000
local function releaseStorage(player)
    player:setStorageValue(standarStorage, -1)
end


function onLogout(player)
    if player:getStorageValue(standarStorage) == 1 then
        addEvent(releaseStorage, standarStorage, player)
    end
    return true
end
