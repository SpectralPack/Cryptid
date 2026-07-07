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
			if
				card.config.center_key == "m_stone"
				or (card.config.center.no_rank and card.config.center.no_suit and not card.config.center.not_stoned)
			then
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
				table.insert(deck_booleans, false) -- i could write this out but nobody wants to see that
			end
			local wilds = {}
			for i, card in ipairs(hand) do
				if
					(card.config.center_key ~= "m_wild" and not card.config.center.any_suit)
					and (card.config.center_key ~= "m_stone" and not card.config.center.no_rank)
				then -- i don't know if these are different... this could be completely redundant but redundant is better than broken
					local rank = card:get_id()
					local suit = card.base.suit
					local suit_int = 0
					suit_table = { "Spades", "Hearts", "Clubs", "Diamonds" }
					for i = 1, 4 do
						if suit == suit_table[i] then
							suit_int = i
						end
					end
					if suit_int > 0 then -- check for custom rank here to prevent breakage?
						deck_booleans[suit_int + ((rank - 2) * 4)] = true
						table.insert(scored_cards, card)
					end
				elseif card.config.center_key == "m_wild" or card.config.center.any_suit then
					table.insert(wilds, card)
				end
			end
			for i, card in ipairs(wilds) do -- this 100% breaks with custom ranks
				local rank = card:get_id()
				for i = 1, 4 do
					if not deck_booleans[i + ((rank - 2) * 4)] then
						deck_booleans[i + ((rank - 2) * 4)] = true
						break
					end
				end
				table.insert(scored_cards, card)
			end
			local entire_fucking_deck = true
			for i = 1, #deck_booleans do
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
		or not (Cryptid.gameset(G.P_CENTERS.b_cry_antimatter) == "madness" or (Cryptid.safe_get(
			G.PROFILES,
			G.SETTINGS.profile,
			"deck_usage",
			back,
			"wins",
			8
		) or 0 ~= 0) or on_load)
		or not (back.unlocked or on_load)
	then
		return false
	end
	if
		back.cry_antimatter_apply
		or back.cry_antimatter_calculate
		or back.cry_antimatter_consumables
		or back.cry_antimatter_vouchers
		or back.cry_antimatter_compat --this is so you can mark a deck as antimatter compat even if it doesnt use the above functions for that
		or not back.original_mod
	then
		return true
	end
	return false
end

--Edition Deck Selection
SMODS.RunSelectPage({
	key = "edeck_ed",
	include_deck_preview = true,
	page = 2,
	area_type = "deck",
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(G.P_CENTER_POOLS.Edition) do
			if not c.no_edeck and c.key ~= "e_base" then
				pool[#pool + 1] = c
			end
		end
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_e_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_e_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed
		if Cryptid.safe_get(G.P_CENTERS, curr, "set") ~= "Edition" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed = "e_foil"
		end
		return localize({
			type = "name_text",
			set = "Edition",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_ed,
		})
	end,
	set_default = function(self, choice)
		return Cryptid.safe_get(G.P_CENTERS, choice, "set") == "Edition" and choice or "e_foil"
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.edition
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.e_foil)
		card:set_edition(card_key, true, true)
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
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		if not remove then
			if self.selection_limit > 1 then
				if
					SMODS.table_size(SMODS.RunSelect.Setup.choices[self.key]) < self.selection_limit
					and not SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key]
				then
					SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key] = true
				else
					if choice.juice_up then
						choice:juice_up()
					end
					return
				end
			else
				SMODS.RunSelect.Setup.choices[self.key] = choice.config.center.key
			end
		else
			if self.selection_limit == 1 then
				SMODS.RunSelect.Setup.choices[self.key] = nil
			else
				SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key] = nil
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_edition = choice
	end,
})

--Enhancement Deck selection
SMODS.RunSelectPage({
	key = "edeck_enh",
	include_deck_preview = true,
	page = 2,
	area_type = "deck",
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(G.P_CENTER_POOLS.Enhanced) do
			if not c.no_edeck then
				pool[#pool + 1] = c
			end
		end
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_et_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_et_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh
		if Cryptid.safe_get(G.P_CENTERS, curr, "set") ~= "Enhanced" then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh = "m_bonus"
		end
		return localize({
			type = "name_text",
			set = "Enhanced",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_enh,
		})
	end,
	set_default = function(self, choice)
		return Cryptid.safe_get(G.P_CENTERS, choice, "set") == "Enhanced" and choice or "m_bonus"
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.enhancement
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.m_bonus)
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
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		if not remove then
			if self.selection_limit > 1 then
				if
					SMODS.table_size(SMODS.RunSelect.Setup.choices[self.key]) < self.selection_limit
					and not SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key]
				then
					SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key] = true
				else
					if choice.juice_up then
						choice:juice_up()
					end
					return
				end
			else
				SMODS.RunSelect.Setup.choices[self.key] = choice.config.center.key
			end
		else
			if self.selection_limit == 1 then
				SMODS.RunSelect.Setup.choices[self.key] = nil
			else
				SMODS.RunSelect.Setup.choices[self.key][choice.config.center.key] = nil
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_enhancement = choice
	end,
})

