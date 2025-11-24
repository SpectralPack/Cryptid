-- ascended.lua - Used for Ascended Hands

G.FUNCS.cry_asc_UI_set = function(e)
	if G.GAME.cry_exploit_override then
		e.config.object.colours = { darken(G.C.SECONDARY_SET.Code, 0.2) }
	else
		e.config.object.colours = { G.C.GOLD }
	end
	e.config.object:update_text()
end

-- Needed because get_poker_hand_info isnt called at the end of the road
local evaluateroundref = G.FUNCS.evaluate_round
function G.FUNCS.evaluate_round()
	evaluateroundref()
	-- This is just the easiest way to check if its gold because lua is annoying
	if G.C.UI_CHIPS[1] == G.C.GOLD[1] then
		ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
		ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
	end
end

-- this is a hook to make funny "x of a kind"/"flush x" display text
local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
	-- Display text if played hand contains a Cluster and a Bulwark
	-- Not Ascended hand related but this hooks in the same spot so i'm lumping it here anyways muahahahahahaha
	if text == "cry_Clusterfuck" then
		if next(poker_hands["cry_Bulwark"]) then
			disp_text = "cry-Cluster Bulwark"
			loc_disp_text = localize(disp_text, "poker_hands")
		end
	end
	local hidden = false
	for i, v in pairs(scoring_hand) do
		if v.facing == "back" then
			hidden = true
			break
		end
	end
	if G.SETTINGS.language == "en-us" then
		if #scoring_hand > 5 and (text == "Flush Five" or text == "Five of a Kind" or text == "bunc_Spectrum Five") then
			local rank_array = {}
			local county = 0
			for i = 1, #scoring_hand do
				local val = scoring_hand[i]:get_id()
				rank_array[val] = (rank_array[val] or 0) + 1
				if rank_array[val] > county then
					county = rank_array[val]
				end
			end
			local function create_num_chunk(int) -- maybe useful enough to not be local? but tbh this function is probably some common coding exercise
				if int >= 1000 then
					int = 999
				end
				local ones = {
					["1"] = "One",
					["2"] = "Two",
					["3"] = "Three",
					["4"] = "Four",
					["5"] = "Five",
					["6"] = "Six",
					["7"] = "Seven",
					["8"] = "Eight",
					["9"] = "Nine",
				}
				local tens = {
					["1"] = "Ten",
					["2"] = "Twenty",
					["3"] = "Thirty",
					["4"] = "Forty",
					["5"] = "Fifty",
					["6"] = "Sixty",
					["7"] = "Seventy",
					["8"] = "Eighty",
					["9"] = "Ninety",
				}
				local str_int = string.reverse(int .. "") -- ehhhh whatever
				local str_ret = ""
				for i = 1, string.len(str_int) do
					local place = str_int:sub(i, i)
					if place ~= "0" then
						if i == 1 then
							str_ret = ones[place]
						elseif i == 2 then
							if place == "1" and str_ret ~= "" then -- admittedly not my smartest moment, i dug myself into a hole here...
								if str_ret == "One" then
									str_ret = "Eleven"
								elseif str_ret == "Two" then
									str_ret = "Twelve"
								elseif str_ret == "Three" then
									str_ret = "Thirteen"
								elseif str_ret == "Five" then
									str_ret = "Fifteen"
								elseif str_ret == "Eight" then
									str_ret = "Eighteen"
								else
									str_ret = str_ret .. "teen"
								end
							else
								str_ret = tens[place] .. ((string.len(str_ret) > 0 and " " or "") .. str_ret)
							end
						elseif i == 3 then
							str_ret = ones[place]
								.. (" Hundred" .. ((string.len(str_ret) > 0 and " and " or "") .. str_ret))
						end -- this line is wild
					end
				end
				return str_ret
			end
			-- text gets stupid small at 100+ anyway
			loc_disp_text = (text == "Flush Five" and "Flush " or text == "bunc_Spectrum Five" and "Spectrum " or "")
				.. (
					(county < 1000 and create_num_chunk(county) or "Thousand")
					.. (text == "Five of a Kind" and " of a Kind" or "")
				)
		end
	end
	-- Ascension power
	local a_power = Cryptid.calculate_ascension_power(
		text,
		_cards,
		scoring_hand,
		G.GAME.used_vouchers.v_cry_hyperspacetether,
		G.GAME.bonus_asc_power
	)
	-- 🔧 Entropy Compatibility Patch (prevents "compare number with table" crash)
	if type(a_power) == "table" then
		-- Entropy uses big-number tables. Normalize to a Lua number.
		if a_power.to_number then
				a_power = a_power:to_number()
		elseif a_power.val then
				a_power = tonumber(a_power.val) or 0
		else
				-- Unknown format: fail safe instead of crashing
				a_power = 0
		end
	end

	if a_power > 0 then
		G.GAME.current_round.current_hand.cry_asc_num = a_power
		-- Change mult and chips colors if hand is ascended
		if not hidden then
			ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.3)
			ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.3)
			G.GAME.current_round.current_hand.cry_asc_num_text = (
				a_power and (type(a_power) == "table" and a_power:gt(to_big(0)) or a_power > 0)
			)
					and " (+" .. a_power .. ")"
				or ""
		else
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
			ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
			G.GAME.current_round.current_hand.cry_asc_num_text = ""
		end
	else
		G.GAME.current_round.current_hand.cry_asc_num = 0
		ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.3)
		ease_colour(G.C.UI_MULT, G.C.RED, 0.3)
		G.GAME.current_round.current_hand.cry_asc_num_text = ""
	end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end
