-- Echo (Enhancement)
-- 1 in 2 to retrigger twice when played
local echo = {
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Coronacht",
		},
		code = {
			"AlexZGreat",
		},
	},
	object_type = "Enhancement",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "echo",
	atlas = "cry_misc",
	order = 201,
	pos = { x = 2, y = 0 },
	config = { retriggers = 2, extra = 2 },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.retriggers or self.config.retriggers,
				SMODS.get_probability_vars(card, 1, card.ability.extra, "Echo Card"),
			},
		} -- note that the check for (card.ability.cry_prob or 1) is probably unnecessary due to cards being initialised with ability.cry_prob
	end,
	calculate = function(self, card, context)
		if context.repetition and SMODS.pseudorandom_probability(card, "echo", 1, card.ability.extra, "Echo Card") then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.retriggers,
				card = card,
			}
		end
	end,
}
-- Eclipse (Tarot)
-- Makes a selected playing card Echo
local eclipse = {
	cry_credits = {
		idea = {
			"Mystick Misclick",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"AlexZGreat",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_misc",
			"m_cry_echo",
		},
	},
	set = "Tarot",
	name = "cry-Eclipse",
	key = "eclipse",
	order = 202,
	pos = { x = 4, y = 0 },
	config = { mod_conv = "m_cry_echo", max_highlighted = 1 },
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_echo

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	demicoloncompat = true,
}
-- Light (Enhancement)
-- When triggered with 5 other cards, gain 0.2 Xmult
-- Increases requirement by 5 when reached
-- Gives Xmult when scored
local light = {
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"AlexZGreat",
		},
	},
	object_type = "Enhancement",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "light",
	atlas = "cry_misc",
	cry_noshadow = true,
	order = 203,
	pos = { x = 0, y = 3 },
	config = { extra = { a_x_mult = 0.2, current_x_mult = 1, req = 5, current = 5 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.extra.a_x_mult or self.config.extra.a_x_mult,
				card and card.ability.extra.current_x_mult or self.config.extra.current_x_mult,
				card and card.ability.extra.current or self.config.extra.current,
				card and card.ability.extra.req or self.config.extra.req,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			if #context.scoring_hand > 1 then
				card.ability.extra.current = card.ability.extra.current - (#context.scoring_hand - 1)
				while card.ability.extra.current <= 0 do
					card.ability.extra.req = card.ability.extra.req + 5
					card.ability.extra.current = card.ability.extra.current + card.ability.extra.req
					card.ability.extra.current_x_mult = card.ability.extra.current_x_mult + card.ability.extra.a_x_mult
				end
			end
			if card.ability.extra.current_x_mult > 1 then
				return {
					x_mult = card.ability.extra.current_x_mult,
				}
			end
		end
	end,
}
-- Seraph (Tarot)
-- Makes 2 selected playing cards Light
local seraph = {
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"sachertote",
		},
		code = {
			"AlexZGreat",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_misc",
			"m_cry_light",
		},
	},
	set = "Tarot",
	name = "cry-Seraph",
	key = "seraph",
	order = 204,
	pos = { x = 5, y = 3 },
	config = { mod_conv = "m_cry_light", max_highlighted = 2 },
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_light

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	demicoloncompat = true,
}
-- Abstract (Enhancement)
-- Has its own rank/suit
-- 1 in 4 to destroy card if held in hand at round end or hand played
-- ^1.15 mult when scored
local abstract = {
	cry_credits = {
		idea = {
			"lolxddj",
		},
		art = {
			"lolxddj",
		},
		code = {
			"70UNIK",
		},
	},
	object_type = "Enhancement",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	name = "cry_abstract",
	key = "abstract",
	not_stoned = true,
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
	atlas = "cry_misc",
	order = 205,
	pos = { x = 3, y = 0 },
	shatters = true, --SMODS has a new "shatters" function
	force_no_face = true, --true = always face, false = always face
	--NEW! specific_suit suit. Like abstracted!
	specific_suit = "cry_abstract",
	specific_rank = "cry_abstract",
	config = { extra = { Emult = 1.15, odds_after_play = 2, odds_after_round = 4, marked = false, survive = false } },
	--#1# emult, #2# in #3# chance card is destroyed after play, #4# in #5$ chance card is destroyed at end of round (even discarded or in deck)
	loc_vars = function(self, info_queue, card)
		local aaa, bbb = SMODS.get_probability_vars(card, 1, card.ability.extra.odds_after_play, "Abstract Card")
		local ccc, ddd = SMODS.get_probability_vars(card, 1, card.ability.extra.odds_after_round, "Abstract Card")
		return {
			vars = {
				card.ability.extra.Emult,
				aaa,
				bbb,
				ccc,
				ddd,
			},
		}
	end,
	calculate = function(self, card, context)
		--During scoring
		if
			context.cardarea == G.hand
			and context.before
			and not card.ability.extra.marked
			and not SMODS.is_eternal(card)
			and not card.ability.extra.survive --this presvents repitition of shatter chance by shutting it out once it confirms to "survive"
			and SMODS.pseudorandom_probability(
				card,
				"cry_abstract_destroy",
				1,
				card.ability.extra.odds_after_play,
				"Abstract Card"
			)
		then -- the 'card.area' part makes sure the card has a chance to survive if in the play area
			card.ability.extra.marked = true
		elseif context.cardarea == G.play and not card.ability.extra.marked then
			card.ability.extra.survive = true
		end
		if context.cardarea == G.play and context.main_scoring then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.Emult),
					},
				}),
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.DARK_EDITION,
			}
		end

		if
			context.final_scoring_step
			and context.cardarea == G.hand
			and card.ability.extra.marked
			and not context.repetition
			and not SMODS.is_eternal(card)
			and not (card.will_shatter or card.destroyed or card.shattered)
		then
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					card:juice_up(0.9, 0.9)
					card:shatter()
					return true
				end,
			}))
		end
		card.ability.extra.survive = false
	end,
}
-- Instability (Tarot)
-- Makes a selected playing card Abstract
local instability = {
	cry_credits = {
		idea = {
			"lolxddj",
		},
		art = {
			"lolxddj",
		},
		code = {
			"70UNIK",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_misc",
			"m_cry_abstract",
		},
	},
	set = "Tarot",
	name = "cry-Instability",
	key = "instability",
	order = 206,
	pos = { x = 5, y = 5 },
	config = { mod_conv = "m_cry_abstract", max_highlighted = 1 },
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_abstract

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
	demicoloncompat = true,
}

