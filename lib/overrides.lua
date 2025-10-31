-- overrides.lua - Adds hooks and overrides used by multiple features.

--Get Pack hooks

-- dumb hook because i don't feel like aggressively patching get_pack to do stuff
-- very inefficient
-- maybe smods should overwrite the function and make it more targetable?
local getpackref = get_pack
function get_pack(_key, _type)
	local temp_banned = copy_table(G.GAME.banned_keys)
	--Add banished keys (via DELETE) to banned_keys so they don't appear in shop
	for k, v in pairs(G.GAME.cry_banished_keys) do
		G.GAME.banned_keys[k] = v
	end
	local abc = getpackref(_key, _type)
	--Convert banned keys back to what it was originally
	G.GAME.banned_keys = copy_table(temp_banned)
	if G.GAME.modifiers.cry_equilibrium then
		if not P_CRY_ITEMS then
			P_CRY_ITEMS = {}
			local valid_pools = { "Joker", "Consumeables", "Voucher", "Booster" }
			for _, id in ipairs(valid_pools) do
				for k, v in pairs(G.P_CENTER_POOLS[id]) do
					if not Cryptid.no(v, "doe", k) then
						P_CRY_ITEMS[#P_CRY_ITEMS + 1] = v.key
					end
				end
			end
			for k, v in pairs(G.P_CARDS) do
				if not Cryptid.no(v, "doe", k) then
					P_CRY_ITEMS[#P_CRY_ITEMS + 1] = v.key
				end
			end
		end
		return G.P_CENTERS[pseudorandom_element(
			P_CRY_ITEMS,
			pseudoseed("cry_equipackbrium" .. G.GAME.round_resets.ante)
		)]
	end
	return abc
end

-- get_currrent_pool hook for Deck of Equilibrium and Copies
local gcp = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append, override_equilibrium_effect)
	if type == "Tag" then
		for i = 1, #pool do
			-- Copies: Turn Double tags into Triple Tags
			if pool[i] == "tag_double" and G.GAME.used_vouchers.v_cry_copies then
				pool[i] = "tag_cry_triple"
			end
			-- Tag Printer: Turn Double tags and Triple Tags into Quadruple Tags
			if (pool[i] == "tag_double" or pool[i] == "tag_cry_triple") and G.GAME.used_vouchers.v_cry_tag_printer then
				pool[i] = "tag_cry_quadruple"
			end
			-- Clone Machine: Turn Double tags and Triple Tags as well as Quadruple Tags into Quintuple Tags
			if
				(pool[i] == "tag_double" or pool[i] == "tag_cry_triple" or pool[i] == "tag_cry_quadruple")
				and G.GAME.used_vouchers.v_cry_clone_machine
			then
				pool[i] = "tag_cry_quintuple"
			end
		end
		-- Deck of Equilibrium stuff
	elseif
		G.GAME.modifiers.cry_equilibrium
		and not override_equilibrium_effect
		and (_append == "sho" or _type == "Voucher" or _type == "Booster")
	then
		if
			_type ~= "Enhanced"
			and _type ~= "Edition"
			and _type ~= "Back"
			and _type ~= "Tag"
			and _type ~= "Seal"
			and _type ~= "Stake"
		then
			-- we're regenerating the pool every time because of banned keys but it's fine tbh
			P_CRY_ITEMS = {}
			local valid_pools = { "Joker", "Consumeables", "Voucher", "Booster" }
			for _, id in ipairs(valid_pools) do
				for k, v in pairs(G.P_CENTER_POOLS[id]) do
					if
						v.unlocked == true
						and not Cryptid.no(v, "doe", k)
						and not (G.GAME.banned_keys[v.key] or G.GAME.cry_banished_keys[v.key])
					then
						P_CRY_ITEMS[#P_CRY_ITEMS + 1] = v.key
					end
				end
			end
			if #P_CRY_ITEMS <= 0 then
				P_CRY_ITEMS[#P_CRY_ITEMS + 1] = "v_blank"
			end
			return P_CRY_ITEMS, "cry_equilibrium" .. G.GAME.round_resets.ante
		end
	end
	return gcp(_type, _rarity, _legendary, _append)
end

local gnb = get_new_boss
function get_new_boss()
	local bl = gnb()
	--Fix an issue with adding bosses mid-run
	for k, v in pairs(G.P_BLINDS) do
		if not G.GAME.bosses_used[k] then
			G.GAME.bosses_used[k] = 0
		end
	end
	-- Force Clock and Lavender Loop for Rush hour
	if G.GAME.modifiers.cry_rush_hour then
		--Check if Clock and Lavender Loop are both enabled
		if (Cryptid.enabled("bl_cry_clock") == true) and (Cryptid.enabled("bl_cry_lavender_loop") == true) then
			return (G.GAME.round_resets.ante % G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2)
					and "bl_cry_lavender_loop"
				or "bl_cry_clock"
		else
			-- Note: code elsewhere will force losses until both blinds are enabled
			return bl
		end
	end
	-- Log
	if G.GAME.LOG_BOSS then
		local v = "" .. G.GAME.LOG_BOSS
		if not G.GAME.USING_LOG then
			G.GAME.LOG_BOSS = nil
		end
		return v
	end
	--This is how nostalgic deck replaces the boss blinds with Nostalgic versions
	if G.GAME.modifiers.cry_beta then
		local bl_key = string.sub(bl, 4)
		local nostalgicblinds = {
			arm = (Cryptid.enabled("bl_cry_oldarm") == true),
			fish = (Cryptid.enabled("bl_cry_oldfish") == true),
			flint = (Cryptid.enabled("bl_cry_oldflint") == true),
			house = (Cryptid.enabled("bl_cry_oldhouse") == true),
			manacle = (Cryptid.enabled("bl_cry_oldmanacle") == true),
			mark = (Cryptid.enabled("bl_cry_oldmark") == true),
			ox = (Cryptid.enabled("bl_cry_oldox") == true),
			pillar = (Cryptid.enabled("bl_cry_oldpillar") == true),
			serpent = (Cryptid.enabled("bl_cry_oldserpent") == true),
		}
		if nostalgicblinds[bl_key] then
			return "bl_cry_old" .. bl_key
		end
	end
	return bl
end

--Add context for after cards are played
local gfep = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
	gfep(e)
	G.GAME.blind:cry_after_play()
end

--Track defeated blinds for Obsidian Orb
local dft = Blind.defeat
function Blind:defeat(s)
	dft(self, s)
	local obj = self.config.blind
	if
		(obj.boss and obj.boss.yes_orb)
		or (
			obj.name == "The Hook"
			or obj.name == "The Ox"
			or obj.name == "The House"
			or obj.name == "The Wall"
			or obj.name == "The Wheel"
			or obj.name == "The Arm"
			or obj.name == "The Club"
			or obj.name == "The Fish"
			or obj.name == "The Psychic"
			or obj.name == "The Goad"
			or obj.name == "The Water"
			or obj.name == "The Window"
			or obj.name == "The Manacle"
			or obj.name == "The Eye"
			or obj.name == "The Mouth"
			or obj.name == "The Plant"
			or obj.name == "The Serpent"
			or obj.name == "The Pillar"
			or obj.name == "The Needle"
			or obj.name == "The Head"
			or obj.name == "The Tooth"
			or obj.name == "The Flint"
			or obj.name == "The Mark"
			or obj.name == "Amber Acorn"
			or obj.name == "Verdant Leaf"
			or obj.name == "Violet Vessel"
			or obj.name == "Crimsion Heart"
			or obj.name == "Cerulean Bell"
		)
	then
	else
		return
	end
	if
		--Stop impossible blind combinations from happening
		--Needs a better system than this, needs a lovely patch for other mods to add to this list currently (TODO)
		(self.name ~= "cry-oldarm" or not G.GAME.defeated_blinds["bl_psychic"])
		and (self.name ~= "The Psychic" or not G.GAME.defeated_blinds["bl_cry_oldarm"])
		and (self.name ~= "cry-oldarm" or not G.GAME.defeated_blinds["bl_cry_scorch"])
		and (self.name ~= "cry-scorch" or not G.GAME.defeated_blinds["bl_cry_oldarm"])
		and (self.name ~= "The Eye" or not G.GAME.defeated_blinds["bl_mouth"])
		and (self.name ~= "The Mouth" or not G.GAME.defeated_blinds["bl_eye"])
		and (self.name ~= "cry-Lavender Loop" or not G.GAME.defeated_blinds["bl_cry_tax"])
		and (self.name ~= "cry-Tax" or not G.GAME.defeated_blinds["bl_cry_lavender_loop"])
		and (self.name ~= "The Needle" or not G.GAME.defeated_blinds["bl_cry_tax"])
		and (self.name ~= "cry-Tax" or not G.GAME.defeated_blinds["bl_needle"])
		and (self.name ~= "The Needle" or not G.GAME.defeated_blinds["bl_cry_chromatic"])
		and (self.name ~= "cry-chromatic" or not G.GAME.defeated_blinds["bl_needle"])
		and (self.name ~= "cry-Tax" or not G.GAME.defeated_blinds["bl_cry_chromatic"])
		and (self.name ~= "cry-chromatic" or not G.GAME.defeated_blinds["bl_cry_tax"])
	then
		G.GAME.defeated_blinds[self.config.blind.key or ""] = true
	end
end

local sr = Game.start_run
function Game:start_run(args)
	sr(self, args)
	if G.P_BLINDS.bl_cry_clock then
		G.P_BLINDS.bl_cry_clock.mult = 0
	end
	if not G.GAME.defeated_blinds then
		G.GAME.defeated_blinds = {}
	end
	G.consumeables.config.highlighted_limit = 1e100
	G.jokers.config.highlighted_limit = 1e100
end

--patch for multiple Clocks to tick separately and load separately
local bsb = Blind.set_blind
function Blind:set_blind(blind, y, z)
	local c = "Boss"
	if string.sub(G.GAME.subhash or "", -1) == "S" then
		c = "Small"
	end
	if string.sub(G.GAME.subhash or "", -1) == "B" then
		c = "Big"
	end
	if G.GAME.CRY_BLINDS and G.GAME.CRY_BLINDS[c] and not y and blind and blind.mult and blind.cry_ante_base_mod then
		blind.mult = G.GAME.CRY_BLINDS[c]
	end
	bsb(self, blind, y, z)
end

local rb = reset_blinds
function reset_blinds()
	if G.GAME.round_resets.blind_states.Boss == "Defeated" then
		G.GAME.CRY_BLINDS = {}
		if G.P_BLINDS.bl_cry_clock then
			G.P_BLINDS.bl_cry_clock.mult = 0
		end
	end
	rb()
end

--Init stuff at the start of the game
local gigo = Game.init_game_object
function Game:init_game_object()
	local g = gigo(self)
	-- Add initial dropshot and number blocks card
	g.current_round.cry_nb_card = { rank = "Ace" }
	g.current_round.cry_dropshot_card = { suit = "Spades" }
	g.monstermult = 1
	g.neutronstarsusedinthisrun = 0
	g.sunlevel = 1
	g.sunnumber = { modest = 0, not_modest = 0 }
	g.bonus_asc_power = 0
	g.cry_oboe = 0
	g.boostertag = 0
	-- Create G.GAME.events when starting a run, so there's no errors
	g.events = {}
	g.jokers_sold = {}
	g.cry_banished_keys = {}
	g.cry_last_used_consumeables = {}
	g.cry_function_stupid_workaround = {}

	-- Added by IcyEthics: Converted the voucher-related modifiers for the tier 3
	-- acclimator vouchers to be more generically accessible
	g.cry_bonusvouchercount = 0
	g.cry_bonusvouchersused = {}

	-- Automatically sets up the cry_percrate for each consumable type and sets it to 100 as a default
	g.cry_percrate = {}
	for _, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
		g.cry_percrate[v:lower()] = 100
	end

	return g
end

-- reset_castle_card hook for things like Dropshot and Number Blocks
-- Also exclude specific ranks/suits (such as abstract cards)
local rcc = reset_castle_card
function reset_castle_card()
	rcc()
	G.GAME.current_round.cry_nb_card = { rank = "Ace" }
	G.GAME.current_round.cry_dropshot_card = { suit = "Spades" }
	local valid_castle_cards = {}
	for k, v in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(v) and not SMODS.has_enhancement(v, "m_cry_abstract") then
			valid_castle_cards[#valid_castle_cards + 1] = v
		end
	end
	if valid_castle_cards[1] then
		--Dropshot
		local castle_card = pseudorandom_element(valid_castle_cards, pseudoseed("cry_dro" .. G.GAME.round_resets.ante))
		G.GAME.current_round.cry_dropshot_card.suit = castle_card.base.suit
		--Number Blocks
		local castle_card_two =
			pseudorandom_element(valid_castle_cards, pseudoseed("cry_nb" .. G.GAME.round_resets.ante))
		G.GAME.current_round.cry_nb_card.rank = castle_card_two.base.value
		G.GAME.current_round.cry_nb_card.id = castle_card_two.base.id
	end
end

-- Back.apply_to_run Hook for decks
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.cry_no_edition_price then
		G.GAME.modifiers.cry_no_edition_price = true
	end
end

--Game:update hook
local upd = Game.update

--init colors so they have references
G.C.CRY_TWILIGHT = { 0, 0, 0, 0 }
G.C.CRY_VERDANT = { 0, 0, 0, 0 }
G.C.CRY_EMBER = { 0, 0, 0, 0 }
G.C.CRY_DAWN = { 0, 0, 0, 0 }
G.C.CRY_HORIZON = { 0, 0, 0, 0 }
G.C.CRY_BLOSSOM = { 0, 0, 0, 0 }
G.C.CRY_AZURE = { 0, 0, 0, 0 }
G.C.CRY_ASCENDANT = { 0, 0, 0, 0 }
G.C.CRY_JOLLY = { 0, 0, 0, 0 }
G.C.CRY_GREENGRADIENT = { 0, 0, 0, 0 }
G.C.CRY_ALTGREENGRADIENT = { 0, 0, 0, 0 }
Cryptid.C = {
	EXOTIC = { HEX("708b91"), HEX("1e9eba") },
	TWILIGHT = { HEX("0800ff"), HEX("aa00ff") },
	VERDANT = { HEX("00ff22"), HEX("f4ff57") },
	EMBER = { HEX("ff0000"), HEX("ffae00") },
	DAWN = { HEX("00aaff"), HEX("ff00e3") },
	HORIZON = { HEX("c8fd09"), HEX("1ee7d9") },
	BLOSSOM = { HEX("ff09da"), HEX("ffd121") },
	AZURE = { HEX("0409ff"), HEX("63dcff") },
	ASCENDANT = { HEX("2e00f5"), HEX("e5001d") },
	JOLLY = { HEX("6ec1f5"), HEX("456b84") },
	SELECTED = { HEX("e38039"), HEX("ccdd1b") },
	GREENGRADIENT = { HEX("51e099"), HEX("1e523a") },
	ALTGREENGRADIENT = { HEX("6bb565"), HEX("bd28bf") },
	TAX_MULT = { HEX("FE5F55"), HEX("40ff40") },
	TAX_CHIPS = { HEX("009dff"), HEX("40ff40") },
}
cry_pointer_dt = 0
cry_jimball_dt = 0
cry_glowing_dt = 0
cry_glowing_dt2 = 0
local none_eval = 0
function Game:update(dt)
	upd(self, dt)
	if not Cryptid.member_count_delay then
		Cryptid.member_count_delay = 0
	end
	if (Cryptid.member_count_delay > 5) or not Cryptid.member_count then -- it doesn't need to update this frequently? but it also doesn't need to be higher tbh...
		if Cryptid.update_member_count then
			Cryptid.update_member_count()
		end -- i honestly hate nil checks like this, wish there was a shorthand
		Cryptid.member_count_delay = 0
	else
		Cryptid.member_count_delay = Cryptid.member_count_delay + dt
	end
	--Gradients based on Balatrostuck code
	local anim_timer = self.TIMERS.REAL * 1.5
	local p = 0.5 * (math.sin(anim_timer) + 1)
	for k, c in pairs(Cryptid.C) do
		if not G.C["CRY_" .. k] then
			G.C["CRY_" .. k] = { 0, 0, 0, 0 }
		end
		for i = 1, 4 do
			G.C["CRY_" .. k][i] = c[1][i] * p + c[2][i] * (1 - p)
		end
	end
	G.C.RARITY["cry_exotic"] = G.C.CRY_EXOTIC
	G.C.SECONDARY_SET["Content Set"] = G.C.CRY_ASCENDANT
	-- Idk what this is for
	if Incantation and not CryptidIncanCompat then
		AllowStacking("Code")
		AllowDividing("Code")
		CryptidIncanCompat = true
	end
	if Cryptid.enabled("set_cry_timer") == true then
		cry_pointer_dt = cry_pointer_dt + dt
		cry_jimball_dt = cry_jimball_dt + dt
		cry_glowing_dt = cry_glowing_dt + dt
		cry_glowing_dt2 = cry_glowing_dt2 + dt
	end
	--Update sprite positions each frame on certain cards to give the illusion of an animated card
	if G.P_CENTERS and G.P_CENTERS.c_cry_pointer and cry_pointer_dt > 0.5 then
		cry_pointer_dt = 0
		local pointerobj = G.P_CENTERS.c_cry_pointer
		pointerobj.pos.x = (pointerobj.pos.x == 11) and 12 or 11
	end
	if G.P_CENTERS and G.P_CENTERS.j_cry_jimball and cry_jimball_dt > 0.1 then
		cry_jimball_dt = 0
		local jimballobj = G.P_CENTERS.j_cry_jimball
		if jimballobj.pos.x == 5 and jimballobj.pos.y == 6 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = 0
		elseif jimballobj.pos.x < 8 then
			jimballobj.pos.x = jimballobj.pos.x + 1
		elseif jimballobj.pos.y < 6 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = jimballobj.pos.y + 1
		end
	end
	if G.P_CENTERS and G.P_CENTERS.b_cry_glowing and cry_glowing_dt > 0.1 then
		cry_glowing_dt = 0
		local glowingobj = G.P_CENTERS.b_cry_glowing
		if glowingobj.pos.x == 1 and glowingobj.pos.y == 4 then
			glowingobj.pos.x = 0
			glowingobj.pos.y = 0
		elseif glowingobj.pos.x < 4 then
			glowingobj.pos.x = glowingobj.pos.x + 1
		elseif glowingobj.pos.y < 6 then
			glowingobj.pos.x = 0
			glowingobj.pos.y = glowingobj.pos.y + 1
		end
	end
	if G.P_CENTERS and G.P_CENTERS.sleeve_cry_glowing_sleeve and cry_glowing_dt2 > 0.1 then
		cry_glowing_dt2 = 0
		local glowingobj = G.P_CENTERS.sleeve_cry_glowing_sleeve
		if glowingobj.pos.x == 1 and glowingobj.pos.y == 4 then
			glowingobj.pos.x = 0
			glowingobj.pos.y = 0
		elseif glowingobj.pos.x < 4 then
			glowingobj.pos.x = glowingobj.pos.x + 1
		elseif glowingobj.pos.y < 6 then
			glowingobj.pos.x = 0
			glowingobj.pos.y = glowingobj.pos.y + 1
		end
	end
	for k, v in pairs(G.I.CARD) do
		if v.children.back and v.children.back.atlas.name == "cry_glowing" then
			v.children.back:set_sprite_pos(G.P_CENTERS.b_cry_glowing.pos or G.P_CENTERS["b_red"].pos)
		end
	end
	if not G.OVERLAY_MENU and G.GAME.CODE_DESTROY_CARD and not G.OVERLAY_MENU_POINTER then
		G.FUNCS.exit_overlay_menu_code()
	end

	if not G.OVERLAY_MENU then
		G.GAME.USING_POINTER = nil
	else
		G.OVERLAY_MENU_POINTER = nil
	end

	--Increase the blind size for The Clock and Lavender Loop
	local choices = { "Small", "Big", "Boss" }
	G.GAME.CRY_BLINDS = G.GAME.CRY_BLINDS or {}
	for _, c in pairs(choices) do
		if
			G.GAME
			and G.GAME.round_resets
			and G.GAME.round_resets.blind_choices
			and G.GAME.round_resets.blind_choices[c]
			and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].cry_ante_base_mod
		then
			if
				G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult ~= 0
				and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult_ante ~= G.GAME.round_resets.ante
			then
				if G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].name == "cry-Obsidian Orb" then
					for i = 1, #G.GAME.defeated_blinds do
						G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult
							* G.P_BLINDS[G.GAME.defeated_blinds[i]]
							/ 2
					end
				else
					G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult = 0
				end
				G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult_ante = G.GAME.round_resets.ante
			end
			if
				G.GAME.round_resets.blind_states[c] ~= "Current"
				and G.GAME.round_resets.blind_states[c] ~= "Defeated"
			then
				G.GAME.CRY_BLINDS[c] = (G.GAME.CRY_BLINDS[c] or G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].mult)
					+ (
						G.P_BLINDS[G.GAME.round_resets.blind_choices[c]].cry_ante_base_mod
							and G.P_BLINDS[G.GAME.round_resets.blind_choices[c]]:cry_ante_base_mod(dt)
						or 0
					)
				--Update UI
				--todo: in blinds screen, too
				if G.blind_select_opts then
					if (SMODS.Mods["StrangeLib"] or {}).can_load then
						StrangeLib.dynablind.blind_choice_scores[c] = get_blind_amount(G.GAME.round_resets.blind_ante)
							* G.GAME.starting_params.ante_scaling
							* G.GAME.CRY_BLINDS[c]
						StrangeLib.dynablind.blind_choice_score_texts[c] =
							number_format(StrangeLib.dynablind.blind_choice_scores[c])
					else
						local blind_UI =
							G.blind_select_opts[string.lower(c)].definition.nodes[1].nodes[1].nodes[1].nodes[1]
						local chip_text_node = blind_UI.nodes[1].nodes[3].nodes[1].nodes[2].nodes[2].nodes[3]
						if chip_text_node then
							chip_text_node.config.text = number_format(
								get_blind_amount(G.GAME.round_resets.blind_ante)
									* G.GAME.starting_params.ante_scaling
									* G.GAME.CRY_BLINDS[c]
							)
							chip_text_node.config.scale = score_number_scale(
								0.9,
								get_blind_amount(G.GAME.round_resets.blind_ante)
									* G.GAME.starting_params.ante_scaling
									* G.GAME.CRY_BLINDS[c]
							)
						end
						G.blind_select_opts[string.lower(c)]:recalculate()
					end
				end
			elseif
				G.GAME.round_resets.blind_states[c] ~= "Defeated"
				and not G.GAME.blind.disabled
				and to_big(G.GAME.chips) < to_big(G.GAME.blind.chips)
			then
				G.GAME.blind.chips = G.GAME.blind.chips
					+ G.GAME.blind:cry_ante_base_mod(dt)
						* get_blind_amount(G.GAME.round_resets.ante)
						* G.GAME.starting_params.ante_scaling
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			end
		end
		if
			G.GAME.round_resets.blind_states[c] == "Current"
			and G.GAME
			and G.GAME.blind
			and not G.GAME.blind.disabled
			and to_big(G.GAME.chips) < to_big(G.GAME.blind.chips)
		then
			G.GAME.blind.chips = G.GAME.blind.chips
				* (G.GAME.blind.cry_round_base_mod and G.GAME.blind:cry_round_base_mod(dt) or 1)
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
	end
	if
		G.STATE == G.STATES.DRAW_TO_HAND
		and not G.hand.cards[1]
		and not G.deck.cards[1]
		and G.PROFILES[G.SETTINGS.profile].cry_none
	then
		G.STATE = G.STATES.SELECTING_HAND
		G.STATE_COMPLETE = false
	end
	if G.STATE == G.STATES.NEW_ROUND or G.STATE == G.STATES.HAND_PLAYED then
		none_eval = none_eval + dt
	else
		none_eval = 0
	end
end

-- All the scattered set_cost hooks from all the pre refactor files moved into one hook
local sc = Card.set_cost
function Card:set_cost()
	-- Makes the edition cost increase usually present not apply if this variable is true
	if self.edition and G.GAME.modifiers.cry_no_edition_price then
		local m = Cryptid.deep_copy(self.edition)
		self.edition = nil
		sc(self)
		self.edition = m
	else
		sc(self)
	end
	--Makes cube and Big Cube always cost a set amount
	if self.ability.name == "cry-Cube" then
		if Card.get_gameset(self) ~= "modest" then
			self.cost = -27
		else
			self.cost = -12
		end
	end
	if self.ability.name == "cry-Big Cube" then
		self.cost = 27
	end
	--Make Tarots free if Tarot Acclimator is redeemed
	--Make Planets free if Planet Acclimator is redeemed
	if self.ability.set == "Tarot" and G.GAME.used_vouchers.v_cry_tacclimator then
		self.cost = 0
	end
	if self.ability.set == "Planet" and G.GAME.used_vouchers.v_cry_pacclimator then
		self.cost = 0
	end

	--Multiplies voucher cost by G.GAME.modifiers.cry_voucher_price_hike
	--Used by bronze stake to make vouchers %50 more expensive
	if self.ability.set == "Voucher" and G.GAME.modifiers.cry_voucher_price_hike then
		self.cost = math.floor(self.cost * G.GAME.modifiers.cry_voucher_price_hike)
	end
	--Clone Tag
	for i = 1, #G.GAME.tags do
		if G.GAME.tags[i].key == "tag_cry_clone" then
			self.cost = self.cost * 1.5
			break
		end
	end

	--Update related costs
	self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
	if
		self.area
		and self.ability.couponed
		and (self.area == G.shop_jokers or self.area == G.shop_booster)
		and self.ability.name ~= "cry-Cube"
	then
		self.cost = 0
	end
	--Makes Cursed Jokers always sell for $0
	if self.config and self.config.center and self.config.center.rarity == "cry_cursed" then
		self.sell_cost = 0
	--Rotten Egg
	elseif G.GAME.cry_rotten_amount then
		self.sell_cost = G.GAME.cry_rotten_amount
	end
	self.sell_cost_label = self.facing == "back" and "?" or self.sell_cost
end

local sell_card_stuff = Card.sell_card
function Card:sell_card()
	if self.config.center.set == "Joker" then
		if self.config.center.key ~= "j_cry_necromancer" then
			local contained = false
			for _, v in ipairs(G.GAME.jokers_sold) do
				if v == self.config.center.key then
					contained = true
					break
				end
			end
			if not contained then
				table.insert(G.GAME.jokers_sold, self.config.center.key)
			end
		end
		-- Add Jolly Joker to the pool if card was treated as Jolly Joker
		if self:is_jolly() then
			local contained = false
			for _, v in ipairs(G.GAME.jokers_sold) do
				if v == "j_jolly" then
					contained = true
					break
				end
			end
			if not contained then
				table.insert(G.GAME.jokers_sold, "j_jolly")
			end
		end
	end
	sell_card_stuff(self)
end

-- Modify to display badges for credits and some gameset badges
-- todo: make this optional
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.cry_credits then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if obj.cry_credits.art or obj.cry_credits.code or obj.cry_credits.idea then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { "Cryptid" }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.cry_credits[v] then
					for i = 1, #obj.cry_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "cry_" .. v, vars = { obj.cry_credits[v][i] } })[1]
					end
				end
			end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			local cry_badge = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = G.C.CRY_EXOTIC,
							r = 0.1,
							minw = 2 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.cry_credits and obj.cry_credits.text_colour or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
			local function eq_col(x, y)
				for i = 1, 4 do
					if x[i] ~= y[i] then
						return false
					end
				end
				return true
			end
			for i = 1, #badges do
				if eq_col(badges[i].nodes[1].config.colour, HEX("708b91")) then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = cry_badge
					break
				end
			end
		end
		if obj.cry_credits.jolly then
			local scale_fac = {}
			local min_scale_fac = 1
			for i = 1, #obj.cry_credits.jolly do
				scale_fac[i] = calc_scale_fac(obj.cry_credits.jolly[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #obj.cry_credits.jolly do
				ct[i] = {
					string = obj.cry_credits.jolly[i],
				}
			end
			badges[#badges + 1] = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = G.C.CRY_JOLLY,
							r = 0.1,
							minw = 2,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.cry_credits and obj.cry_credits.text_colour_jolly or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
		end
	end
	local id = obj and obj.mod and obj.mod.id
	if
		Cryptid.safe_get(G, "ACTIVE_MOD_UI", "id") == id
		and obj
		and not obj.force_gameset
		and Cryptid.mod_gameset_whitelist[id]
	then
		local set = Cryptid.gameset(obj)
		if set == "disabled" or obj.set == "Content Set" then
			return
		end
		local card_type = localize("cry_gameset_" .. Cryptid.gameset(obj))
		if card_type == "ERROR" then
			card_type = localize("cry_gameset_custom")
		end
		badges[#badges + 1] = create_badge(
			card_type,
			set == "modest" and G.C.GREEN
				or set == "mainline" and G.C.RED
				or set == "madness" and G.C.CRY_EXOTIC
				or G.C.CRY_ASCENDANT
		)
	end
end

-- This is short enough that I'm fine overriding it
function calculate_reroll_cost(skip_increment)
	local limit = G.GAME.reroll_limit_buffer or nil
	if not limit then
		if next(find_joker("cry-candybuttons")) then
			limit = 1
		elseif G.GAME.used_vouchers.v_cry_rerollexchange then
			limit = 2
		end
	end
	if not G.GAME.current_round.free_rerolls or G.GAME.current_round.free_rerolls < 0 then
		G.GAME.current_round.free_rerolls = 0
	end
	if next(find_joker("cry-crustulum")) or G.GAME.current_round.free_rerolls > 0 then
		G.GAME.current_round.reroll_cost = 0
		return
	end
	if
		limit
		and (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost)
				+ G.GAME.current_round.reroll_cost_increase
			>= limit
	then
		G.GAME.current_round.reroll_cost_increase = 0
		G.GAME.current_round.reroll_cost = limit
		return
	end

	G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase or 0
	if not skip_increment then
		G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase
			+ (G.GAME.modifiers.cry_reroll_scaling or 1)
	end
	G.GAME.current_round.reroll_cost = (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost)
		+ G.GAME.current_round.reroll_cost_increase
end

local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local area = area or G.jokers
	local pseudo = function(x)
		return pseudorandom(pseudoseed(x))
	end
	local ps = pseudoseed
	if area == "ERROR" then
		pseudo = function(x)
			return pseudorandom(Cryptid.predict_pseudoseed(x))
		end
		ps = Cryptid.predict_pseudoseed
	end
	if (_type == "Joker" or _type == "Meme") and G.GAME and G.GAME.modifiers and G.GAME.modifiers.all_rnj then
		forced_key = "j_cry_rnjoker"
	end
	local function aeqviable(center)
		return center.unlocked and not Cryptid.no(center, "doe") and not (center.rarity == "cry_exotic")
	end
	if _type == "Joker" and not _rarity and not legendary then
		if not G.GAME.aequilibriumkey then
			G.GAME.aequilibriumkey = 1
		end
		local aeqactive = nil
		if next(find_joker("Ace Aequilibrium")) and not forced_key then
			while not aeqactive or not aeqviable(G.P_CENTER_POOLS.Joker[aeqactive]) do
				if math.ceil(G.GAME.aequilibriumkey) > #G.P_CENTER_POOLS["Joker"] then
					G.GAME.aequilibriumkey = 1
				end
				aeqactive = math.ceil(G.GAME.aequilibriumkey)
				G.GAME.aequilibriumkey = math.ceil(G.GAME.aequilibriumkey + 1)
			end
		end
		if aeqactive then
			forced_key = G.P_CENTER_POOLS["Joker"][aeqactive].key
		end
	end
	if _type == "Base" then
		forced_key = "c_base"
	end

	if forced_key and not G.GAME.banned_keys[forced_key] then
		_type = (G.P_CENTERS[forced_key].set ~= "Default" and G.P_CENTERS[forced_key].set or _type)
	end

	local front = (SMODS.set_create_card_front and (_type == "Base" or _type == "Enhanced")) or nil

	if area == "ERROR" then
		local ret = (front or G.P_CENTERS[forced_key] or G.P_CENTERS.b_red)
		if not ret.config then
			ret.config = {}
		end
		if not ret.config.center then
			ret.config.center = {}
		end
		if not ret.config.center.key then
			ret.config.center.key = ""
		end
		if not ret.ability then
			ret.ability = {}
		end
		return ret --the config.center.key stuff prevents a crash with Jen's Almanac hook
	end

	local card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local center = card and card.config and card.config.center or {}
	if front and G.GAME.modifiers.cry_force_suit then
		card:change_suit(G.GAME.modifiers.cry_force_suit)
	end
	if front and G.GAME.modifiers.cry_force_enhancement then
		card:set_ability(G.P_CENTERS[G.GAME.modifiers.cry_force_enhancement])
	end
	if front and G.GAME.modifiers.cry_force_edition then
		card:set_edition({ [G.GAME.modifiers.cry_force_edition] = true }, true, true)
		card:add_to_deck()
	end
	if front and G.GAME.modifiers.cry_force_seal then
		card:set_seal(G.GAME.modifiers.cry_force_seal)
	end
	if
		G.GAME.modifiers.cry_force_sticker == "eternal"
		or (
			G.GAME.modifiers.cry_sticker_sheet_plus
			and not (
				(_type == "Base" or _type == "Enhanced") and not ((area == G.shop_jokers) or (area == G.pack_cards))
			)
		)
	then -- wow that is long
		card:set_eternal(true)
		card.ability.eternal = true
	end
	if
		G.GAME.modifiers.cry_force_sticker == "perishable"
		or (
			G.GAME.modifiers.cry_sticker_sheet_plus
			and not (
				(_type == "Base" or _type == "Enhanced") and not ((area == G.shop_jokers) or (area == G.pack_cards))
			)
		)
	then
		card:set_perishable(true)
		card.ability.perish_tally = G.GAME.perishable_rounds -- set_perishable should be doing this? whatever
		card.ability.perishable = true
	end
	if
		G.GAME.modifiers.cry_force_sticker == "rental"
		or (
			G.GAME.modifiers.cry_sticker_sheet_plus
			and not (
				(_type == "Base" or _type == "Enhanced") and not ((area == G.shop_jokers) or (area == G.pack_cards))
			)
		)
	then
		card:set_rental(true)
		card.ability.rental = true
	end
	if
		G.GAME.modifiers.cry_force_sticker == "pinned"
		or (
			G.GAME.modifiers.cry_sticker_sheet_plus
			and not (
				(_type == "Base" or _type == "Enhanced") and not ((area == G.shop_jokers) or (area == G.pack_cards))
			)
		)
	then
		card.pinned = true
	end
	if
		G.GAME.modifiers.cry_force_sticker == "banana"
		or (
			G.GAME.modifiers.cry_sticker_sheet_plus
			and not (
				(_type == "Base" or _type == "Enhanced") and not ((area == G.shop_jokers) or (area == G.pack_cards))
			)
		)
	then
		card.ability.banana = true
	end
	if G.GAME.modifiers.cry_sticker_sheet_plus and not (_type == "Base" or _type == "Enhanced") then
		for k, v in pairs(SMODS.Stickers) do
			if v.apply and not v.no_sticker_sheet then
				v:apply(card, true)
			end
		end
	end

	if card.ability.name == "cry-Cube" then
		card:set_eternal(true)
	end
	if _type == "Joker" or (G.GAME.modifiers.cry_any_stickers and not G.GAME.modifiers.cry_sticker_sheet) then
		if G.GAME.modifiers.all_eternal then
			card:set_eternal(true)
		end
		if G.GAME.modifiers.cry_all_perishable then
			card:set_perishable(true)
		end
		if G.GAME.modifiers.cry_all_rental then
			card:set_rental(true)
		end
		if G.GAME.modifiers.cry_all_pinned then
			card.pinned = true
		end
		if G.GAME.modifiers.cry_all_banana then
			card.ability.banana = true
		end
		if (area == G.shop_jokers) or (area == G.pack_cards) then
			local eternal_perishable_poll = pseudorandom("cry_et" .. (key_append or "") .. G.GAME.round_resets.ante)
			if G.GAME.modifiers.enable_eternals_in_shop and eternal_perishable_poll > 0.7 then
				card:set_eternal(true)
			end
			if G.GAME.modifiers.enable_perishables_in_shop then
				if
					not G.GAME.modifiers.cry_eternal_perishable_compat
					and ((eternal_perishable_poll > 0.4) and (eternal_perishable_poll <= 0.7))
				then
					card:set_perishable(true)
				end
				if
					G.GAME.modifiers.cry_eternal_perishable_compat
					and pseudorandom("cry_per" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7
				then
					card:set_perishable(true)
				end
			end
			if
				G.GAME.modifiers.enable_rentals_in_shop
				and pseudorandom("cry_ssjr" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7
			then
				card:set_rental(true)
			end
			if
				G.GAME.modifiers.cry_enable_pinned_in_shop
				and pseudorandom("cry_pin" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7
			then
				card.pinned = true
			end
			if
				not G.GAME.modifiers.cry_eternal_perishable_compat
				and G.GAME.modifiers.enable_banana
				and (pseudorandom("cry_banana" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7)
				and (eternal_perishable_poll <= 0.7)
			then
				card.ability.banana = true
			end
			if
				G.GAME.modifiers.cry_eternal_perishable_compat
				and G.GAME.modifiers.enable_banana
				and (pseudorandom("cry_banana" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7)
			then
				card.ability.banana = true
			end
			if G.GAME.modifiers.cry_sticker_sheet then
				for k, v in pairs(SMODS.Stickers) do
					if v.apply and not v.no_sticker_sheet then
						v:apply(card, true)
					end
				end
			end
			if
				not SMODS.is_eternal(card)
				and G.GAME.modifiers.cry_enable_flipped_in_shop
				and pseudorandom("cry_flip" .. (key_append or "") .. G.GAME.round_resets.ante) > 0.7
			then
				card.cry_flipped = true
			end
		end
	end
	if (card.ability.set == "Code") and G.GAME.used_vouchers.v_cry_quantum_computing then
		local tot = 0
		for k, v in pairs(SMODS.find_card("v_cry_quantum_computing")) do
			tot = tot + v.ability.extra
		end
		if card.ability.cry_multiuse then
			card.ability.cry_multiuse = math.ceil((card.ability.cry_multiuse + tot))
		else
			card.ability.cry_multiuse = tot + 1
		end
	end
	if
		G.GAME.modifiers.cry_force_edition
		and not G.GAME.modifiers.cry_force_random_edition
		and area ~= G.pack_cards
	then
		card:set_edition(nil, true)
	end
	if G.GAME.modifiers.cry_force_random_edition and area ~= G.pack_cards then
		local edition = Cryptid.poll_random_edition()
		card:set_edition(edition, true)
	end
	if not (card.edition and (card.edition.cry_oversat or card.edition.cry_glitched)) then
		Cryptid.manipulate(card)
	end
	if card.ability.set == "Joker" and G.GAME.modifiers.cry_common_value_quad then
		if card.config.center.rarity == 1 then
			Cryptid.manipulate(card, { value = 4 })
		end
	end
	if card.ability.set == "Joker" and G.GAME.modifiers.cry_uncommon_value_quad then
		if card.config.center.rarity == 2 then
			Cryptid.manipulate(card, { value = 4 })
		end
	end
	if card.ability.consumeable and card.pinned then -- counterpart is in Sticker.toml
		G.GAME.cry_pinned_consumeables = G.GAME.cry_pinned_consumeables + 0
	end
	if next(find_joker("Cry-topGear")) and card.config.center.rarity == 1 then
		if
			card.ability.name ~= "cry-meteor"
			and card.ability.name ~= "cry-exoplanet"
			and card.ability.name ~= "cry-stardust"
			and card.ability.name ~= "cry-universe"
		then
			card:set_edition("e_polychrome", true, nil, true)
		end
	end
	if card.ability.name == "cry-meteor" then
		card:set_edition("e_foil", true, nil, true)
	end
	if card.ability.name == "cry-exoplanet" then
		card:set_edition("e_holo", true, nil, true)
	end
	if card.ability.name == "cry-stardust" then
		card:set_edition("e_polychrome", true, nil, true)
	end
	if card.ability.name == "cry-universe" then
		card:set_edition("e_cry_astral", true, nil, true)
	end
	-- Certain jokers such as Steel Joker and Driver's License depend on values set
	-- during the update function. Cryptid can create jokers mid-scoring, meaning
	-- those values will be unset during scoring unless update() is manually called.
	card:update(0.016) -- dt is unused in the base game, but we're providing a realistic value anyway
	return card
end

local at = add_tag
function add_tag(tag)
	at(tag)
	-- Update Costs for Clone Tag
	if tag.name == "cry-Clone Tag" then
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then
				v:set_cost()
			end
		end
	end
	-- Make tags fit if there's more than 13 of them
	-- This + Tag.remove Hook modify the offset to squeeze in more tags when needed
	if #G.HUD_tags > 13 then
		for i = 2, #G.HUD_tags do
			G.HUD_tags[i].config.offset.y = 0.9 - 0.9 * 13 / #G.HUD_tags
		end
	end
end

local tr = Tag.remove
function Tag:remove()
	tr(self)
	if #G.HUD_tags >= 13 then
		for i = 2, #G.HUD_tags do
			G.HUD_tags[i].config.offset.y = 0.9 - 0.9 * 13 / #G.HUD_tags
		end
	end
end

local nr = new_round
function new_round()
	-- I don't remember exactly what this patch was for, perhaps issues with syncing hand size with jokers like Effarcire?
	G.hand:change_size(0)
	nr()
	-- Reset Semicolon
	G.GAME.current_round.semicolon = false
	-- Force losses if Rush hour is played with clock and lavender loop disabled
	if G.GAME.modifiers.cry_rush_hour then
		if not (Cryptid.enabled("bl_cry_clock") == true) or not (Cryptid.enabled("bl_cry_lavender_loop") == true) then
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.STAGE == G.STAGES.RUN then
						G.STATE = G.STATES.GAME_OVER
						G.STATE_COMPLETE = false
					end
					print(localize("rush_hour_reminder"))
					return true
				end,
			}))
		end
	end
end

local stamp_can_play = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
	local value = 0
	-- Allow 0 card hand to always be played if none is unlocked and poker hands aren't disabled
	if Cryptid.enabled("set_cry_poker_hand_stuff") == true and G.PROFILES[G.SETTINGS.profile].cry_none then
		value = -1
	end
	-- Prevent 1 card hand from being played if Sapphire Stamp is active and poker hands aren't enabled (would result in 0 card hand)
	if G.GAME.stamp_mod and Cryptid.enabled("set_cry_poker_hand_stuff") ~= true then
		value = 1
	end

	if value == 0 then
		stamp_can_play(e)
	else
		if
			#G.hand.highlighted <= value
			or G.GAME.blind.block_play
			or #G.hand.highlighted > math.max(G.GAME.starting_params.play_limit, 1)
		then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.BLUE
			e.config.button = "play_cards_from_highlighted"
		end
	end
end
local stamp_can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
	local value = 0
	-- Allow 0 card hand to always be discarded if none is unlocked and poker hands aren't disabled
	if Cryptid.enabled("set_cry_poker_hand_stuff") == true and G.PROFILES[G.SETTINGS.profile].cry_none then
		value = -1
	end
	if value == 0 then
		stamp_can_discard(e)
	else
		if
			G.GAME.current_round.discards_left <= 0
			or #G.hand.highlighted <= value
			or #G.hand.highlighted > math.max(G.GAME.starting_params.discard_limit, 0)
		then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.RED
			e.config.button = "discard_cards_from_highlighted"
		end
	end
end

-- These allow jokers that add joker slots to be obtained even without room, like with Negative Jokers in vanilla
local gfcfbs = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	if
		(card.ability.name == "cry-Negative Joker" and card.ability.extra.slots >= 1)
		or (card.ability.name == "cry-soccer" and card.ability.extra.holygrail >= 1)
		or (card.ability.name == "cry-Tenebris" and card.ability.extra.slots >= 1)
	then
		return true
	end
	return gfcfbs(card)
end

local gfcsc = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
	if
		(e.config.ref_table.ability.name == "cry-Negative Joker" and e.config.ref_table.ability.extra.slots >= 1)
		or (e.config.ref_table.ability.name == "cry-soccer" and e.config.ref_table.ability.extra.holygrail >= 1)
		or (e.config.ref_table.ability.name == "cry-Tenebris" and e.config.ref_table.ability.extra.slots >= 1)
	then
		e.config.colour = G.C.GREEN
		e.config.button = "use_card"
	else
		gfcsc(e)
	end
end

--Cryptid (THE MOD) localization
local function parse_loc_txt(center)
	center.text_parsed = {}
	if center.text then
		for _, line in ipairs(center.text) do
			center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
		end
		center.name_parsed = {}
		for _, line in ipairs(type(center.name) == "table" and center.name or { center.name }) do
			center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
		end
		if center.unlock then
			center.unlock_parsed = {}
			for _, line in ipairs(center.unlock) do
				center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
			end
		end
	end
end
local il = init_localization
function init_localization()
	if G.SETTINGS.language == "en-us" then
		G.localization.descriptions.Spectral.c_cryptid.text[2] = "{C:attention}#2#{} selected card"
		G.localization.descriptions.Spectral.c_talisman.text[2] = "to {C:attention}#1#{} selected"
		G.localization.descriptions.Spectral.c_trance.text[2] = "to {C:attention}#1#{} selected"
		G.localization.descriptions.Spectral.c_medium.text[2] = "to {C:attention}#1#{} selected"
		G.localization.descriptions.Spectral.c_deja_vu.text[2] = "to {C:attention}#1#{} selected"
		G.localization.descriptions.Spectral.c_deja_vu.text[2] = "to {C:attention}#1#{} selected"
		G.localization.descriptions.Spectral.c_deja_vu.text[2] = "to {C:attention}#1#{} selected" -- why is this done THREE times???
		G.localization.descriptions.Voucher.v_antimatter.text[1] = "{C:dark_edition}+#1#{} Joker Slot"
		G.localization.descriptions.Voucher.v_overstock_norm.text[1] = "{C:attention}+#1#{} card slot"
		G.localization.descriptions.Voucher.v_overstock_plus.text[1] = "{C:attention}+#1#{} card slot"
		G.localization.descriptions.Voucher.v_crystal_ball.text[1] = "{C:attention}+#1#{} consumable slot"
		G.localization.descriptions.Joker.j_seance.text[1] = "If {C:attention}played hand{} contains a" -- damnit seance
	end
	il()
	if Cryptid.object_buffer and Cryptid.object_buffer.Stake then
		for i = 1, #Cryptid.object_buffer.Stake do
			local key = Cryptid.object_buffer.Stake[i].key
			local color = G.localization.descriptions.Stake[key] and G.localization.descriptions.Stake[key].colour
			if color then
				local sticker_key = key:sub(7) .. "_sticker"
				if not G.localization.descriptions.Other[sticker_key] then
					G.localization.descriptions.Other[sticker_key] = {
						name = localize({ type = "variable", key = "cry_sticker_name", vars = { color } })[1],
						text = localize({
							type = "variable",
							key = "cry_sticker_desc",
							vars = {
								color,
								"{C:attention}",
								"{}",
							},
						}),
					}
					parse_loc_txt(G.localization.descriptions.Other[sticker_key])
				end
			end
		end
	end

	for _, group in pairs(G.localization.descriptions) do
		if
			_ ~= "Back"
			and _ ~= "Content Set"
			and _ ~= "Edition"
			and _ ~= "Enhanced"
			and _ ~= "Stake"
			and _ ~= "Other"
		then
			for key, card in pairs(group) do
				if G.P_CENTERS[key] then
					Cryptid.pointeraliasify(key, card.name, true)
				end
			end
		end
	end
	Cryptid.inject_pointer_aliases()
end

--Fix a corrupted game state
function Controller:queue_L_cursor_press(x, y)
	if self.locks.frame then
		return
	end
	if G.STATE == G.STATES.SPLASH then
		if not G.HUD then
			self:key_press("escape")
		else
			G.STATE = G.STATES.BLIND_SELECT
		end
	end
	self.L_cursor_queue = { x = x, y = y }
end

-- Lemon Trophy's effect
local trophy_mod_mult = mod_mult
function mod_mult(_mult)
	hand_chips = hand_chips or 0
	if G.GAME.trophymod then
		_mult = math.min(_mult, math.max(hand_chips, 0))
	end
	return trophy_mod_mult(_mult)
end

-- Fix a CCD-related crash
local cuc = Card.can_use_consumeable
function Card:can_use_consumeable(any_state, skip_check)
	if not self.ability.consumeable then
		return false
	end
	return cuc(self, any_state, skip_check)
end

-- add second back button to create_UIBox_generic_options
local cuigo = create_UIBox_generic_options
function create_UIBox_generic_options(args)
	local ret = cuigo(args)
	if args.back2 then
		local mainUI = ret.nodes[1].nodes[1].nodes
		mainUI[#mainUI + 1] = {
			n = G.UIT.R,
			config = {
				id = args.back2_id or "overlay_menu_back2_button",
				align = "cm",
				minw = 2.5,
				button_delay = args.back2_delay,
				padding = 0.1,
				r = 0.1,
				hover = true,
				colour = args.back2_colour or G.C.ORANGE,
				button = args.back2_func or "exit_overlay_menu",
				shadow = true,
				focus_args = { nav = "wide", button = "b", snap_to = args.snap_back2 },
			},
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0, no_fill = true },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								id = args.back2_id or nil,
								text = args.back2_label or localize("b_back"),
								scale = 0.5,
								colour = G.C.UI.TEXT_LIGHT,
								shadow = true,
								func = not args.no_pip and "set_button_pip" or nil,
								focus_args = not args.no_pip and { button = args.back2_button or "b" } or nil,
							},
						},
					},
				},
			},
		}
	end
	return ret
