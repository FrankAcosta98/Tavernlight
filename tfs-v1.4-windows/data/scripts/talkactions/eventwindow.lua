-- Event handler for modal window responses
function onModalWindow(player, modalWindowId, buttonId, choiceId)
    if modalWindowId == 1000 then  -- Check for the specific modal window ID
        if buttonId == 1 then  -- Button ID for "Press Me"
            -- Simulate moving the button by reopening the window with a new random position
            createRandomModalWindow(player)

            return true
        end
    end

    return false
end