-- Blessing
-- Creates a random Consumeable
local blessing = {
	cry_credits = {
		idea = {
			"5381",
		},
		art = {
			"RattlingSnow353",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	set = "Tarot",
	name = "cry-theblessing",
	key = "theblessing",
	order = 500,
	pos = { x = 2, y = 3 },
	cost = 3,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
	end,
	can_bulk_use = true,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local forceuse = G.cry_force_use
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards or forceuse then
					play_sound("timpani")
					local forced_key = Cryptid.random_consumable("blessing", nil, "c_cry_blessing")
					local _card = create_card(
						"Consumeables",
						G.consumeables,
						nil,
						nil,
						nil,
						nil,
						forced_key.config.center_key,
						"blessing"
					)
					_card:add_to_deck()
					G.consumeables:emplace(_card)
					used_consumable:juice_up(0.3, 0.5)
				end
				return true
			end,
		}))
		delay(0.6)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

-- insert typhoon here (why is it in spectral.lua)
local azure_seal = {
	cry_credits = {
		idea = {
			"stupid",
		},
		art = {
			"stupid",
		},
		code = {
			"stupid",
		},
	},
	object_type = "Seal",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	name = "cry-Azure-Seal",
	key = "azure",
	badge_colour = HEX("1d4fd7"),
	config = { planets_amount = 3 },
	loc_vars = function(self, info_queue)
		return { vars = { self.config.planets_amount } }
	end,
	atlas = "cry_misc",
	order = 502,
	pos = { x = 0, y = 2 },
	-- This is still quite jank
	calculate = function(self, card, context)
		if context.destroying_card and context.cardarea == G.play and context.destroy_card == card then
			card.will_shatter = true
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					local card_type = "Planet"
					local _planet = nil
					if G.GAME.last_hand_played then
						for k, v in pairs(G.P_CENTER_POOLS.Planet) do
							if v.config.hand_type == G.GAME.last_hand_played then
								_planet = v.key
								break
							end
						end
						if
							(
								G.GAME.last_hand_played == "cry_Declare0"
								or G.GAME.last_hand_played == "cry_Declare1"
								or G.GAME.last_hand_played == "cry_Declare2"
							) and Cryptid.enabled("c_cry_voxel") == true
						then
							_planet = "c_cry_voxel"
						end
					end

					for i = 1, self.config.planets_amount do
						local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, "cry_azure")

						card:set_edition({ negative = true }, true)
						card:add_to_deck()
						G.consumeables:emplace(card)
					end
					return true
				end,
			}))
			return { remove = true }
		end
	end,
}

-- Packs
local meme_digital_hallucinations_compat = {
	colour = G.C.CRY_ASCENDANT,
	loc_key = "k_plus_joker",
	create = function()
		local ccard = create_card("Meme", G.jokers, nil, nil, true, true, nil, "diha")
		ccard:set_edition({ negative = true }, true)
		ccard:add_to_deck()
		G.jokers:emplace(ccard) --Note: Will break if any non-Joker gets added to the meme pool
	end,
}
-- Anti synergy with digital hallucinations, it will create ANOTHER cursed Joker when opening the pack
local cursed_digital_hallucinations_compat = {
	colour = HEX("474931"),
	loc_key = "k_plus_joker",
	create = function()
		local ccard = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "diha")
		ccard:set_edition({ negative = true }, true)
		ccard:add_to_deck()
		G.jokers:emplace(ccard) --Note: Will break if any non-Joker gets added to the meme pool
	end,
}
-- Meme Pack 1 (2/5 Meme Jokers)
local meme1 = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Booster",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	key = "meme_1",
	kind = "meme",
	atlas = "pack",
	pos = { x = 0, y = 1 },
	order = 801,
	config = { extra = 5, choose = 2 },
	cost = 14,
	weight = 0.18 / 3, --0.18 base ÷ 3 since there are 3 identical packs
	create_card = function(self, card)
		if
			Cryptid.enabled("j_cry_waluigi")
			and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		then
			if pseudorandom("meme1_" .. G.GAME.round_resets.ante) > 0.997 then
				return create_card("Meme", G.pack_cards, nil, nil, true, true, "j_cry_waluigi", nil)
			end
		end
		return create_card("Meme", G.pack_cards, nil, nil, true, true, nil, "cry_meme")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_cry_meme_pack",
	cry_digital_hallucinations = meme_digital_hallucinations_compat,
}
-- Meme Pack 2 (2/5 Meme Jokers)
local meme2 = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Booster",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	key = "meme_two",
	kind = "meme",
	atlas = "pack",
	pos = { x = 1, y = 1 },
	order = 802,
	config = { extra = 5, choose = 2 },
	cost = 14,
	weight = 0.18 / 3, --0.18 base ÷ 3 since there are 3 identical packs
	create_card = function(self, card)
		if
			Cryptid.enabled("j_cry_waluigi")
			and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		then
			if pseudorandom("memetwo_" .. G.GAME.round_resets.ante) > 0.997 then
				return create_card("Meme", G.pack_cards, nil, nil, true, true, "j_cry_waluigi", nil)
			end
		end
		return create_card("Meme", G.pack_cards, nil, nil, true, true, nil, "cry_memetwo")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_cry_meme_pack",
	cry_digital_hallucinations = meme_digital_hallucinations_compat,
}
-- Meme Pack 3 (2/5 Meme Jokers)
local meme3 = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Booster",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	key = "meme_three",
	kind = "meme",
	atlas = "pack",
	pos = { x = 2, y = 1 },
	order = 803,
	config = { extra = 5, choose = 2 },
	cost = 14,
	weight = 0.18 / 3, --0.18 base ÷ 3 since there are 3 identical packs
	create_card = function(self, card)
		if
			Cryptid.enabled("j_cry_waluigi")
			and not (G.GAME.used_jokers["j_cry_waluigi"] and not next(find_joker("Showman")))
		then
			if pseudorandom("memethree_" .. G.GAME.round_resets.ante) > 0.997 then
				return create_card("Meme", G.pack_cards, nil, nil, true, true, "j_cry_waluigi", nil)
			end
		end
		return create_card("Meme", G.pack_cards, nil, nil, true, true, nil, "cry_memethree")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.CRY_ASCENDANT)
		ease_background_colour({ new_colour = G.C.CRY_ASCENDANT, special_colour = G.C.BLACK, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_cry_meme_pack",
	cry_digital_hallucinations = meme_digital_hallucinations_compat,
}
-- 804 in case of meme pack 4
-- 805-808 for program packs
-- Baneful Buffoon Pack 1 (1/4 Cursed jokers)
local baneful1 = {
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"Nova",
		},
		code = {
			"70UNIK",
		},
	},
	object_type = "Booster",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "baneful_1",
	kind = "baneful",
	atlas = "pack",
	order = 809,
	pos = { x = 0, y = 2 },
	cry_baneful_punishment = true,
	no_music = true, --prevent override of music, such as in boss blinds
	no_doe = true,
	unskippable = function(self)
		--Only be unskippable if no VALID jokers are owned (if rightmost is eternal/cursed, the next)
		if G.jokers and (#G.jokers.cards == 0 or not G.jokers.cards) then
			return true
		end
		--For loop that iterates from right to left, breaking and returning false if finding the rightmost valid noneternal or cursed Joker
		if G.jokers and G.jokers.cards then
			for i = #G.jokers.cards, 1, -1 do
				if
					not (SMODS.is_eternal(G.jokers.cards[i]) or G.jokers.cards[i].config.center.rarity == "cry_cursed")
				then
					return false
				end
			end
		end
		return true
	end,
	config = { extra = 4, choose = 1 },
	cost = 1,
	immutable = true,
	weight = 0, --never spawn naturally
	create_card = function(self, card)
		return create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "baneful_pack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("474931"))
		ease_background_colour({ new_colour = HEX("474931"), special_colour = G.C.BLACK, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and card.ability.choose or self.config.choose,
				card and card.ability.extra or self.config.extra,
			},
		}
	end,
	--never spawn as well in pool
	in_pool = function()
		return false
	end,
	group_key = "k_cry_baneful_pack",
	cry_digital_hallucinations = cursed_digital_hallucinations_compat,
}
-- 810-812 reserved for more Baneful packs if they come