end

local scuref = set_consumeable_usage
function set_consumeable_usage(card)
	if not G.GAME.cry_last_used_consumeables then
		G.GAME.cry_last_used_consumeables = {}
	end
	for i = 1, #G.GAME.cry_last_used_consumeables do
		if not G.GAME.cry_function_stupid_workaround then
			G.GAME.cry_function_stupid_workaround = {}
		end
		G.GAME.cry_function_stupid_workaround[i] = G.GAME.cry_last_used_consumeables[i]
	end
	local nextindex = #G.GAME.cry_last_used_consumeables + 1
	G.GAME.cry_last_used_consumeables[nextindex] = card.config.center_key
	if nextindex > 3 then
		table.remove(G.GAME.cry_last_used_consumeables, 1)
	end
	scuref(card)
end

--Abstract cards: Fix to avoid "ghost cards", as aresult of destroying discarded cards by adding a flag checcking its not destroyed
G.FUNCS.draw_from_discard_to_deck = function(e)
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			local discard_count = #G.discard.cards
			for i = 1, discard_count do --draw cards from deck
				local card = G.discard.cards[i]
				if not card.shattered and not card.destroyed then
					draw_card(
						G.discard,
						G.deck,
						i * 100 / discard_count,
						"up",
						nil,
						card,
						0.005,
						i % 2 == 0,
						nil,
						math.max((21 - i) / 20, 0.7)
					)
				end
			end
			return true
		end,
	}))