-- Sticker Deck selection
SMODS.RunSelectPage({
	key = "edeck_sk",
	include_deck_preview = true,
	page = 2,
	area_type = "deck",
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(SMODS.Sticker.obj_buffer) do
			if not SMODS.Stickers[c].no_edeck then
				pool[#pool + 1] = SMODS.Stickers[c]
			end
		end
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_sk_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_sk_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk
		if not SMODS.Stickers[curr] then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk = "eternal"
		end
		return localize({
			type = "name_text",
			set = "Other",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sk,
		})
	end,
	set_default = function(self, choice)
		return SMODS.Stickers[choice] and choice or "eternal"
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.sticker
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.c_base)
		card:add_sticker(card_key, true)
		card.ability._cry_sticker_choice = card_key
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
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		if not remove then
			if self.selection_limit > 1 then
				if
					SMODS.table_size(SMODS.RunSelect.Setup.choices[self.key]) < self.selection_limit
					and not SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_sticker_choice]
				then
					SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_sticker_choice] = true
				else
					if choice.juice_up then
						choice:juice_up()
					end
					return
				end
			else
				SMODS.RunSelect.Setup.choices[self.key] = choice.ability._cry_sticker_choice
			end
		else
			if self.selection_limit == 1 then
				SMODS.RunSelect.Setup.choices[self.key] = nil
			else
				SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_sticker_choice] = nil
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_sticker = choice
	end,
})

-- Suit Deck selection
SMODS.RunSelectPage({
	key = "edeck_st",
	include_deck_preview = true,
	page = 2,
	area_type = "deck",
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
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		if not remove then
			if self.selection_limit > 1 then
				if
					SMODS.table_size(SMODS.RunSelect.Setup.choices[self.key]) < self.selection_limit
					and not SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_suit_choice]
				then
					SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_suit_choice] = true
				else
					if choice.juice_up then
						choice:juice_up()
					end
					return
				end
			else
				SMODS.RunSelect.Setup.choices[self.key] = choice.ability._cry_suit_choice
			end
		else
			if self.selection_limit == 1 then
				SMODS.RunSelect.Setup.choices[self.key] = nil
			else
				SMODS.RunSelect.Setup.choices[self.key][choice.ability._cry_suit_choice] = nil
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_suit = choice
	end,
})

-- Seal Deck selection
SMODS.RunSelectPage({
	key = "edeck_sl",
	include_deck_preview = true,
	page = 2,
	area_type = "deck",
	random_select = true,
	generate_pool = function(self)
		local pool = {}
		for _, c in ipairs(SMODS.Seal.obj_buffer) do
			if not G.P_SEALS[c].no_edeck then
				pool[#pool + 1] = G.P_SEALS[c]
			end
		end
		return pool
	end,
	quick_start_text = function()
		local back = G.PROFILES[G.SETTINGS.profile].last_choices.deck_choice
		local antimatter = G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter or {}
		if back ~= "b_cry_sl_deck" and not (back == "b_cry_antimatter" and antimatter.b_cry_sl_deck) then
			return
		end
		local curr = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl
		if not G.P_SEALS[curr] then
			G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl = "Gold"
		end
		return localize({
			type = "name_text",
			set = "Other",
			key = G.PROFILES[G.SETTINGS.profile].last_choices.cry_edeck_sl:lower() .. "_seal",
		})
	end,
	set_default = function(self, choice)
		return G.P_SEALS[choice] and choice or "Gold"
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local sprites = Cryptid.edeck_sprites.seal
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.c_base)
		card:set_seal(card_key, true, true)
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
		SMODS.RunSelect.Setup.choices[self.key] = SMODS.RunSelect.Setup.choices[self.key] or {}
		if not remove then
			if self.selection_limit > 1 then
				if
					SMODS.table_size(SMODS.RunSelect.Setup.choices[self.key]) < self.selection_limit
					and not SMODS.RunSelect.Setup.choices[self.key][choice.seal]
				then
					SMODS.RunSelect.Setup.choices[self.key][choice.seal] = true
				else
					if choice.juice_up then
						choice:juice_up()
					end
					return
				end
			else
				SMODS.RunSelect.Setup.choices[self.key] = choice.seal
			end
		else
			if self.selection_limit == 1 then
				SMODS.RunSelect.Setup.choices[self.key] = nil
			else
				SMODS.RunSelect.Setup.choices[self.key][choice.seal] = nil
			end
		end
	end,
	start_run = function(self, choice)
		G.GAME.cry_selected_seal = choice
	end,
})

--Antimatter Deck selection
SMODS.RunSelectPage({
	key = "antimatter",
	include_deck_preview = true,
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
				if Cryptid.antimatter_compat(k) then
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
				if Cryptid.antimatter_compat(k) then
					deck_total = deck_total + 1
				else
					curr[k] = nil
				end
			end
		end
	end,
	create_selection_card = function(self, card_key, card_number, area)
		local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.b_red)
		local unlocked = Cryptid.antimatter_compat(card_key)
		card.cry_antimatter_card = true --figure out how to make this actually display a different description
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
})