-- Editions start at 900, haven't decided on order yet

if not AurinkoAddons then
	AurinkoAddons = {}
end

--Edition code based on Bunco's Glitter Edition
local mosaic_shader = {
	object_type = "Shader",
	key = "mosaic",
	path = "mosaic.fs",
}
local mosaic = {
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		--Replace with Shader later
		art = {
			"Math",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "mosaic",
	order = 2,
	weight = 0.8, --slightly rarer than Polychrome
	shader = "mosaic",
	in_shop = true,
	extra_cost = 5,
	config = { x_chips = 2.5, trigger = nil },
	sound = {
		sound = "cry_e_mosaic",
		per = 1,
		vol = 0.2,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.x_chips or self.config.x_chips } }
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { x_chips = card and card.edition and card.edition.x_chips or self.config.x_chips } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
}

local oversat_shader = {
	object_type = "Shader",
	key = "oversat",
	path = "oversat.fs",
}
local oversat = {
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"Math",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "oversat",
	order = 3,
	weight = 3,
	shader = "oversat",
	in_shop = true,
	extra_cost = 5,
	sound = {
		sound = "cry_e_oversaturated",
		per = 1,
		vol = 0.25,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	-- Note: Duping playing cards resets the base chips for some reason
	on_apply = function(card)
		if not card.ability.cry_oversat then
			Cryptid.manipulate(card, {
				value = 2,
			}, nil, true)
			if card.config.center.apply_oversat then
				card.config.center:apply_oversat(card, function(val)
					return Cryptid.misprintize_val(val, {
						min = 2 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 2 * (G.GAME.modifiers.cry_misprint_max or 1),
					}, Cryptid.is_card_big(card))
				end)
			end
		end
		card.ability.cry_oversat = true
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, { value = 1 / 2 })
		Cryptid.manipulate(card) -- Correct me if i'm wrong but this is for misprint deck. or atleast it is after this patch
		card.ability.cry_oversat = nil
	end,
	init = function(self)
		AurinkoAddons.cry_oversat = function(card, hand, instant, amount)
			G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + (G.GAME.hands[hand].l_chips * amount), 0)
			G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + (G.GAME.hands[hand].l_mult * amount), 1)
			if not instant then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.3,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 1.3 }, { chips = G.GAME.hands[hand].chips, StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.3,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 1.3 }, { mult = G.GAME.hands[hand].mult, StatusText = true })
			elseif Aurinko.VerboseMode then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ chips = (to_big(amount) > to_big(0) and "++" or "--"), StatusText = true }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ mult = (to_big(amount) > to_big(0) and "++" or "--"), StatusText = true }
				)
			end
		end
	end,
}