end

--Add a hook to getID for abstracts (and to conditionally enable the check)
local getIDenhance = Card.get_id
function Card:get_id()
	--Force suit to be suit X if specified in enhancement, only if not vampired
	if Cryptid.cry_enhancement_has_specific_rank(self) and not self.vampired then
		--Get the max value + 1, to always be the last at the list
		return SMODS.Rank.max_id.value + 1
	end
	local vars = getIDenhance(self)
	return vars
end

--override shatter function to adjust volume (it has been requested that at end of deck, abstract cards should shatter a bit quieter)
function Card:shatter(volume)
	local dissolve_time = 0.7
	self.shattered = true
	self.dissolve = 0
	self.dissolve_colours = { { 1, 1, 1, 0.8 } }
	self:juice_up()
	local childParts = Particles(0, 0, 0, 0, {
		timer_type = "TOTAL",
		timer = 0.007 * dissolve_time,
		scale = 0.3,
		speed = 4,
		lifespan = 0.5 * dissolve_time,
		attach = self,
		colours = self.dissolve_colours,
		fill = true,
	})
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		blockable = false,
		delay = 0.5 * dissolve_time,
		func = function()
			childParts:fade(0.15 * dissolve_time)
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		blockable = false,
		func = function()
			play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, volume or 0.5)
			play_sound("generic1", math.random() * 0.2 + 0.9, volume or 0.5)
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "ease",
		blockable = false,
		ref_table = self,
		ref_value = "dissolve",
		ease_to = 1,
		delay = 0.5 * dissolve_time,
		func = function(t)
			return t
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		blockable = false,
		delay = 0.55 * dissolve_time,
		func = function()
			self:remove()
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		blockable = false,
		delay = 0.51 * dissolve_time,
	}))
