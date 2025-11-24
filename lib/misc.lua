--Localization colors
local lc = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		lc()
	end
	G.ARGS.LOC_COLOURS.cry_code = G.C.SET.Code
	G.ARGS.LOC_COLOURS.heart = G.C.SUITS.Hearts
	G.ARGS.LOC_COLOURS.diamond = G.C.SUITS.Diamonds
	G.ARGS.LOC_COLOURS.spade = G.C.SUITS.Spades
	G.ARGS.LOC_COLOURS.club = G.C.SUITS.Clubs
	for k, v in pairs(G.C) do
		if string.len(k) > 4 and string.sub(k, 1, 4) == "CRY_" then
			G.ARGS.LOC_COLOURS[string.lower(k)] = v
		end
	end
	return lc(_c, _default)
end

-- More advanced version of find joker for things that need to find very specific things
function Cryptid.advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
	local jokers = {}
	if not G.jokers or not G.jokers.cards then
		return {}
	end
	local filter = 0
	if name then
		filter = filter + 1
	end
	if edition then
		filter = filter + 1
	end
	if type(rarity) ~= "table" then
		if type(rarity) == "string" then
			rarity = { rarity }
		else
			rarity = nil
		end
	end
	if rarity then
		filter = filter + 1
	end
	if type(ability) ~= "table" then
		if type(ability) == "string" then
			ability = { ability }
		else
			ability = nil
		end
	end
	if ability then
		filter = filter + 1
	end
	-- return nothing if function is called with no useful arguments
	if filter == 0 then
		return {}
	end
	if not area or area == "j" then
		for k, v in pairs(G.jokers.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.key == edition) --[[ make this use Cryptid.safe_get later? if it's possible anyways]]
				then
					check = check + 1
				end
				if rarity then
					--Passes as valid if rarity matches ANY of the values in the rarity table
					for _, a in ipairs(rarity) do
						if v.config.center.rarity == a then
							check = check + 1
							break
						end
					end
				end
				if ability then
					--Only passes if the joker has everything in the ability table
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	if not area or area == "c" then
		for k, v in pairs(G.consumeables.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.key == edition) --[[ make this use Cryptid.safe_get later? if it's possible anyways]]
				then
					check = check + 1
				end
				if ability then
					--Only passes if the joker has everything in the ability table
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				--Consumables don't have a rarity, so this should ignore it in that case (untested lmfao)
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	return jokers
end

-- Midground sprites - used for Exotic Jokers and Gateway
-- don't really feel like explaining this deeply, it's based on code for The Soul and Legendary Jokers
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
	if _center and _center.name == "cry-Gateway" then
		self.children.floating_sprite = Sprite(
			self.T.x,
			self.T.y,
			self.T.w,
			self.T.h,
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 2, y = 0 }
		)
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite.states.hover.can = false
		self.children.floating_sprite.states.click.can = false
		self.children.floating_sprite2 = Sprite(
			self.T.x,
			self.T.y,
			self.T.w,
			self.T.h,
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 1, y = 0 }
		)
		self.children.floating_sprite2.role.draw_major = self
		self.children.floating_sprite2.states.hover.can = false
		self.children.floating_sprite2.states.click.can = false
	end
	if _center and _center.soul_pos and _center.soul_pos.extra then
		self.children.floating_sprite2 = Sprite(
			self.T.x,
			self.T.y,
			self.T.w,
			self.T.h,
			G.ASSET_ATLAS[_center.atlas or _center.set],
			_center.soul_pos.extra
		)
		self.children.floating_sprite2.role.draw_major = self
		self.children.floating_sprite2.states.hover.can = false
		self.children.floating_sprite2.states.click.can = false
	end
end

-- simple plural s function for localisation
function Cryptid.pluralize(str, vars)
	local inside = str:match("<(.-)>") -- finds args
	local _table = {}
	if inside then
		for v in inside:gmatch("[^,]+") do -- adds args to array
			table.insert(_table, v)
		end
		local num = vars[tonumber(string.match(str, ">(%d+)"))] -- gets reference variable
		if type(num) == "string" then
			num = (Big and to_number(to_big(num))) or num
		end
		if not num then
			num = 1
		end
		local plural = _table[1] -- default
		local checks = { [1] = "=" } -- checks 1 by default
		local checks1mod = false -- tracks if 1 was modified
		if #_table > 1 then
			for i = 2, #_table do
				local isnum = tonumber(_table[i])
				if isnum then
					if not checks1mod then
						checks[1] = nil
					end -- dumb stuff
					checks[isnum] = "<" .. (_table[i + 1] or "") -- do less than for custom values
					if isnum == 1 then
						checks1mod = true
					end
					i = i + 1
				elseif i == 2 then
					checks[1] = "=" .. _table[i]
				end
			end
		end
		local function fch(str, c)
			return string.sub(str, 1, 1) == c -- gets first char and returns boolean
		end
		local keys = {}
		for k in pairs(checks) do
			table.insert(keys, k)
		end
		table.sort(keys, function(a, b)
			return a < b
		end)
		if not (tonumber(num) or is_number(num)) then
			num = 1
		end
		for _, k in ipairs(keys) do
			if fch(checks[k], "=") then
				if to_big(math.abs(num - k)) < to_big(0.001) then
					return string.sub(checks[k], 2, -1)
				end
			elseif fch(checks[k], "<") then
				if to_big(num) < to_big(k - 0.001) then
					return string.sub(checks[k], 2, -1)
				end
			end
		end
		return plural
	end
end

-- generate a random edition (e.g. Antimatter Deck)
function Cryptid.poll_random_edition()
	local random_edition = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("cry_ant_edition"))
	while random_edition.key == "e_base" do
		random_edition = pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("cry_ant_edition"))
	end
	ed_table = { [random_edition.key:sub(3)] = true }
	return ed_table