local glitched_shader = {
	object_type = "Shader",
	key = "glitched",
	path = "glitched.fs",
}
local glitched_shader2 = {
	object_type = "Shader",
	key = "ultrafoil",
	path = "ultrafoil.fs",
}
local glitched_shaderb = {
	object_type = "Shader",
	key = "glitched_b",
	path = "glitched_b.fs",
}
local glitched = {
	cry_credits = {
		art = {
			"Cassknows",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "glitched",
	order = 1,
	weight = 15,
	--shader = G.SETTINGS.reduced_motion and "ultrafoil" or "glitched",
	shader = "glitched_b",
	in_shop = true,
	extra_cost = 0,
	sound = {
		sound = "cry_e_glitched",
		per = 1,
		vol = 0.25,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	-- Note: Duping playing cards resets the base chips for some reason
	on_apply = function(card)
		if not card.ability.cry_glitched then
			Cryptid.manipulate(card, {
				min = 0.1,
				max = 10,
			})

			if card.config.center.apply_glitched then
				card.config.center:apply_glitched(card, function(val)
					return Cryptid.manipulate_value(val, {
						min = 0.1 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 10 * (G.GAME.modifiers.cry_misprint_max or 1),
						type = "X",
					}, Cryptid.is_card_big(card))
				end)
			end
		end
		card.ability.cry_glitched = true
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, { min = 1, max = 1, dont_stack = true })
		Cryptid.manipulate(card) -- Correct me if i'm wrong but this is for misprint deck. or atleast it is after this patch
		card.ability.cry_glitched = nil
	end,
	init = function(self)
		local randtext = {
			"A",
			"B",
			"C",
			"D",
			"E",
			"F",
			"G",
			"H",
			"I",
			"J",
			"K",
			"L",
			"M",
			"N",
			"O",
			"P",
			"Q",
			"R",
			"S",
			"T",
			"U",
			"V",
			"W",
			"X",
			"Y",
			"Z",
			" ",
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"w",
			"x",
			"y",
			"z",
			"0",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9",
			"+",
			"-",
			"?",
			"!",
			"$",
			"%",
			"[",
			"]",
			"(",
			")",
		}

		local function obfuscatedtext(length)
			local str = ""
			for i = 1, length do
				str = str .. randtext[math.random(#randtext)]
			end
			return str
		end

		AurinkoAddons.cry_glitched = function(card, hand, instant, amount)
			local modc = G.GAME.hands[hand].l_chips
				* Cryptid.log_random(
					pseudoseed("cry_aurinko_chips_misprint" .. G.GAME.round_resets.ante),
					(G.GAME.modifiers.cry_misprint_min or 1) / 10,
					(G.GAME.modifiers.cry_misprint_max or 1) * 10
				)
				* amount
			local modm = G.GAME.hands[hand].l_mult
				* Cryptid.log_random(
					pseudoseed("cry_aurinko_mult_misprint" .. G.GAME.round_resets.ante),
					(G.GAME.modifiers.cry_misprint_min or 1) / 10,
					(G.GAME.modifiers.cry_misprint_max or 1) * 10
				)
				* amount
			G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + modc, 1)
			G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + modm, 1)
			if not instant then
				for i = 1, math.random(2, 4) do
					update_hand_text(
						{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
						{ chips = obfuscatedtext(3) }
					)
				end
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, {
					chips = (to_big(amount) > to_big(0) and "+" or "-") .. number_format(math.abs(modc)),
					StatusText = true,
				})
				update_hand_text({ delay = 1.3 }, { chips = G.GAME.hands[hand].chips })
				for i = 1, math.random(2, 4) do
					update_hand_text(
						{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
						{ mult = obfuscatedtext(3) }
					)
				end
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, {
					mult = (to_big(amount) > to_big(0) and "+" or "-") .. number_format(math.abs(modm)),
					StatusText = true,
				})
				update_hand_text({ delay = 1.3 }, { mult = G.GAME.hands[hand].mult })
			elseif Aurinko.VerboseMode then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ chips = (to_big(amount) > to_big(0) and "+" or "-") .. "???", StatusText = true }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ mult = (to_big(amount) > to_big(0) and "+" or "-") .. "???", StatusText = true }
				)
			end
		end
	end,
}

