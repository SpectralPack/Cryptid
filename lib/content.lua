-- content.lua - adds SMODS objects for content that should always be loaded

SMODS.Atlas({
	key = "poker_hands",
	path = "hands.png",
	px = 53,
	py = 13,
})

SMODS.PokerHand({
	key = "Bulwark",
	visible = false,
	chips = 100,
	mult = 10,
	l_chips = 50,
	l_mult = 1,
	example = {
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
	},
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	evaluate = function(parts, hand)
		if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true or Cryptid.enabled("c_cry_asteroidbelt") ~= true then
			return {}
		end
		local stones = {}
		for i, card in ipairs(hand) do
			if SMODS.has_no_rank(card) and SMODS.has_no_suit(card) then
				stones[#stones + 1] = card
			end
		end
		return #stones >= 5 and { stones } or {}
	end,
})
SMODS.PokerHandPart({
	key = "cfpart",
	func = function(hand)
		if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true or Cryptid.enabled("c_cry_void") ~= true then
			return {}
		end
		local eligible_cards = {}
		for i, card in ipairs(hand) do
			if not card.config.center.not_fucked then --card.ability.name ~= "Gold Card"
				eligible_cards[#eligible_cards + 1] = card
			end
		end
		if #eligible_cards > 7 then
			return { eligible_cards }
		end
		return {}
	end,
})
SMODS.PokerHand({
	key = "Clusterfuck",
	visible = false,
	chips = 200,
	mult = 19,
	l_chips = 40,
	l_mult = 4,
	example = {
		{ "S_A", true },
		{ "C_K", true },
		{ "H_J", true },
		{ "S_T", true },
		{ "D_9", true },
		{ "D_8", true },
		{ "S_6", true },
		{ "C_5", true },
	},
	atlas = "poker_hands",
	pos = { x = 0, y = 1 },
	evaluate = function(parts, hand)
		local other_hands = next(parts._flush) or next(parts._straight) or next(parts._all_pairs)
		if next(parts.cry_cfpart) then
			if not other_hands then
				return { SMODS.merge_lists(parts.cry_cfpart) }
			end
		end
		return {}
	end,
})
SMODS.PokerHand({
	key = "UltPair",
	visible = false,
	chips = 220,
	mult = 22,
	l_chips = 40,
	l_mult = 4,
	example = {
		{ "S_A", true },
		{ "S_A", true },
		{ "S_T", true },
		{ "S_T", true },
		{ "H_K", true },
		{ "H_K", true },
		{ "H_7", true },
		{ "H_7", true },
	},
	atlas = "poker_hands",
	pos = { x = 0, y = 2 },
	evaluate = function(parts, hand)
		if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true or Cryptid.enabled("c_cry_marsmoons") ~= true then
			return
		end
		local scoring_pairs = {}
		local unique_suits = 0
		for suit, _ in pairs(SMODS.Suits) do
			local scoring_suit_pairs = {}
			for i = 1, #parts._2 do
				if parts._2[i][1]:is_suit(suit) and parts._2[i][2]:is_suit(suit) then
					scoring_suit_pairs[#scoring_suit_pairs + 1] = i
				end
			end
			if #scoring_suit_pairs >= 2 then
				unique_suits = unique_suits + 1
				for i = 1, #scoring_suit_pairs do
					scoring_pairs[scoring_suit_pairs[i]] = (scoring_pairs[scoring_suit_pairs[i]] or 0) + 1
				end
			end
		end
		if unique_suits < 2 then
			return
		end
		local scored_cards = {}
		local sc_max = 0
		local sc_unique = 0
		for i = 1, #parts._2 do
			if scoring_pairs[i] then
				if scoring_pairs[i] > 1 then
					sc_unique = sc_unique + 1
				end
				sc_max = math.max(sc_max, scoring_pairs[i])
				scored_cards[#scored_cards + 1] = parts._2[i][1]
				scored_cards[#scored_cards + 1] = parts._2[i][2]
			end
		end
		if sc_max == #scored_cards / 2 - 1 and sc_unique == 1 then
			return {}
		end
		if #scored_cards >= 8 then
			return { scored_cards }
		end
	end,
})
SMODS.PokerHand({
	key = "WholeDeck",
	visible = false,
	chips = 525252525252525252525252525252,
	mult = 52525252525252525252525252525,
	l_chips = 52525252525252525252525252525,
	l_mult = 5252525252525252525252525252,
	example = {
		{ "S_A", true },
		{ "H_A", true },
		{ "C_A", true },
		{ "D_A", true },
		{ "S_K", true },
		{ "H_K", true },
		{ "C_K", true },
		{ "D_K", true },
		{ "S_Q", true },
		{ "H_Q", true },
		{ "C_Q", true },
		{ "D_Q", true },
		{ "S_J", true },
		{ "H_J", true },
		{ "C_J", true },
		{ "D_J", true },
		{ "S_T", true },
		{ "H_T", true },
		{ "C_T", true },
		{ "D_T", true },
		{ "S_9", true },
		{ "H_9", true },
		{ "C_9", true },
		{ "D_9", true },
		{ "S_8", true },
		{ "H_8", true },
		{ "C_8", true },
		{ "D_8", true },
		{ "S_7", true },
		{ "H_7", true },
		{ "C_7", true },
		{ "D_7", true },
		{ "S_6", true },
		{ "H_6", true },
		{ "C_6", true },
		{ "D_6", true },
		{ "S_5", true },
		{ "H_5", true },
		{ "C_5", true },
		{ "D_5", true },
		{ "S_4", true },
		{ "H_4", true },
		{ "C_4", true },
		{ "D_4", true },
		{ "S_3", true },
		{ "H_3", true },
		{ "C_3", true },
		{ "D_3", true },
		{ "S_2", true },
		{ "H_2", true },
		{ "C_2", true },
		{ "D_2", true },
	},
	evaluate = function(parts, hand)
		if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true or Cryptid.enabled("c_cry_universe") ~= true then
			return
		end
		if #hand >= 52 then
			local deck_booleans = {}
			local scored_cards = {}
			for i = 1, 52 do
				table.insert(deck_booleans, false)
			end

			local suit_table = { "Spades", "Hearts", "Clubs", "Diamonds" }
			local valid_cards = {}

			for _, card in ipairs(hand) do
				if
					not (
						card.config.center_key == "m_stone"
						or (
							card.config.center.no_rank
							and card.config.center.no_suit
							and not card.config.center.not_stoned
						)
					)
				then
					local rank = card:get_id()
					if rank and rank >= 2 and rank <= 14 then
						local matching_suits = {}
						for s_idx, suit_name in ipairs(suit_table) do
							if card:is_suit(suit_name, true) then
								table.insert(matching_suits, s_idx)
							end
						end
						if #matching_suits > 0 then
							table.insert(valid_cards, {
								card = card,
								rank = rank,
								matching_suits = matching_suits,
							})
						end
					end
				end
			end

			table.sort(valid_cards, function(a, b)
				return #a.matching_suits < #b.matching_suits
			end)

			for _, entry in ipairs(valid_cards) do
				local rank = entry.rank
				local card_assigned = false
				for _, s_idx in ipairs(entry.matching_suits) do
					local slot_index = s_idx + ((rank - 2) * 4)
					if not deck_booleans[slot_index] then
						deck_booleans[slot_index] = true
						card_assigned = true
						table.insert(scored_cards, entry.card)
						break
					end
				end
				if not card_assigned then
					table.insert(scored_cards, entry.card)
				end
			end

			local entire_fucking_deck = true
			for i = 1, 52 do
				if deck_booleans[i] == false then
					entire_fucking_deck = false
					break
				end
			end
			if entire_fucking_deck == true then
				return { scored_cards }
			end
		end
		return
	end,
})

SMODS.PokerHand({
	key = "None",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = 5,
	l_mult = 0.5,
	example = {},
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	evaluate = function(parts, hand)
		if Cryptid.enabled("set_cry_poker_hand_stuff") ~= true or Cryptid.enabled("c_cry_nibiru") ~= true then --or Cryptid.enabled("c_cry_asteroidbelt") ~= true then
			return {}
		end
		return { hand and #hand == 0 and G.GAME.hands["cry_None"].visible and {} or nil }
	end,
})

SMODS.PokerHand({
	key = "Declare0",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = 0,
	l_mult = 0,
	example = {},
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	above_hand = "cry_UltPair",
	order_offset = 1000,
	evaluate = function(parts, hand) end,
})
SMODS.PokerHand({
	key = "Declare1",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = 0,
	l_mult = 0,
	example = {},
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	above_hand = "cry_UltPair",
	order_offset = 1001,
	evaluate = function(parts, hand) end,
})
SMODS.PokerHand({
	key = "Declare2",
	visible = false,
	chips = 0,
	mult = 0,
	l_chips = 0,
	l_mult = 0,
	example = {},
	atlas = "poker_hands",
	pos = { x = 0, y = 0 },
	above_hand = "cry_UltPair",
	order_offset = 1002,
	evaluate = function(parts, hand) end,
})

SMODS.Rarity({
	key = "exotic",
	loc_txt = {},
	badge_colour = G.C.CRY_EXOTIC,
})

SMODS.Rarity({
	key = "epic",
	loc_txt = {},
	badge_colour = HEX("ef0098"),
	default_weight = 0.003,
	pools = { ["Joker"] = true },
	get_weight = function(self, weight, object_type)
		-- The game shouldn't try generating Epic Jokers when they are disabled
		if Cryptid.enabled("set_cry_epic") then
			return 0.003
		else
			return 0
		end
	end,
})

SMODS.Rarity({
	key = "candy",
	loc_txt = {},
	badge_colour = HEX("e275e6"),
})

SMODS.Rarity({
	key = "cursed",
	loc_txt = {},
	badge_colour = HEX("474931"),
})

--Add Unique consumable set - used for unique consumables that aren't normally obtained (e.g. Potion)
SMODS.ConsumableType({
	key = "Unique",
	primary_colour = G.C.MONEY,
	secondary_colour = G.C.MONEY,
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_cry_potion",
	can_stack = false,
	can_divide = false,
	no_collection = true,
})
-- Pool used by Food Jokers
SMODS.ObjectType({
	key = "Food",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_egg)
		self:inject_card(G.P_CENTERS.j_ice_cream)
		self:inject_card(G.P_CENTERS.j_cavendish)
		self:inject_card(G.P_CENTERS.j_turtle_bean)
		self:inject_card(G.P_CENTERS.j_diet_cola)
		self:inject_card(G.P_CENTERS.j_popcorn)
		self:inject_card(G.P_CENTERS.j_ramen)
		self:inject_card(G.P_CENTERS.j_selzer)
	end,
})
SMODS.ObjectType({
	object_type = "ObjectType",
	key = "Meme",
	default = "j_mr_bones",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game meme jokers
		self:inject_card(G.P_CENTERS.j_mr_bones)
		self:inject_card(G.P_CENTERS.j_four_fingers) --loss reference
		self:inject_card(G.P_CENTERS.j_obelisk)
		self:inject_card(G.P_CENTERS.j_jolly)
		self:inject_card(G.P_CENTERS.j_space)
	end,
})
SMODS.ObjectType({
	object_type = "ObjectType",
	key = "Tier3",
	default = "v_blank",
	cards = {},
})
SMODS.ObjectType({
	object_type = "ObjectType",
	key = "M",
	default = "j_jolly",
	cards = {},
})
--Stickers and modifiers used by Challenges+Stakes
SMODS.Atlas({
	key = "sticker",
	path = "sticker_cry.png",
	px = 71,
	py = 95,
	inject = function(self)
		local file_path = type(self.path) == "table"
				and (self.path[G.SETTINGS.language] or self.path["default"] or self.path["en-us"])
			or self.path
		if file_path == "DEFAULT" then
			return
		end
		-- language specific sprites override fully defined sprites only if that language is set
		if self.language and not (G.SETTINGS.language == self.language) then
			return
		end
		if not self.language and self.obj_table[("%s_%s"):format(self.key, G.SETTINGS.language)] then
			return
		end
		self.full_path = (self.mod and self.mod.path or SMODS.path)
			.. "assets/"
			.. G.SETTINGS.GRAPHICS.texture_scaling
			.. "x/"
			.. file_path
		local file_data =
			assert(NFS.newFileData(self.full_path), ("Failed to collect file data for Atlas %s"):format(self.key))
		self.image_data = assert(
			love.image.newImageData(file_data),
			("Failed to initialize image data for Atlas %s"):format(self.key)
		)
		self.image =
			love.graphics.newImage(self.image_data, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
		G[self.atlas_table][self.key_noloc or self.key] = self
		G.shared_sticker_banana =
			Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], { x = 5, y = 2 })
		G.shared_sticker_pinned =
			Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], { x = 5, y = 0 })
	end,
})
SMODS.Sound({
	key = "forcetrigger",
	path = "forcetrigger.ogg",
})
SMODS.Sound({
	key = "demitrigger",
	path = "demitrigger.ogg",
})
SMODS.Sound({
	key = "meow1",
	path = "meow1.ogg",
})
SMODS.Sound({
	key = "meow2",
	path = "meow2.ogg",
})
SMODS.Sound({
	key = "meow3",
	path = "meow3.ogg",
})
SMODS.Sound({
	key = "meow4",
	path = "meow4.ogg",
})
SMODS.Sound({
	key = "e_mosaic",
	path = "e_mosaic.ogg",
})
SMODS.Sound({
	key = "e_glitched",
	path = "e_glitched.ogg",
})
SMODS.Sound({
	key = "e_oversaturated",
	path = "e_oversaturated.ogg",
})
SMODS.Sound({
	key = "e_blur",
	path = "e_blur.ogg",
})
SMODS.Sound({
	key = "e_double_sided",
	path = "e_double_sided.ogg",
})
SMODS.Sound({
	key = "e_jolly",
	path = "e_jolly.ogg",
})
SMODS.Sound({
	key = "e_noisy",
	path = "e_noisy.ogg",
})
SMODS.Sound({
	key = "e_fragile",
	path = "e_fragile.ogg",
})
SMODS.Sound({
	key = "e_golden",
	path = "e_golden.ogg",
})
SMODS.Sound({
	key = "studiofromhelsinki",
	path = "studiofromhelsinki.ogg",
})
SMODS.Sound({
	key = "whapoosh",
	path = "whapoosh.ogg",
})
SMODS.Sound({
	key = "music_jimball",
	path = "music_jimball.ogg",
	sync = false,
	pitch = 1,
	select_music_track = function()
		return next(SMODS.find_card("j_cry_jimball"))
			and Cryptid_config.Cryptid
			and Cryptid_config.Cryptid.jimball_music
			-- Lowering priority for edition Jimballs later
			and 200
	end,
})
SMODS.Sound({
	key = "music_code",
	path = "music_code.ogg",
	select_music_track = function()
		return (
			Cryptid_config.Cryptid
			and Cryptid_config.Cryptid.code_music
			and (
								-- in a code pack
(
					G.booster_pack
					and not G.booster_pack.REMOVED
					and SMODS.OPENED_BOOSTER
					and SMODS.OPENED_BOOSTER.config.center.kind == "Code"
				)
				-- using a code card
				or (G.GAME and G.GAME.USING_CODE)
			)
		) and 100
	end,
})
SMODS.Sound({
	key = "music_big",
	path = "music_big.ogg",
	select_music_track = function()
		if G.GAME.cry_music_big then
			return G.GAME.cry_music_big
		elseif
			Cryptid_config.Cryptid
			and Cryptid_config.Cryptid.big_music
			and to_big(G.GAME.round_scores["hand"].amt) > to_big(10) ^ 1000000
		then
			G.GAME.cry_music_big = 6
			return 100.001
		end
	end,
})
SMODS.Sound({
	key = "music_exotic",
	path = "music_exotic.ogg",
	volume = 0.4,
	select_music_track = function()
		return (
			Cryptid_config.Cryptid
			and Cryptid_config.Cryptid.exotic_music
			and #Cryptid.advanced_find_joker(nil, "cry_exotic", nil, nil, true) ~= 0
		) and 100.002
	end,
})
SMODS.Sound({
	key = "music_mainline",
	path = "music_mainline.ogg",
	volume = 0.7,
	sync = {
		cry_music_modest = true,
		cry_music_madness = true,
	},
	pitch = 1,
	select_music_track = function()
		return G.STAGE == G.STAGES.MAIN_MENU
			and (G.PROFILES[G.SETTINGS.profile].cry_gameset and G.PROFILES[G.SETTINGS.profile].cry_gameset == "mainline" or G.selectedGameset and G.selectedGameset ~= "modest" and G.selectedGameset ~= "madness")
			and Cryptid_config.Cryptid.alt_bg_music
	end,
})
SMODS.Sound({
	key = "music_madness",
	path = "music_madness.ogg",
	volume = 0.7,
	sync = {
		cry_music_modest = true,
		cry_music_mainline = true,
	},
	pitch = 1,
	select_music_track = function()
		return G.STAGE == G.STAGES.MAIN_MENU
			and (G.PROFILES[G.SETTINGS.profile].cry_gameset and G.PROFILES[G.SETTINGS.profile].cry_gameset == "madness" or G.selectedGameset == "madness")
			and Cryptid_config.Cryptid.alt_bg_music
	end,
})
SMODS.Sound({
	key = "music_modest",
	path = "music_modest.ogg",
	volume = 0.7,
	sync = {
		cry_music_mainline = true,
		cry_music_madness = true,
	},
	pitch = 1,
	select_music_track = function()
		return G.STAGE == G.STAGES.MAIN_MENU
			and (G.PROFILES[G.SETTINGS.profile].cry_gameset and G.PROFILES[G.SETTINGS.profile].cry_gameset == "modest" or G.selectedGameset == "modest")
			and Cryptid_config.Cryptid.alt_bg_music
	end,
})
SMODS.Atlas({
	key = "modicon",
	path = "cry_icon.png",
	px = 32,
	py = 32,
})
SMODS.Atlas({
	key = "gameset",
	path = "cry_gameset.png",
	px = 29,
	py = 29,
})
SMODS.Atlas({
	key = "placeholders",
	path = "placeholders.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasepic",
	path = "atlasepic.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasone",
	path = "atlasone.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlastwo",
	path = "atlastwo.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasthree",
	path = "atlasthree.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasspooky",
	path = "atlasspooky.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasexotic",
	path = "atlasexotic.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasnotjokers", --this is easier to spell then consumables
	path = "atlasnotjokers.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "tag_cry",
	path = "tag_cry.png",
	px = 34,
	py = 34,
})

-- shiny tags
SMODS.Atlas({
	key = "shinyv",
	path = "shinyv.png",
	px = 34,
	py = 34,
})
SMODS.Atlas({
	key = "shinyc",
	path = "shinyc.png",
	px = 34,
	py = 34,
})

SMODS.Atlas({
	key = "atlasdeck",
	path = "atlasdeck.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "glowing",
	path = "b_cry_glowing.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "effarcire",
	path = "goofy.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "pack",
	path = "pack_cry.png",
	px = 71,
	py = 95,
})
SMODS.UndiscoveredSprite({
	key = "Code",
	atlas = "atlasnotjokers",
	path = "atlasnotjokers.png",
	pos = { x = 12, y = 6 },
	px = 71,
	py = 95,
})
SMODS.UndiscoveredSprite({
	key = "Unique",
	atlas = "atlasnotjokers",
	path = "atlasnotjokers.png",
	pos = { x = 9, y = 5 },
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "blinds",
	atlas_table = "ANIMATION_ATLAS",
	path = "bl_cry.png",
	px = 34,
	py = 34,
	frames = 21,
})
--splitting these up because like more than 20 on one atlas is a crime
SMODS.Atlas({
	key = "blinds_two",
	atlas_table = "ANIMATION_ATLAS",
	path = "bl_cry_two.png",
	px = 34,
	py = 34,
	frames = 21,
})
SMODS.Atlas({
	key = "nostalgia",
	atlas_table = "ANIMATION_ATLAS",
	path = "bl_nostalgia.png",
	px = 34,
	py = 34,
	frames = 21,
})
--Enchancements, seals, other misc things etc
SMODS.Atlas({
	key = "cry_misc",
	path = "cry_misc.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	key = "atlasSleeves",
	path = "atlasSleeves.png",
	px = 73,
	py = 95,
})
SMODS.Atlas({
	key = "glowingSleeve",
	path = "sleeve_cry_glowing.png",
	px = 73,
	py = 95,
})

-- There's probably a better way to fix observatory on these than this
for k, v in pairs({
	"mercury",
	"venus",
	"earth",
	"mars",
	"jupiter",
	"saturn",
	"uranus",
	"neptune",
	"pluto",
	"planet_x",
	"ceres",
	"eris",
}) do
	SMODS.Consumable:take_ownership(v, {
		calculate = function(self, card, context)
			if context.cry_observatory and context.scoring_name == card.ability.consumeable.hand_type then
				local value = context.cry_observatory.ability.extra
				if Overflow then
					value = value ^ to_big(card:getQty())
				end
				return { xmult = value }
			end
		end,
	}, true)
end

if not SMODS.RunSelectPage then
	return
end

local function stick(card)
	card.children.back.states.hover = card.states.hover
	card.children.back.states.click = card.states.click
	card.children.back.states.drag = card.states.drag
	card.children.back.states.collide.can = false
	card.children.back:set_role({ major = card, role_type = "Glued", draw_major = card })
end

function Cryptid.antimatter_compat(key, on_load)
	local back = G.P_CENTERS[key]
	if
		not back
		or back.set ~= "Back"
		or (SMODS.Centers[key] and Cryptid.enabled(key) ~= true)
		or not (Cryptid.gameset(G.P_CENTERS.b_cry_antimatter or "b_cry_antimatter") == "madness" or ((Cryptid.safe_get(
			G.PROFILES,
			G.SETTINGS.profile,
			"deck_usage",
			key,
			"wins",
			8
		) or 0) ~= 0) or on_load)
		or not (back.unlocked or on_load)
	then
		return false
	end
	if back.no_antimatter then --mostly for purely detrimental/explicitly incompatible decks
		return false
	end
	return true
end

function Cryptid.antimatter_sleeve_compat(sleeve_key)
	if not sleeve_key then
		return false
	end
	local full_key = sleeve_key
	if not full_key:find("^sleeve_") then
		full_key = "sleeve_" .. full_key
	end
	if full_key == "sleeve_cry_antimatter_sleeve" or full_key == "sleeve_casl_none" or full_key == "sleeve_none" then
		return false
	end
	if Cryptid.gameset(G.P_CENTERS.sleeve_cry_antimatter_sleeve or "sleeve_cry_antimatter_sleeve") == "madness" then
		return true
	end
	return (
		Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "sleeve_usage", full_key, "wins_by_key", "stake_gold")
		or Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "sleeve_usage", sleeve_key, "wins_by_key", "stake_gold")
		or 0
	) > 0
