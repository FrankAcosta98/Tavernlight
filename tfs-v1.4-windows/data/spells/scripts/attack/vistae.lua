local talk = TalkAction("/vista", "!vista")

function talk.onSay(player, words, param)
    local windowId = 1000  -- Unique ID for the modal window
    local title = " "
    local message = " "

    -- Create a new modal window
    local modal = ModalWindow(windowId, title, message)

    -- Add a button
    modal:addButton(1,"Jump",
		function(button,choice)
			local randomX = math.random(0, 200)
    		local randomY = math.random(0, 200)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Button clicked!")
		end
	)  -- (ID, Label)
	modal:addButton(2,"exit")
    -- Set default button behaviors
    modal:setDefaultEnterButton(2)

    -- Display the modal window to the player
    modal:sendToPlayer(player)

    return false  -- Return false to prevent other behavior from happening
end
-- Event handler for modal window responses


talk:separator(" ")
talk:register()