end

-- gets a random, valid consumeable (used for Hammerspace, CCD Deck, Blessing, etc.)
function Cryptid.random_consumable(seed, excluded_flags, banned_card, pool, no_undiscovered)
	-- set up excluded flags - these are the kinds of consumables we DON'T want to have generating
	excluded_flags = excluded_flags or { "hidden", "no_doe", "no_grc" }
	local selection = "n/a"
	local passes = 0
	local tries = 500
	while true do
		tries = tries - 1
		passes = 0
		-- create a random consumable naively
		local key = pseudorandom_element(pool or G.P_CENTER_POOLS.Consumeables, pseudoseed(seed or "grc")).key
		selection = G.P_CENTERS[key]
		-- check if it is valid
		if selection.discovered or not no_undiscovered then
			for k, v in pairs(excluded_flags) do
				if not Cryptid.no(selection, v, key, true) then
					--Makes the consumable invalid if it's a specific card unless it's set to
					--I use this so cards don't create copies of themselves (eg potential inf Blessing chain, Hammerspace from Hammerspace...)
					if not banned_card or (banned_card and banned_card ~= key) then
						passes = passes + 1
					end
				end
			end
		end
		-- use it if it's valid or we've run out of attempts
		if passes >= #excluded_flags or tries <= 0 then
			if tries <= 0 and no_undiscovered then
				return G.P_CENTERS["c_strength"]
			else
				return selection
			end
		end
	end
end

-- checks for Jolly Jokers or cards that are supposed to be treated as jolly jokers
function Card:is_jolly()
	if self.ability.name == "Jolly Joker" or self.ability.name == "cry-jollysus Joker" then
		return true
	end
	if self.edition and self.edition.key == "e_cry_m" then
		return true
	end
	return false
end

function Cryptid.with_deck_effects(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card.from_quantum = true
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		card.from_quantum = nil
		return ret
	end
end

function Cryptid.deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[Cryptid.deep_copy(k, s)] = Cryptid.deep_copy(v, s)
	end
	return res
end

function SMODS.current_mod.reset_game_globals(run_start)
	G.GAME.cry_ach_conditions = G.GAME.cry_ach_conditions or {}
end

--Used for m vouchers, perhaps this can have more applications in the future
function Cryptid.get_m_jokers()
	local mcount = 0
	if G.jokers then
		for i = 1, #G.jokers.cards do
			if Cryptid.safe_get(G.jokers.cards[i].config.center, "pools", "M") then
				mcount = mcount + 1
			end
			if G.jokers.cards[i].ability.name == "cry-mprime" then
				mcount = mcount + 1
			end
		end
	end
	return mcount
end

-- Check G.GAME as well as joker info for banned keys
function Card:no(m, no_no)
	if no_no then
		-- Infinifusion Compat
		if self.infinifusion then
			for i = 1, #self.infinifusion do
				if
					G.P_CENTERS[self.infinifusion[i].key][m]
					or (G.GAME and G.GAME[m] and G.GAME[m][self.infinifusion[i].key])
				then
					return true
				end
			end
			return false
		end
		if not self.config then
			--assume this is from one component of infinifusion
			return G.P_CENTERS[self.key][m] or (G.GAME and G.GAME[m] and G.GAME[m][self.key])
		end

		return self.config.center[m] or (G.GAME and G.GAME[m] and G.GAME[m][self.config.center_key]) or false
	end
	return Card.no(self, "no_" .. m, true)
end

function Cryptid.no(center, m, key, no_no)
	if no_no then
		return center[m] or (G.GAME and G.GAME[m] and G.GAME[m][key]) or false
	end
	return Cryptid.no(center, "no_" .. m, key, true)
end

--todo: move to respective stake file
--[from pre-refactor] make this always active to prevent crashes
function Cryptid.apply_ante_tax()
	if G.GAME.modifiers.cry_ante_tax then
		local tax = math.max(
			0,
			math.min(G.GAME.modifiers.cry_ante_tax_max, math.floor(G.GAME.modifiers.cry_ante_tax * G.GAME.dollars))
		)
		ease_dollars(-1 * tax)
		return true
	end
	return false
end

--Changes main menu colors and stuff
--has to be modified with new enabling system
if Cryptid_config.menu then
	local oldfunc = Game.main_menu
	Game.main_menu = function(change_context)
		local ret = oldfunc(change_context)
		-- adds a Cryptid spectral to the main menu
		local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS.c_cryptid,
			{ bypass_discovery_center = true }
		)
		-- recenter the title
		G.title_top.T.w = G.title_top.T.w * 1.7675
		G.title_top.T.x = G.title_top.T.x - 0.8
		G.title_top:emplace(newcard)
		-- make the card look the same way as the title screen Ace of Spades
		newcard.T.w = newcard.T.w * 1.1 * 1.2
		newcard.T.h = newcard.T.h * 1.1 * 1.2
		newcard.no_ui = true
		newcard.states.visible = false

		-- make the title screen use different background colors
		G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
					{ name = "vort_speed", val = 0.4 },
					{ name = "colour_1", ref_table = G.C, ref_value = "CRY_EXOTIC" },
					{ name = "colour_2", ref_table = G.C, ref_value = "DARK_EDITION" },
				},
			},
		})

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
				if change_context == "splash" then
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				else
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
				end
				return true
			end,
		}))

		return ret
	end
