local ruby = {
	object_type = "Stake",
	name = "cry-Ruby Stake",
	key = "ruby",
	pos = { x = 0, y = 0 },
	atlas = "stake",
	applied_stakes = { "gold" },
	prefix_config = { applied_stakes = { mod = false } },
	modifiers = function()
		G.GAME.win_ante = 10
	end,
	shiny = true,
	order = 2,
}

local topaz = {
	object_type = "Stake",
	name = "cry-Topaz Stake",
	key = "topaz",
	pos = { x = 1, y = 0 },
	atlas = "stake",
	applied_stakes = { "cry_ruby" },
	modifiers = function()
		G.GAME.modifiers.cry_interest_rate = 8
	end,
	shiny = true,
	order = 2,
}

local quartz = {
	object_type = "Stake",
	name = "cry-Quartz Stake",
	key = "quartz",
	pos = { x = 2, y = 0 },
	atlas = "stake",
	applied_stakes = { "cry_topaz" },
	modifiers = function()
		G.GAME.modifiers.cry_enable_pinned_in_shop = true
	end,
	shiny = true,
	order = 3,
}

local diamond = {
	object_type = "Stake",
	name = "cry-Diamond Stake",
	key = "diamond",
	pos = { x = 3, y = 0 },
	atlas = "stake",
	applied_stakes = { "cry_quartz" },
	modifiers = function()
		G.GAME.modifiers.enable_banana = true
	end,
	shiny = true,
	order = 4,
}
--init colors so they have references
G.C.CRY_EMBER = { 0, 0, 0, 0 }
G.C.CRY_HORIZON = { 0, 0, 0, 0 }
G.C.CRY_BLOSSOM = { 0, 0, 0, 0 }
G.C.CRY_ASCENDANT = { 0, 0, 0, 0 }
local ember = {
	object_type = "Stake",
	name = "cry-Ember Stake",
	key = "ember",
	pos = { x = 0, y = 1 },
	atlas = "stake",
	applied_stakes = { "cry_diamond" },
	modifiers = function()
		G.GAME.modifiers.cry_sell_price = -1
	end,
	shiny = true,
	order = 5,
	colour = G.C.CRY_EMBER,
}
local horizon = {
	object_type = "Stake",
	name = "cry-Horizon Stake",
	key = "horizon",
	pos = { x = 1, y = 1 },
	atlas = "stake",
	applied_stakes = { "cry_ember" },
	modifiers = function()
		G.GAME.modifiers.cry_big_showdown = 5
	end,
	shiny = true,
	order = 6,
	colour = G.C.CRY_HORIZON,
}
local blossom = {
	object_type = "Stake",
	name = "cry-Blossom Stake",
	key = "blossom",
	pos = { x = 2, y = 1 },
	atlas = "stake",
	applied_stakes = { "cry_horizon" },
	modifiers = function()
		G.GAME.modifiers.cry_rarer_modifications = 0.2
	end,
	shiny = true,
	order = 7,
	colour = G.C.CRY_BLOSSOM,
}
local ascendant = {
	object_type = "Stake",
	name = "cry-Ascendant Stake",
	key = "ascendant",
	pos = { x = 3, y = 1 },
	atlas = "stake",
	applied_stakes = { "cry_blossom" },
	modifiers = function()
		G.GAME.modifiers.inflation = true
	end,
	shiny = true,
	order = 8,
	colour = G.C.CRY_ASCENDANT,
}
local stake_atlas = { object_type = "Atlas", key = "stake", path = "stake_cry.png", px = 29, py = 29 }
return {
	name = "More Stakes",
	init = function(self)
		-- Disallow use of Debuffed Perishable consumables
		local cuc = Card.can_use_consumeable
		function Card:can_use_consumeable(any_state, skip_check)
			if self.debuff then
				return false
			end
			return cuc(self, any_state, skip_check)
		end
		-- Overriding Steamodded's registering of Incantation/Familiar/Grim
		local function random_destroy(used_tarot)
			local destroyed_cards = {}
			local temp_hand = {}
			local hasHand = false
			for k, v in ipairs(G.hand.cards) do
				if not SMODS.is_eternal(v) then
					temp_hand[#temp_hand + 1] = v
					hasHand = true
				end
			end
			if hasHand then
				destroyed_cards[#destroyed_cards + 1] = pseudorandom_element(temp_hand, pseudoseed("random_destroy"))
			end
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("tarot1")
					if used_tarot and used_tarot.juice_up then
						used_tarot:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					for i = #destroyed_cards, 1, -1 do
						local card = destroyed_cards[i]
						if card.ability.name == "Glass Card" then
							card:shatter()
						else
							card:start_dissolve(nil, i ~= #destroyed_cards)
						end
					end
					return true
				end,
			}))
			return destroyed_cards
		end
		SMODS.Consumable:take_ownership("grim", {
			use = function(self, card, area, copier)
				local used_tarot = copier or card
				local destroyed_cards = random_destroy(used_tarot)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.7,
					func = function()
						local cards = {}
						for i = 1, card.ability.extra do
							cards[i] = true
							local suit_list = {}
							for i = #SMODS.Suit.obj_buffer, 1, -1 do
								suit_list[#suit_list + 1] = SMODS.Suit.obj_buffer[i]
							end
							local _suit, _rank =
								SMODS.Suits[pseudorandom_element(suit_list, pseudoseed("grim_create"))].card_key, "A"
							local cen_pool = {}
							for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
								if v.key ~= "m_stone" then
									cen_pool[#cen_pool + 1] = v
								end
							end
							create_playing_card({
								front = G.P_CARDS[_suit .. "_" .. _rank],
								center = pseudorandom_element(cen_pool, pseudoseed("spe_card")),
							}, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
						end
						playing_card_joker_effects(cards)
						return true
					end,
				}))
				delay(0.3)
				SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
			end,
		}, true)
		SMODS.Consumable:take_ownership("familiar", {
			use = function(self, card, area, copier)
				local used_tarot = copier or card
				local destroyed_cards = random_destroy(used_tarot)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.7,
					func = function()
						local cards = {}
						for i = 1, card.ability.extra do
							cards[i] = true
							local suit_list = {}
							for i = #SMODS.Suit.obj_buffer, 1, -1 do
								suit_list[#suit_list + 1] = SMODS.Suit.obj_buffer[i]
							end
							local faces = {}
							for _, v in ipairs(SMODS.Rank.obj_buffer) do
								local r = SMODS.Ranks[v]
								if r.face then
									table.insert(faces, r.card_key)
								end
							end
							local _suit, _rank =
								SMODS.Suits[pseudorandom_element(suit_list, pseudoseed("familiar_create"))].card_key,
								pseudorandom_element(faces, pseudoseed("familiar_create"))
							local cen_pool = {}
							for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
								if v.key ~= "m_stone" then
									cen_pool[#cen_pool + 1] = v
								end
							end
							create_playing_card({
								front = G.P_CARDS[_suit .. "_" .. _rank],
								center = pseudorandom_element(cen_pool, pseudoseed("spe_card")),
							}, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
						end
						playing_card_joker_effects(cards)
						return true
					end,
				}))
				delay(0.3)
				SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
			end,
		}, true)
		SMODS.Consumable:take_ownership("incantation", {
			use = function(self, card, area, copier)
				local used_tarot = copier or card
				local destroyed_cards = random_destroy(used_tarot)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.7,
					func = function()
						local cards = {}
						for i = 1, card.ability.extra do
							cards[i] = true
							local suit_list = {}
							for i = #SMODS.Suit.obj_buffer, 1, -1 do
								suit_list[#suit_list + 1] = SMODS.Suit.obj_buffer[i]
							end
							local numbers = {}
							for _RELEASE_MODE, v in ipairs(SMODS.Rank.obj_buffer) do
								local r = SMODS.Ranks[v]
								if v ~= "Ace" and not r.face then
									table.insert(numbers, r.card_key)
								end
							end
							local _suit, _rank =
								SMODS.Suits[pseudorandom_element(suit_list, pseudoseed("incantation_create"))].card_key,
								pseudorandom_element(numbers, pseudoseed("incantation_create"))
							local cen_pool = {}
							for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
								if v.key ~= "m_stone" then
									cen_pool[#cen_pool + 1] = v
								end
							end
							create_playing_card({
								front = G.P_CARDS[_suit .. "_" .. _rank],
								center = pseudorandom_element(cen_pool, pseudoseed("spe_card")),
							}, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
						end
						playing_card_joker_effects(cards)
						return true
					end,
				}))
				delay(0.3)
				SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
			end,
		}, true)
		for _, v in pairs(self.items) do
			if v.object_type == "Stake" then
				v.sticker_pos = v.pos
				v.sticker_atlas = "sticker"
			end
		end
	end,
	items = {
		stake_atlas,

		ruby,
		topaz,
		quartz,
		diamond,

		ember,
		horizon,
		blossom,
		ascendant,
	},
}