end

-- Buttercup's store joker mechanic, creates a specified joker
local ccfs = create_card_for_shop
function create_card_for_shop(area)
	local guaranteed_card = Card(
		area.x,
		area.y,
		G.CARD_W,
		G.CARD_H,
		nil,
		G.P_CENTERS.j_jolly,
		{ bypass_discovery_center = true, bypass_discovery_ui = true }
	)
	local areas_to_check = {
		shop_jokers = G.shop_jokers,
		shop_vouchers = G.shop_vouchers,
		shop_booster = G.shop_booster,
	}
	local loaded_card_data = nil
	local loaded_card_pos = -1
	-- check if there's a card for `area` within `next_shop_cards`,
	-- then put its data in `loaded_card_data` and its index in the table in `loaded_card_pos`
	if G.GAME.next_shop_cards and #G.GAME.next_shop_cards > 0 then
		for i, card in ipairs(G.GAME.next_shop_cards) do
			if not card.cry_from_shop then
				card.cry_from_shop = "shop_jokers"
			end -- failsafe :3
			if areas_to_check[card.cry_from_shop] == area and loaded_card_pos == -1 then
				loaded_card_data = card
				loaded_card_pos = i
				break
			elseif areas_to_check[card.cry_from_shop] ~= G.shop_jokers then
				local other_card = Card(
					area.x,
					area.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS.j_jolly,
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				other_card:load(card, nil)
				other_card.VT.h = other_card.T.h
				table.remove(G.GAME.next_shop_cards, i)
				create_shop_card_ui(
					other_card,
					G.P_CENTERS[card.save_fields.center],
					set,
					areas_to_check[card.cry_from_shop]
				)
				areas_to_check[card.cry_from_shop]:emplace(other_card)
				other_card.states.visible = false
				G.E_MANAGER:add_event(Event({
					delay = 0.4,
					trigger = "after",
					func = function()
						other_card:start_materialize()
						other_card:set_cost()
						return true
					end,
				}))
				other_card:set_cost()
			end
		end
	end
	if loaded_card_data then
		-- guaranteed_card.T.h = G.CARD_H
		guaranteed_card:load(loaded_card_data, nil)
		guaranteed_card.VT.h = guaranteed_card.T.h
		table.remove(G.GAME.next_shop_cards, loaded_card_pos)
		create_shop_card_ui(guaranteed_card, "Joker", area)
		guaranteed_card.states.visible = false
		G.E_MANAGER:add_event(Event({
			delay = 0.4,
			trigger = "after",
			func = function()
				guaranteed_card:start_materialize()
				guaranteed_card:set_cost()
				return true
			end,
		}))
		guaranteed_card:set_cost()
		return guaranteed_card
	else
		guaranteed_card:remove()
	end
	return ccfs(area)
end

-- Again, buttercup, making sure you can savescum safely :gjumbsup:
local carsv = Card.save
function Card:save()
	local saved_table = carsv(self)
	if self.cry_storage then
		saved_table.cry_storage = self.cry_storage:save()
	end
	if self.cry_from_shop then
		saved_table.cry_from_shop = self.cry_from_shop
	end
	return saved_table
end

local carld = Card.load
function Card:load(cardTable, other_card)
	carld(self, cardTable, other_card)

	local storage_area_config = {
		type = "play",
		card_w = G.CARD_W,
	}
	if cardTable.cry_storage then
		self.cry_storage = CardArea(self.T.x, 2, 1, 1, storage_area_config)
		self.cry_storage:load(cardTable.cry_storage)
		for i, card in ipairs(self.cry_storage.cards) do
			card.T.orig = { w = card.T.w, h = card.T.h }
			card.T.w = card.T.w * 0.5
			card.T.h = card.T.h * 0.5
		end
	end
	if cardTable.cry_from_shop then
		self.cry_from_shop = cardTable.cry_from_shop
	end
end

-- Attach Buttercup's stored cards card area
local carmv = Card.move
function Card:move(dt)
	carmv(self, dt)
	if self.cry_storage ~= nil and self.cry_storage.cards ~= nil then
		self.cry_storage.config.card_limit = #self.cry_storage.cards + 1
		self.cry_storage.T.w = G.CARD_W * 2
		self.cry_storage.T.x = self.T.x - (G.CARD_W * 0.5)
		self.cry_storage.T.y = self.T.y
		self.cry_storage.VT.x = self.VT.x
		self.cry_storage.VT.y = self.VT.y
	end
end

--Hook for booster skip to automatically destroy and banish the rightmost Joker, regardless of eternal
local banefulSkipPenalty = G.FUNCS.skip_booster
G.FUNCS.skip_booster = function(e)
	--Imported from my Epic Decision and also works in Polterworx and with unpleasant card, in the event youc an still skip with all eternals/cursed jokers
	local obj = SMODS.OPENED_BOOSTER.config.center
	-- local obj2 = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if obj.unskippable and type(obj.unskippable) == "function" and obj:unskippable() == true then
		if G.GAME.blind then
			--Unplesant card will continously spam, so that will do for now without patching that; it is "unpleasant" after all;
			-- play_sound('cancel', 0.8, 1)
			-- local text = localize('k_nope_ex')
			-- attention_text({
			--     scale = 0.9, text = text, hold = 0.75, align = 'cm', offset = {x = 0,y = -2.7},major = G.play,colour = obj2.boss_colour or G.C.RED
			-- })
			G.GAME.blind:wiggle()
			G.GAME.blind.triggered = true
		end
		if e and e.disable_button then
			e.disable_button = nil
			-- print("disble")
		end
	else
		if SMODS.OPENED_BOOSTER.config.center.cry_baneful_punishment then
			if not G.GAME.banned_keys then
				G.GAME.banned_keys = {}
			end -- i have no idea if this is always initialised already tbh
			if not G.GAME.cry_banned_pcards then
				G.GAME.cry_banished_keys = {}
			end
			local c = nil
			c = G.jokers.cards[#G.jokers.cards] --fallback to rightmost if somehow, you skipped without disabling and its unskippable.
			--Iterate backwards to get the rightmost valid (non eternal or cursed) Joker
			if G.jokers and G.jokers.cards then
				for i = #G.jokers.cards, 1, -1 do
					if
						not (
							SMODS.is_eternal(G.jokers.cards[i])
							or G.jokers.cards[i].config.center.rarity == "cry_cursed"
						)
					then
						c = G.jokers.cards[i]
						break
					end
				end
			end

			if c.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end

			G.GAME.cry_banished_keys[c.config.center.key] = true
			if G.GAME.blind then
				G.GAME.blind:wiggle()
				G.GAME.blind.triggered = true
			end
			c:start_dissolve()
		end
		banefulSkipPenalty(e)
	end
end

--Overriding the skip booster function.
G.FUNCS.can_skip_booster = function(e)
	if
		G.pack_cards
		and not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
		and (
			G.STATE == G.STATES.SMODS_BOOSTER_OPENED
			or G.STATE == G.STATES.PLANET_PACK
			or G.STATE == G.STATES.STANDARD_PACK
			or G.STATE == G.STATES.BUFFOON_PACK
			or G.hand
		)
	then
		--if a booster is unskippable (when its unskippable conditionsa re fulfilled), unhighlight it
		local obj = SMODS.OPENED_BOOSTER.config.center
		if obj.unskippable and type(obj.unskippable) == "function" then
			if obj:unskippable() == true then
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
			else
				e.config.colour = G.C.GREY
				e.config.button = "skip_booster"
			end
		else
			e.config.colour = G.C.GREY
			e.config.button = "skip_booster"
		end
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end
--none stuff
local set_blindref = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
	set_blindref(self, blind, reset, silent)
	if
		G.GAME.hands["cry_None"].visible
		and (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND)
		and #G.hand.highlighted == 0
	then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				Cryptid.reset_to_none()
				return true
			end,
		}))
	end