local astral_shader = {
	object_type = "Shader",
	key = "astral",
	path = "astral.fs",
}
local astral = {
	cry_credits = {
		--Don't remember who came up with this idea
		art = {
			"AlexZGreat",
		},
		code = {
			"Math",
		},
		art = {
			"lord.ruby",
			"Oiiman",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "astral",
	order = 30,
	weight = 0.3, --very rare
	shader = "astral",
	in_shop = true,
	extra_cost = 9,
	sound = {
		sound = "talisman_emult",
		per = 1,
		vol = 0.5,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	config = { e_mult = 1.1, trigger = nil },
	loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.e_mult or self.config.e_mult } }
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { e_mult = card and card.edition and card.edition.e_mult or self.config.e_mult } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
}

local blurred_shader = {
	object_type = "Shader",
	key = "blur",
	path = "blur.fs",
}
local blurred = {
	cry_credits = {
		idea = {
			"stupid",
		},
		art = {
			"stupid",
		},
		code = {
			"stupid",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "blur",
	order = 6,
	weight = 0.5, --very rare
	shader = "blur",
	in_shop = true,
	extra_cost = 5,
	sound = {
		sound = "cry_e_blur",
		per = 1,
		vol = 0.5,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	config = { retrigger_chance = 2, retriggers = 1, extra_retriggers = 1 },
	loc_vars = function(self, info_queue, center)
		local aaa, bbb = SMODS.get_probability_vars(self, 1, self.config.retrigger_chance, "Blurred Edition")
		local retriggers = center and center.edition and center.edition.retriggers or self.config.retriggers

		return { vars = { aaa, bbb, retriggers } }
	end,
	--Note: This doesn't always play the animations properly for Jokers
	calculate = function(self, card, context)
		if
			context.other_card == card
			and (
				(context.repetition and context.cardarea == G.play)
				or (context.retrigger_joker_check and not context.retrigger_joker)
			)
		then
			return {
				message = localize("cry_again_q"),
				repetitions = self.config.retriggers + (SMODS.pseudorandom_probability(
					self,
					"cry_blurred",
					1,
					self.config.retrigger_chance,
					"Blurred Edition"
				) and self.config.extra_retriggers or 0),
				card = card,
			}
		end
	end,
}

local noisy_shader = {
	object_type = "Shader",
	key = "noisy",
	path = "noisy.fs",
}
local noisy_stats = {
	min = {
		mult = 0,
		chips = 0,
	},
	max = {
		mult = 30,
		chips = 150,
	},
}
local noisy = {
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"jenwalter666",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "noisy",
	order = 7,
	weight = 3,
	shader = "noisy",
	in_shop = true,
	extra_cost = 4,
	config = {
		min_mult = noisy_stats.min.mult,
		max_mult = noisy_stats.max.mult,
		min_chips = noisy_stats.min.chips,
		max_chips = noisy_stats.max.chips,
		trigger = nil,
	},
	sound = {
		sound = "cry_e_noisy",
		per = 1,
		vol = 0.25,
	},
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			local min_mult = card and card.edition and card.edition.min_mult or self.config.min_mult
			local max_mult = card and card.edition and card.edition.max_mult or self.config.max_mult
			local min_chips = card and card.edition and card.edition.min_chips or self.config.min_chips
			local max_chips = card and card.edition and card.edition.max_chips or self.config.max_chips
			return {
				mult = pseudorandom("cry_noisy_mult", min_mult, max_mult),
				chips = pseudorandom("cry_noisy_chips", min_chips, max_chips),
			} -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if not full_UI_table.name then
			full_UI_table.name = localize({ type = "name", set = self.set, key = self.key, nodes = full_UI_table.name })
		end
		local r_mults = {}
		for i = self.config.min_mult, self.config.max_mult do
			r_mults[#r_mults + 1] = tostring(i)
		end
		local loc_mult = " " .. (localize("k_mult")) .. " "
		local r_chips = {}
		for i = self.config.min_chips, self.config.max_chips do
			r_chips[#r_chips + 1] = tostring(i)
		end
		local loc_chips = " " .. (localize("k_chips")) .. " "
		mult_ui = {
			{ n = G.UIT.T, config = { text = "  +", colour = G.C.MULT, scale = 0.32 } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = r_mults,
						colours = { G.C.MULT },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.5,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{
								string = "#@"
									.. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)
									.. (
										G.deck
											and G.deck.cards[1]
											and G.deck.cards[#G.deck.cards].base.suit
											and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1)
										or "D"
									),
								colour = G.C.RED,
							},
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
							loc_mult,
						},
						colours = { G.C.UI.TEXT_DARK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
		}
		chip_ui = {
			{ n = G.UIT.T, config = { text = "  +", colour = G.C.CHIPS, scale = 0.32 } },
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = r_chips,
						colours = { G.C.CHIPS },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.5,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{
								string = "@#"
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.suit and G.deck.cards[1].base.suit:sub(
										2,
										2
									) or "m")
									.. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.id or 7),
								colour = G.C.BLUE,
							},
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
							loc_chips,
						},
						colours = { G.C.UI.TEXT_DARK },
						pop_in_rate = 9999999,
						silent = true,
						random_element = true,
						pop_delay = 0.2011,
						scale = 0.32,
						min_cycle_time = 0,
					}),
				},
			},
		}
		desc_nodes[#desc_nodes + 1] = mult_ui
		desc_nodes[#desc_nodes + 1] = chip_ui
	end,
	init = function(self)
		local randtext = {
			"A",
			"B",
			"C",
			"D",
			"E",
			"F",
			"G",
			"H",
			"I",
			"J",
			"K",
			"L",
			"M",
			"N",
			"O",
			"P",
			"Q",
			"R",
			"S",
			"T",
			"U",
			"V",
			"W",
			"X",
			"Y",
			"Z",
			" ",
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"w",
			"x",
			"y",
			"z",
			"0",
			"1",
			"2",
			"3",
			"4",
			"5",
			"6",
			"7",
			"8",
			"9",
			"+",
			"-",
			"?",
			"!",
			"$",
			"%",
			"[",
			"]",
			"(",
			")",
		}

		local function obfuscatedtext(length)
			local str = ""
			for i = 1, length do
				str = str .. randtext[math.random(#randtext)]
			end
			return str
		end

		AurinkoAddons.cry_noisy = function(card, hand, instant, amount)
			local modc = pseudorandom("cry_noisy_chips_aurinko", noisy_stats.min.chips, noisy_stats.max.chips) * amount
			local modm = pseudorandom("cry_noisy_mult_aurinko", noisy_stats.min.mult, noisy_stats.max.mult) * amount
			G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + modc, 1)
			G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + modm, 1)
			if not instant then
				for i = 1, math.random(2, 4) do
					update_hand_text(
						{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
						{ chips = obfuscatedtext(3) }
					)
				end
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, {
					chips = (to_big(amount) > to_big(0) and "+" or "-") .. number_format(math.abs(modc)),
					StatusText = true,
				})
				update_hand_text({ delay = 1.3 }, { chips = G.GAME.hands[hand].chips })
				for i = 1, math.random(2, 4) do
					update_hand_text(
						{ sound = "button", volume = 0.4, pitch = 1.1, delay = 0.2 },
						{ mult = obfuscatedtext(3) }
					)
				end
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, {
					mult = (to_big(amount) > to_big(0) and "+" or "-") .. number_format(math.abs(modm)),
					StatusText = true,
				})
				update_hand_text({ delay = 1.3 }, { mult = G.GAME.hands[hand].mult })
			elseif hand == G.handlist[#G.handlist] then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ chips = (to_big(amount) > to_big(0) and "+" or "-") .. "???", StatusText = true }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ mult = (to_big(amount) > to_big(0) and "+" or "-") .. "???", StatusText = true }
				)
			end
		end
	end,
}

local jollyeditionshader = {
	object_type = "Shader",
	key = "m",
	path = "m.fs",
}
local jollyedition = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"stupid",
			"Math",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
			"set_cry_m",
		},
	},
	in_shop = false,
	order = 31,
	weight = 0,
	pos = { x = 2, y = 0 },
	name = "cry-jollyedition",
	sound = {
		sound = "cry_e_jolly",
		per = 1,
		vol = 0.3,
	},
	extra_cost = 0,
	config = { mult = 8, trigger = nil },
	apply_to_float = true,
	key = "m",
	shader = "m",
	disable_base_shader = true,
	disable_shadow = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.mult or self.config.mult } }
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { mult = card and card.edition and card.edition.mult or self.config.mult } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	init = function(self)
		--Change name of cards with Jolly edition
		local gcui = generate_card_ui
		function generate_card_ui(
			_c,
			full_UI_table,
			specific_vars,
			card_type,
			badges,
			hide_desc,
			main_start,
			main_end,
			card
		)
			local full_UI_table =
				gcui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
			if
				card
				and Cryptid.safe_get(card, "edition", "cry_m")
				and ((not card.ability) or card.ability.set ~= "Edition")
				and type(Cryptid.safe_get(full_UI_table, "name")) == "table"
				and Cryptid.safe_get(full_UI_table.name, 1, "nodes", 1, "config", "object", "config")
			then
				local conf = full_UI_table.name[1].nodes[1].config.object.config
				if conf.string and #conf.string > 0 then
					local function m_ify_word(text)
						-- Define a pattern for vowels
						local vowels = "AEIOUaeiou"

						-- Use gsub to replace the first consonant of each word with 'M'
						local result = text:gsub("(%a)(%w*)", function(first, rest)
							if vowels:find(first) then
								-- If the first character is a vowel, add an M
								if (not rest[1]) or (rest:lower()[1] == rest[1]) then --this check doesn't work properly
									return "M" .. first:lower() .. rest
								else
									return "M" .. first:upper() .. rest
								end
							elseif first:lower() == "m" then
								-- If the word already starts with 'M', keep it unchanged
								return first .. rest
							else
								-- Replace the first consonant with 'M'
								return "M" .. rest
							end
						end)

						return result
					end
					function m_ify(text)
						-- Use gsub to apply the m_ify_word function to each word
						local result = text:gsub("(%S+)", function(word)
							return m_ify_word(word)
						end)

						return result
					end
					conf.string[1] = m_ify(conf.string[1])
					full_UI_table.name[1].nodes[1].config.object:remove()
					full_UI_table.name[1].nodes[1].config.object = DynaText(conf)
				end
			end
			return full_UI_table
		end
	end,
}

