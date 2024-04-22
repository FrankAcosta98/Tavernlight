local talk = TalkAction("/vista", "!vista")



-- Function to create a modal window with a button at a random position
function createRandomModalWindow(player)
    local windowId = 1000-- Unique ID for the modal window
    local title = " "
    local message = " "

    -- Create the modal window
    local modal = ModalWindow(windowId, title, message)

    -- Randomize button position (simulated, not truly changing position in TFS modal windows)
    -- Add a button to the modal window
    modal:addButton(1, "Jump")  -- Button ID and label

    -- Send the modal window to the player
    modal:sendToPlayer(player)
end

-- Command to open the modal window
function talk.onSay(player, words, param)
    createRandomModalWindow(player)
end


talk:separator(" ")
talk:register()