end

local end_roundref = end_round
function end_round()
	if
		((#G.hand.cards < 1 and #G.deck.cards < 1 and #G.play.cards < 1) or (#G.hand.cards < 1 and #G.deck.cards < 1))
		and G.STATE == G.STATES.SELECTING_HAND
	then
		if
			Cryptid.enabled("set_cry_poker_hand_stuff") == true
			and not Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "cry_none")
		then
			G.PROFILES[G.SETTINGS.profile].cry_none2 = true
			G.PROFILES[G.SETTINGS.profile].cry_none = true
		end
		if not Cryptid.enabled("set_cry_poker_hand_stuff") then
			end_roundref()
		end
	else
		end_roundref()
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		func = function()
			update_hand_text({ delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })

			return true
		end,
	}))
end

local after_ref = evaluate_play_after
function evaluate_play_after(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
	local ret = after_ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
	if G.GAME.hands["cry_None"].visible then
		G.reset_to_none = true
	end
	return ret
end
local update_handref = Game.update_selecting_hand
function Game:update_selecting_hand(dt)
	local ret = update_handref(self, dt)
	if G.reset_to_none then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				Cryptid.reset_to_none()

				return true
			end,
		}))
		G.reset_to_none = nil
	end
	return ret
end

local blind_loadref = Blind.load
function Blind:load(blindTable)
	blind_loadref(self, blindTable)
	if
		G.GAME.hands["cry_None"].visible
		and self.blind_set
		and (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.DRAW_TO_HAND)
	then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				Cryptid.reset_to_none()
				return true
			end,
		}))
	end