end

--Edition Deck Selection
SMODS.RunSelectPage({
	key = "edeck_ed",
	automatic_preview = true,
	page = 2,
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(G.P_CENTER_POOLS.Edition) do
			if not c.no_edeck and c.key ~= "e_base" then
				pool[#pool + 1] = c
			end
		end
		pool[#pool + 1] = { key = "random" }
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_e_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_e_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed
		if Cryptid.safe_get(G.P_CENTERS, curr, "set") ~= "Edition" and curr ~= "random" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed = "e_foil"
		end
		if curr == "random" then
			return localize("run_select_cry_edeck_ed_random")
		end
		return localize({
			type = "name_text",
			set = "Edition",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed,
		})
	end,
	set_default = function(self, choice)
		return (Cryptid.safe_get(G.P_CENTERS, choice, "set") == "Edition" or choice == "random") and choice or "e_foil"
	end,
	selected_text = function(self, selection)
		if selection == "random" then
			return localize("run_select_cry_edeck_ed_random")
		end
		return localize({ type = "name_text", set = "Edition", key = selection })
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.edition
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.e_foil)
		card.cry_edeck_choice = card_key
		if Cryptid.safe_get(G.P_CENTERS, card_key, "set") == "Edition" then
			card:set_edition(card_key, true, true)
		end
		if card_key == "random" then
			card.generate_UIBox_ability_table = function(self2, vars_only)
				if vars_only then
					return
				end
				return generate_card_ui({ set = "Other", key = "random_edition" }, nil, nil, "Other", {})
			end
		end
		if sprites[card_key] then
			card.children.center.atlas = G.ASSET_ATLAS[sprites[card_key].atlas]
			card.children.center:set_sprite_pos(sprites[card_key].pos)
		end
		stick(card)
		return card
	end,
	optional = function(self)
		local back = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "deck_choice")
		local antimatter = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_antimatter") or {}
		if back == "b_cry_e_deck" or (back == "b_cry_antimatter" and antimatter.b_cry_e_deck) then
			return true
		end
		return false
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or "e_foil"
		local val = choice.cry_edeck_choice
		if not val then
			return
		end
		if not remove then
			SMODS.RunSelect.Setup.choices[self.key] = val
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, val, self.silent)
			end
		else
			SMODS.RunSelect.Setup.choices[self.key] = nil
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, choice, self.silent, true)
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_edition = choice
	end,
	choose_random = function(self)
		local options = {}
		for _, v in ipairs(self.pool) do
			if v.key ~= SMODS.RunSelect.Setup.choices[self.key] then
				options[#options + 1] = v
			end
		end
		local edition = pseudorandom_element(options, pseudoseed(os.time()))
		self:handle_choice({ cry_edeck_choice = edition.key })
	end,
})

