--- Controller shoulder button support for Cryptid
--- Adds gamepad shoulder button functionality for controller-only play.
---
--- Features:
--- - Left Shoulder (L1/LB): Select/toggle highlight on focused card
--- - Right Shoulder (R1/RB): Flip double-sided cards
--- - Both Shoulders Together: Select all cards in hand

--- Track shoulder button states for "both pressed" detection
local shoulder_state = {
	left_pressed = false,
	right_pressed = false,
	both_action_fired = false,
}

--- Handle shoulder button input for gamepad controls.
--- Processes left/right shoulder button presses for card selection and flipping.
--- @param button string The LÖVE gamepad button name ("leftshoulder" or "rightshoulder")
--- @param pressed boolean True if button was pressed, false if released
function Cryptid.handle_shoulder_button(button, pressed)
	-- Only process if the feature is enabled
	if Cryptid_config and Cryptid_config.controller_shoulders == false then
		return
	end

	if button == "leftshoulder" then
		shoulder_state.left_pressed = pressed
	elseif button == "rightshoulder" then
		shoulder_state.right_pressed = pressed
	else
		return
	end

	-- Reset "both" flag when either is released
	if not pressed then
		shoulder_state.both_action_fired = false
		return
	end

	-- Check for both shoulders pressed (select all hand cards)
	if shoulder_state.left_pressed and shoulder_state.right_pressed then
		if not shoulder_state.both_action_fired then
			shoulder_state.both_action_fired = true
			Cryptid.select_all_hand_cards()
		end
		return
	end

	-- Single shoulder actions (only on press, not hold)
	if pressed then
		if button == "leftshoulder" then
			Cryptid.shoulder_select_focused()
		elseif button == "rightshoulder" then
			Cryptid.shoulder_flip_card()
		end
	end
end

--- Select all cards currently in the player's hand.
--- Only works during the hand selection phase of gameplay.
function Cryptid.select_all_hand_cards()
	if not G.hand or not G.hand.cards or #G.hand.cards == 0 then
		return
	end

	-- Check if we're in a state where we can select cards
	if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND then
		-- Select all cards (user preference: always select all regardless of current selection)
		for _, card in ipairs(G.hand.cards) do
			if not card.highlighted then
				G.hand:add_to_highlighted(card, true)
			end
		end
		play_sound("cardSlide1", 0.5)
	end
end

--- Toggle selection on the currently focused card using controller navigation.
--- Works with jokers, hand cards, and consumables.
function Cryptid.shoulder_select_focused()
	-- Get the currently focused element from controller
	local target = G.CONTROLLER and G.CONTROLLER.cursor_hover and G.CONTROLLER.cursor_hover.target

	if not target then
		return
	end

	-- Check if target is a card in the jokers area
	if target.area == G.jokers then
		-- Toggle highlight on joker
		if target.highlighted then
			G.jokers:remove_from_highlighted(target)
		else
			G.jokers:add_to_highlighted(target, true)
		end
		play_sound("cardSlide1", 0.5)
	-- Support selecting hand cards with L1
	elseif target.area == G.hand then
		if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND then
			if target.highlighted then
				-- Deselect if already highlighted
				G.hand:remove_from_highlighted(target)
			else
				G.hand:add_to_highlighted(target, true)
			end
			play_sound("cardSlide1", 0.5)
		end
	-- Support consumeables too
	elseif target.area == G.consumeables then
		if target.highlighted then
			G.consumeables:remove_from_highlighted(target)
		else
			G.consumeables:add_to_highlighted(target, true)
		end
		play_sound("cardSlide1", 0.5)
	end
end

--- Flip a double-sided card if the currently focused card has that edition.
--- Only works on cards with the cry_double_sided edition.
function Cryptid.shoulder_flip_card()
	local target = G.CONTROLLER and G.CONTROLLER.cursor_hover and G.CONTROLLER.cursor_hover.target

	if not target then
		return
	end

	-- Only flip cards with double-sided edition
	if target.edition and target.edition.cry_double_sided then
		if target.flip_side then
			target:flip_side()
			play_sound("card1", 1)
			target:juice_up(0.3, 0.3)
		end
	end
end

--- Check if controller shoulder button feature should be active.
--- Returns false if we're in menus, paused, or overlay is shown.
--- @return boolean True if shoulder button handling should be active
local function should_handle_controller_input()
	-- Only active during gameplay
	if G.STAGE ~= G.STAGES.RUN then
		return false
	end

	-- Disabled when paused
	if G.SETTINGS and G.SETTINGS.paused then
		return false
	end

	-- Disabled when overlay menu is shown
	if G.OVERLAY_MENU then
		return false
	end

	return true
end

-- Hook into LÖVE's gamepad event handlers
local original_gamepadpressed = love.handlers.gamepadpressed
love.handlers.gamepadpressed = function(joystick, button)
	-- Call original handler first
	if original_gamepadpressed then
		original_gamepadpressed(joystick, button)
	end

	-- Handle shoulder buttons during gameplay
	if should_handle_controller_input() then
		Cryptid.handle_shoulder_button(button, true)
	end
end

local original_gamepadreleased = love.handlers.gamepadreleased
love.handlers.gamepadreleased = function(joystick, button)
	-- Call original handler first
	if original_gamepadreleased then
		original_gamepadreleased(joystick, button)
	end

	-- Always process releases to reset state
	if G.STAGE == G.STAGES.RUN then
		Cryptid.handle_shoulder_button(button, false)
	end
end