function Cryptid.ascend(num) -- edit this function at your leisure
	if (Cryptid.safe_get(G, "GAME", "current_round", "current_hand", "cry_asc_num") or 0) <= 0 then
		return num
	end
	if Cryptid.gameset(G.P_CENTERS.c_cry_sunplanet) == "modest" then
		-- Default: Chips and Mult multiplier + 0.25 for every 1 Ascension power
		return num * to_big(1 + ((0.25 + G.GAME.sunnumber.modest) * G.GAME.current_round.current_hand.cry_asc_num))
	else
		-- Default: Chips and Mult multiplier X1.25 for every 1 Ascension power
		return num * to_big((1.25 + G.GAME.sunnumber.not_modest) ^ G.GAME.current_round.current_hand.cry_asc_num)
	end
end

function Cryptid.pulse_flame(duration, intensity) -- duration is in seconds, intensity is in idfk honestly, but it increases pretty quickly
	G.cry_flame_override = G.cry_flame_override or {}
	G.cry_flame_override["duration"] = duration or 0.01
	G.cry_flame_override["intensity"] = intensity or 2
end

function Cryptid.calculate_ascension_power(hand_name, hand_cards, hand_scoring_cards, tether, bonus)
	bonus = bonus or 0
	local starting = 0
	if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true then
		return 0
	end
	if hand_name then
		-- Get Starting Ascension power from Poker Hands
		if hand_cards then
			local check = Cryptid.hand_ascension_numbers(hand_name, tether)
			if check then
				starting = (tether and #hand_cards or #hand_scoring_cards) - check
			end
		end
		-- Extra starting calculation for Declare hands
		if G.GAME.hands[hand_name] and G.GAME.hands[hand_name].declare_cards then
			local total = 0
			for i, v in pairs(G.GAME.hands[hand_name].declare_cards or {}) do
				local how_many_fit = 0
				local suit, rank
				for i2, v2 in pairs(hand_cards) do
					if not v2.marked then
						if SMODS.has_no_rank(v2) and v.rank == "rankless" or v2:get_id() == v.rank then
							rank = true
						end
						if v2:is_suit(v.suit) or (v.suit == "suitless" and SMODS.has_no_suit(v2)) or not v.suit then
							suit = true
						end
						if not (suit and rank) then
							suit = false
							rank = false
						end
						if suit and rank then
							how_many_fit = how_many_fit + 1
							v2.marked = true
						end
					end
				end
				if not rank or not suit then
					how_many_fit = 0
				end
				total = total + how_many_fit
			end
			for i2, v2 in pairs(hand_cards) do
				v2.marked = nil
			end
			starting = starting + (total - #hand_scoring_cards)
		end
	end
	-- Get Ascension power from Exploit
	if G.GAME.cry_exploit_override then
		bonus = bonus + 1
	end
	-- Get Ascension Power From Sol/Perkele (Observatory effect)
	if
		G.GAME.used_vouchers.v_observatory and (next(find_joker("cry-sunplanet")) or next(find_joker("cry-Perkele")))
	then
		-- switch this to not use find_joker eventually please for the love of god
		local super_entropic_local_variable_that_stores_the_amount_of_suns = #find_joker("cry-sunplanet")
			+ #find_joker("cry-Perkele")

		if super_entropic_local_variable_that_stores_the_amount_of_suns == 1 then
			bonus = bonus + 1
		else
			bonus = bonus
				+ Cryptid.nuke_decimals(
					Cryptid.funny_log(2, super_entropic_local_variable_that_stores_the_amount_of_suns + 1),
					2
				)
		end
	end
	local final = math.max(0, starting + bonus)
	-- Round to 1 if final value is less than 1 but greater than 0
	if final > 0 and final < 1 then
		final = 1
	end
	return final
end
function Cryptid.hand_ascension_numbers(hand_name, tether)
	if Cryptid.ascension_numbers[hand_name] and type(Cryptid.ascension_numbers[hand_name]) == "function" then
		return Cryptid.ascension_numbers[hand_name](hand_name, tether)
	end
	if hand_name == "High Card" then
		return tether and 1 or nil
	elseif hand_name == "Pair" then
		return tether and 2 or nil
	elseif hand_name == "Two Pair" then
		return 4
	elseif hand_name == "Three of a Kind" then
		return tether and 3 or nil
	elseif hand_name == "Straight" or hand_name == "Flush" or hand_name == "Straight Flush" then
		return next(SMODS.find_card("j_four_fingers")) and Cryptid.gameset() ~= "modest" and 4 or 5
	elseif
		hand_name == "Full House"
		or hand_name == "Five of a Kind"
		or hand_name == "Flush House"
		or hand_name == "cry_Bulwark"
		or hand_name == "Flush Five"
		or hand_name == "bunc_Spectrum"
		or hand_name == "bunc_Straight Spectrum"
		or hand_name == "bunc_Spectrum House"
		or hand_name == "bunc_Spectrum Five"
	then
		return 5
	elseif hand_name == "Four of a Kind" then
		return G.GAME.used_vouchers.v_cry_hyperspacetether and 4 or nil
	elseif hand_name == "cry_Clusterfuck" or hand_name == "cry_UltPair" then
		return 8
	elseif hand_name == "cry_WholeDeck" then
		return 52
	elseif hand_name == "cry_Declare0" then
		return G.GAME.hands.cry_Declare0
			and G.GAME.hands.cry_Declare0.declare_cards
			and #G.GAME.hands.cry_Declare0.declare_cards
	elseif hand_name == "cry_Declare1" then
		return G.GAME.hands.cry_Declare1
			and G.GAME.hands.cry_Declare1.declare_cards
			and #G.GAME.hands.cry_Declare1.declare_cards
	elseif hand_name == "cry_Declare2" then
		return G.GAME.hands.cry_Declare2
			and G.GAME.hands.cry_Declare2.declare_cards
			and #G.GAME.hands.cry_Declare2.declare_cards
	elseif
		hand_name == "spa_Spectrum"
		or hand_name == "spa_Straight_Spectrum"
		or hand_name == "spa_Spectrum_House"
		or hand_name == "spa_Spectrum_Five"
		or hand_name == "spa_Flush_Spectrum"
		or hand_name == "spa_Straight_Flush_Spectrum"
		or hand_name == "spa_Flush_Spectrum_House"
		or hand_name == "spa_Flush_Spectrum_Five"
	then
		return SpectrumAPI
				and SpectrumAPI.configuration.misc.four_fingers_spectrums
				and next(SMODS.find_card("j_four_fingers"))
				and Cryptid.gameset() ~= "modest"
				and 4
			or 5
	end
	return nil
end