end

local evaluate_ref = G.FUNCS.evaluate_round
G.FUNCS.evaluate_round = function()
	evaluate_ref()
	update_hand_text({ delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		func = function()
			update_hand_text({ delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })
			return true
		end,
	}))
end

local discard_ref = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
	--Labyrinth: set current_round_discards_used to 0 for effects
	G.GAME.current_round.discards_used2 = G.GAME.current_round.discards_used
	if next(find_joker("cry-maze")) then
		G.GAME.current_round.discards_used = 0
	end
	discard_ref(e, hook)
	local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
	if highlighted_count <= 0 then
		table.sort(G.hand.highlighted, function(a, b)
			return a.T.x < b.T.x
		end)
		check_for_unlock({ type = "discard_custom", cards = {} })
		for j = 1, #G.jokers.cards do
			G.jokers.cards[j]:calculate_joker({ pre_discard = true, full_hand = G.hand.highlighted, hook = hook })
		end
		if not hook then
			if G.GAME.modifiers.discard_cost then
				ease_dollars(-G.GAME.modifiers.discard_cost)
			end
			ease_discard(-1)
			G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
			G.STATE = G.STATES.DRAW_TO_HAND
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					G.STATE_COMPLETE = false
					return true
				end,
			}))
		end
	end
	if G.GAME.hands["cry_None"].visible then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				Cryptid.reset_to_none()
				return true
			end,
		}))
	end
	--Labyrinth: return current_round_discards_used back to the amount it is supposed to be after
	G.GAME.current_round.discards_used = G.GAME.current_round.discards_used2 + 1