--Enhancement Deck selection
SMODS.RunSelectPage({
	key = "edeck_enh",
	automatic_preview = true,
	page = 2,
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(G.P_CENTER_POOLS.Enhanced) do
			if not c.no_edeck then
				pool[#pool + 1] = c
			end
		end
		pool[#pool + 1] = { key = "random" }
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_et_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_et_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh
		if Cryptid.safe_get(G.P_CENTERS, curr, "set") ~= "Enhanced" and curr ~= "random" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh = "m_bonus"
		end
		if curr == "random" then
			return localize("run_select_cry_edeck_enh_random")
		end
		return localize({
			type = "name_text",
			set = "Enhanced",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh,
		})
	end,
	set_default = function(self, choice)
		return (Cryptid.safe_get(G.P_CENTERS, choice, "set") == "Enhanced" or choice == "random") and choice
			or "m_bonus"
	end,
	selected_text = function(self, selection)
		if selection == "random" then
			return localize("run_select_cry_edeck_enh_random")
		end
		return localize({ type = "name_text", set = "Enhanced", key = selection })
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.enhancement
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.c_base)
		card.cry_edeck_choice = card_key
		if card_key == "random" then
			card.children.center.atlas = G.ASSET_ATLAS[sprites.default.atlas]
			card.children.center:set_sprite_pos(sprites.default.pos)
			card.generate_UIBox_ability_table = function(self2, vars_only)
				if vars_only then
					return
				end
				return generate_card_ui({ set = "Other", key = "random_enhancement" }, nil, nil, "Other", {})
			end
		end
		if sprites[card_key] then
			card.children.center.atlas = G.ASSET_ATLAS[sprites[card_key].atlas]
			card.children.center:set_sprite_pos(sprites[card_key].pos)
		end
		stick(card)
		return card
	end,
	optional = function(self)
		local back = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "deck_choice")
		local antimatter = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_antimatter") or {}
		if back == "b_cry_et_deck" or (back == "b_cry_antimatter" and antimatter.b_cry_et_deck) then
			return true
		end
		return false
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or "m_bonus"
		local val = choice.cry_edeck_choice
		if not remove then
			SMODS.RunSelect.Setup.choices[self.key] = val
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, val, self.silent)
			end
		else
			SMODS.RunSelect.Setup.choices[self.key] = nil
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, choice, self.silent, true)
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_enhancement = choice
	end,
	choose_random = function(self)
		local options = {}
		for _, v in ipairs(self.pool) do
			if v.key ~= SMODS.RunSelect.Setup.choices[self.key] then
				options[#options + 1] = v
			end
		end
		local edition = pseudorandom_element(options, pseudoseed(os.time()))
		self:handle_choice({ cry_edeck_choice = edition.key })
	end,
})