local glass_shader = {
	object_type = "Shader",
	key = "glass",
	path = "glass.fs",
	send_vars = function(sprite, card)
		return {
			lines_offset = card and card.edition and card.edition.cry_glass_seed or 0,
		}
	end,
}
local glass_edition = {
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"stupid",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "glass",
	order = 4,
	shader = "glass",
	in_shop = true,
	disable_base_shader = true,
	disable_shadow = true,
	on_apply = function(card)
		-- Randomize offset to -1..1
		card.edition.cry_glass_seed = pseudorandom("e_cry_glass") * 2 - 1
	end,
	sound = {
		sound = "cry_e_fragile",
		per = 1,
		vol = 0.3,
	},
	weight = 7,
	extra_cost = 2,
	config = { x_mult = 3, shatter_chance = 8, trigger = nil },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				((card and card.edition and card.edition.shatter_chance or self.config.shatter_chance) - 1),
				(card and card.edition and card.edition.shatter_chance or self.config.shatter_chance),
				card and card.edition and card.edition.x_mult or self.config.x_mult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.edition and context.cardarea == G.jokers and card.config.trigger then
			return { x_mult = card and card.edition and card.edition.x_mult or self.config.x_mult }
		end

		if
			context.cardarea == G.jokers
			and context.post_trigger
			and context.other_card == card --animation-wise this looks weird sometimes
		then
			if
				not SMODS.is_eternal(card)
				and not (
					pseudorandom(pseudoseed("cry_fragile"))
					> ((self.config.shatter_chance - 1) / self.config.shatter_chance)
				)
			then
				-- this event call might need to be pushed later to make more sense
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
						card.states.drag.is = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
		if context.main_scoring and context.cardarea == G.play then
			if
				not SMODS.is_eternal(card)
				and (
					pseudorandom(pseudoseed("cry_fragile"))
					> ((self.config.shatter_chance - 1) / self.config.shatter_chance)
				)
			then
				card.config.will_shatter = true
			end
			return { x_mult = self.config.x_mult }
		end

		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end

		if context.destroying_card and card.config.will_shatter then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
					card.states.drag.is = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return { remove = true }
		end
	end,
}

local gold_shader = {
	object_type = "Shader",
	key = "gold",
	path = "gold.fs",
	send_vars = function(sprite, card)
		return {
			lines_offset = card and card.edition and card.edition.cry_gold_seed or 0,
		}
	end,
}
local gold_edition = {
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"stupid",
		},
		code = {
			"Math",
		},
	},
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	key = "gold",
	order = 5,
	shader = "gold",
	weight = 7,
	extra_cost = 4,
	in_shop = true,
	config = { dollars = 2, active = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.dollars or self.config.dollars } }
	end,
	sound = {
		sound = "cry_e_golden",
		per = 1,
		vol = 0.3,
	},
	on_apply = function(card)
		-- Randomize offset to -1..1
		card.edition.cry_gold_seed = pseudorandom("e_cry_gold") * 2 - 1
	end,
	calculate = function(self, card, context)
		if
			(
				context.post_trigger -- for when on jonklers
				and context.other_card == card
				and Cryptid.isNonRollProbabilityContext(context.other_context)
			)
			or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
			or (
				context.using_consumeable -- for when using a consumable
				and context.consumeable == card
			)
		then
			return { p_dollars = card and card.edition and card.edition.dollars or self.config.dollars } -- updated value
		end
	end,
}