end
local play_ref = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
	--Labyrinth: set current_round_hands played to 0 for effects
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			G.GAME.current_round.hands_played2 = G.GAME.current_round.hands_played
			if next(find_joker("cry-maze")) then
				G.GAME.current_round.hands_played = 0
			end
			return true
		end,
	}))
	G.GAME.before_play_buffer = true
	-- None Stuff
	if G.GAME.stamp_mod and not G.PROFILES[G.SETTINGS.profile].cry_none and #G.hand.highlighted == 1 then
		G.PROFILES[G.SETTINGS.profile].cry_none = true
		G.PROFILES[G.SETTINGS.profile].cry_none2 = true
		print("nonelock stuff here")
		G.GAME.hands["cry_None"].visible = true
	end
	if G.PROFILES[G.SETTINGS.profile].cry_none and #G.hand.highlighted == 0 then
		G.GAME.hands["cry_None"].visible = true
	end
	--Add blind context for Just before cards are played
	G.GAME.blind:cry_before_play()
	play_ref(e)
	--Labyrinth: return current_round_hands played to the amount it is supposed to be at after
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					G.GAME.current_round.hands_played = G.GAME.current_round.hands_played2 + 1
					return true
				end,
			}))
			return true
		end,
	}))
	G.GAME.before_play_buffer = nil