-- Sticker Deck selection
SMODS.RunSelectPage({
	key = "edeck_sk",
	automatic_preview = true,
	page = 2,
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(SMODS.Sticker.obj_buffer) do
			if not SMODS.Stickers[c].no_edeck then
				pool[#pool + 1] = SMODS.Stickers[c]
			end
		end
		pool[#pool + 1] = { key = "random" }
		pool[#pool + 1] = { key = "all" }
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_sk_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_sk_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk
		if not SMODS.Stickers[curr] and curr ~= "all" and curr ~= "random" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk = "eternal"
		end
		if curr == "all" then
			return localize("run_select_cry_edeck_sk_all")
		elseif curr == "random" then
			return localize("run_select_cry_edeck_sk_random")
		end
		return localize({
			type = "name_text",
			set = "Other",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk,
		})
	end,
	set_default = function(self, choice)
		return (SMODS.Stickers[choice] or choice == "all" or choice == "random") and choice or "eternal"
	end,
	selected_text = function(self, selection)
		if selection == "all" then
			return localize("run_select_cry_edeck_sk_all")
		elseif selection == "random" then
			return localize("run_select_cry_edeck_sk_random")
		end
		return localize({
			type = "name_text",
			set = "Other",
			key = selection,
		})
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.sticker
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.c_base)
		if SMODS.Stickers[card_key] then
			card:add_sticker(card_key, true)
		end
		if card_key == "random" then
			card.generate_UIBox_ability_table = function(self2, vars_only)
				if vars_only then
					return
				end
				return generate_card_ui({ set = "Other", key = "random_sticker" }, nil, nil, "Other", {})
			end
			card.children.center.atlas = G.ASSET_ATLAS[sprites.default.atlas]
			card.children.center:set_sprite_pos(sprites.default.pos)
		elseif card_key == "all" then
			card.generate_UIBox_ability_table = function(self2, vars_only)
				if vars_only then
					return
				end
				return generate_card_ui({ set = "Other", key = "all_stickers" }, nil, nil, "Other", {})
			end
			for _, sticker in pairs(SMODS.Stickers) do
				if not sticker.no_edeck then
					card:add_sticker(sticker.key, true)
				end
			end
		end
		card.cry_edeck_choice = card_key
		if sprites[card_key] then
			card.children.center.atlas = G.ASSET_ATLAS[sprites[card_key].atlas]
			card.children.center:set_sprite_pos(sprites[card_key].pos)
		end
		stick(card)
		return card
	end,
	optional = function(self)
		local back = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "deck_choice")
		local antimatter = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_antimatter") or {}
		if back == "b_cry_sk_deck" or (back == "b_cry_antimatter" and antimatter.b_cry_sk_deck) then
			return true
		end
		return false
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or "eternal"
		local val = choice.cry_edeck_choice
		if not remove then
			SMODS.RunSelect.Setup.choices[self.key] = val
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, val, self.silent)
			end
		else
			SMODS.RunSelect.Setup.choices[self.key] = nil
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, choice, self.silent, true)
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_sticker = choice
	end,
	choose_random = function(self)
		local options = {}
		for _, v in ipairs(self.pool) do
			if v.key ~= SMODS.RunSelect.Setup.choices[self.key] then
				options[#options + 1] = v
			end
		end
		local sticker = pseudorandom_element(options, pseudoseed(os.time()))
		self:handle_choice({ cry_edeck_choice = sticker.key })
	end,
})