local double_sided = {
	object_type = "Edition",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	-- 	gameset_config = {
	-- 		modest = { disabled = true },
	-- 		mainline = { disabled = true },
	-- 		madness = { disabled = true },
	-- 		exp = {},
	-- 	},
	extra_gamesets = { "exp" },
	key = "double_sided",
	shader = G.SETTINGS.reduced_motion and "ultrafoil" or "glitched",
	order = 32,
	weight = 10,
	extra_cost = 0,
	in_shop = true,
	no_edeck = true, --major lag issues even if draw_shader crashes are patched
	sound = {
		sound = "cry_e_double_sided",
		per = 1,
		vol = 0.3,
	},
	cry_credits = {
		art = {
			"Samario",
			-- Reduced Motion Shader
			"Selicre",
		},
		code = {
			"Math",
			"lord-ruby",
		},
		jolly = {
			"Jolly Open Winner",
			"Axolotolus",
		},
	},
	on_apply = function(card)
		if not card.ability.immutable then
			card.ability.immutable = {}
		end
		if not card.ability.immutable.other_side then
			card.ability.immutable.other_side = "c_base"
		end
	end,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight * (G.GAME.used_vouchers.v_cry_double_vision and 4 or 1)
	end,
	init = function(self)
		local highlight_ref = Card.highlight
		function Card:highlight(is_highlighted)
			if self.edition and self.edition.key == "e_cry_double_sided" then
				if is_highlighted and self.area.config.type ~= "shop" and self.area ~= G.pack_cards then
					self.children.flip = UIBox({
						definition = {
							n = G.UIT.ROOT,
							config = {
								minh = 0.3,
								maxh = 0.5,
								minw = 0.4,
								maxw = 4,
								r = 0.08,
								padding = 0.1,
								align = "cm",
								colour = G.C.PURPLE,
								shadow = true,
								button = "flip_ds",
								func = "can_flip_ds",
								ref_table = self,
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("b_flip"), --localize
										scale = 0.3,
										colour = G.C.UI.TEXT_LIGHT,
									},
								},
							},
						},
						config = {
							align = "bmi",
							offset = {
								x = 0,
								y = 0.5,
							},
							bond = "Strong",
							parent = self,
						},
					})
					self.children.merge_ds = UIBox({
						definition = {
							n = G.UIT.ROOT,
							config = {
								minh = 0.3,
								maxh = 0.5,
								minw = 0.4,
								maxw = 4,
								r = 0.08,
								padding = 0.1,
								align = "cm",
								colour = G.C.PURPLE,
								shadow = true,
								button = "merge_ds",
								func = "can_merge_ds",
								ref_table = self,
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("b_merge"),
										scale = 0.3,
										colour = G.C.UI.TEXT_LIGHT,
									},
								},
							},
						},
						config = {
							align = "bmi",
							offset = {
								x = 0,
								y = 1,
							},
							bond = "Strong",
							parent = self,
						},
					})
				end
				if not is_highlighted or self.area.config.type == "shop" or self.area == G.pack_cards then
					if self.children.flip then
						self.children.flip:remove()
						self.children.flip = nil
					end

					if self.children.merge_ds then
						self.children.merge_ds:remove()
						self.children.merge_ds = nil
					end
				end
			end
			return highlight_ref(self, is_highlighted)
		end
		function Card:flip_side()
			local card = self
			if not card.ability.immutable then
				card.ability.immutable = {}
			end
			if card.ability.immutable.other_side then
				if type(card.ability.immutable.other_side) == "string" then
					if next(find_joker("cry-Flip Side")) then
						if card:get_other_side_dummy() then
							local dummy = card:get_other_side_dummy()
							dummy.added_to_deck = true
							Card.remove_from_deck(dummy, true)
						end
					else
						card:remove_from_deck(true)
					end
					local curr_abil = copy_table(card.ability)
					local key = card.config.center.key
					local base = copy_table(card.base)
					local seal = card.seal
					if card.ability.immutable.other_side.base then
						card.base = card.ability.immutable.other_side.base
					else
						card.base = {
							nominal = 0,
							suit_nominal = 0,
							face_nominal = 0,
							times_played = 0,
							suit_nominal_original = 0,
						}
					end
					if card.base.nominal ~= 0 then
						SMODS.change_base(card, card.base.suit, card.base.value)
					else
						if card.children.front then
							card.children.front:remove()
							card.children.front = nil
						end
					end
					card.seal = G.P_SEALS[card.ability.immutable.other_side.seal]
							and card.ability.immutable.other_side.seal
						or nil
					card:set_ability(G.P_CENTERS[card.ability.immutable.other_side], true, true)
					if not card.ability.immutable then
						card.ability.immutable = {}
					end
					card.ability.immutable.other_side = curr_abil
					card.ability.immutable.other_side.key = key
					card.ability.immutable.other_side.seal = G.P_SEALS[seal] and seal or nil
					if next(find_joker("cry-Flip Side")) then
						if card:get_other_side_dummy() then
							Card.add_to_deck(card:get_other_side_dummy(), true)
						end
					else
						card:add_to_deck(true)
					end
					card.ability.immutable.other_side.base = base
				else
					if next(find_joker("cry-Flip Side")) then
						local dummy = card:get_other_side_dummy()
						dummy.added_to_deck = true
						Card.remove_from_deck(dummy, true)
					else
						card:remove_from_deck(true)
					end
					local curr_abil = copy_table(card.ability)
					local key = card.config.center.key
					local seal = card.seal
					local base = copy_table(card.base)
					if card.ability.immutable.other_side.base then
						card.base = card.ability.immutable.other_side.base
					else
						card.base = {
							nominal = 0,
							suit_nominal = 0,
							face_nominal = 0,
							times_played = 0,
							suit_nominal_original = 0,
						}
					end
					if card.base.nominal ~= 0 then
						SMODS.change_base(card, card.base.suit, card.base.value)
					else
						if card.children.front then
							card.children.front:remove()
							card.children.front = nil
						end
					end
					card.seal = G.P_SEALS[card.ability.immutable.other_side.seal]
							and card.ability.immutable.other_side.seal
						or nil
					card:set_ability(card.ability.immutable.other_side.key, true, true)
					if card.ability.immutable.other_side then
						card.ability = copy_table(card.ability.immutable.other_side)
					end
					if not card.ability.immutable then
						card.ability.immutable = {}
					end
					card.ability.immutable.other_side = curr_abil
					card.ability.immutable.other_side.key = key
					card.ability.immutable.other_side.seal = G.P_SEALS[seal] and seal or nil
					if next(find_joker("cry-Flip Side")) then
						Card.add_to_deck(card:get_other_side_dummy(), true)
					else
						card:add_to_deck(true)
					end
					card.ability.immutable.other_side.base = base
				end
			end
		end
		function Card:get_other_side_dummy(added_to_deck)
			if self.ability.immutable and type(self.ability.immutable.other_side) == "table" then
				local tbl = {
					ability = self.ability.immutable.other_side,
					config = {
						center = G.P_CENTERS[self.ability.immutable.other_side.key],
					},
					juice_up = function(_, ...)
						return self:juice_up(...)
					end,
					start_dissolve = function(_, ...)
						return self:start_dissolve(...)
					end,
					remove = function(_, ...)
						return self:remove(...)
					end,
					flip = function(_, ...)
						return self:flip(...)
					end,
					original_card = self,
					area = self.area,
					added_to_deck = added_to_deck,
				}
				for i, v in pairs(self) do
					if type(v) == "function" and i ~= "flip_side" then
						tbl[i] = function(_, ...)
							return v(self, ...)
						end
					end
				end
				return tbl
			end
		end
		local set_editionref = Card.set_edition
		function Card:set_edition(...)
			set_editionref(self, ...)
			if self.edition and self.edition.key ~= "e_cry_double_sided" then
				if self.children.flip then
					self.children.flip:remove()
					self.children.flip = nil
				end
				if self.children.merge then
					self.children.merge:remove()
					self.children.merge = nil
				end
				self.merged = nil
				if self.ability.immutable then
					self.ability.immutable.other_side = nil
				end
			end
		end

		local no_rankref = SMODS.has_no_rank
		function SMODS.has_no_rank(card)
			if not card.base.value then
				return true
			end
			return no_rankref(card)
		end

		local no_suitref = SMODS.has_no_suit
		function SMODS.has_no_suit(card)
			if not card.base.suit then
				return true
			end
			return no_suitref(card)
		end

		-- 		local calculate_joker = Card.calculate_joker
		-- 		function Card:calculate_joker(context)
		-- 			if next(SMODS.find_card("cry-Flip Side")) and type(self.ability.immutable.other_side) ~= "string" and self.ability.immutable.other_side then
		-- 				context.dbl_side = true
		-- 				local ret = self:get_other_side_dummy()
		-- 				return calculate_joker(ret, context)
		-- 			end
		-- 			return calculate_joker(self, context)
		-- 		end

		local card_st_ref = card_eval_status_text
		function card_eval_status_text(card, ...)
			return card_st_ref(card.original_card or card, ...)
		end

		local remove_cardref = CardArea.remove_card
		function CardArea:remove_card(card, ...)
			return remove_cardref(self, card and card.original_card or card, ...)
		end

		--prevent chaos the clown's ability from being applied on debuff
		local catd = Card.add_to_deck
		local crfd = Card.remove_from_deck
		function Card:add_to_deck(debuff)
			if debuff and self.ability.name == "Chaos the Clown" then
				return
			end
			return catd(self, debuff)
		end
		function Card:remove_from_deck(debuff)
			if debuff and self.ability.name == "Chaos the Clown" then
				return
			end
			return crfd(self, debuff)
		end
		local sjw = set_joker_win
		function set_joker_win()
			sjw()
			for k, v in pairs(G.jokers.cards) do
				if
					v.ability.immutable
					and v.ability.immutable.other_side
					and type(v.ability.immutable.other_side) == "table"
					and G.P_CENTERS[v.ability.immutable.other_side.key] == "Joker"
				then
					G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key] = G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key]
						or {
							count = 1,
							order = v.dbl_side.config.center.order,
							wins = {},
							losses = {},
							wins_by_key = {},
							losses_by_key = {},
						}
					if G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key] then
						G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key].wins = G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key].wins
							or {}
						G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key].wins[G.GAME.stake] = (
							G.PROFILES[G.SETTINGS.profile].joker_usage[v.ability.immutable.other_side.key].wins[G.GAME.stake]
							or 0
						) + 1
					end
				end
			end
			G:save_settings()
		end
	end,
}