end

local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
	use_cardref(e, mute, nosave)
	if G.STATE == G.STATES.SELECTING_HAND then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				G.hand:parse_highlighted()
				return true
			end,
		}))
	else
		update_hand_text({ delay = 0 }, { mult = 0, chips = 0, handname = "", level = "" })
	end
end
local emplace_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	return emplace_ref(self, card or {}, location, stay_flipped)
end
-- Added by IcyEthics: Adding a hook to the shuffle function so that there can be a context to modify randomization
-- Any card using this will most likely want to use cry_post_shuffle.
-- added cry_pre_shuffle for posterity
local o_ca_shuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
	SMODS.calculate_context({ cry_shuffling_area = true, cardarea = self, cry_pre_shuffle = true })

	o_ca_shuffle(self, _seed)

	SMODS.calculate_context({ cry_shuffling_area = true, cardarea = self, cry_post_shuffle = true })
end

local smods_four_fingers = SMODS.four_fingers
function SMODS.four_fingers()
	return smods_four_fingers() - Cryptid.get_paved_joker()
end

function Cryptid.create_dummy_from_stone(rank)
	local r = tostring(rank)
	rank = SMODS.Ranks[r].id
	return {
		get_id = function()
			return rank
		end,
		config = {
			center = {},
		},
		ability = {},
		base = {
			id = rank,
			value = rank >= 11 and "Queen" or "10",
		},
	}
end
function Cryptid.next_ranks(key, start, recurse)
	key = ({
		["14"] = "Ace",
		["13"] = "King",
		["12"] = "Queen",
		["11"] = "Jack",
	})[tostring(key)] or key
	local rank = SMODS.Ranks[tostring(key)]
	local ret = {}
	if not rank or (not start and not wrap and rank.straight_edge) then
		return ret
	end
	for _, v in ipairs(rank.next) do
		ret[#ret + 1] = v
		local curr = #ret
		if recurse and recurse > 0 then
			for i, v in pairs(Cryptid.next_ranks(ret[#ret], start, recurse - 1)) do
				ret[#ret + 1] = v
			end
		end
	end
	return ret
end

local function append(t, new)
	local clone = {}
	for _, item in ipairs(t) do
		clone[#clone + 1] = item
	end
	clone[#clone + 1] = new
	return clone
end

function Cryptid.unique_combinations(tbl, sub, min)
	sub = sub or {}
	min = min or 1
	local wrap, yield = coroutine.wrap, coroutine.yield
	return wrap(function()
		if #sub > 0 then
			yield(sub) -- yield short combination.
		end
		if #sub < #tbl then
			for i = min, #tbl do -- iterate over longer combinations.
				for combo in Cryptid.unique_combinations(tbl, append(sub, tbl[i]), i + 1) do
					yield(combo)
				end
			end
		end
	end)
end
get_straight_ref = get_straight
function get_straight(hand, min_length, skip, wrap)
	local permutations = {}
	local ranks = {}
	local cards = {}
	local stones = Cryptid.get_paved_joker()
	if stones > 0 then
		for i, v in pairs(hand) do
			if v.config.center.key ~= "m_stone" then
				cards[#cards + 1] = v
				for i, v in pairs(Cryptid.next_ranks(v:get_id(), nil, stones)) do --this means its inaccurate in some situations like K S S S S but its fine there isnt a better way
					ranks[v] = true
				end
			end
			if v:get_id() >= 11 then
				new_ranks = {
					"Ace",
					"King",
					"Queen",
					"Jack",
					10,
				}
				for i, v in pairs(new_ranks) do
					ranks[v] = true
				end
			end
		end
		local rranks = {}
		for i, v in pairs(ranks) do
			rranks[#rranks + 1] = i
		end
		for i, v in Cryptid.unique_combinations(rranks) do
			if #i == stones then
				permutations[#permutations + 1] = i
			end
		end
		for i, v in ipairs(permutations) do
			local actual = {}
			local ranks = {}
			for i, v in pairs(cards) do
				actual[#actual + 1] = v
				ranks[v:get_id()] = true
			end
			for i, p in pairs(v) do
				local d = Cryptid.create_dummy_from_stone(p)
				if not ranks[d:get_id()] then
					actual[#actual + 1] = d
				end
			end
			local ret = get_straight_ref(actual, min_length + stones, skip, true)
			if ret and #ret > 0 then
				return ret
			end
		end
	end

	return get_straight_ref(hand, min_length + stones, skip, wrap)
end

local get_prob_vars_ref = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll, no_mod, ...)
	local mod = trigger_obj and trigger_obj.ability and trigger_obj.ability.cry_prob or 1
	local numerator = base_numerator * mod
	if trigger_obj and trigger_obj.ability and trigger_obj.ability.cry_rigged and not no_mod then
		numerator = base_denominator
	end
	return get_prob_vars_ref(trigger_obj, numerator, base_denominator, identifier, from_roll, no_mod, ...)
end

local pseudorandom_probability_ref = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod, ...)
	local mod = trigger_obj and trigger_obj.ability and trigger_obj.ability.cry_prob or 1
	local numerator = base_numerator * mod
	if trigger_obj and trigger_obj.ability and trigger_obj.ability.cry_rigged and not no_mod then
		SMODS.post_prob = SMODS.post_prob or {}
		SMODS.post_prob[#SMODS.post_prob + 1] = {
			pseudorandom_result = true,
			result = true,
			trigger_obj = trigger_obj,
			numerator = base_denominator,
			denominator = base_denominator,
			identifier = identifier or seed,
		}
		return true
	end
	return pseudorandom_probability_ref(trigger_obj, seed, numerator, base_denominator, identifier, no_mod, ...)
end

local is_eternalref = SMODS.is_eternal
function SMODS.is_eternal(card)
	if Cryptid.safe_get(card, "ability", "cry_absolute") then
		return true
	end
	return is_eternalref(card)
end

local unlock_allref = G.FUNCS.unlock_all
G.FUNCS.unlock_all = function(e)
	unlock_allref(e)
	G.PROFILES[G.SETTINGS.profile].cry_none2 = true
	G.PROFILES[G.SETTINGS.profile].cry_none = (Cryptid.enabled("set_cry_poker_hand_stuff") == true)
end

local scie = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition, ...)
	local ret = scie(effect, scored_card, key, amount, from_edition, ...)
	if ret then
		return ret
	end

	if key == "cry_broken_swap" and amount > 0 then
		if effect.card and effect.card ~= scored_card then
			juice_card(effect.card)
		end
		-- only need math.min due to amount being required to be greater than 0
		amount = math.min(amount, 1)

		local chips = SMODS.Scoring_Parameters.chips
		local mult = SMODS.Scoring_Parameters.mult
		local chip_mod = chips.current * amount
		local mult_mod = mult.current * amount

		chips:modify(mult_mod - chip_mod)
		mult:modify(chip_mod - mult_mod)

		if not Cryptid.safe_get(Talisman, "config_file", "disable_anims") then
			G.E_MANAGER:add_event(Event({
				func = function()
					-- scored_card:juice_up()
					local pitch_mod = pseudorandom("cry_broken_sync") * 0.05 + 0.85
					-- wolf fifth as opposed to plasma deck's just-intonated fifth
					-- yes i'm putting music theory nerd stuff in here no you cannot stop me
					play_sound("gong", pitch_mod, 0.3)
					play_sound("gong", pitch_mod * 1.4814814, 0.2)
					play_sound("tarot1", 1.5)
					ease_colour(G.C.UI_CHIPS, mix_colours(G.C.BLUE, G.C.RED, amount))
					ease_colour(G.C.UI_MULT, mix_colours(G.C.RED, G.C.BLUE, amount))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						blockable = false,
						blocking = false,
						delay = 0.8,
						func = function()
							ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
							ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
							return true
						end,
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						blockable = false,
						blocking = false,
						no_delete = true,
						delay = 1.3,
						func = function()
							G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] =
								G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
							G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] =
								G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
							return true
						end,
					}))
					return true
				end,
			}))
			if not effect.remove_default_message then
				if effect.balance_message then
					card_eval_status_text(
						effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus,
						"extra",
						nil,
						percent,
						nil,
						effect.balance_message
					)
				else
					card_eval_status_text(
						effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus,
						"extra",
						nil,
						percent,
						nil,
						{ message = localize("cry_balanced_q"), colour = { 0.8, 0.45, 0.85, 1 } }
					)
				end
			end
			delay(0.6)
		end

		return true
	end
end

SMODS.scoring_parameter_keys[#SMODS.scoring_parameter_keys + 1] = "cry_broken_swap"