-- Suit Deck selection
-- You dont get random suit, just play erratic deck lil vro
SMODS.RunSelectPage({
	key = "edeck_st",
	automatic_preview = true,
	page = 2,
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(SMODS.Suit.obj_buffer) do
			if not SMODS.Suits[c].no_edeck then
				pool[#pool + 1] = SMODS.Suits[c]
			end
		end
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_st_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_st_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_st
		if not SMODS.Suits[curr] then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_st = "Spades"
		end
		return localize(G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_st, "suits_plural")
	end,
	set_default = function(self, choice)
		return SMODS.Suits[choice] and choice or "Spades"
	end,
	selected_text = function(self, selection)
		return localize(selection, "suits_plural")
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.suit
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.c_base)
		card.no_ui = true
		card.ability._cry_suit_choice = card_key
		if sprites[card_key] then
			card.children.center.atlas = G.ASSET_ATLAS[sprites[card_key].atlas]
			card.children.center:set_sprite_pos(sprites[card_key].pos)
		else
			assert(SMODS.change_base(card, card_key, "Ace"))
		end
		stick(card)
		return card
	end,
	optional = function(self)
		local back = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "deck_choice")
		local antimatter = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_antimatter") or {}
		if back == "b_cry_st_deck" or (back == "b_cry_antimatter" and antimatter.b_cry_st_deck) then
			return true
		end
		return false
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or "Spades"
		local val = choice.ability._cry_suit_choice
		if not remove then
			SMODS.RunSelect.Setup.choices[self.key] = val
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, val, self.silent)
			end
		else
			SMODS.RunSelect.Setup.choices[self.key] = nil
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, choice, self.silent, true)
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_suit = choice
	end,
	choose_random = function(self)
		local options = {}
		for _, v in ipairs(self.pool) do
			if v.key ~= SMODS.RunSelect.Setup.choices[self.key] then
				options[#options + 1] = v
			end
		end
		local suit = pseudorandom_element(options, pseudoseed(os.time()))
		self:handle_choice({ ability = { _cry_suit_choice = suit.key } })
	end,
})

