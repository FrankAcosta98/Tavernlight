--Q2
function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
local guildName = result.getString("name")
print(guildName)
end

--Fixed

function printSmallGuildNames(memberCount)
    -- String with count
    local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
    local resultId = db.storeQuery(selectGuildQuery)
    -- Check if succesfull
    if resultId ~= false then
        repeat
            local guildName = result.getDataString(resultId, "name")
            print(guildName)
        until not result.next(resultId)
        -- Free the results
        result.free(resultId)
    else
        print("Error executing query")
    end
end