end

-- just dumping this garbage here
-- this just ensures that extra voucher slots work as expected
function Cryptid.bonus_voucher_mod(mod)
	if not G.GAME.shop then
		return
	end
	G.GAME.cry_bonusvouchercount = G.GAME.cry_bonusvouchercount + mod
	if G.shop_jokers and G.shop_jokers.cards then
		G.shop:recalculate()
		if mod > 0 then -- not doing minus mod because it'd be janky and who really cares
			for i = 1, G.GAME.cry_bonusvouchercount + 1 - #G.shop_vouchers.cards do
				local curr_bonus = G.GAME.current_round.cry_bonusvouchers
				curr_bonus[#curr_bonus + 1] = get_next_voucher_key()

				-- this could be a function but it's done like what... 3 times? it doesn't matter rn

				local card = Card(
					G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
					G.shop_vouchers.T.y,
					G.CARD_W,
					G.CARD_H,
					G.P_CARDS.empty,
					G.P_CENTERS[curr_bonus[#curr_bonus]],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.shop_cry_bonusvoucher = #curr_bonus
				Cryptid.manipulate(card)
				if G.GAME.events.ev_cry_choco2 then
					card.misprint_cost_fac = (card.misprint_cost_fac or 1) * 2
					card:set_cost()
				end
				if
					G.GAME.modifiers.cry_enable_flipped_in_shop
					and pseudorandom("cry_flip_vouch" .. G.GAME.round_resets.ante) > 0.7
				then
					card.cry_flipped = true
				end
				create_shop_card_ui(card, "Voucher", G.shop_vouchers)
				card:start_materialize()
				if G.GAME.current_round.cry_voucher_edition then
					card:set_edition(G.GAME.current_round.cry_voucher_edition, true, true)
				end
				G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
				G.shop_vouchers:emplace(card)
			end
		end
	end
end

function Cryptid.save()
	local data = {
		shinytags = {},
	}
	data.shinytags = copy_table(Cryptid.shinytagdata)
	compress_and_save(G.SETTINGS.profile .. "/" .. "cryptidsave.jkr", STR_PACK(data))
end

local sppref = set_profile_progress
function set_profile_progress()
	sppref()
	if not Cryptid.shinytagdata then
		Cryptid.shinytagdata = {}
	end
	if not Cryptid.shinytagdata.init then
		for k, v in pairs(G.P_TAGS) do
			if Cryptid.shinytagdata[k] == nil then
				Cryptid.shinytagdata.init = true
				Cryptid.shinytagdata[k] = false
			end
		end
	end
end

Cryptid.big_num_blacklist = {
	["j_cry_fractal"] = true,
	["j_cry_wonka_bar"] = true,
	["j_cry_oldcandy"] = true,
	["j_cry_negative"] = true,
	["j_cry_energia"] = true,

	["c_magician"] = true,
	["c_empress"] = true,
	["c_heirophant"] = true,
	["c_lovers"] = true,
	["c_chariot"] = true,
	["c_justice"] = true,
	["c_strength"] = true,
	["c_hanged_man"] = true,
	["c_death"] = true,
	["c_devil"] = true,
	["c_tower"] = true,
	["c_star"] = true,
	["c_moon"] = true,
	["c_sun"] = true,
	["c_world"] = true,
	["c_cry_eclipse"] = true,
	["c_cry_seraph"] = true,
	["c_cry_instability"] = true,

	["v_cry_stickyhand"] = true,
	["v_cry_grapplinghook"] = true,
	["v_cry_hyperspacetether"] = true,

	-- Add your Jokers here if you *don't* want to have it's numbers go into BigNum
	-- FORMAT: <Joker Key ("j_cry_oil_lamp")> = true,
	-- TARGET: BigNum Black List
}

Cryptid.mod_whitelist = {
	Cryptid = true,

	-- Add your ModName here if you want your mod to have it's jokers' values go into BigNum
	-- FORMAT: <ModName> = true,
	-- TARGET: BigNum Mod Whitelist
}

function Cryptid.is_card_big(joker)
	local center = joker.config and joker.config.center
	if not center then
		return false
	end

	if center.immutable and center.immutable == true then
		return false
	end

	if center.mod and not Cryptid.mod_whitelist[center.mod.name] then
		return false
	end

	local in_blacklist = Cryptid.big_num_blacklist[center.key or "Nope!"] or false

	return not in_blacklist --[[or
	       (center.mod and center.mod.id == "Cryptid" and not center.no_break_infinity) or center.break_infinity--]]
end

--Utility function to check things without erroring
---@param t table
---@param ... any
---@return table|false
function Cryptid.safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

--Functions used by boss blinds
function Blind:cry_ante_base_mod(dt)
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_ante_base_mod and type(obj.cry_ante_base_mod) == "function" then
			return obj:cry_ante_base_mod(dt)
		end
	end
	return 0
end

function Blind:cry_round_base_mod(dt)
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_round_base_mod and type(obj.cry_round_base_mod) == "function" then
			return obj:cry_round_base_mod(dt)
		end
	end
	return 1
end

function Blind:cry_cap_score(score)
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_modify_score and type(obj.cry_modify_score) == "function" then
			score = obj:cry_modify_score(score)
		end
		if obj.cry_cap_score and type(obj.cry_cap_score) == "function" then
			return obj:cry_cap_score(score)
		end
	end
	return score
end

function Blind:cry_after_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_after_play and type(obj.cry_after_play) == "function" then
			return obj:cry_after_play()
		end
	end
end

function Blind:cry_before_play()
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_before_play and type(obj.cry_before_play) == "function" then
			return obj:cry_before_play()
		end
	end
end

--The decision's ability to show a booster pack
function Blind:cry_before_cash()
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_before_cash and type(obj.cry_before_cash) == "function" then
			return obj:cry_before_cash()
		end
	end
end

function Blind:cry_calc_ante_gain()
	if G.GAME.modifiers.cry_spooky then --here is the best place to check when spooky should apply
		local card
		if pseudorandom(pseudoseed("cry_spooky_curse")) < G.GAME.modifiers.cry_curse_rate then
			card = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "cry_spooky")
		else
			card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_spooky")
		end
		card:add_to_deck()
		card:start_materialize()
		G.jokers:emplace(card)
	end
	if not self.disabled then
		local obj = self.config.blind
		if obj.cry_calc_ante_gain and type(obj.cry_calc_ante_gain) == "function" then
			return obj:cry_calc_ante_gain()
		end
	end
	return 1
end

function Cryptid.enhanced_deck_info(deck)
	--only accounts for vanilla stuff at the moment (WIP)
	local edition, enhancement, sticker, suit, seal =
		"e_" .. (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_edeck_edition") or "foil"),
		Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_edeck_enhancement") or "m_bonus",
		Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_edeck_sticker") or "eternal",
		Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_edeck_suit") or "Spades",
		Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_edeck_seal") or "Gold"
	-- Do Stuff
	edition = (Cryptid.safe_get(G.P_CENTERS, edition) and edition or "e_foil"):sub(3)
	enhancement = Cryptid.safe_get(G.P_CENTERS, enhancement) and enhancement or "m_bonus"
	sticker = Cryptid.safe_get(SMODS.Stickers, sticker) and sticker or "eternal"
	suit = Cryptid.safe_get(SMODS.Suits, suit) and suit or "Spades"
	seal = Cryptid.safe_get(G.P_SEALS, seal) and seal or "Gold"
	local ret = {
		edition = edition,
		enhancement = enhancement,
		sticker = sticker,
		suit = suit,
		seal = seal,
	}
	for k, _ in pairs(ret) do
		if G.GAME.modifiers["cry_force_" .. k] and not G.GAME.viewed_back then
			ret[k] = G.GAME.modifiers["cry_force_" .. k]
		elseif Cryptid.safe_get(deck, "config", "cry_force_" .. k) then
			ret[k] = deck.config["cry_force_" .. k]
		end
	end
	return ret.edition, ret.enhancement, ret.sticker, ret.suit, ret.seal
end

function Cryptid.post_process(center)
	if center.pools and center.pools.M then
		local vc = center.calculate
		center.calculate = function(self, card, context)
			local ret, trig = vc(self, card, context)
			if context.retrigger_joker_check and context.other_card == card then
				local reps = Cryptid.get_m_retriggers(self, card, context)
				if reps > 0 then
					return {
						message = localize("k_again_ex"),
						repetitions = reps + (ret and ret.repetitions or 0),
						card = card,
					}
				end
			end
			return ret, trig
		end
	end
end

-- Wrapper G.FUNCS function to reset localization
-- For resetting localization on the fly for family friendly toggle
function Cryptid.reload_localization()
	SMODS.handle_loc_file(Cryptid.path)
	Cryptid.handle_other_localizations()
	return init_localization()
end
-- Purely for crossmod purposes
function Cryptid.handle_other_localizations() end

-- Checks if all jokers in shop will have editions (via Curate, Edition Decks, etc.)
-- Will cause edition tags to Nope!
function Cryptid.forced_edition()
	return G.GAME.modifiers.cry_force_edition or G.GAME.used_vouchers.v_cry_curate
end

-- Add Ctrl+Space for Pointer UI in Debug Mode
local ckpu = Controller.key_press_update
function Controller:key_press_update(key, dt)
	ckpu(self, key, dt)
	if
		key == "space"
		and G.STAGE == G.STAGES.RUN
		and not _RELEASE_MODE
		and (self.held_keys["lctrl"] or self.held_keys["rctrl"] or self.held_keys["lgui"] or self.held_keys["rgui"])
		and not G.GAME.USING_CODE
	then
		G.GAME.USING_CODE = true
		G.GAME.USING_POINTER = true
		G.DEBUG_POINTER = true
		G.ENTERED_CARD = ""
		G.CHOOSE_CARD = UIBox({
			definition = create_UIBox_pointer(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_CARD.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_CARD:align_to_major()
	end
end

function Cryptid.roll_shiny()
	local prob = 1
	if next(SMODS.find_card("j_lucky_cat")) then
		prob = 3
	end
	if pseudorandom("cry_shiny") < prob / 4096 then
		return "shiny"
	end
	return "normal"
end

function Cryptid.is_shiny()
	if Cryptid.roll_shiny() == "shiny" then
		return true
	end
	return false
end

--Abstracted cards
function Cryptid.cry_enhancement_has_specific_suit(card)
	for k, _ in pairs(SMODS.get_enhancements(card)) do
		if G.P_CENTERS[k].specific_suit then
			return true
		end
	end
	return false
end

function Cryptid.cry_enhancement_get_specific_suit(card)
	for k, _ in pairs(SMODS.get_enhancements(card)) do
		if G.P_CENTERS[k].specific_suit then
			return G.P_CENTERS[k].specific_suit
		end
	end
	return nil
end

function Cryptid.cry_enhancement_has_specific_rank(card)
	for k, _ in pairs(SMODS.get_enhancements(card)) do
		if G.P_CENTERS[k].specific_rank then
			return true
		end
	end
	return false
end

function Cryptid.cry_enhancement_get_specific_rank(card)
	for k, _ in pairs(SMODS.get_enhancements(card)) do
		if G.P_CENTERS[k].specific_rank then
			return G.P_CENTERS[k].specific_rank
		end
	end
	return nil
end

--For better durability (at the expense of performance), this finds the rank ID of a custom rank (such as abstract).
function Cryptid.cry_rankname_to_id(rankname)
	for i, v in pairs(SMODS.Rank.obj_buffer) do
		if rankname == v then
			return i
		end
	end
	return nil
end
-- for buttercup
function G.FUNCS.can_store_card(e)
	-- get shop highlighted
	-- only from the jokers spot
	local highlighted_shop_cards = {}
	local areas_to_check = {
		shop_jokers = G.shop_jokers,
		shop_vouchers = G.shop_vouchers,
		shop_booster = G.shop_booster,
	}
	local jok = e.config.ref_table

	for key, value in pairs(areas_to_check) do
		if value == nil then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
			return
		elseif #value.highlighted == 1 and #highlighted_shop_cards == 0 then
			highlighted_shop_cards[1] = value.highlighted[1]
		end
	end
	if #highlighted_shop_cards == 1 and jok:can_use_storage() then
		e.config.colour = G.C.BLUE
		e.config.button = "store_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.store_card(e)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			local areas_to_check = {
				shop_jokers = G.shop_jokers,
				shop_vouchers = G.shop_vouchers,
				shop_booster = G.shop_booster,
			}
			local this_card = e.config.ref_table
			-- This doesn't take into account the possibility that multiple cards might be selected in different areas
			-- but can_store_card already does that for us, so who cares tbh
			for shop_name, shop_area in pairs(areas_to_check) do
				if #shop_area.highlighted == 1 then
					local new_card = shop_area.highlighted[1]
					new_card.T.orig = { w = new_card.T.w, h = new_card.T.h }
					new_card.T.w = new_card.T.w * 0.5
					new_card.T.h = new_card.T.h * 0.5
					new_card.cry_from_shop = shop_name
					if new_card.children.price then
						new_card.children.price:remove()
					end
					new_card.children.price = nil
					if new_card.children.buy_button then
						new_card.children.buy_button:remove()
					end
					new_card.children.buy_button = nil
					shop_area:remove_card(new_card)
					this_card.cry_storage:emplace(new_card)
				end
			end
			return true
		end,
	}))
end

function Card:can_use_storage()
	if self.cry_storage ~= nil then
		return #self.cry_storage.cards < self.ability.extra.slots
	elseif self.config.center.key == "j_cry_buttercup" then -- "where did my fucking storage go"
		sendInfoMessage("creating missing card area")
		self.cry_storage = CardArea(0.5, 0.5, 1, 1, storage_area_config)
	end
	return false
end
function Cryptid.reset_to_none()
	update_hand_text({ delay = 0 }, {
		mult = Cryptid.ascend(G.GAME.hands["cry_None"].mult),
		chips = Cryptid.ascend(G.GAME.hands["cry_None"].chips),
		level = G.GAME.hands["cry_None"].level,
		handname = localize("cry_None", "poker_hands"),
	})
end

function Card:is_food()
	--you cant really check if vanilla jokers are in a pool because its hardcoded
	--so i have to hardcode it here too for the starfruit unlock
	local food = {
		j_gros_michel = true,
		j_egg = true,
		j_ice_cream = true,
		j_cavendish = true,
		j_turtle_bean = true,
		j_diet_cola = true,
		j_popcorn = true,
		j_ramen = true,
		j_selzer = true,
	}
	if food[self.config.center.key] or Cryptid.safe_get(self.config.center, "pools", "Food") then
		return true
	end
end

function Cryptid.get_highlighted_cards(areas, ignore, min, max, blacklist, seed)
	ignore.checked = true
	blacklist = blacklist or function()
		return true
	end
	local cards = {}
	for i, area in pairs(areas) do
		if area.cards then
			for i2, card in pairs(area.cards) do
				if
					card ~= ignore
					and blacklist(card)
					and (card.highlighted or G.cry_force_use)
					and not card.checked
				then
					cards[#cards + 1] = card
					card.checked = true
				end
			end
		end
	end
	for i, v in ipairs(cards) do
		v.checked = nil
	end
	if (#cards >= min and #cards <= max) or not G.cry_force_use then
		ignore.checked = nil
		return cards
	else
		for i, v in pairs(cards) do
			v.f_use_order = i
		end
		pseudoshuffle(cards, pseudoseed("forcehighlight" or seed))
		local actual = {}
		for i = 1, max do
			if cards[i] and not cards[i].checked and actual ~= ignore then
				actual[#actual + 1] = cards[i]
			end
		end
		table.sort(actual, function(a, b)
			return a.f_use_order < b.f_use_order
		end)
		for i, v in pairs(cards) do
			v.f_use_order = nil
		end
		ignore.checked = nil
		return actual
	end
	return {}
end

function Cryptid.table_merge(...)
	local tbl = {}
	for _, t in ipairs({ ... }) do
		if type(t) == "table" then
			for _, v in pairs(t) do
				tbl[#tbl + 1] = v
			end
		end
	end
	return tbl
end

function Cryptid.get_circus_description()
	local desc = {}
	local ind = 1
	local extra_rarities = {}
	if not Cryptid.circus_rarities then
		Cryptid.circus_rarities = {}
	end
	for i, v in pairs(Cryptid.circus_rarities) do
		if not v.hidden then
			extra_rarities[#extra_rarities + 1] = v
		end
	end
	table.sort(extra_rarities, function(a, b)
		return a.order < b.order
	end)
	for i, v in pairs(extra_rarities) do
		local rarity = v.rarity
		rarity = localize(({
			[1] = "k_common",
			[2] = "k_uncommon",
			[3] = "k_rare",
			[4] = "k_legendary",
		})[rarity] or "k_" .. rarity)
		local orig = localize("cry_circus_generic")
		orig = string.gsub(orig, "#1#", ind)
		orig = string.gsub(orig, "#2#", rarity)
		orig = string.gsub(orig, "#3#", "#" .. tostring(ind) .. "#")
		desc[#desc + 1] = orig
		ind = ind + 1
	end
	return desc
end

function Cryptid.add_circus_rarity(rarity, dontreload)
	Cryptid.circus_rarities[rarity.rarity] = rarity
	if not dontreload then
		Cryptid.reload_localization()
	end
end

function Cryptid.get_paved_joker()
	if G.hand then
		local total = 0
		for i, v in pairs(SMODS.find_card("j_cry_paved_joker")) do
			total = total + v.ability.extra
		end
		local stones = 0
		for i, v in pairs(G.hand.highlighted) do
			if v.config.center.key == "m_stone" then
				stones = stones + 1
			end
		end
		for i, v in pairs(G.play.cards) do
			if v.config.center.key == "m_stone" then
				stones = stones + 1
			end
		end
		total = math.min(stones, total)
		return total
	end
	return 0
end

function Card:has_stickers()
	for i, v in pairs(SMODS.Sticker.obj_table) do
		if self.ability[i] then
			return true
		end
	end
end
function Card:remove_random_sticker(seed)
	local s = {}
	for i, v in pairs(SMODS.Sticker.obj_table) do
		if not v.hidden and i ~= "cry_absolute" and self.ability[i] then
			s[#s + 1] = i
		end
	end
	if #s > 0 then
		local sticker = pseudorandom_element(s, pseudoseed(seed))
		self.ability[sticker] = nil
		if sticker == "perishable" then
			self.ability.perish_tally = nil
		end
	end
end

function create_UIBox_class()
	return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Enhanced, { 4, 4 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		--infotip = localize('ml_edition_seal_enhancement_explanation'),
		hide_single_page = true,
		back_func = "exit_overlay_menu_code",
	})
end

function create_UIBox_variable_code()
	local cards = {}
	local ranks = {}
	for i, v in pairs(SMODS.Ranks) do
		cards[#cards + 1] = G.P_CENTERS.c_base
		ranks[#ranks + 1] = i
	end
	table.sort(ranks, function(a, b)
		return SMODS.Ranks[a].id < SMODS.Ranks[b].id
	end)
	return SMODS.card_collection_UIBox(cards, { 5, 5, 5 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		--infotip = localize('ml_edition_seal_enhancement_explanation'),
		hide_single_page = true,
		back_func = "exit_overlay_menu_code",
		modify_card = function(card, center, i, j)
			SMODS.change_base(card, "Spades", ranks[(j - 1) * 5 + i])
		end,
	})
end

function create_UIBox_exploit()
	local cards = {}
	local ranks = {}
	for i, v in pairs(G.P_CENTER_POOLS.Planet) do
		if v.config.handname then
			cards[#cards + 1] = v
		end
	end
	table.sort(ranks, function(a, b)
		return G.GAME.hands[a.config.handname].order < G.GAME.hands[b.config.handname]
	end)
	return SMODS.card_collection_UIBox(cards, { 5, 5, 5 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		--infotip = localize('ml_edition_seal_enhancement_explanation'),
		hide_single_page = true,
		back_func = "exit_overlay_menu_code",
	})
end

G.FUNCS.exit_overlay_menu_code = function(e)
	G.FUNCS.exit_overlay_menu(e)
	G.GAME.USING_CLASS = nil
	G.GAME.USING_CODE = nil
	G.GAME.USING_VARIABLE = nil
	G.GAME.USING_EXPLOIT_HAND = nil
	G.GAME.USING_EXPLOIT = nil
	G.GAME.USING_POINTER = nil
	G.GAME.POINTER_SUBMENU = nil
	G.GAME.POINTER_PLAYING = nil
	G.GAME.POINTER_COLLECTION = nil
	if
		G.GAME.CODE_DESTROY_CARD
		and G.GAME.CODE_DESTROY_CARD.ability
		and G.GAME.CODE_DESTROY_CARD.ability.cry_multiuse
	then
		G.GAME.CODE_DESTROY_CARD.ability.cry_multiuse = G.GAME.CODE_DESTROY_CARD.ability.cry_multiuse - 1
	elseif G.GAME.CODE_DESTROY_CARD then
		G.GAME.CODE_DESTROY_CARD:start_dissolve()
		G.GAME.CODE_DESTROY_CARD = nil
	end
	G.GAME.CODE_DESTROY_CARD = nil
end

function G.UIDEF.exploit_menu()
	return create_UIBox_generic_options({
		contents = {
			create_tabs({
				tabs = {
					{
						label = localize("b_poker_hands"),
						chosen = true,
						tab_definition_function = create_UIBox_current_hands_exploit,
					},
				},
				tab_h = 8,
				snap_to_nav = true,
			}),
		},
	})
end

function create_UIBox_current_hands_exploit(simple)
	local ref = create_UIBox_current_hand_row
	local ret = create_UIBox_current_hands(simple)
	create_UIBox_current_hand_row = ref
	return ret
end

local htref = create_UIBox_hand_tip
function create_UIBox_hand_tip(handname)
	if G.GAME.USING_EXPLOIT then
		G.GAME.USING_EXPLOIT_HAND = handname
	end
	return htref(handname)
end

local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
	lcpref(self, x, y)
	if G and G.GAME and G.GAME.hands and G.GAME.USING_EXPLOIT_HAND then
		if
			G.CONTROLLER.cursor_hover
			and G.CONTROLLER.cursor_hover.target
			and G.CONTROLLER.cursor_hover.target.config
			and G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip
			and G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler
			and G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler.args
			and G.GAME.hands[G.CONTROLLER.cursor_hover.target.config.on_demand_tooltip.filler.args]
		then
			-- Re-use the Exploit card
			if G.GAME.ACTIVE_CODE_CARD then
				if
					not G.GAME.ACTIVE_CODE_CARD.ability.cry_multiuse
					or to_big(G.GAME.ACTIVE_CODE_CARD.ability.cry_multiuse) <= to_big(1)
				then
					G.GAME.ACTIVE_CODE_CARD:start_dissolve()
				else
					G.GAME.ACTIVE_CODE_CARD.ability.cry_multiuse =
						lenient_bignum(to_big(G.GAME.ACTIVE_CODE_CARD.ability.cry_multiuse) - to_big(1))
				end
			end
			G.GAME.ACTIVE_CODE_CARD = nil
			G.GAME.cry_exploit_override = G.GAME.USING_EXPLOIT_HAND
			G.FUNCS.exit_overlay_menu_code()
		end
	end
end

function create_UIBox_pointer_rank()
	G.GAME.POINTER_SUBMENU = "Rank"
	G.GAME.POINTER_PLAYING = {}
	local cards = {}
	local ranks = {}
	for i, v in pairs(SMODS.Ranks) do
		cards[#cards + 1] = G.P_CENTERS.c_base
		ranks[#ranks + 1] = i
	end
	table.sort(ranks, function(a, b)
		return SMODS.Ranks[a].id < SMODS.Ranks[b].id
	end)
	return SMODS.card_collection_UIBox(cards, { 5, 5, 5 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		--infotip = localize('ml_edition_seal_enhancement_explanation'),
		hide_single_page = true,
		back_func = "your_collection",
		modify_card = function(card, center, i, j)
			SMODS.change_base(card, "Spades", ranks[(j - 1) * 5 + i])
			if
				center.hidden
				or center.no_noe
				or center.no_pointer
				or center.no_code
				or center.no_variable
				or center.no_class
			then
				card.deuff = true
			end
		end,
	})
end

function create_UIBox_pointer_suit()
	G.GAME.POINTER_SUBMENU = "Suit"
	local cards = {}
	local suits = {}
	for i, v in pairs(SMODS.Suits) do
		cards[#cards + 1] = G.P_CENTERS.c_base
		suits[#suits + 1] = i
	end
	table.sort(suits, function(a, b)
		return SMODS.Suits[a].suit_nominal < SMODS.Suits[b].suit_nominal
	end)
	return SMODS.card_collection_UIBox(cards, { 4, 4, 4 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		--infotip = localize('ml_edition_seal_enhancement_explanation'),
		hide_single_page = true,
		back_func = "your_collection",
		modify_card = function(card, center, i, j)
			SMODS.change_base(card, suits[(j - 1) * 4 + i], G.GAME.POINTER_PLAYING.rank)
			if
				center.hidden
				or center.no_noe
				or center.no_pointer
				or center.no_code
				or center.no_variable
				or center.no_class
			then
				card.deuff = true
			end
		end,
	})
end

function create_UIBox_pointer_enhancement()
	G.GAME.POINTER_SUBMENU = "Enhancement"
	return create_UIBox_your_collection_enhancements_pointer()
end

function create_UIBox_pointer_edition()
	G.GAME.POINTER_SUBMENU = "Edition"
	return create_UIBox_your_collection_editions_pointer()
end

function create_UIBox_pointer_seal()
	G.GAME.POINTER_SUBMENU = "Seal"
	return create_UIBox_your_collection_seals_pointer()
end

G.FUNCS.your_collection_create_card_rank = function(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_pointer_rank(),
	})
end

create_UIBox_your_collection_enhancements_pointer = function()
	local cards = {
		G.P_CENTERS.c_base,
	}
	for i, v in pairs(G.P_CENTER_POOLS.Enhanced) do
		cards[#cards + 1] = v
	end
	return SMODS.card_collection_UIBox(cards, { 4, 4 }, {
		no_materialize = true,
		snap_back = true,
		h_mod = 1.03,
		hide_single_page = true,
		modify_card = function(card, center)
			SMODS.change_base(card, G.GAME.POINTER_PLAYING.suit, G.GAME.POINTER_PLAYING.rank)
			if
				center.hidden
				or center.no_noe
				or center.no_pointer
				or center.no_code
				or center.no_variable
				or center.no_class
			then
				card.deuff = true
			end
		end,
	})
end

create_UIBox_your_collection_editions_pointer = function()
	return SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Edition, { 5, 5 }, {
		snap_back = true,
		h_mod = 1.03,
		hide_single_page = true,
		collapse_single_page = true,
		modify_card = function(card, center)
			if center.discovered then
				card:set_edition(center.key, true, true)
				SMODS.change_base(card, G.GAME.POINTER_PLAYING.suit, G.GAME.POINTER_PLAYING.rank)
				card:set_ability(G.P_CENTERS[G.GAME.POINTER_PLAYING.center])
				if
					center.hidden
					or center.no_noe
					or center.no_pointer
					or center.no_code
					or center.no_variable
					or center.no_class
				then
					card.deuff = true
				end
			end
		end,
	})
end

create_UIBox_your_collection_seals_pointer = function()
	local cards = {
		{ key = nil },
	}
	for i, v in pairs(G.P_CENTER_POOLS.Seal) do
		cards[#cards + 1] = v
	end
	return SMODS.card_collection_UIBox(cards, { 5, 5 }, {
		snap_back = true,
		hide_single_page = true,
		collapse_single_page = true,
		center = "c_base",
		h_mod = 1.03,
		modify_card = function(card, center)
			card:set_seal(center.key, true)
			SMODS.change_base(card, G.GAME.POINTER_PLAYING.suit, G.GAME.POINTER_PLAYING.rank)
			card:set_ability(G.P_CENTERS[G.GAME.POINTER_PLAYING.center])
			card:set_edition(G.GAME.POINTER_PLAYING.edition, true, true)
			if
				center.hidden
				or center.no_noe
				or center.no_pointer
				or center.no_code
				or center.no_variable
				or center.no_class
			then
				card.deuff = true
			end
		end,
	})
end

function Cryptid.get_next_tag(override)
	if next(SMODS.find_card("j_cry_kittyprinter")) then
		return "tag_cry_cat"
	end
end

-- for Cryptid.isNonRollProbabilityContext
local probability_contexts = {
	"mod_probability",
	"fix_probability",
}

-- Checks if a context table is a probability context called outside of a roll
function Cryptid.isNonRollProbabilityContext(context)
	for _, ctx in ipairs(probability_contexts) do
		if context[ctx] then
			return context.from_roll
		end
	end

	return true
end

function Cryptid.nuke_decimals(number, surviving_decimals, round)
	surviving_decimals = surviving_decimals or 0
	--Set round to 0.5 to round or 0 to floor
	round = round or 0
	local aaa = 10 ^ surviving_decimals
	return math.floor(number * aaa + round) / aaa
end
-- "log base (x) of (y)". Pre-Calculus courses recommended
function Cryptid.funny_log(x, y)
	return math.log(y) / math.log(x)
end

-- Clamps n between min and max
function Cryptid.clamp(n, min, max)
	return math.min(math.max(n, min), max)
end

local say_stuff_ref = Card_Character.say_stuff
function Card_Character:say_stuff(n, not_first, quip_key)
	local quip = SMODS.JimboQuips[quip_key]
	if quip then
		return say_stuff_ref(self, n, not_first, quip_key)
	end
	-- Always call the original function if no custom quip exists (fixes bug where Jimbo would not say anything)
	return say_stuff_ref(self, n, not_first, quip_key)
end