-- Seal Deck selection
SMODS.RunSelectPage({
	key = "edeck_sl",
	automatic_preview = true,
	page = 2,
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(SMODS.Seal.obj_buffer) do
			if not G.P_SEALS[c].no_edeck then
				pool[#pool + 1] = G.P_SEALS[c]
			end
		end
		pool[#pool + 1] = { key = "random" }
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_sl_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_sl_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl
		if not G.P_SEALS[curr] and curr ~= "random" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl = "Gold"
		end
		if G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl == "random" then
			return localize("run_select_cry_edeck_sl_random")
		end
		return localize({
			type = "name_text",
			set = "Other",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl:lower() .. "_seal",
		})
	end,
	set_default = function(self, choice)
		return (choice == "random" or G.P_SEALS[choice]) and choice or "Gold"
	end,
	selected_text = function(self, selection)
		return localize({
			type = "name_text",
			set = "Other",
			key = selection:lower() .. "_seal",
		})
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.seal
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.c_base)
		card.cry_edeck_choice = card_key
		if G.P_SEALS[card_key] then
			card:set_seal(card_key, true, true)
		end
		if card_key == "random" then
			card.generate_UIBox_ability_table = function(self2, vars_only)
				if vars_only then
					return
				end
				return generate_card_ui({ set = "Other", key = "random_seal" }, nil, nil, "Other", {})
			end
			card.children.center.atlas = G.ASSET_ATLAS[sprites.default.atlas]
			card.children.center:set_sprite_pos(sprites.default.pos)
		end
		if sprites[card_key] then
			card.children.center.atlas = G.ASSET_ATLAS[sprites[card_key].atlas]
			card.children.center:set_sprite_pos(sprites[card_key].pos)
		end
		stick(card)
		return card
	end,
	optional = function(self)
		local back = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "deck_choice")
		local antimatter = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_antimatter") or {}
		if back == "b_cry_sl_deck" or (back == "b_cry_antimatter" and antimatter.b_cry_sl_deck) then
			return true
		end
		return false
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or "Gold"
		local val = choice.cry_edeck_choice
		if not remove then
			SMODS.RunSelect.Setup.choices[self.key] = val
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, val, self.silent)
			end
		else
			SMODS.RunSelect.Setup.choices[self.key] = nil
			if SMODS.RunSelect.Internals.preview_area then
				SMODS.RunSelect.Functions.populate_preview_ui(self.key, choice, self.silent, true)
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_seal = choice
	end,
	choose_random = function(self)
		local options = {}
		for _, v in ipairs(self.pool) do
			if v.key ~= SMODS.RunSelect.Setup.choices[self.key] then
				options[#options + 1] = v
			end
		end
		local seal = pseudorandom_element(options, pseudoseed(os.time()))
		self:handle_choice({ cry_edeck_choice = seal.key })
	end,
})