G.FUNCS.can_flip_ds = function(e)
	local card = e.config.ref_table
	if
		not (G.CONTROLLER.locked or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
		and not G.SETTINGS.paused
		and card.area.config.type ~= "shop"
	then
		e.config.colour = G.C.PURPLE
		e.config.button = "flip_ds"
		e.states.visible = true
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
		if card.area.config.type == "shop" then
			e.states.visible = false
		end
	end
end

G.FUNCS.flip_ds = function(e)
	e.config.ref_table:flip()
end

G.FUNCS.can_merge_ds = function(e)
	local card = e.config.ref_table
	local other
	for i, v in ipairs(card.area.highlighted) do
		if v ~= card then
			other = v
		end
	end
	local highlighted = #card.area.highlighted
	if
		not (G.CONTROLLER.locked or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
		and highlighted == 2
		and not G.SETTINGS.paused
		and not card.merged
		and other
		and not other.merged
		and card.area
		and card.area.config.type ~= "shop"
	then
		e.config.colour = G.C.PURPLE
		e.config.button = "merge_ds"
		e.states.visible = true
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
		e.states.visible = false
	end
end

G.FUNCS.merge_ds = function(e)
	local card = e.config.ref_table
	card.merged = true
	local other
	for i, v in ipairs(card.area.highlighted) do
		if v ~= card then
			other = v
		end
	end
	card.ability.immutable.other_side = copy_table(other.ability)
	card.ability.immutable.other_side.key = copy_table(other.config.center.key)
	card.ability.immutable.other_side.seal = copy_table(other.seal)
	if other.base.nominal ~= 0 then
		card.ability.immutable.other_side.base = copy_table(other.base)
	end
	other:start_dissolve()
	if next(find_joker("cry-Flip Side")) then
		card:remove_from_deck(true)
		Card.add_to_deck(card:get_other_side_dummy(), true)
	end
end

-- Absolute
-- Can't be sold, destroyed, Absolute can't be removed
local absolute = {
	object_type = "Sticker",
	dependencies = {
		items = {
			"set_cry_misc",
		},
	},
	badge_colour = HEX("c75985"),
	prefix_config = { key = false },
	key = "cry_absolute",
	atlas = "sticker",
	order = 3004,
	pos = { x = 1, y = 5 },
	should_apply = false,
	no_sticker_sheet = true,
	draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		G.shared_stickers["cry_absolute"].role.draw_major = card
		G.shared_stickers["cry_absolute"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		G.shared_stickers["cry_absolute"]:draw_shader(
			"polychrome",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
		G.shared_stickers["cry_absolute"]:draw_shader(
			"voucher",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
	end,
}

local miscitems = {
	meme1,
	meme2,
	meme3,
	baneful1,
	mosaic_shader,
	oversat_shader,
	glitched_shader,
	glitched_shader2,
	glitched_shaderb,
	astral_shader,
	blurred_shader,
	glass_shader,
	gold_shader,
	noisy_shader,
	glass_edition,
	gold_edition,
	glitched,
	noisy,
	mosaic,
	oversat,
	blurred,
	astral,
	echo,
	eclipse,
	blessing,
	azure_seal,
	double_sided,
	abstract,
	instability,
	absolute,
	light,
	seraph,
	jollyeditionshader,
	jollyedition,
}
return {
	name = "Misc.",
	init = function()
		-- Remove shadow from cards (e.g. Light Cards)
		local setabilityref = Card.set_ability
		function Card:set_ability(center, initial, delay_sprites)
			setabilityref(self, center, initial, delay_sprites)

			if self.config.center.cry_noshadow then
				self.ignore_shadow["cry_noshadow"] = true
			elseif self.ignore_shadow["cry_noshadow"] then
				self.ignore_shadow["cry_noshadow"] = nil
			end
		end
		function Card:calculate_abstract_break()
			if self.config.center_key == "m_cry_abstract" and not self.ability.extra.marked then
				if
					SMODS.pseudorandom_probability(
						self,
						"cry_abstract_destroy2",
						1,
						self.ability and self.ability.extra and self.ability.extra.odds_after_round
							or self.config.extra.odds_after_round
							or 4,
						"Abstract Card"
					)
				then
					self.ability.extra.marked = true
					--KUFMO HAS abstract!!!!111!!!
					G.E_MANAGER:add_event(Event({
						trigger = "immediate",
						delay = "0.1",
						func = function()
							self:juice_up(2, 2)
							self:shatter(0.2)
							return true
						end,
					}))
					return true
				else
					return false
				end
			end
			return false
		end
	end,
	items = miscitems,
}