--Antimatter Deck selection
SMODS.RunSelectPage({
	key = "antimatter",
	include_deck_preview = true,
	random_select = true,
	page = 2,
	area_type = "deck",
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(G.P_CENTER_POOLS.Back) do
			if c.key ~= "b_cry_antimatter" and Cryptid.antimatter_compat(c.key, true) then
				pool[#pool + 1] = c
			end
		end
		return pool
	end,
	set_default = function(self, choice)
		local selected = {}
		if choice then
			for k in pairs(choice) do
				if Cryptid.antimatter_compat(k) and choice[k] then
					selected[k] = true
				end
			end
		else
			for _, c in ipairs(G.P_CENTER_POOLS.Back) do
				if Cryptid.antimatter_compat(c.key) then
					selected[c.key] = true
				end
			end
		end
		return selected
	end,
	quick_start_text = function()
		if G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice == "b_cry_antimatter" then
			local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter
			local deck_total = 0
			for k in pairs(curr or {}) do
				if Cryptid.antimatter_compat(k) and curr[k] then
					deck_total = deck_total + 1
				end
			end
			return localize({ type = "variable", key = "antimatter_quickstart", vars = { deck_total } })
		end
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.b_red)
		local unlocked = Cryptid.antimatter_compat(card_key)
		card.cry_antimatter_card = true
		card.cry_antimatter_locked = not unlocked
		card.sprite_facing = "back"
		card.facing = "back"
		card.children.back:remove()
		card.children.back = SMODS.create_sprite(
			card.T.x,
			card.T.y,
			card.T.w,
			card.T.h,
			G.ASSET_ATLAS[unlocked and card.config.center.atlas or "centers"],
			unlocked and card.config.center.pos or { x = 4, y = 0 }
		)
		stick(card)
		return card
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		local choices = SMODS.RunSelect.Setup.choices[self.key]
		if Cryptid.antimatter_compat(choice.config.center.key) then
			choices[choice.config.center.key] = not choices[choice.config.center.key]
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_antimatter_decks = SMODS.shallow_copy(choice)
	end,
	optional = function(self)
		return SMODS.RunSelect.Setup.choices.deck_choice == "b_cry_antimatter"
	end,
	choose_random = function(self)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		local choices = SMODS.RunSelect.Setup.choices[self.key]
		for _, back in ipairs(self.pool) do
			if Cryptid.antimatter_compat(back.key) then
				choices[back.key] = math.random() > 0.5
			end
		end
	end,
})

--Antimatter Sleeve selection
SMODS.RunSelectPage({
	key = "cry_antimatter_sleeve",
	include_deck_preview = true,
	area_type = "deck",
	stack_size = 11,
	preview_size = 11,
	inject = function(self)
		local sleeve_idx = nil
		if SMODS.RunSelect and SMODS.RunSelect.Internals and SMODS.RunSelect.Internals.pages then
			for idx, p_key in ipairs(SMODS.RunSelect.Internals.pages) do
				if p_key == "casl_sleeve_choice" or p_key == "sleeve_choice" then
					sleeve_idx = idx
					break
				end
			end
		end
		if sleeve_idx then
			self.page = sleeve_idx + 1
		else
			self.page = #SMODS.RunSelect.Internals.pages + 1
		end
		SMODS.RunSelectPage.inject(self)
	end,
	card_hover = function(self, card)
		local page = SMODS.RunSelect
			and SMODS.RunSelect.Pages
			and (SMODS.RunSelect.Pages.casl_sleeve_choice or SMODS.RunSelect.Pages.sleeve_choice)
		if page and page.card_hover then
			return page:card_hover(card)
		end
	end,
	generate_pool = function(self)
		local pool = {}
		if G.P_CENTER_POOLS.Sleeve then
			for _, c in ipairs(G.P_CENTER_POOLS.Sleeve) do
				if c.key ~= "sleeve_cry_antimatter_sleeve" and Cryptid.antimatter_sleeve_compat(c.key) then
					pool[#pool + 1] = c
				end
			end
		end
		return pool
	end,
	set_default = function(self, choice)
		local selected = {}
		if choice and type(choice) == "table" then
			for k, v in pairs(choice) do
				if Cryptid.antimatter_sleeve_compat(k) then
					selected[k] = (v == true)
				end
			end
		else
			if G.P_CENTER_POOLS.Sleeve then
				for _, c in ipairs(G.P_CENTER_POOLS.Sleeve) do
					if Cryptid.antimatter_sleeve_compat(c.key) then
						selected[c.key] = true
					end
				end
			end
		end
		return selected
	end,
	quick_start_text = function()
		local slv = G.PROFILES[G.SETTINGS.profile].last_choices.casl_sleeve_choice
			or G.PROFILES[G.SETTINGS.profile].last_choices.sleeve_choice
		if slv == "sleeve_cry_antimatter_sleeve" then
			local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter_sleeve
			local sleeve_total = 0
			for k in pairs(curr or {}) do
				if Cryptid.antimatter_sleeve_compat(k) then
					sleeve_total = sleeve_total + 1
				else
					curr[k] = nil
				end
			end
		end
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local page = SMODS.RunSelect
			and SMODS.RunSelect.Pages
			and (SMODS.RunSelect.Pages.casl_sleeve_choice or SMODS.RunSelect.Pages.sleeve_choice)
		if page and page.create_selection_card then
			local card = page:create_selection_card(card_key, card_number, area)
			card.cry_antimatter_sleeve_card = true
			if not Cryptid.antimatter_sleeve_compat(card_key) then
				card.cry_antimatter_sleeve_locked = true
			end
			return card
		end
	end,
	handle_choice = function(self, choice, remove)
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		local choices = SMODS.RunSelect.Setup.choices[self.key]
		local s_key = choice.config.center.key
		if Cryptid.antimatter_sleeve_compat(s_key) then
			choices[s_key] = not choices[s_key]
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_antimatter_sleeves = SMODS.shallow_copy(choice or {})
	end,
	optional = function(self)
		local s_choice = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "casl_sleeve_choice")
			or Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "sleeve_choice")
			or (G.GAME and G.GAME.selected_sleeve)
			or Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "last_choices", "casl_sleeve_choice")
		return s_choice == "sleeve_cry_antimatter_sleeve" or s_choice == "cry_antimatter_sleeve"
	end,
})

local create_page_ref = SMODS.RunSelect.Functions.create_page
function SMODS.RunSelect.Functions.create_page(key)
	local page_def = SMODS.RunSelect.Pages[key]
	if page_def and page_def.get_pool then
		page_def.pool = page_def:get_pool()
	end
	return create_page_ref(key)
end
