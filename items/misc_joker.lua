--[[
gameset_config = {
        modest = {extra = {chips = 1}, center = {rarity = 1, blueprint_compat = false, immutable = true, no_dbl = false}},
		mainline = {center = {rarity = 2, blueprint_compat = true, immutable = true, no_dbl = true}},
        madness = {extra = {chips = 100}, center = {rarity = 3}},
		cryptid_in_2025 = {extra = {chips = 1e308}, center = {rarity = "cry_exotic"}},
 },
]]
--
-- Card.get_gameset(card) ~= "modest"
local dropshot = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Dropshot",
	key = "dropshot",
	order = 3,
	config = {
		extra = {
			Xmult_mod = 0.2,
			x_mult = 1,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				Xmult_mod = 0.1,
				x_mult = 1,
			},
		},
	},
	pos = { x = 5, y = 0 },
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Xmult_mod),
				localize(
					G.GAME.current_round.cry_dropshot_card and G.GAME.current_round.cry_dropshot_card.suit or "Spades",
					"suits_singular"
				),
				number_format(center.ability.extra.x_mult),
				colours = {
					G.C.SUITS[G.GAME.current_round.cry_dropshot_card and G.GAME.current_round.cry_dropshot_card.suit or "Spades"],
				},
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			cards = 0
			for k, v in ipairs(context.scoring_hand) do
				v.cry_dropshot_incompat = true
			end
			for k, v in ipairs(context.full_hand) do
				if not v.cry_dropshot_incompat and v:is_suit(G.GAME.current_round.cry_dropshot_card.suit) then
					cards = cards + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end,
					}))
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v.cry_dropshot_incompat = nil
			end
			if cards > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "Xmult_mod",
					message_key = "a_xmult",
					message_colour = G.C.MULT,
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + scaling * cards
					end,
				})
				return nil, true
			end
		end
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "Xmult_mod",
				no_message = true,
			})
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Mystic Misclick",
			"George the Rat",
		},
		code = {
			"Math",
		},
	},
}
local happyhouse = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-happyhouse",
	key = "happyhouse",
	pos = { x = 2, y = 4 },
	order = 2,
	config = {
		immutable = {
			mult = 4,
			trigger = 114,
			check = 0,
			ante_cutoff = 8,
		},
	},
	pools = { ["Meme"] = true },
	rarity = 2,
	cost = 2,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.immutable.mult),
				number_format(center.ability.immutable.check),
				number_format(center.ability.immutable.trigger),
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.immutable.check = lenient_bignum(card.ability.immutable.check + 1)
			if
				card.ability.immutable.check == card.ability.immutable.trigger
				and G.GAME.round_resets.ante < card.ability.immutable.ante_cutoff
				and not (G.GAME.selected_back.effect.center.key == "antimatter" or G.GAME.selected_back.effect.center.key == "equilibrium")
				and (
					not CardSleeves
					or (
						CardSleeves
						and G.GAME.selected_sleeve
						and G.GAME.selected_sleeve ~= "sleeve_cry_antimatter_sleeve"
						and G.GAME.selected_sleeve ~= "sleeve_cry_equilibrium_sleeve"
					)
				)
			then --Yes, the cut off point is boss blind Ante 7. I'm evil >:3.
				check_for_unlock({ type = "home_realtor" })
			end
			if card.ability.immutable.check < card.ability.immutable.trigger then --Hardcoded, dont want misprint to mess with this hehe
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = number_format(card.ability.immutable.check) .. "/" .. number_format(
							card.ability.immutable.trigger
						),
						colour = G.C.DARK_EDITION,
					}),
				}
			end
		end
		if
			context.joker_main
			and (to_big(card.ability.immutable.mult) > to_big(1))
			and to_big(card.ability.immutable.check) > to_big(card.ability.immutable.trigger)
		then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.immutable.mult) },
				}),
				Emult_mod = lenient_bignum(card.ability.immutable.mult),
				colour = G.C.DARK_EDITION,
				card = card,
			}
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.immutable.mult) },
				}),
				Emult_mod = lenient_bignum(card.ability.immutable.mult),
				colour = G.C.DARK_EDITION,
				card = card,
			}
		end
	end,
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
}
local maximized = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Maximized",
	key = "maximized",
	pos = { x = 5, y = 2 },
	rarity = 3,
	order = 13,
	cost = 11,
	immutable = true,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"Gold",
		},
		art = {
			"George The Rat",
		},
		code = {
			"Math",
		},
	},
	init = function(self)
		local cgi_ref = Card.get_id
		override_maximized = false
		function Card:get_id()
			local id = cgi_ref(self)
			if id == nil then
				id = 10
			end
			if next(find_joker("cry-Maximized")) and not override_maximized then
				if id >= 2 and id <= 10 then
					id = 10
				end
				if id >= 11 and id <= 13 or next(find_joker("Pareidolia")) then
					id = 13
				end
			end
			return id
		end
		--Fix issues with View Deck and Maximized
		local gui_vd = G.UIDEF.view_deck
		function G.UIDEF.view_deck(unplayed_only)
			override_maximized = true
			local ret_value = gui_vd(unplayed_only)
			override_maximized = false
			return ret_value
		end
	end,
}
local potofjokes = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Pot of Jokes",
	key = "pot_of_jokes",
	config = {
		extra = {
			h_size = -2,
			h_mod = 1,
		},
		immutable = {
			h_added = 0,
			h_mod_max = 1000,
		},
	},
	pos = { x = 5, y = 0 },
	rarity = 3,
	order = 104,
	cost = 10,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.h_size < 0 and center.ability.extra.h_size
					or "+" .. math.min(1000, center.ability.extra.h_size),
				number_format(center.ability.extra.h_mod),
				"+" .. center.ability.immutable.h_mod_max,
			},
		}
	end,
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.individual and not context.repetition and not context.blueprint)
			or context.forcetrigger
		then
			if
				to_big(card.ability.extra.h_size) + to_big(card.ability.extra.h_mod)
				>= to_big(card.ability.immutable.h_mod_max)
			then
				card.ability.extra.h_size = card.ability.immutable.h_mod_max
				card.ability.extra.h_mod = 0

				-- Fallback for if Pot of Jokes comes into this calcuate function with large h_size
				if card.ability.immutable.h_added < card.ability.immutable.h_mod_max then
					local delta = card.ability.immutable.h_mod_max - card.ability.immutable.h_added

					G.hand:change_size(delta)

					card.ability.immutable.h_added = card.ability.immutable.h_mod_max
				end
			end

			local delta = to_number(
				math.min(
					math.max(0, card.ability.immutable.h_mod_max - card.ability.extra.h_size),
					card.ability.extra.h_mod
				)
			)

			G.hand:change_size(delta)

			card.ability.immutable.h_added = card.ability.immutable.h_added + delta

			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "h_size",
				scalar_value = "h_mod",
				message_key = "a_handsize",
			})
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(math.min(card.ability.immutable.h_mod_max, card.ability.extra.h_size))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-1 * math.min(card.ability.immutable.h_mod_max, card.ability.extra.h_size))
	end,
	cry_credits = {
		idea = {
			"Mjiojio",
		},
		art = {
			"Ein13",
		},
		code = {
			"Math",
			"BobJoe400",
		},
	},
	unlocked = false,
	check_for_unlock = function(self, args)
		if G and G.hand and G.hand.config and G.hand.config.card_limit and G.hand.config.card_limit >= 12 then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local queensgambit = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Queen's Gambit",
	key = "queens_gambit",
	pos = { x = 1, y = 0 },
	rarity = 1,
	order = 7,
	cost = 7,
	immutable = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
	end,
	atlas = "atlastwo",
	config = { extra = { type = "Straight Flush" } },
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint then
			if
				G.GAME.current_round.current_hand.handname == localize("Royal Flush", "poker_hands")
				and context.destroying_card:get_id() == 12
			then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_plus_joker"), colour = G.C.FILTER }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						local card = create_card("Joker", G.jokers, nil, 0.99, nil, nil, nil, "cry_gambit")
						card:set_edition({ negative = true })
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						return true
					end,
				}))
				return { remove = not SMODS.is_eternal(context.destroying_card) }
			end
		end
		if context.forcetrigger then
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_plus_joker"), colour = G.C.FILTER }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					local card = create_card("Joker", G.jokers, nil, 0.99, nil, nil, nil, "cry_gambit")
					card:set_edition({ negative = true })
					card:add_to_deck()
					G.jokers:emplace(card)
					card:start_materialize()
					return true
				end,
			}))
		end
	end,
	cry_credits = {
		idea = {
			"Project666",
		},
		art = {
			"Missingnumber",
		},
		code = {
			--wonder what happened to this guy
			"Thedrunkenbrick",
		},
	},
}
local wee_fib = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Wee Fibonacci",
	key = "wee_fib",
	config = {
		extra = {
			mult = 0,
			mult_mod = 3,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				mult = 0,
				mult_mod = 1,
			},
		},
	},
	pos = { x = 1, y = 5 },
	display_size = { w = 0.7 * 71, h = 0.7 * 95 },
	rarity = 3,
	cost = 9,
	order = 98,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.mult),
				number_format(center.ability.extra.mult_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and not context.blueprint then
			local rank = context.other_card:get_id()
			if rank == 14 or rank == 2 or rank == 3 or rank == 5 or rank == 8 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_mod",
					message_colour = G.C.MULT,
				})
			end
		end
		if context.joker_main and (to_big(card.ability.extra.mult) > to_big(0)) then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_mod",
				message_colour = G.C.MULT,
				no_message = true,
			})
			return {
				mult = lenient_bignum(card.ability.extra.mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"LocalThunk",
		},
		code = {
			"Math",
		},
	},
}
local whip = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-The WHIP",
	key = "whip",
	pos = { x = 5, y = 3 },
	config = {
		extra = {
			Xmult_mod = 0.5,
			x_mult = 1,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				Xmult_mod = 0.1,
				x_mult = 1,
			},
		},
	},
	rarity = 2,
	cost = 8,
	order = 15,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Xmult_mod),
				number_format(center.ability.extra.x_mult),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local two = false
			local seven = false
			local twosuits = {}
			local sevensuits = {}
			for i = 1, #context.full_hand do
				if context.full_hand[i]:get_id() == 2 or context.full_hand[i]:get_id() == 7 then
					if context.full_hand[i]:get_id() == 2 then
						if not two then
							two = true
						end
						for k, v in pairs(SMODS.Suits) do
							if context.full_hand[i]:is_suit(k, nil, true) then
								local contained = false
								for i = 1, #twosuits do
									if k == twosuits[i] then
										contained = true
									end
								end
								if not contained then
									twosuits[#twosuits + 1] = k
								end
							end
						end
					else
						if not seven then
							seven = true
						end
						for k, v in pairs(SMODS.Suits) do
							if context.full_hand[i]:is_suit(k, nil, true) then
								local contained = false
								for i = 1, #sevensuits do
									if k == sevensuits[i] then
										contained = true
									end
								end
								if not contained then
									sevensuits[#sevensuits + 1] = k
								end
							end
						end
					end
				end
				if two and seven then
					if
						(#twosuits > 1 or #sevensuits > 1)
						or (#twosuits == 1 and #sevensuits == 1 and twosuits[1] ~= sevensuits[1])
					then
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = "x_mult",
							scalar_value = "Xmult_mod",
							message_key = "a_xmult",
							message_colour = G.C.MULT,
						})
						return nil, true
					end
				end
			end
		end
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.force_trigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "Xmult_mod",
				no_message = true,
			})
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Gold",
		},
		art = {
			"Ein13",
		},
		code = {
			"Math",
		},
	},
}
local lucky_joker = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Lucky Joker",
	key = "lucky_joker",
	config = { extra = { dollars = 5 } },
	gameset_config = {
		modest = {
			extra = {
				dollars = 4,
			},
		},
	},
	pos = { x = 4, y = 3 },
	rarity = 1,
	cost = 4,
	order = 36,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	enhancement_gate = "m_lucky",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
		return { vars = { center.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.other_card.lucky_trigger then
			G.GAME.dollar_buffer = lenient_bignum((G.GAME.dollar_buffer or 0) + card.ability.extra.dollars)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.dollar_buffer = 0
					return true
				end,
			}))
			return {
				dollars = lenient_bignum(card.ability.extra.dollars),
				card = card,
			}
		end
		if context.forcetrigger then
			return {
				dollars = lenient_bignum(card.ability.extra.dollars),
				card = card,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Ein13",
		},
		art = {
			"Jevonn",
		},
		code = {
			"WilsontheWolf",
		},
	},
}
local cursor = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Cursor",
	key = "cursor",
	config = { extra = { chips = 0, chip_mod = 8 } },
	gameset_config = {
		modest = {
			extra = {
				chips = 0,
				chip_mod = 4,
			},
		},
	},
	pos = { x = 4, y = 1 },
	rarity = 1,
	cost = 5,
	order = 5,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.chip_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.buying_card and not context.blueprint and not (context.card == card) then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_mod",
				message_key = "a_chips",
				message_colour = G.C.CHIPS,
			})
			return nil, true
		end
		if context.joker_main and (to_big(card.ability.extra.chips) > to_big(0)) then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_mod",
				message_key = "a_chips",
				message_colour = G.C.CHIPS,
			})
			return {
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Math",
		},
	},
}
local pickle = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Pickle",
	key = "pickle",
	config = {
		extra = {
			tags = 3,
			tags_mod = 1,
		},
		immutable = {
			max_tags = 20,
		},
	},
	pos = { x = 3, y = 3 },
	rarity = 2,
	order = 45,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				math.min(center.ability.immutable.max_tags, center.ability.extra.tags),
				number_format(center.ability.extra.tags_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.skip_blind or context.forcetrigger then
			for i = 1, to_number(math.min(card.ability.immutable.max_tags, card.ability.extra.tags)) do
				local tag_key = get_next_tag_key("cry_pickle")
				if tag_key == "tag_boss" then
					i = i - 1 --skip these, as they can cause bugs with pack opening from other tags
				else
					local tag = Tag(tag_key)
					if tag.name == "Orbital Tag" then
						local _poker_hands = {}
						for k, v in pairs(G.GAME.hands) do
							if v.visible then
								_poker_hands[#_poker_hands + 1] = k
							end
						end
						tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("cry_pickle_orbital"))
					end
					tag.ability.shiny = Cryptid.is_shiny()
					add_tag(tag)
				end
			end
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = card.ability.extra.tags == 1 and "a_tag" or "a_tags",
					vars = { number_format(card.ability.extra.tags) },
				})[1],
				colour = G.C.FILTER,
			})
			return nil, true
		end
		if (context.setting_blind and not context.blueprint) or context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "tags",
				scalar_value = "tags_mod",
				operation = "-",
				no_message = true,
			})
			if to_big(card.ability.extra.tags) > to_big(0) then
				if not msg or type(msg) == "string" then
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = msg or localize({
							type = "variable",
							key = card.ability.extra.tags_mod == 1 and "a_tag_minus" or "a_tags_minus",
							vars = { number_format(card.ability.extra.tags_mod) },
						})[1],
						colour = G.C.FILTER,
					})
				end
				return nil, true
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
			end
		end
	end,
	cry_credits = {
		idea = {
			"5381",
		},
		art = {
			"Mystic Misclick",
			"unexian",
		},
		code = {
			"Math",
		},
	},
}
local cube = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-Cube",
	key = "cube",
	config = { extra = { chips = 6 } },
	pos = { x = 5, y = 4 },
	pixel_size = { w = 0.1 * 71, h = 0.1 * 95 },
	rarity = 1,
	order = 11,
	cost = -27,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	pools = { ["Meme"] = true },
	source_gate = "sho",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.chips) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Ein13",
			"Math",
		},
		art = {
			"Ein13",
		},
		code = {
			"Math",
		},
	},
}
local triplet_rhythm = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Triplet Rhythm",
	key = "triplet_rhythm",
	config = { extra = { Xmult = 3 } },
	pos = { x = 0, y = 4 },
	rarity = 1,
	order = 10,
	cost = 6,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.Xmult) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.scoring_hand then
			local threes = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 3 then
					threes = threes + 1
				end
			end
			if threes == 3 then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Math",
		},
	},
}
local booster = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Booster Joker",
	key = "booster",
	config = {
		extra = { booster_slots = 1 },
		immutable = { max_slots = 25 },
	},
	pos = { x = 2, y = 0 },
	display_size = { w = 1.17 * 71, h = 1.17 * 95 },
	order = 34,
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_slots, center.ability.extra.booster_slots) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		local mod = to_number(math.min(card.ability.immutable.max_slots, card.ability.extra.booster_slots))
		SMODS.change_booster_limit(mod)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local mod = to_number(math.min(card.ability.immutable.max_slots, card.ability.extra.booster_slots))
		SMODS.change_booster_limit(-mod)
	end,
	cry_credits = {
		idea = {
			"Ein13",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Math",
		},
	},
}
local chili_pepper = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Chili Pepper",
	key = "chili_pepper",
	config = {
		extra = {
			Xmult = 1,
			Xmult_mod = 0.5,
			rounds_remaining = 8,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				Xmult = 1,
				Xmult_mod = 0.5,
				rounds_remaining = 5,
			},
		},
	},
	pos = { x = 0, y = 1 },
	rarity = 2,
	cost = 6,
	order = 48,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlastwo",
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Xmult),
				number_format(center.ability.extra.Xmult_mod),
				number_format(center.ability.extra.rounds_remaining),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and to_big(card.ability.extra.Xmult) > to_big(1) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			card.ability.extra.rounds_remaining = lenient_bignum(to_big(card.ability.extra.rounds_remaining) - 1)
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_mod",
				no_message = true,
			})
			if to_big(card.ability.extra.rounds_remaining) > to_big(0) then
				if not msg or type(msg) == "string" then
					return {
						message = msg or localize({
							type = "variable",
							key = "a_xmult",
							vars = { number_format(card.ability.extra.Xmult) },
						}),
						colour = G.C.FILTER,
					}
				end
				return nil, true
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
			end
		end
		if context.forcetrigger then
			card.ability.extra.rounds_remaining = lenient_bignum(to_big(card.ability.extra.rounds_remaining) - 1)
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_mod",
				message_key = "a_xmult",
				message_colour = G.C.MULT,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Mystic Misclick",
			"George the Rat",
		},
		code = {
			"Math",
		},
	},
}
local compound_interest = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Compound Interest",
	key = "compound_interest",
	config = {
		extra = {
			percent_mod = 3,
			percent = 12,
		},
	},
	pos = { x = 3, y = 2 },
	rarity = 3,
	order = 9,
	cost = 10,
	perishable_compat = false,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.percent),
				number_format(center.ability.extra.percent_mod),
			},
		}
	end,
	calc_dollar_bonus = function(self, card)
		if to_big(G.GAME.dollars) > to_big(0) then
			local bonus = lenient_bignum(
				math.max(0, math.floor(0.01 * to_big(card.ability.extra.percent) * (G.GAME.dollars or 1)))
			)

			local old = lenient_bignum(card.ability.extra.percent)

			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "percent",
				scalar_value = "percent_mod",
				no_message = true,
			})
			if to_big(bonus) > to_big(0) then
				return bonus
			end
		else
			return 0
		end
	end,
	cry_credits = {
		idea = {
			"Mjiojio",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Math",
		},
	},
}
local big_cube = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"j_cry_cube",
		},
	},
	name = "cry-Big Cube",
	key = "big_cube",
	joker_gate = "cry-Cube",
	config = { extra = { x_chips = 6 }, override_x_chips_check = true },
	gameset_config = {
		modest = {
			extra = {
				x_chips = 3,
			},
		},
	},
	pos = { x = 4, y = 4 },
	rarity = 1,
	order = 105,
	cost = 27,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.x_chips) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
				colour = G.C.CHIPS,
			}
		end
	end,
	in_pool = function(self)
		return #find_joker("cry-Cube", true) ~= 0
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"Math",
		},
	},
}
local eternalflame = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-eternalflame",
	key = "eternalflame",
	pos = { x = 0, y = 4 },
	config = {
		extra = {
			extra = 0.1,
			x_mult = 1,
		},
	},
	rarity = 3,
	order = 100,
	cost = 9,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.extra),
				number_format(center.ability.extra.x_mult),
			},
			key = Card.get_gameset(card) ~= "modest" and "j_cry_eternalflame2" or "j_cry_eternalflame",
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		elseif
			context.selling_card
			and (context.card.sell_cost >= 2 or Card.get_gameset(card) ~= "modest")
			and not context.blueprint
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
				message_key = "a_xmult",
				message_colour = G.C.MULT,
			})
			return nil, true
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
				message_key = "a_xmult",
				message_colour = G.C.MULT,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Dovahkiin1307",
		},
		art = {
			"Missingnumber",
			"George The Rat",
		},
		code = {
			"Jevonn",
		},
	},
}
local nice = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-Nice",
	key = "nice",
	config = {
		extra = {
			chips = 420,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				chips = 200,
			},
		},
	},
	pos = { x = 2, y = 3 },
	pools = { ["Meme"] = true },
	rarity = 3,
	cost = 6,
	order = 84,
	atlas = "atlasone",
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.chips) } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			local aaa, bbb = nil, nil
			for i = 1, #context.full_hand do
				if context.full_hand[i]:get_id() == 6 then
					aaa = true
				end
				if context.full_hand[i]:get_id() == 9 then
					bbb = true
				end
			end
			if aaa and bbb then
				return {
					message = localize({
						type = "variable",
						key = "a_chips",
						vars = { number_format(card.ability.extra.chips) },
					}),
					chip_mod = lenient_bignum(card.ability.extra.chips),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"AlexZGreat",
		},
		art = {
			"Jevonn",
		},
		code = {
			"AlexZGreat",
		},
	},
}
local seal_the_deal = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Seal The Deal",
	key = "seal_the_deal",
	config = { extra = nil },
	pos = { x = 2, y = 4 },
	rarity = 2,
	cost = 5,
	order = 101,
	immutable = true,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if
			context.after
			and (G.GAME.current_round.hands_left == 0 or next(find_joker("cry-panopticon")))
			and context.scoring_hand
			and not context.blueprint
			and not context.retrigger_joker
		then
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 1.3,
				func = function() -- i can't figure out how to split these events without making em look bad so you get this?
					for j = 1, #context.scoring_hand do
						if not context.scoring_hand[j].seal then
							context.scoring_hand[j]:set_seal(
								SMODS.poll_seal({ guaranteed = true, type_key = "sealthedeal" }),
								true,
								false
							)
							context.scoring_hand[j]:juice_up()
						end
					end
					play_sound("gold_seal", 1.2, 0.4)
					card:juice_up()
					return true
				end,
			}))
			return nil, true
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		local sealtable = { "blue", "red", "purple", "azure", "green" }
		card.ability.extra = pseudorandom_element(sealtable, pseudoseed("abc"))
		if self.discovered and not (card.area and card.area.config.collection) then
			--Gold (ULTRA RARE!!!!!!!!)
			if pseudorandom("xyz") <= 0.000001 then
				card.children.center:set_sprite_pos({ x = 6, y = 4 })
			--Others
			elseif card.ability.extra == "red" then
				card.children.center:set_sprite_pos({ x = 6, y = 0 })
			elseif card.ability.extra == "azure" then
				card.children.center:set_sprite_pos({ x = 6, y = 2 })
			elseif card.ability.extra == "purple" then
				card.children.center:set_sprite_pos({ x = 6, y = 3 })
			elseif card.ability.extra == "green" then
				card.children.center:set_sprite_pos({ x = 6, y = 1 })
			end
		end
	end,
	cry_credits = {
		idea = {
			"Zak",
		},
		art = {
			"5381",
		},
		code = {
			"AlexZGreat",
		},
	},
}
local chad = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-Chad",
	key = "chad",
	pos = { x = 0, y = 3 },
	order = 71,
	config = {
		extra = { retriggers = 2 },
		immutable = { max_retriggers = 25 },
	},
	pools = { ["Meme"] = true },
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
			if context.other_card == G.jokers.cards[1] then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
					),
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"SDM_0",
		},
		code = {
			"Math",
		},
	},
}
local jimball = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-Jimball",
	key = "jimball",
	pos = { x = 0, y = 0 },
	pixel_size = { w = 57 / 69 * 71, h = 57 / 69 * 71 },
	order = 8,
	config = {
		extra = {
			x_mult = 1,
			x_mult_mod = 0.15,
		},
	},
	pools = { ["Meme"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.x_mult_mod),
				number_format(center.ability.extra.x_mult),
			},
		}
	end,
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local reset = false
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
					reset = true
				end
			end
			if reset then
				if to_big(card.ability.extra.x_mult) > to_big(1) then
					card.ability.extra.x_mult = 1
					return {
						card = self,
						message = localize("k_reset"),
					}
				end
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "x_mult_mod",
					message_key = "a_xmult",
					message_colour = G.C.MULT,
				})
				return nil, true
			end
		end
		--Adding actual scoring because that is missing
		if context.joker_main and to_big(card.ability.extra.x_mult) > to_big(1) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "x_mult_mod",
				message_key = "a_xmult",
				message_colour = G.C.MULT,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			Cryptid.notification_overlay("jimball")
		end
	end,
	atlas = "jimball",
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"Grazzy",
			"Zakosek Artworks",
		},
		code = {
			"Math",
		},
	},
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "win" then
			local hand = nil
			for k, v in pairs(G.GAME.hands) do
				if G.GAME.hands[k].played ~= 0 then
					if not hand then
						hand = G.GAME.hands[k]
					else
						return
					end
				end
			end
			return true
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	init = function(self)
		G.FUNCS.notif_jimball = function()
			Cryptid_config.Cryptid.jimball_music = false
			G:save_settings()
			G.FUNCS:exit_overlay_menu()
			-- todo: autosave settings (Not sure if this autosaves it)
		end
	end,
}
local jimball_sprite = { --left this one on it's own atlas for obvious reasons
	object_type = "Atlas",
	key = "jimball",
	path = "j_cry_jimball.png",
	px = 71,
	py = 95,
}
local sus = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-SUS",
	key = "sus",
	pos = { x = 1, y = 3 },
	pools = { ["Meme"] = true },
	rarity = 3,
	cost = 7,
	order = 79,
	blueprint_compat = true,
	atlas = "atlasone",
	calculate = function(self, card, context)
		local function is_impostor(card)
			return card.base.value and card:get_id() == 13 and card:is_suit("Hearts")
		end
		if context.end_of_round and context.cardarea == G.jokers and #G.hand.cards >= 1 then
			local king_of_hearts_cards, destroyed_cards = {}, {}
			local chosen_card = nil
			-- use the chosen card from previous SUS activations if there are any
			-- Use a random card elsewhere
			for _, v in ipairs(G.hand.cards) do
				if v.sus then
					chosen_card = v
					break
				end
			end
			chosen_card = chosen_card or pseudorandom_element(G.hand.cards, pseudoseed("cry_sus"))
			-- For future sus activations
			chosen_card.sus = true

			-- Add Ignored cards to a table, this table will be used to destroy the cards
			-- Ignore King of Kearts and ignore the chosen card only if there are no King of Hearts
			for _, v in ipairs(G.hand.cards) do
				if is_impostor(v) then
					table.insert(king_of_hearts_cards, v)
				end
				if not SMODS.is_eternal(v) and not (v.sus and #king_of_hearts_cards == 0) and not is_impostor(v) then
					table.insert(destroyed_cards, v)
				end
			end
			-- Destroy Cards
			-- Don't destroy them if they were already destroyed though
			if not G.GAME.sus_cards then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						for i = #destroyed_cards, 1, -1 do
							local aaa = destroyed_cards[i]
							if SMODS.shatters(aaa) then
								aaa:shatter()
							else
								aaa:start_dissolve(nil, i == #destroyed_cards)
							end
						end
						return true
					end,
				}))
			end
			--Create the copied card
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.4,
				func = function()
					card:juice_up(0.3, 0.4)
					G.playing_card = (G.playing_card or 0) + 1
					--Prioritize copying King of hearts if there are any, otherwise copy the chosen card
					local to_copy = (
						#king_of_hearts_cards > 0 and pseudorandom_element(king_of_hearts_cards, pseudoseed("cry_sus2"))
					) or chosen_card
					local _c = copy_card(to_copy, nil, nil, G.playing_card)
					_c:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, _c)
					G.play:emplace(_c)
					_c:start_materialize()
					playing_card_joker_effects({ _c })
					return true
				end,
			}))

			-- use destroyed cards to Calc card removal effects
			-- not here though; doing it here would make said effects trigger multiple times
			if not G.GAME.sus_cards then
				G.GAME.sus_cards = destroyed_cards
			end
			-- SMODS.calculate_context({ remove_playing_cards = true, removed = G.GAME.sus_cards })
			return {
				message = localize("cry_sus_ex"),
				func = function()
					-- this was moved to here because of a timing issue (no bugs/odd behaviour, but looked weird)
					draw_card(G.play, G.deck, 90, "up", nil)
					playing_card_joker_effects({ _c })
				end,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Math",
		},
		art = {
			"Jevonn",
			"unexian",
		},
		code = {
			"Math",
		},
	},
}
local fspinner = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-fspinner",
	key = "fspinner",
	pos = { x = 4, y = 0 },
	config = {
		extra = {
			chips = 0,
			chip_mod = 6,
		},
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.chip_mod),
			},
		}
	end,
	rarity = 1,
	cost = 5,
	order = 77,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local play_more_than, yes = (G.GAME.hands[context.scoring_name].played or 0), false
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
					yes = true
				end
			end
			if yes then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_mod",
					message_colour = G.C.CHIPS,
				})
			end
		end
		if context.joker_main and (to_big(card.ability.extra.chips) > to_big(0)) then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_mod",
				message_key = "a_chips",
				message_colour = G.C.CHIPS,
			})
			return {
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	atlas = "atlasone",
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Lil. Mr. Slipstream",
		},
		code = {
			"Jevonn",
		},
	},
}
local waluigi = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Waluigi",
	key = "waluigi",
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	config = { extra = { Xmult = 2.5 } },
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.Xmult) } }
	end,
	rarity = 4,
	cost = 20,
	order = 87,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.ability.set == "Joker" then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"MarioFan597",
			"HexaCryonic",
		},
		code = {
			"Math",
		},
	},
}
local wario = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-wario",
	key = "wario",
	order = 88,
	pos = { x = 2, y = 3 },
	soul_pos = { x = 3, y = 3 },
	config = { extra = { money = 3 } },
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.money) } }
	end,
	calculate = function(self, card, context)
		if
			(
				context.post_trigger
				and not context.other_context.fixed_probability
				and not context.other_context.mod_probability
			) or context.forcetrigger
		then
			return {
				dollars = lenient_bignum(card.ability.extra.money),
				card = context.other_context and context.other_context.blueprint_card or context.other_card or nil,
				-- This function isn't working properly :sob:
				--[[func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							if not Talisman.config_file.disable_anims then
								(context.blueprint_card or card):juice_up(0.5, 0.5)
							end
							return true
						end,
					}))
					return true
				end,--]]
			}
		end
	end,
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	atlas = "atlasthree",
	cry_credits = {
		idea = {
			"Auto Watto",
		},
		art = {
			"MarioFan597",
		},
		code = {
			"Auto Watto",
		},
	},
}
local krustytheclown = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-krustytheclown",
	key = "krustytheclown",
	pos = { x = 3, y = 4 },
	config = {
		extra = {
			extra = 0.02,
			x_mult = 1,
		},
	},
	pools = { ["Meme"] = true },
	rarity = 2,
	order = 31,
	cost = 7,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.extra),
				number_format(center.ability.extra.x_mult),
			},
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
			})
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Izumi",
		},
		art = {
			"Jevonn",
		},
		code = {
			"Jevonn",
		},
	},
}
local blurred = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-blurred Joker",
	key = "blurred",
	pos = { x = 4, y = 4 },
	pools = { ["Meme"] = true },
	config = {
		extra = { extra_hands = 1 },
		immutable = { max_hand_size_mod = 1000 },
	},
	rarity = 1,
	cost = 4,
	order = 51,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		local aaa
		if next(SMODS.find_mod("sdm0sstuff")) then
			if G.localization.descriptions.Other.blurred_sdm0 then
				aaa = {}
				localize({ type = "other", key = "blurred_sdm0", nodes = aaa, vars = {} })
				aaa = aaa[1]
			end
		end
		return {
			vars = { math.min(center.ability.immutable.max_hand_size_mod, center.ability.extra.extra_hands) },
			main_end = aaa,
		}
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if (context.setting_blind and not (context.blueprint_card or card).getting_sliced) or context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_hands_played(
						math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.extra_hands)
					)
					card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_hands",
							vars = {
								math.min(card.ability.immutable.max_hand_size_mod, card.ability.extra.extra_hands),
							},
						}),
					})
					return true
				end,
			}))
		end
	end,
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
}
local gardenfork = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-gardenfork",
	key = "gardenfork",
	pos = { x = 0, y = 1 },
	config = { extra = { money = 7 } },
	rarity = 3,
	cost = 7,
	order = 66,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.money) } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and context.full_hand then
			local has_ace = false
			local has_7 = false
			for i = 1, #context.full_hand do
				if context.full_hand[i]:get_id() == 14 then
					has_ace = true
				elseif context.full_hand[i]:get_id() == 7 then
					has_7 = true
				end
			end
			if has_ace and has_7 then
				ease_dollars(lenient_bignum(card.ability.extra.money))
				return { message = "$" .. number_format(card.ability.extra.money), colour = G.C.MONEY }
			end
		end
		if context.forcetrigger then
			ease_dollars(lenient_bignum(card.ability.extra.money))
			return { message = "$" .. number_format(card.ability.extra.money), colour = G.C.MONEY }
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Jevonn",
		},
	},
}
local lightupthenight = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-lightupthenight",
	key = "lightupthenight",
	config = { extra = { xmult = 1.5 } },
	gameset_config = {
		modest = {
			cost = 9,
		},
	},
	pos = { x = 1, y = 1 },
	atlas = "atlasone",
	rarity = 3,
	cost = 7,
	order = 67,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			local rank = context.other_card:get_id()
			if rank == 2 or rank == 7 then
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					colour = G.C.RED,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				x_mult = lenient_bignum(card.ability.extra.xmult),
				colour = G.C.RED,
				card = card,
			}
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Jevonn",
		},
	},
}
local nosound = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-nosound",
	key = "nosound",
	config = {
		extra = { retriggers = 3 },
		immutable = { max_retriggers = 40 },
	},
	pos = { x = 2, y = 1 },
	atlas = "atlasone",
	rarity = 3,
	order = 68,
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				if context.other_card:get_id() == 7 then
					return {
						message = localize("k_again_ex"),
						repetitions = to_number(
							math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
						),
						card = card,
					}
				end
			end
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Jevonn",
		},
	},
}
local antennastoheaven = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-antennastoheaven",
	key = "antennastoheaven",
	pos = { x = 3, y = 1 },
	config = {
		extra = {
			bonus = 0.1,
			x_chips = 1,
		},
	},
	rarity = 3,
	cost = 7,
	order = 69,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.bonus),
				number_format(center.ability.extra.x_chips),
			},
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
				colour = G.C.CHIPS,
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint then
			local rank = context.other_card:get_id()
			if rank == 4 or rank == 7 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_chips",
					scalar_value = "bonus",
				})
			end
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_chips",
				scalar_value = "bonus",
				message_key = "a_xchips",
				message_colour = G.C.CHIPS,
			})
			return {
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Jevonn",
		},
	},
}
local hunger = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-hunger",
	key = "hunger",
	config = { extra = { money = 3 } },
	extra_gamesets = { "exp_modest" },
	gameset_config = {
		exp_modest = { extra = { money = 2 } },
	},
	pos = { x = 3, y = 0 },
	rarity = 2,
	cost = 6,
	order = 80,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlastwo",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.money) } }
	end,
	calculate = function(self, card, context) -- haha one liner
		return (context.using_consumeable or context.forcetrigger)
			and { p_dollars = lenient_bignum(card.ability.extra.money) }
	end,
	cry_credits = {
		idea = {
			"Mjiojio",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"Jevonn",
		},
	},
}
local weegaming = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-weegaming",
	key = "weegaming",
	order = 62,
	config = {
		extra = { retriggers = 2 },
		immutable = { max_retriggers = 25 },
	},
	pos = { x = 3, y = 4 },
	atlas = "atlastwo",
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				if context.other_card:get_id() == 2 then
					return {
						message = localize("k_again_ex"),
						repetitions = to_number(
							math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
						),
						card = card,
					}
				end
			end
		end
	end,
	cry_credits = {
		idea = {
			"Gold",
		},
		art = {
			"Mystic Misclick",
		},
		code = {
			"Jevonn",
		},
	},
}
local redbloon = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-redbloon",
	key = "redbloon",
	config = {
		extra = {
			money = 20,
			rounds_remaining = 2,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				money = 20,
				rounds_remaining = 3,
			},
		},
	},
	pos = { x = 5, y = 1 },
	rarity = 1,
	cost = 4,
	order = 97,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.money),
				number_format(center.ability.extra.rounds_remaining),
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			card.ability.extra.rounds_remaining = lenient_bignum(to_big(card.ability.extra.rounds_remaining) - 1)
			if to_big(card.ability.extra.rounds_remaining) > to_big(0) then
				return {
					message = { localize("cry_minus_round") },
					colour = G.C.FILTER,
				}
			else
				ease_dollars(lenient_bignum(card.ability.extra.money))
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = "$" .. number_format(card.ability.extra.money),
					colour = G.C.MONEY,
				}
			end
		end
		if context.forcetrigger then
			ease_dollars(lenient_bignum(card.ability.extra.money))
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return {
				message = "$" .. number_format(card.ability.extra.money),
				colour = G.C.MONEY,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Roguefort Cookie",
		},
		art = {
			"Darren_The_Frog",
		},
		code = {
			"Jevonn",
		},
	},
}
local apjoker = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-AP Joker",
	key = "apjoker",
	pos = { x = 2, y = 0 },
	config = { extra = { x_mult = 4 } },
	rarity = 2,
	cost = 6,
	order = 37,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.x_mult) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main and G.GAME.blind.boss) or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"unexian",
		},
		code = {
			"Jevonn",
		},
	},
}
local maze = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-maze",
	key = "maze",
	pos = { x = 1, y = 1 },
	rarity = 1,
	cost = 1,
	order = 61,
	immutable = true,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"zy-b-org",
		},
		art = {
			"Math",
		},
		code = {
			"Jevonn",
		},
	},
}
--Fixed Jank for the most part. Other modded jokers may still be jank depending on how they are implemented
--funny side effect of this fix causes trading card and dna to juice up like craaazy lol
local panopticon = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-panopticon",
	key = "panopticon",
	pos = { x = 1, y = 4 },
	config = {
		extra = {},
	},
	rarity = 1,
	order = 47,
	cost = 1,
	immutable = true,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.before and not context.blueprint and not context.retrigger_joker then
			if not G.GAME.cry_panop_juggle then
				G.GAME.cry_panop_juggle = G.GAME.current_round.hands_left
			end
			G.GAME.current_round.hands_left = 0
		end
		if context.after and not context.blueprint and not context.retrigger_joker then
			if G.GAME.cry_panop_juggle then
				G.GAME.current_round.hands_left = G.GAME.cry_panop_juggle
				G.GAME.cry_panop_juggle = nil
			end
		end
	end,
	cry_credits = {
		idea = {
			"Samario",
		},
		art = {
			"Samario",
		},
		code = {
			"Samario",
			"Toneblock",
		},
	},
}
local magnet = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-magnet",
	key = "magnet",
	pos = { x = 4, y = 0 },
	pixel_size = { w = 35, h = 35 },
	config = {
		extra = {
			money = 2,
			Xmoney = 5,
			slots = 4,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				money = 2,
				Xmoney = 3,
				slots = 3,
			},
		},
	},
	rarity = 1,
	cost = 6,
	order = 96,
	blueprint_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.money),
				number_format(center.ability.extra.Xmoney),
				number_format(center.ability.extra.slots),
			},
		}
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.forcetrigger then
			ease_dollars(lenient_bignum(to_big(card.ability.extra.money) * card.ability.extra.Xmoney))
		end
	end,
	calc_dollar_bonus = function(self, card)
		if to_big(#G.jokers.cards) <= to_big(card.ability.extra.slots) then
			return lenient_bignum(to_big(card.ability.extra.money) * card.ability.extra.Xmoney)
		else
			return lenient_bignum(card.ability.extra.money)
		end
	end,
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
}
local unjust_dagger = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Unjust Dagger",
	key = "unjust_dagger",
	pos = { x = 3, y = 0 },
	config = { extra = { x_mult = 1 } },
	rarity = 2,
	cost = 8,
	order = 102,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.x_mult) } }
	end,
	atlas = "atlasone",
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
		local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if
			context.setting_blind
			and not card.getting_sliced
			and not context.blueprint
			and my_pos
			and G.jokers.cards[my_pos - 1]
			and not SMODS.is_eternal(G.jokers.cards[my_pos - 1])
			and not G.jokers.cards[my_pos - 1].getting_sliced
		then
			local sliced_card = G.jokers.cards[my_pos - 1]
			sliced_card.getting_sliced = true
			if sliced_card.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_table = sliced_card,
				scalar_value = "sell_cost",
				operation = function(ref_table, ref_value, initial, scaling)
					ref_table[ref_value] = initial + 0.2 * scaling
				end,
				scaling_message = {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { card.ability.extra.x_mult + 0.2 * sliced_card.sell_cost },
					}),
					colour = G.C.MULT,
					no_juice = true,
				},
			})
			return nil, true
		end
		if context.forcetrigger then
			if
				my_pos
				and G.jokers.cards[my_pos - 1]
				and not SMODS.is_eternal(G.jokers.cards[my_pos - 1])
				and not G.jokers.cards[my_pos - 1].getting_sliced
			then
				local sliced_card = G.jokers.cards[my_pos - 1]
				sliced_card.getting_sliced = true
				if sliced_card.config.center.rarity == "cry_exotic" then
					check_for_unlock({ type = "what_have_you_done" })
				end
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound("slice1", 0.96 + math.random() * 0.08)
						return true
					end,
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_table = sliced_card,
					scalar_value = "sell_cost",
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + 0.2 * scaling
					end,
					scaling_message = {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = { card.ability.extra.x_mult + 0.2 * sliced_card.sell_cost },
						}),
						colour = G.C.MULT,
						no_juice = true,
					},
				})
			end
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Mystic Misclick",
		},
		code = {
			"Mystic Misclick",
		},
	},
}
local monkey_dagger = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Monkey Dagger",
	key = "monkey_dagger",
	pos = { x = 4, y = 3 },
	config = { extra = { chips = 0 } },
	rarity = 2,
	cost = 6,
	order = 49,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.chips) } }
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.chips) > to_big(0)) then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
		local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if
			context.setting_blind
			and not card.getting_sliced
			and not context.blueprint
			and my_pos
			and G.jokers.cards[my_pos - 1]
			and not SMODS.is_eternal(G.jokers.cards[my_pos - 1])
			and not G.jokers.cards[my_pos - 1].getting_sliced
		then
			local sliced_card = G.jokers.cards[my_pos - 1]
			sliced_card.getting_sliced = true
			if sliced_card.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_table = sliced_card,
				scalar_value = "sell_cost",
				operation = function(ref_table, ref_value, initial, scaling)
					ref_table[ref_value] = initial + 10 * scaling
				end,
				scaling_message = {
					message = localize({
						type = "variable",
						key = "a_chips",
						vars = { card.ability.extra.chips + 10 * sliced_card.sell_cost },
					}),
					colour = G.C.CHIPS,
					no_juice = true,
				},
			})
			return nil, true
		end
		if context.forcetrigger then
			if
				my_pos
				and G.jokers.cards[my_pos - 1]
				and not SMODS.is_eternal(G.jokers.cards[my_pos - 1])
				and not G.jokers.cards[my_pos - 1].getting_sliced
			then
				local sliced_card = G.jokers.cards[my_pos - 1]
				sliced_card.getting_sliced = true
				if sliced_card.config.center.rarity == "cry_exotic" then
					check_for_unlock({ type = "what_have_you_done" })
				end
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound("slice1", 0.96 + math.random() * 0.08)
						return true
					end,
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_table = sliced_card,
					scalar_value = "sell_cost",
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + 10 * scaling
					end,
					scaling_message = {
						message = localize({
							type = "variable",
							key = "a_chips",
							vars = { card.ability.extra.chips + 10 * sliced_card.sell_cost },
						}),
						colour = G.C.CHIPS,
						no_juice = true,
					},
				})
			end
			return {
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Mystic Misclick",
		},
		code = {
			"Mystic Misclick",
		},
	},
}
local pirate_dagger = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Pirate Dagger",
	key = "pirate_dagger",
	pos = { x = 3, y = 3 },
	config = { extra = { x_chips = 1 } },
	rarity = 2,
	cost = 8,
	order = 103,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.x_chips) } }
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
			}
		end
		local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if
			context.setting_blind
			and not card.getting_sliced
			and not context.blueprint
			and my_pos
			and G.jokers.cards[my_pos + 1]
			and not SMODS.is_eternal(G.jokers.cards[my_pos + 1])
			and not G.jokers.cards[my_pos + 1].getting_sliced
		then
			local sliced_card = G.jokers.cards[my_pos + 1]
			sliced_card.getting_sliced = true
			if sliced_card.config.center.rarity == "cry_exotic" then
				check_for_unlock({ type = "what_have_you_done" })
			end
			G.GAME.joker_buffer = G.GAME.joker_buffer - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = 0
					card:juice_up(0.8, 0.8)
					sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
					play_sound("slice1", 0.96 + math.random() * 0.08)
					return true
				end,
			}))
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_chips",
				scalar_table = sliced_card,
				scalar_value = "sell_cost",
				operation = function(ref_table, ref_value, initial, scaling)
					ref_table[ref_value] = initial + 0.25 * scaling
				end,
				scaling_message = {
					message = localize({
						type = "variable",
						key = "a_xchips",
						vars = { card.ability.extra.x_chips + 0.25 * sliced_card.sell_cost },
					}),
					colour = G.C.CHIPS,
					no_juice = true,
				},
			})
			return nil, true
		end
		if context.forcetrigger then
			if
				my_pos
				and G.jokers.cards[my_pos + 1]
				and not SMODS.is_eternal(G.jokers.cards[my_pos + 1])
				and not G.jokers.cards[my_pos + 1].getting_sliced
			then
				local sliced_card = G.jokers.cards[my_pos + 1]
				sliced_card.getting_sliced = true
				if sliced_card.config.center.rarity == "cry_exotic" then
					check_for_unlock({ type = "what_have_you_done" })
				end
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound("slice1", 0.96 + math.random() * 0.08)
						return true
					end,
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_chips",
					scalar_table = sliced_card,
					scalar_value = "sell_cost",
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + 0.25 * scaling
					end,
					scaling_message = {
						message = localize({
							type = "variable",
							key = "a_xchips",
							vars = { card.ability.extra.x_chips + 0.25 * sliced_card.sell_cost },
						}),
						colour = G.C.CHIPS,
						no_juice = true,
					},
				})
			end
			return {
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Mystic Misclick",
		},
		code = {
			"Mystic Misclick",
		},
	},
}
local mondrian = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-mondrian",
	key = "mondrian",
	pos = { x = 5, y = 3 },
	config = {
		extra = {
			extra = 0.25,
			x_mult = 1,
		},
	},
	rarity = 2,
	cost = 7,
	order = 44,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.extra),
				number_format(center.ability.extra.x_mult),
			},
		}
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
		if
			context.end_of_round
			and G.GAME.current_round.discards_used == 0
			and not context.blueprint
			and not context.individual
			and not context.repetition
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
			})
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
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
}
local sapling = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-sapling",
	key = "sapling",
	pos = { x = 3, y = 2 }, --todo animations
	config = {
		extra = {
			req = 18,
			check = nil,
		},
		immutable = { score = 0 },
	},
	rarity = 2,
	cost = 6,
	order = 42,
	blueprint_compat = false,
	eternal_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.immutable.score),
				number_format(center.ability.extra.req),
				Cryptid.enabled("set_cry_epic") == true and localize("k_cry_epic") or localize("k_rare"),
				colours = { G.C.RARITY[Cryptid.enabled("set_cry_epic") == true and "cry_epic" or 3] },
				Cryptid.enabled("set_cry_epic") == true and localize("cry_sapling_an") or localize("cry_sapling_a"),
			},
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and not context.blueprint
			and not context.retrigger_joker
		then
			if context.other_card.ability.effect ~= "Base" then
				card.ability.immutable.score = lenient_bignum(card.ability.immutable.score + 1)
				if
					to_big(card.ability.immutable.score) >= to_big(card.ability.extra.req)
					and not card.ability.extra.check
				then
					card.ability.extra.check = true --Prevents violent juice up spam when playing enchanced cards while already active
					local eval = function(card)
						return not card.REMOVED
					end
					juice_card_until(card, eval, true)
				end
			end
		elseif context.selling_self and not context.blueprint and not context.retrigger_joker then
			if to_big(card.ability.immutable.score) >= to_big(card.ability.extra.req) then
				local value = Cryptid.enabled("set_cry_epic") == true and "cry_epic" or 0.99
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_plus_joker"), colour = G.C.RARITY["cry_epic"] }
				)
				local card = create_card("Joker", G.jokers, nil, value, nil, nil, nil, "cry_sapling")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:start_materialize()
				return nil, true
			else
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_nope_ex"), colour = G.C.RARITY["cry_epic"] }
				)
			end
		end
		if context.forcetrigger then
			card.ability.immutable.score = lenient_bignum(card.ability.immutable.score + 1)
			local value = Cryptid.enabled("set_cry_epic") == true and "cry_epic" or 0.99
			card_eval_status_text(
				card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_plus_joker"), colour = G.C.RARITY["cry_epic"] }
			)
			local card = create_card("Joker", G.jokers, nil, value, nil, nil, nil, "cry_sapling")
			card:add_to_deck()
			G.jokers:emplace(card)
			card:start_materialize()
		end
	end,
	cry_credits = {
		idea = {
			"Mjiojio",
		},
		art = {
			"Jevonn",
			"George the Rat",
		},
		code = {
			"Jevonn",
		},
	},
}
local spaceglobe = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-spaceglobe",
	key = "spaceglobe",
	pos = { x = 1, y = 4 },
	config = {
		extra = {
			x_chips = 1,
			Xchipmod = 0.2,
			type = "High Card",
		},
	},
	rarity = 3,
	cost = 8,
	order = 73,
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.x_chips),
				number_format(center.ability.extra.Xchipmod),
				localize(center.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasone",
	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then
				_poker_hands[#_poker_hands + 1] = k
			end
		end
		card.ability.extra.type = pseudorandom_element(
			_poker_hands,
			pseudoseed(
				(card.area and card.area.config.type == "title") and "false_cry_space_globe" or "cry_space_globe"
			)
		)
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if context.scoring_name == card.ability.extra.type then
				G.E_MANAGER:add_event(Event({
					func = function()
						local _type = {}
						for k, v in pairs(G.GAME.hands) do
							if v.visible and k ~= card.ability.extra.type then
								_type[#_type + 1] = k
							end
						end
						card.ability.extra.type = pseudorandom_element(_type, pseudoseed("cry_space_globe"))
						return true
					end,
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_chips",
					scalar_value = "Xchipmod",
					message_colour = G.C.CHIPS,
				})
			end
		end
		if context.joker_main and (to_big(card.ability.extra.x_chips) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xchips",
					vars = { number_format(card.ability.extra.x_chips) },
				}),
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
				colour = G.C.CHIPS,
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_chips",
				scalar_value = "Xchipmod",
				message_key = "a_xchips",
				message_colour = G.C.CHIPS,
			})
			return {
				Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Selicre",
		},
		code = {
			"Jevonn",
		},
	},
}
local happy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-happy",
	key = "happy",
	pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 2,
	gameset_config = {
		modest = {
			cost = 5,
		},
	},
	order = 63,
	immutable = true,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.selling_self and #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit then
			local sellcreatejoker = 1
			G.GAME.joker_buffer = G.GAME.joker_buffer + sellcreatejoker
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, sellcreatejoker do
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "happy")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_plus_joker"), colour = G.C.BLUE }
			)
			return nil, true
		end
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		then
			local roundcreatejoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + roundcreatejoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if roundcreatejoker > 0 then
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "happy")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_plus_joker"), colour = G.C.BLUE }
			)
			return nil, true
		end
		if context.forcetrigger then
			local roundcreatejoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + roundcreatejoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if roundcreatejoker > 0 then
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "happy")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
		end
	end,
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
}
local meteor = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-meteor",
	key = "meteor",
	pos = { x = 0, y = 2 },
	config = { extra = { chips = 75 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.foil) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		end
		return { vars = { number_format(center.ability.extra.chips) } }
	end,
	rarity = 1,
	cost = 4,
	order = 38,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.foil == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.chips) },
				}),
				chip_mod = lenient_bignum(card.ability.extra.chips),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.foil == true then
				return {
					chips = lenient_bignum(card.ability.extra.chips),
					colour = G.C.CHIPS,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.foil == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					chips = lenient_bignum(card.ability.extra.chips), --this doesn't exist yet :pensive: if only...
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				chips = lenient_bignum(card.ability.extra.chips),
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Jevonn",
		},
	},
}
local exoplanet = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-exoplanet",
	key = "exoplanet",
	pos = { x = 1, y = 2 },
	config = { extra = { mult = 15 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.holo) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		end
		return { vars = { number_format(center.ability.extra.mult) } }
	end,
	rarity = 1,
	order = 39,
	cost = 3,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.holo == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.holo == true then
				return {
					mult = lenient_bignum(card.ability.extra.mult),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.holo == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					h_mult = lenient_bignum(card.ability.extra.mult),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				mult = lenient_bignum(card.ability.extra.mult),
				colour = G.C.MULT,
				card = card,
			}
		end
	end,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Jevonn",
		},
	},
}
local stardust = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-stardust",
	key = "stardust",
	pos = { x = 2, y = 2 },
	config = { extra = { xmult = 2 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.polychrome) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		end
		return { vars = { number_format(center.ability.extra.xmult) } }
	end,
	rarity = 1,
	cost = 2,
	order = 40,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.polychrome == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.xmult),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.polychrome == true then
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.polychrome == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				x_mult = lenient_bignum(card.ability.extra.xmult),
				colour = G.C.MULT,
				card = card,
			}
		end
	end,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Jevonn",
		},
	},
}
local rnjoker = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-rnjoker Joker", --:balatrojoker:
	key = "rnjoker",
	pos = { x = 5, y = 4 },
	config = {},
	order = 59,
	loc_vars = function(self, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card and card.ability.extra.cond_value or 0, "RNJoker")
		local vars = {
			vars = {
				(card.ability.extra and card.ability.extra.value_mod and card.ability.extra.value) or 0,
				(card.ability.extra and card.ability.extra.value and card.ability.extra.value_mod)
					or (card.ability.extra and card.ability.extra.value)
					or 0,
				card.ability.extra and card.ability.extra.cond_value or 0,
				num,
			},
		}
		if card.ability.extra and card.ability.extra.color then
			vars.vars.colours = { card.ability.extra.color }
		end
		return vars
	end,
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	immutable = true,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.abilities = {}
		Cryptid.rnjoker_randomize(card)
	end,
	calculate = function(self, card, context)
		if card.ability and card.ability.abilities then
			for i, j in ipairs(card.ability.abilities) do
				local j_context = j.context
				local indiv = false
				if j_context ~= "cry_payout" then
					local valid_context = not not context[j.context]
					if j.scale_value and context.blueprint then
						valid_context = false
					end
					if (j_context == "playing_card_added") and card.getting_sliced then
						valid_context = false
					end
					if (j_context == "setting_blind") and card.getting_sliced then
						valid_context = false
					end
					if (j_context == "before") and (card.area ~= G.jokers) then
						valid_context = false
					end
					if (j_context == "after") and (card.area ~= G.jokers) then
						valid_context = false
					end
					if (j_context == "joker_main") and (card.area ~= G.jokers) then
						valid_context = false
					end
					if (j_context == "end_of_round") and (context.repetition or context.individual) then
						valid_context = false
					end
					if
						(j_context == "individual_play")
						and context.individual
						and not context.repetition
						and (context.cardarea == G.play)
					then
						valid_context = true
						indiv = true
					end
					if
						(j_context == "individual_hand_score")
						and context.individual
						and not context.repetition
						and (context.cardarea == G.hand)
						and not context.end_of_round
					then
						valid_context = true
						indiv = true
					end
					if
						(j_context == "individual_hand_end")
						and context.individual
						and not context.repetition
						and (context.cardarea == G.hand and context.end_of_round)
					then
						valid_context = true
						indiv = true
					end
					if (j_context == "repetition_play") and context.repetition and (context.cardarea == G.play) then
						valid_context = true
					end
					if (j_context == "repetition_hand") and context.repetition and (context.cardarea == G.hand) then
						valid_context = true
					end
					if valid_context then
						local cond_passed = false
						local times_passed = 1
						if j_context == "playing_card_added" and context.cards and context.cards[1] then
							times_passed = #context.cards
						end
						if j.cond then
							if j.cond == "buy_common" then
								if
									context.card
									and context.card.ability
									and (context.card.ability.set == "Joker")
									and (context.card.config.center.rarity == 1)
								then
									cond_passed = true
								end
							elseif j.cond == "buy_uncommon" then
								if
									context.card
									and context.card.ability
									and (context.card.ability.set == "Joker")
									and (context.card.config.center.rarity == 2)
								then
									cond_passed = true
								end
							elseif j.cond == "tarot" then
								local card = context.card or context.consumeable
								if card and card.ability and (card.ability.set == "Tarot") then
									cond_passed = true
								end
							elseif j.cond == "planet" then
								local card = context.card or context.consumeable
								if card and card.ability and (card.ability.set == "Planet") then
									cond_passed = true
								end
							elseif j.cond == "spectral" then
								local card = context.card or context.consumeable
								if card and card.ability and (card.ability.set == "Spectral") then
									cond_passed = true
								end
							elseif j.cond == "joker" then
								if context.card and context.card.ability and (context.card.ability.set == "Joker") then
									cond_passed = true
								end
							elseif j.cond == "suit" then
								times_passed = 0
								local cards = context.cards
								if cards == nil then
									cards = context.removed
								end
								if cards == nil then
									cards = { context.other_card }
								end
								for i2, j2 in ipairs(cards) do
									if j2:is_suit(j.suit) then
										cond_passed = true
										times_passed = times_passed + 1
									end
								end
							elseif j.cond == "rank" then
								times_passed = 0
								local cards = context.cards
								if cards == nil then
									cards = context.removed
								end
								if cards == nil then
									cards = { context.other_card }
								end
								for i2, j2 in ipairs(cards) do
									if j2:get_id() == j.rank then
										cond_passed = true
										times_passed = times_passed + 1
									end
								end
							elseif j.cond == "face" then
								times_passed = 0
								local cards = context.cards
								if cards == nil then
									cards = context.removed
								end
								if cards == nil then
									cards = { context.other_card }
								end
								for i2, j2 in ipairs(cards) do
									if j2:is_face() then
										cond_passed = true
										times_passed = times_passed + 1
									end
								end
							elseif j.cond == "boss" then
								if context.blind.boss and not (context.blind.config and context.blind.config.bonus) then
									cond_passed = true
								end
							elseif j.cond == "non_boss" then
								if context.blind and not G.GAME.blind.boss then
									cond_passed = true
								end
							elseif j.cond == "small" then
								if context.blind == G.P_BLINDS.bl_small then
									cond_passed = true
								end
							elseif j.cond == "big" then
								if context.blind == G.P_BLINDS.bl_big then
									cond_passed = true
								end
							elseif j.cond == "first" then
								if G.GAME.current_round.hands_played == 0 then
									cond_passed = true
								end
							elseif j.cond == "last" then
								if G.GAME.current_round.hands_left == 0 then
									cond_passed = true
								end
							elseif j.cond == "common" then
								if context.other_joker.config.center.rarity == 1 then
									cond_passed = true
								end
							elseif j.cond == "uncommon" then
								if context.other_joker.config.center.rarity == 2 then
									cond_passed = true
								end
							elseif j.cond == "rare" then
								if context.other_joker.config.center.rarity == 3 then
									cond_passed = true
								end
							elseif j.cond == "poker_hand" then
								if context.poker_hands ~= nil and next(context.poker_hands[j.poker_hand]) then
									cond_passed = true
								end
							elseif j.cond == "or_more" then
								if #context.full_hand >= j.cond_value then
									cond_passed = true
								end
							elseif j.cond == "or_less" then
								if #context.full_hand <= j.cond_value then
									cond_passed = true
								end
							elseif j.cond == "hands_left" then
								if G.GAME.current_round.hands_left == j.cond_value then
									cond_passed = true
								end
							elseif j.cond == "discards_left" then
								if G.GAME.current_round.discards_left == j.cond_value then
									cond_passed = true
								end
							elseif j.cond == "first_discard" then
								if G.GAME.current_round.discards_used <= 0 then
									cond_passed = true
								end
							elseif j.cond == "last_discard" then
								if G.GAME.current_round.discards_left <= 1 then
									cond_passed = true
								end
							elseif j.cond == "odds" then
								if j_context == "playing_card_added" and context.cards and context.cards[1] then
									for i = 1, #context.cards do
										if
											SMODS.pseudorandom_probability(
												card,
												"rnj",
												1,
												card and card.ability.extra.cond_value or 0,
												"RNJoker"
											)
										then
										else
											times_passed = math.max(0, times_passed - 1)
										end
									end
									if times_passed == 0 then
										cond_passed = false
									else
										cond_passed = true
									end
								else
									if
										SMODS.pseudorandom_probability(
											card,
											"rnj",
											1,
											card and card.ability.extra.cond_value or 0,
											"RNJoker"
										)
									then
										cond_passed = true
									end
								end
							end
						else
							cond_passed = true
						end
						if cond_passed then
							if j.context == "other_joker" then
								local stats = {
									plus_mult = "a_mult",
									plus_chips = "a_chips",
									x_mult = "a_xmult",
									x_chips = "a_xchips",
								}
								local mods = {
									plus_chips = "chip_mod",
									plus_mult = "mult_mod",
									x_mult = "Xmult_mod",
									x_chips = "Xchip_mod",
								}
								local table = {}
								table.message = localize({
									type = "variable",
									key = stats[j.stat],
									vars = {
										card.ability.extra.value,
									},
								})
								table[mods[j.stat]] = card.ability.extra.value
								table.card = card
								G.E_MANAGER:add_event(Event({
									func = function()
										context.other_joker:juice_up(0.5, 0.5)
										return true
									end,
								}))
								return table
							elseif (j.context == "repetition_play") or (j.context == "repetition_hand") then
								return {
									message = localize("k_again_ex"),
									repetitions = 1,
									card = card,
								}
							elseif j.scale_value then
								card.ability.extra.value = card.ability.extra.value
									+ (card.ability.extra.value_mod * times_passed)
								card_eval_status_text(
									card,
									"extra",
									nil,
									nil,
									nil,
									{ message = localize("k_upgrade_ex") }
								)
								if j.stat == "h_size" then
									G.hand:change_size(card.ability.extra.value_mod)
								end
							elseif j.act then
								local j_mod = 0
								if j.context == "selling_self" and (card.ability.set == "Joker") then
									j_mod = 1
								end
								if j.context == "selling_card" and (context.card.ability.set == "Joker") then
									j_mod = 1
								end
								local c_mod = 0
								if j.context == "selling_self" and card.ability.consumeable then
									c_mod = 1
								end
								if j.context == "selling_card" and card.ability.consumeable then
									c_mod = 1
								end
								if j.act == "make_joker" then
									local amount = card.ability.extra.value * times_passed
									if
										(G.jokers.config.card_limit + j_mod - #G.jokers.cards - G.GAME.joker_buffer)
										< amount
									then
										amount = G.jokers.config.card_limit
											+ j_mod
											- #G.jokers.cards
											- G.GAME.joker_buffer
									end
									if amount > 0 then
										G.GAME.joker_buffer = G.GAME.joker_buffer + amount
										G.E_MANAGER:add_event(Event({
											trigger = "before",
											delay = 0.0,
											func = function()
												for i = 1, amount do
													if G.jokers.config.card_limit + j_mod > #G.jokers.cards then
														local card = create_card(
															"Joker",
															G.jokers,
															nil,
															nil,
															nil,
															nil,
															nil,
															"rnj"
														)
														card:add_to_deck()
														G.jokers:emplace(card)
													else
														break
													end
												end
												G.GAME.joker_buffer = 0
												return true
											end,
										}))
									end
								elseif j.act == "make_tarot" then
									local amount = card.ability.extra.value * times_passed
									if
										(
											G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
										) < amount
									then
										amount = G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
									end
									if amount > 0 then
										G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + amount
										G.E_MANAGER:add_event(Event({
											trigger = "before",
											delay = 0.0,
											func = function()
												for i = 1, amount do
													if
														G.consumeables.config.card_limit + c_mod
														> #G.consumeables.cards
													then
														local card = create_card(
															"Tarot",
															G.consumeables,
															nil,
															nil,
															nil,
															nil,
															nil,
															"rnj"
														)
														card:add_to_deck()
														G.consumeables:emplace(card)
													else
														break
													end
												end
												G.GAME.consumeable_buffer = 0
												return true
											end,
										}))
									end
								elseif j.act == "make_planet" then
									local amount = card.ability.extra.value * times_passed
									if
										(
											G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
										) < amount
									then
										amount = G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
									end
									if amount > 0 then
										G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + amount
										G.E_MANAGER:add_event(Event({
											trigger = "before",
											delay = 0.0,
											func = function()
												for i = 1, amount do
													if
														G.consumeables.config.card_limit + c_mod
														> #G.consumeables.cards
													then
														local card = create_card(
															"Planet",
															G.consumeables,
															nil,
															nil,
															nil,
															nil,
															nil,
															"rnj"
														)
														card:add_to_deck()
														G.consumeables:emplace(card)
													else
														break
													end
												end
												G.GAME.consumeable_buffer = 0
												return true
											end,
										}))
									end
								elseif j.act == "make_spectral" then
									local amount = card.ability.extra.value * times_passed
									if
										(
											G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
										) < amount
									then
										amount = G.consumeables.config.card_limit
											+ c_mod
											- #G.consumeables.cards
											- G.GAME.consumeable_buffer
									end
									if amount > 0 then
										G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + amount
										G.E_MANAGER:add_event(Event({
											trigger = "before",
											delay = 0.0,
											func = function()
												for i = 1, amount do
													if
														G.consumeables.config.card_limit + c_mod
														> #G.consumeables.cards
													then
														local card = create_card(
															"Spectral",
															G.consumeables,
															nil,
															nil,
															nil,
															nil,
															nil,
															"rnj"
														)
														card:add_to_deck()
														G.consumeables:emplace(card)
													else
														break
													end
												end
												G.GAME.consumeable_buffer = 0
												return true
											end,
										}))
									end
								elseif j.act == "add_dollars" then
									ease_dollars(card.ability.extra.value)
									return {
										message = localize("$") .. card.ability.extra.value,
										colour = G.C.MONEY,
										card = card,
									}
								end
							end
						end
					end
					if j.stat and context.individual and indiv then
						local cond_passed = false
						if j.cond == "suit" then
							if context.other_card:is_suit(j.suit) then
								cond_passed = true
							end
						elseif j.cond == "rank" then
							if context.other_card:get_id() == j.rank then
								cond_passed = true
							end
						elseif j.cond == "face" then
							if context.other_card:is_face() then
								cond_passed = true
							end
						elseif j.cond == "odds" then
							if
								SMODS.pseudorandom_probability(
									card,
									"rnj",
									1,
									card and card.ability.extra.cond_value or 0,
									"RNJoker"
								)
							then
								cond_passed = true
							end
						end
						if not j.cond then
							cond_passed = true
						end
						if cond_passed then
							if (context.cardarea == G.hand) and context.other_card.debuff then
								return {
									message = localize("k_debuffed"),
									colour = G.C.RED,
									card = card,
								}
							end
							if j.scale_value then
								card.ability.extra.value = card.ability.extra.value + card.ability.extra.value_mod
								card_eval_status_text(
									card,
									"extra",
									nil,
									nil,
									nil,
									{ message = localize("k_upgrade_ex") }
								)
								if j.stat == "h_size" then
									G.hand:change_size(card.ability.extra.value_mod)
								end
							else
								local stats = {
									plus_mult = "mult",
									plus_chips = "chips",
								}
								if context.cardarea == G.hand then
									local stats = {
										plus_mult = "h_mult",
										plus_chips = "h_chips",
									}
								end
								local stat = stats[j.stat] or j.stat
								local colors = {
									plus_mult = G.C.RED,
									plus_chips = G.C.BLUE,
									x_mult = G.C.RED,
									x_chips = G.C.BLUE,
								}
								local table = {
									card = card,
								}
								table.colour = colors[j.stat]
								table[stat] = card.ability.extra.value
								return table
							end
						end
					end
					if context.joker_main and j.stat and (j.stat ~= "h_size") and (j.stat ~= "money") then
						local cond_passed = false
						if j_context ~= "joker_main" then
							cond_passed = true
						end
						if j.cond == "first" then
							if G.GAME.current_round.hands_played == 0 then
								cond_passed = true
							end
						elseif j.cond == "last" then
							if G.GAME.current_round.hands_left == 0 then
								cond_passed = true
							end
						elseif j.cond == "poker_hand" then
							if context.poker_hands ~= nil and next(context.poker_hands[j.poker_hand]) then
								cond_passed = true
							end
						elseif j.cond == "or_more" then
							if #context.full_hand >= j.cond_value then
								cond_passed = true
							end
						elseif j.cond == "or_less" then
							if #context.full_hand <= j.cond_value then
								cond_passed = true
							end
						elseif j.cond == "odds" then
							if
								SMODS.pseudorandom_probability(
									card,
									"rnj",
									1,
									card and card.ability.extra.cond_value or 0,
									"RNJoker"
								)
							then
								cond_passed = true
							end
						end
						if not j.cond then
							cond_passed = true
						end
						if cond_passed then
							local stats = {
								plus_mult = "a_mult",
								plus_chips = "a_chips",
								x_mult = "a_xmult",
								x_chips = "a_xchips",
							}
							local mods = {
								plus_mult = "mult_mod",
								plus_chips = "chip_mod",
								x_mult = "Xmult_mod",
								x_chips = "Xchip_mod",
							}
							local table = {}
							table.message = localize({
								type = "variable",
								key = stats[j.stat],
								vars = { card.ability.extra.value },
							})
							table[mods[j.stat]] = card.ability.extra.value
							return table
						end
					end
				end
			end
		end
		if
			not context.individual
			and not context.repetition
			and not card.debuff
			and context.end_of_round
			and not context.blueprint
			and G.GAME.blind.boss
			and not (G.GAME.blind.config and G.GAME.blind.config.bonus)
		then
			local hand_size = 0
			if card.ability and card.ability.abilities then
				for i, j in ipairs(card.ability.abilities) do
					if j.stat == "h_size" then
						hand_size = hand_size + card.ability.extra.value
					end
				end
			end
			G.hand:change_size(-hand_size)
			Cryptid.rnjoker_randomize(card)
			return {
				message = localize("k_reset"),
				colour = G.C.RED,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		local hand_size = 0
		if card.ability and card.ability.abilities then
			for i, j in ipairs(card.ability.abilities) do
				if j.stat == "h_size" then
					hand_size = hand_size + card.ability.extra.value
				end
			end
		end
		G.hand:change_size(hand_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local hand_size = 0
		if card.ability and card.ability.abilities then
			for i, j in ipairs(card.ability.abilities) do
				if j.stat == "h_size" then
					hand_size = hand_size + card.ability.extra.value
				end
			end
		end
		G.hand:change_size(-hand_size)
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		card = card or self:create_fake_card()
		local len = (
			card.ability
			and card.ability.abilities
			and card.ability.abilities[1].loc_txt
			and #card.ability.abilities[1].loc_txt
		) or 0
		local target = {
			type = "descriptions",
			key = self.key,
			set = self.set,
			nodes = desc_nodes,
			vars = specific_vars or {},
		}
		if self.loc_vars and type(self.loc_vars) == "function" then
			res = self:loc_vars(info_queue, card) or {}
			target.vars = res.vars or target.vars
			target.key = res.key or target.key
		end
		local new_loc = { text = {} }
		if
			card.ability
			and card.ability.abilities
			and card.ability.abilities[1].loc_txt
			and #card.ability.abilities[1].loc_txt
		then
			for i, j in ipairs(card.ability.abilities[1].loc_txt) do
				table.insert(new_loc.text, j)
			end
			new_loc.text_parsed = card.ability.abilities[1].text_parsed
		end
		new_loc.text_parsed = new_loc.text_parsed or {}
		if not full_UI_table.name then
			full_UI_table.name =
				localize({ type = "name", set = self.set, key = target.key or self.key, nodes = full_UI_table.name })
		end
		if specific_vars and specific_vars.debuffed then
			target = {
				type = "other",
				key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
				nodes = desc_nodes,
			}
			localize(target)
		else
			Cryptid.direct_localize(new_loc, target)
		end
	end,
	calc_dollar_bonus = function(self, card)
		if card.ability and card.ability.abilities then
			for i, j in ipairs(card.ability.abilities) do
				if j.stat == "money" then
					if card.ability.extra.value > 0 then
						return card.ability.extra.value
					end
				end
			end
		end
	end,
	atlas = "atlastwo",
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	init = function(self)
		function Cryptid.rnjoker_randomize(card)
			card.ability.abilities = {}
			card.ability.extra = {}
			card.ability.extra.value = {}
			card.ability.extra.value_mod = {}
			card.ability.extra.cond_value = {}
			local values = {}
			local contexts = {
				"open_booster",
				"buying_card",
				"selling_self",
				"selling_card",
				"reroll_shop",
				"ending_shop",
				"skip_blind",
				"skipping_booster",
				"playing_card_added",
				"first_hand_drawn",
				"setting_blind",
				"remove_playing_cards",
				"using_consumeable",
				"debuffed_hand",
				"pre_discard",
				"discard",
				"end_of_round",
				"individual_play",
				"individual_hand_score",
				"individual_hand_end",
				"repetition_play",
				"repetition_hand",
				"other_joker",
				"before",
				"after",
				"joker_main",
			}
			local stats = {
				plus_mult = 2 + pseudorandom("rnj_mult1") * 28,
				plus_chips = 4 + pseudorandom("rnj_chips1") * 196,
				x_mult = 1 + pseudorandom("rnj_mult2") * 3,
				x_chips = 1 + pseudorandom("rnj_chips2") * 3,
				h_size = 1 + math.floor(pseudorandom("rnj_h_size") * 3),
				money = 1 + math.floor(pseudorandom("rnj_money") * 5),
			}
			local actions = {
				make_joker = 1,
				make_tarot = 1 + math.min(2, math.floor(pseudorandom("rnj_tarot") * 2)),
				make_planet = 1 + math.min(2, math.floor(pseudorandom("rnj_planet") * 2)),
				make_spectral = 1,
				add_dollars = 1 + math.min(4, math.floor(pseudorandom("rnj_dollars") * 5)),
			}
			local context = pseudorandom_element(contexts, pseudoseed("rnj_context"))
			values.context = context
			if context == "other_joker" or context == "joker_main" then
				stats.h_size = nil
				stats.money = nil
			end
			local stat_val, stat = pseudorandom_element(stats, pseudoseed("rnj_stat"))
			local act_val, act = pseudorandom_element(actions, pseudoseed("rnj_stat"))
			local scale = (pseudorandom("rnj_scale") > 0.5)
			local is_stat = (pseudorandom("rnj_stat") > 0.5)
			if context == "other_joker" or context == "joker_main" then
				is_stat = true
				scale = false
			end
			if
				((stat == "h_size") or (stat == "money"))
				and (context == "individual_play" or context == "individual_hand_score" or context == "individual_hand_end")
				and is_stat
			then
				scale = true
			end
			if context == "selling_self" then
				is_stat = false
				scale = false
			end
			if is_stat then
				values.value = stat_val or 0
				values.stat = stat
				if
					scale
					or (
						(context ~= "joker_main")
						and (context ~= "other_joker")
						and (context ~= "individual_play")
						and (context ~= "individual_hand_score")
					)
				then
					values.value = ((stat == "x_mult") or (stat == "x_chips")) and 1 or 0
					scale = true
					if stat == "plus_mult" then
						values.scale_value = pseudorandom("rnj_scaling") * 10
					elseif stat == "plus_chips" then
						values.scale_value = pseudorandom("rnj_scaling") * 50
					elseif stat == "h_size" then
						values.scale_value = 1
					elseif stat == "money" then
						values.scale_value = pseudorandom("rnj_scaling") * 4
					else
						values.scale_value = pseudorandom("rnj_scaling")
					end
				end
			else
				scale = false
				values.value = act_val
				values.act = act
			end
			if pseudorandom("rnj_stat") < 0.8 then
				local conds = {}
				if context == "buying_card" then
					conds = {
						"buy_common",
						"buy_uncommon",
						"tarot",
						"planet",
						"spectral",
						"odds",
					}
				elseif context == "selling_card" then
					conds = {
						"tarot",
						"planet",
						"spectral",
						"joker",
						"odds",
					}
				elseif context == "playing_card_added" then
					conds = { "odds" }
				elseif context == "setting_blind" then
					conds = {
						"boss",
						"non_boss",
						"small",
						"big",
						"odds",
					}
				elseif context == "remove_playing_cards" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "using_consumeable" then
					conds = {
						"tarot",
						"planet",
						"spectral",
						"odds",
					}
				elseif context == "pre_discard" then
					conds = {
						"first_discard",
						"last_discard",
						"odds",
					}
				elseif context == "discard" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "individual_play" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "individual_hand_score" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "individual_hand_end" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "repetition_play" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "repetition_hand" then
					conds = {
						"suit",
						"rank",
						"face",
						"odds",
					}
				elseif context == "other_joker" then
					conds = {
						"uncommon",
						"rare",
						"odds",
					}
				elseif context == "before" then
					conds = {
						"first",
						"last",
						"poker_hand",
						"odds",
					}
				elseif context == "after" then
					conds = {
						"first",
						"last",
						"poker_hand",
						"odds",
					}
				elseif context == "joker_main" then
					conds = {
						"first",
						"last",
						"poker_hand",
						"or_more",
						"or_less",
						"odds",
					}
				elseif context == "cry_payout" then
					conds = {
						"hands_left",
						"discards_left",
					}
				end
				if #conds > 0 then
					local cond = pseudorandom_element(conds, pseudoseed("rnj_stat"))
					values.cond = cond
					if cond == "poker_hand" then
						local none, key = pseudorandom_element(G.GAME.hands, pseudoseed("rnj_poker-hand"))
						values.cond_value = localize(key, "poker_hands")
						values.poker_hand = key
					end
					if cond == "suit" then
						local suit = pseudorandom_element(SMODS.Suits, pseudoseed("rnj_suit"))
						values.cond_value = localize(suit.key, "suits_singular")
						values.suit = suit.key
						values.color = G.C.SUITS[suit.key]
						if values.color == nil then
							values.color = G.C.IMPORTANT
						end
					end
					if cond == "rank" then
						local rank = pseudorandom_element(SMODS.Ranks, pseudoseed("rnj_rank"))
						values.cond_value = localize(rank.key, "ranks")
						values.rank = rank.id
					end
					if (cond == "or_more") or (cond == "or_less") then
						values.cond_value = math.min(5, math.floor(pseudorandom("rnj_cards") * 6))
					end
					if (cond == "hands_left") or (cond == "discards_left") then
						values.cond_value = math.min(3, math.floor(pseudorandom("rnj_cards") * 4))
					end
					if cond == "odds" then
						values.cond_value = 2 + math.min(3, math.floor(pseudorandom("rnj_cards") * 4))
					end
				end
			end
			local loc_txt = ""
			local extra_lines = { "" }
			if (context ~= "repetition_play") and (context ~= "repetition_hand") then
				if values.stat then
					for i, j in ipairs(G.localization.misc.rnj_loc_txts.stats[values.stat]) do
						if scale and (i == 1) then
							loc_txt = loc_txt .. "Gains "
						end
						loc_txt = loc_txt .. j
					end
				end
				if values.act then
					for i, j in ipairs(G.localization.misc.rnj_loc_txts.actions[values.act]) do
						loc_txt = loc_txt .. j
					end
				end
			else
				scale = false
				values.stat = nil
				values.act = nil
				values.value = nil
				values.scale_value = nil
			end
			loc_txt = loc_txt .. " "
			if values.context then
				for i, j in ipairs(G.localization.misc.rnj_loc_txts.contexts[values.context]) do
					loc_txt = loc_txt .. j
				end
			end
			if values.context ~= "joker_main" then
				loc_txt = loc_txt .. " "
			end
			if values.cond then
				for i, j in ipairs(G.localization.misc.rnj_loc_txts.conds[values.cond]) do
					loc_txt = loc_txt .. j
				end
			end
			if scale then
				for i, j in ipairs(G.localization.misc.rnj_loc_txts.stats_inactive[values.stat]) do
					table.insert(extra_lines, j)
				end
			end
			if values.act and (values.act ~= "add_dollars") then
				table.insert(extra_lines, "{C:inactive}(Must have room){}")
			end
			local accum = 0
			local lines = { "Randomize abilities each {C:attention}Ante{}" }
			local in_brace = false
			local cuur_str = ""
			for i = 1, string.len(loc_txt) do
				local char = string.sub(loc_txt, i, i)
				if char == "{" then
					in_brace = true
					cuur_str = cuur_str .. char
				elseif char == "}" then
					in_brace = false
					cuur_str = cuur_str .. char
				elseif char == " " and (accum >= 25) then
					table.insert(lines, cuur_str)
					cuur_str = ""
					accum = 0
				else
					if not in_brace then
						accum = accum + 1
					end
					cuur_str = cuur_str .. char
				end
			end
			if string.len(cuur_str) > 0 then
				table.insert(lines, cuur_str)
			end
			if #extra_lines > 0 then
				for i, j in ipairs(extra_lines) do
					table.insert(lines, j)
				end
			end
			values.loc_txt = lines
			card.ability.extra = {}
			if values.value then
				values.value = math.floor(values.value * 100) / 100
				card.ability.extra.value = values.value
			end
			if values.scale_value then
				values.scale_value = math.floor(values.scale_value * 100) / 100
				card.ability.extra.value_mod = values.scale_value
			end
			if values.cond_value then
				card.ability.extra.cond_value = values.cond_value
			end
			if values.color then
				card.ability.extra.color = values.color
			end
			local text_parsed = {}
			for _, line in ipairs(values.loc_txt) do
				text_parsed[#text_parsed + 1] = loc_parse_string(line)
			end
			values.text_parsed = text_parsed
			card.ability.abilities = { values }
		end
		function Cryptid.direct_localize(loc_target, args, misc_cat)
			if loc_target then
				for _, lines in
					ipairs(
						args.type == "unlocks" and loc_target.unlock_parsed
							or args.type == "name" and loc_target.name_parsed
							or (args.type == "text" or args.type == "tutorial" or args.type == "quips") and loc_target
							or loc_target.text_parsed
					)
				do
					local final_line = {}
					for _, part in ipairs(lines) do
						local assembled_string = ""
						for _, subpart in ipairs(part.strings) do
							assembled_string = assembled_string
								.. (
									type(subpart) == "string" and subpart
									or format_ui_value(args.vars[tonumber(subpart[1])])
									or "ERROR"
								)
						end
						local desc_scale = G.LANG.font.DESCSCALE
						if G.F_MOBILE_UI then
							desc_scale = desc_scale * 1.5
						end
						if args.type == "name" then
							final_line[#final_line + 1] = {
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { assembled_string },
										colours = {
											(part.control.V and args.vars.colours[tonumber(part.control.V)])
												or (part.control.C and loc_colour(part.control.C))
												or G.C.UI.TEXT_LIGHT,
										},
										bump = true,
										silent = true,
										pop_in = 0,
										pop_in_rate = 4,
										maxw = 5,
										shadow = true,
										y_offset = -0.6,
										spacing = math.max(0, 0.32 * (17 - #assembled_string)),
										scale = (0.55 - 0.004 * #assembled_string)
											* (part.control.s and tonumber(part.control.s) or 1),
									}),
								},
							}
						elseif part.control.E then
							local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
							if part.control.E == "1" then
								_float = true
								_silent = true
								_pop_in = 0
							elseif part.control.E == "2" then
								_bump = true
								_spacing = 1
							end
							final_line[#final_line + 1] = {
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { assembled_string },
										colours = {
											part.control.V and args.vars.colours[tonumber(part.control.V)]
												or loc_colour(part.control.C or nil),
										},
										float = _float,
										silent = _silent,
										pop_in = _pop_in,
										bump = _bump,
										spacing = _spacing,
										scale = 0.32 * (part.control.s and tonumber(part.control.s) or 1) * desc_scale,
									}),
								},
							}
						elseif part.control.X then
							final_line[#final_line + 1] = {
								n = G.UIT.C,
								config = {
									align = "m",
									colour = loc_colour(part.control.X),
									r = 0.05,
									padding = 0.03,
									res = 0.15,
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = assembled_string,
											colour = loc_colour(part.control.C or nil),
											scale = 0.32
												* (part.control.s and tonumber(part.control.s) or 1)
												* desc_scale,
										},
									},
								},
							}
						else
							final_line[#final_line + 1] = {
								n = G.UIT.T,
								config = {
									detailed_tooltip = part.control.T
											and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T])
										or nil,
									text = assembled_string,
									shadow = args.shadow,
									colour = part.control.V and args.vars.colours[tonumber(part.control.V)]
										or loc_colour(part.control.C or nil, args.default_col),
									scale = 0.32 * (part.control.s and tonumber(part.control.s) or 1) * desc_scale,
								},
							}
						end
					end
					if args.type == "name" or args.type == "text" then
						return final_line
					end
					args.nodes[#args.nodes + 1] = final_line
				end
			end
		end
	end,
}
local filler = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-filler",
	key = "filler",
	pos = { x = 0, y = 1 },
	pools = { ["Meme"] = true },
	config = {
		extra = {
			Xmult = 1.00000000000003,
			type = "High Card",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	order = 89,
	cost = 1,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands[card.ability.extra.type]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "High Card" },
}
local duos = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-duos",
	key = "duos",
	order = 90,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			Xmult = 2.5,
			type = "Two Pair",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if
				context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type])
				or context.poker_hands ~= nil and next(context.poker_hands["Full House"])
			then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "Two Pair" },
}
local home = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-home",
	key = "home",
	order = 91,
	pos = { x = 2, y = 0 },
	config = {
		extra = {
			Xmult = 3.5,
			type = "Full House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "Full House" },
}
local nuts = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-nuts",
	key = "nuts",
	order = 92,
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			Xmult = 5,
			type = "Straight Flush",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "Straight Flush" },
}
local quintet = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-quintet",
	key = "quintet",
	order = 93,
	pos = { x = 3, y = 0 },
	config = {
		extra = {
			Xmult = 5,
			type = "Five of a Kind",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = number_format(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = number_format(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Five of a Kind"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "Five of a Kind" then
			return true
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
}
local unity = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-unity",
	key = "unity",
	order = 94,
	pos = { x = 4, y = 0 },
	config = {
		extra = {
			Xmult = 9,
			type = "Flush House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush House"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "Flush House" then
			return true
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
}
local swarm = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-swarm",
	key = "swarm",
	order = 95,
	pos = { x = 5, y = 0 },
	config = {
		extra = {
			Xmult = 9,
			type = "Flush Five",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush Five"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "Flush Five" then
			return true
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
}
local stronghold = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_asteroidbelt",
		},
	},
	name = "cry-stronghold",
	key = "stronghold",
	order = 119,
	pos = { x = 8, y = 4 },
	config = {
		extra = {
			Xmult = 5,
			type = "cry_Bulwark",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Bulwark"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "cry_Bulwark" then
			return true
		end
	end,
	unlocked = false,
}
local wtf = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_void",
		},
	},
	name = "cry-wtf",
	key = "wtf",
	order = 120,
	pos = { x = 7, y = 1 },
	config = {
		extra = {
			Xmult = 10,
			type = "cry_Clusterfuck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Clusterfuck"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "cry_Clusterfuck" then
			return true
		end
	end,
	unlocked = false,
}
local clash = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_marsmoons",
		},
	},
	name = "cry-clash",
	key = "clash",
	order = 121,
	pos = { x = 8, y = 1 },
	config = {
		extra = {
			Xmult = 12,
			type = "cry_UltPair",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.poker_hands ~= nil and next(context.poker_hands[card.ability.extra.type]) then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_UltPair"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "cry_UltPair" then
			return true
		end
	end,
	unlocked = false,
}

local the = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_nibiru",
		},
	},
	name = "cry-the",
	key = "the",
	order = 121.5,
	pos = { x = 5, y = 7 },
	config = {
		extra = {
			Xmult = 2,
			type = "cry_None",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.Xmult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.Xmult) > to_big(1)) then
			if context.scoring_name == "cry_None" then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult) },
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				colour = G.C.RED,
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_None"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "cry_None" then
			return true
		end
	end,
	unlocked = false,
	cry_credits = {
		art = { "MarioFan597" },
		code = { "lord-ruby" },
	},
}

local annihalation = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_universe",
		},
	},
	name = "cry-annihalation",
	key = "annihalation",
	order = 121.75,
	pos = { x = 8, y = 7 },
	config = {
		extra = {
			emult = 5.2,
			type = "cry_WholeDeck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.emult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.emult) > to_big(1)) then
			if next(context.poker_hands["cry_WholeDeck"]) then
				return {
					colour = G.C.DARK_EDITION,
					Emult = lenient_bignum(card.ability.extra.emult),
				}
			end
		end
		if context.forcetrigger then
			return {
				colour = G.C.DARK_EDITION,
				Emult = lenient_bignum(card.ability.extra.emult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_WholeDeck"].played > 0 then
			return true
		end
		return false
	end,
	check_for_unlock = function(self, args)
		if args.type == "win" and G.GAME.last_hand_played == "cry_WholeDeck" then
			return true
		end
	end,
	unlocked = false,
	cry_credits = {
		art = { "luigicat11" },
		code = { "lord-ruby" },
	},
}

local filler = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-filler",
	key = "filler",
	pos = { x = 0, y = 1 },
	pools = { ["Meme"] = true },
	config = { Xmult = 1.00000000000003, type = "High Card" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_mult, localize(card.ability.type, "poker_hands") } }
	end,
	atlas = "atlasthree",
	rarity = 3,
	order = 89,
	cost = 1,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands[card.ability.type]))
			or context.forcetrigger
		then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.x_mult } }),
				colour = G.C.RED,
				Xmult_mod = card.ability.x_mult,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Mathguy",
		},
		art = {
			"Mathguy",
		},
		code = {
			"Mathguy",
		},
	},
	unlocked = false,
	unlock_condition = { type = "win_no_hand", extra = "High Card" },
}
local giggly = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Giggly Joker",
	key = "giggly",
	effect = "Cry Type Mult",
	pos = { x = 0, y = 5 },
	config = {
		extra = {
			t_mult = 4,
			type = "High Card",
		},
	},
	order = 16,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 1,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["High Card"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local nutty = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Nutty Joker",
	key = "nutty",
	effect = "Cry Type Mult",
	pos = { x = 1, y = 5 },
	order = 17,
	config = {
		extra = {
			t_mult = 19,
			type = "Four of a Kind",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Four of a Kind"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local manic = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Manic Joker",
	key = "manic",
	effect = "Cry Type Mult",
	pos = { x = 2, y = 5 },
	order = 18,
	config = {
		extra = {
			t_mult = 22,
			type = "Straight Flush",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Straight Flush"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local silly = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Silly Joker",
	key = "silly",
	pos = { x = 3, y = 5 },
	effect = "Cry Type Mult",
	order = 19,
	config = {
		extra = {
			t_mult = 16,
			type = "Full House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Full House"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local delirious = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Delirious Joker",
	key = "delirious",
	effect = "Cry Type Mult",
	pos = { x = 4, y = 5 },
	order = 20,
	config = {
		extra = {
			t_mult = 22,
			type = "Five of a Kind",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Five of a Kind"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Five of a Kind"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local wacky = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Wacky Joker",
	key = "wacky",
	pos = { x = 5, y = 5 },
	order = 21,
	config = {
		extra = {
			t_mult = 30,
			type = "Flush House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	effect = "Cry Type Mult",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Flush House"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush House"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local kooky = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Kooky Joker",
	key = "kooky",
	pos = { x = 6, y = 5 },
	order = 22,
	config = {
		extra = {
			t_mult = 30,
			type = "Flush Five",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Flush Five"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush Five"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local bonkers = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_asteroidbelt",
		},
	},
	name = "cry-Bonkers Joker",
	key = "bonkers",
	pos = { x = 8, y = 5 },
	order = 113,
	config = {
		extra = {
			t_mult = 20,
			type = "cry_Bulwark",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_Bulwark"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Bulwark"].played > 0 then
			return true
		end
		return false
	end,
}
local fuckedup = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_void",
		},
	},
	name = "cry-Fucked-Up Joker",
	key = "fuckedup",
	pos = { x = 7, y = 2 },
	order = 114,
	config = {
		extra = {
			t_mult = 37,
			type = "cry_Clusterfuck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_Clusterfuck"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Clusterfuck"].played > 0 then
			return true
		end
		return false
	end,
}
local foolhardy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_marsmoons",
		},
	},
	name = "cry-Foolhardy Joker",
	key = "foolhardy",
	pos = { x = 8, y = 2 },
	order = 115,
	config = {
		extra = {
			t_mult = 42,
			type = "cry_UltPair",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_UltPair"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_UltPair"].played > 0 then
			return true
		end
		return false
	end,
}

local undefined = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_nibiru",
		},
	},
	name = "cry-undefined Joker",
	key = "undefined",
	pos = { x = 3, y = 7 },
	order = 115.5,
	config = {
		extra = {
			t_mult = 5,
			type = "cry_None",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.joker_main and context.scoring_name == "cry_None") or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.t_mult) },
				}),
				colour = G.C.RED,
				mult_mod = lenient_bignum(card.ability.extra.t_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_None"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		art = { "unexian" },
		code = { "lord-ruby" },
	},
}

local wordscanteven = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_universe",
		},
	},
	name = "cry-Words Cant Even",
	key = "words_cant_even",
	pos = { x = 6, y = 7 },
	effect = "Cry Type Chips",
	order = 115.75,
	config = {
		extra = {
			x_mult = 52000000,
			type = "cry_WholeDeck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.x_mult),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.joker_main and next(context.poker_hands["cry_WholeDeck"])) or context.forcetrigger then
			return {
				colour = G.C.RED,
				xmult = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_WholeDeck"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		art = { "luigicat11" },
		code = { "lord-ruby" },
	},
}

local dubious = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Dubious Joker",
	key = "dubious",
	pos = { x = 0, y = 6 },
	order = 24,
	config = {
		extra = {
			t_chips = 20,
			type = "High Card",
		},
	},
	effect = "Cry Type Chips",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 1,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["High Card"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local shrewd = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Shrewd Joker",
	key = "shrewd",
	pos = { x = 1, y = 6 },
	order = 25,
	effect = "Cry Type Chips",
	config = {
		extra = {
			t_chips = 150,
			type = "Four of a Kind",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Four of a Kind"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local tricksy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Tricksy Joker",
	key = "tricksy",
	effect = "Cry Type Chips",
	order = 26,
	pos = { x = 2, y = 6 },
	config = {
		extra = {
			t_chips = 170,
			type = "Straight Flush",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Straight Flush"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local foxy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Foxy Joker",
	key = "foxy",
	pos = { x = 3, y = 6 },
	order = 27,
	effect = "Cry Type Chips",
	config = {
		extra = {
			t_chips = 130,
			type = "Full House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Full House"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local savvy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Savvy Joker",
	key = "savvy",
	pos = { x = 4, y = 6 },
	effect = "Cry Type Chips",
	order = 28,
	config = {
		extra = {
			t_chips = 170,
			type = "Five of a Kind",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Five of a Kind"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Five of a Kind"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local subtle = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Subtle Joker",
	key = "subtle",
	pos = { x = 5, y = 6 },
	effect = "Cry Type Chips",
	order = 29,
	config = {
		extra = {
			t_chips = 240,
			type = "Flush House",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Flush House"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush House"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local discreet = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Discreet Joker",
	key = "discreet",
	pos = { x = 6, y = 6 },
	effect = "Cry Type Chips",
	order = 30,
	config = {
		extra = {
			t_chips = 240,
			type = "Flush Five",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["Flush Five"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["Flush Five"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		idea = {
			"Luigicat11",
		},
		art = {
			"Luigicat11",
		},
		code = {
			"Math",
		},
	},
}
local adroit = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_asteroidbelt",
		},
	},
	name = "cry-Adroit Joker",
	key = "adroit",
	pos = { x = 7, y = 4 },
	effect = "Cry Type Chips",
	order = 116,
	config = {
		extra = {
			t_chips = 170,
			type = "cry_Bulwark",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_Bulwark"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Bulwark"].played > 0 then
			return true
		end
		return false
	end,
}
local penetrating = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_void",
		},
	},
	name = "cry-Penetrating Joker",
	key = "penetrating",
	pos = { x = 7, y = 3 },
	effect = "Cry Type Chips",
	order = 117,
	config = {
		extra = {
			t_chips = 270,
			type = "cry_Clusterfuck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_Clusterfuck"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_Clusterfuck"].played > 0 then
			return true
		end
		return false
	end,
}
local treacherous = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_marsmoons",
		},
	},
	name = "cry-Treacherous Joker",
	key = "treacherous",
	pos = { x = 8, y = 3 },
	effect = "Cry Type Chips",
	order = 118,
	config = {
		extra = {
			t_chips = 300,
			type = "cry_UltPair",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			(context.joker_main and context.poker_hands and next(context.poker_hands["cry_UltPair"]))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_UltPair"].played > 0 then
			return true
		end
		return false
	end,
}
local nebulous = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_nibiru",
		},
	},
	name = "cry-nebulous Joker",
	key = "nebulous",
	pos = { x = 4, y = 7 },
	effect = "Cry Type Chips",
	order = 118.5,
	config = {
		extra = {
			t_chips = 30,
			type = "cry_None",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.t_chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.joker_main and context.scoring_name == "cry_None") or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_chips",
					vars = { number_format(card.ability.extra.t_chips) },
				}),
				colour = G.C.BLUE,
				chip_mod = lenient_bignum(card.ability.extra.t_chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_None"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		art = { "unexian" },
		code = { "lord-ruby" },
	},
}

local manylostminds = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"c_cry_universe",
		},
	},
	name = "cry-Many Lost Minds",
	key = "many_lost_minds",
	pos = { x = 7, y = 7 },
	order = 118.75,
	config = {
		extra = {
			chips = 8.0658175e67, --52!
			type = "cry_WholeDeck",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.chips),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "atlasthree",
	rarity = 1,
	effect = "Cry Type Mult",
	cost = 4,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.joker_main and next(context.poker_hands["cry_WholeDeck"])) or context.forcetrigger then
			return {
				colour = G.C.BLUE,
				chips = lenient_bignum(card.ability.extra.chips),
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.hands["cry_WholeDeck"].played > 0 then
			return true
		end
		return false
	end,
	cry_credits = {
		art = { "luigicat11" },
		code = { "lord-ruby" },
	},
}

local coin = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-coin",
	key = "coin",
	pos = { x = 0, y = 2 },
	config = {
		extra = { money = 1 },
		immutable = { money_mod = 10 },
	},
	rarity = 1,
	order = 53,
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.money),
				number_format(
					center.ability.extra.money
						* (Card.get_gameset(card) ~= "modest" and center.ability.immutable.money_mod or 4)
				),
			},
		}
	end,
	atlas = "atlasthree",
	calculate = function(self, card, context)
		if (context.selling_card and context.card.ability.set == "Joker") or context.forcetrigger then
			local mod = math.floor(
				pseudorandom(pseudoseed("coin"))
					* (Card.get_gameset(card) ~= "modest" and card.ability.immutable.money_mod or 4)
			) + 1
			local option = lenient_bignum(to_big(card.ability.extra.money) * mod)
			ease_dollars(option)
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("$") .. number_format(option), colour = G.C.MONEY, delay = 0.45 }
			)
			return nil, true
		end
	end,
	cry_credits = {
		idea = {
			"Squiddy",
		},
		art = {
			"Timetoexplode",
			"George the Rat",
		},
		code = {
			"Jevonn",
		},
	},
}
local wheelhope = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-wheelhope",
	key = "wheelhope",
	pos = { x = 1, y = 1 },
	config = {
		extra = {
			extra = 0.5,
			x_mult = 1,
		},
	},
	rarity = 2,
	cost = 5,
	order = 74,
	perishable_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		local aaa, bbb = SMODS.get_probability_vars(nil, 1, 4, "wheel_of_fortune")
		info_queue[#info_queue + 1] = { key = "alt_wheel_of_fortune", set = "Other", specific_vars = { aaa, bbb } }
		return {
			vars = {
				number_format(center.ability.extra.extra),
				number_format(center.ability.extra.x_mult),
			},
		}
	end,
	atlas = "atlasthree",
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.x_mult) > to_big(1)) then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.x_mult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
		if context.pseudorandom_result and not context.result then
			if context.identifier and context.identifier == "wheel_of_fortune" then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "extra",
					message_key = "a_xmult",
					message_colour = G.C.RED,
				})
				return nil, true
			end
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "extra",
				message_key = "a_xmult",
				message_colour = G.C.RED,
			})
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.x_mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Linus Goof Balls",
		},
		art = {
			"Linus Good Balls",
		},
		code = {
			"Toneblock",
		},
	},
}
local oldblueprint = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-oldblueprint",
	key = "oldblueprint",
	pos = { x = 2, y = 1 },
	config = { extra = { odds = 4 } },
	rarity = 1,
	cost = 6,
	order = 83,
	blueprint_compat = true,
	eternal_compat = false,
	atlas = "atlasthree",
	loc_vars = function(self, info_queue, card)
		if card.area and card.area == G.jokers then
			local other_joker
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
									or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
								r = 0.05,
								padding = 0.06,
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = " "
											.. localize("k_" .. (compatible and "compatible" or "incompatible"))
											.. " ",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			}
		end
		return {
			vars = {
				SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Old Blueprint"),
			},
			main_end = main_end,
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.game_over == false
			and context.main_eval
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			if SMODS.pseudorandom_probability(card, "oldblueprint", 1, card.ability.extra.odds, "Old Blueprint") then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("cry_destroyed_ex") })
			else
				return {
					message = localize("k_safe_ex"),
				}
			end
		end
		local other_joker = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				other_joker = G.jokers.cards[i + 1]
			end
		end
		return SMODS.blueprint_effect(card, other_joker, context)
	end,
	cry_credits = {
		idea = {
			"Linus Goof Balls",
		},
		art = {
			"Linus Goof Balls",
			"unexian",
		},
		code = {
			"Math", --original
			"NaoRiley", --rewrite
		},
	},
}
local night = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-night",
	key = "night",
	config = { extra = { mult = 3 } },
	gameset_config = {
		modest = {
			extra = {
				mult = 2,
			},
		},
	},
	pos = { x = 3, y = 1 },
	rarity = 3,
	cost = 6,
	order = 41,
	eternal_compat = false,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasthree",
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.mult) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_left == 0 then
			if to_big(card.ability.extra.mult) > to_big(1) then
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = { number_format(card.ability.extra.mult) },
					}),
					Emult_mod = lenient_bignum(card.ability.extra.mult),
					colour = G.C.DARK_EDITION,
				}
			end
		elseif
			context.cardarea == G.jokers
			and context.after
			and not context.blueprint
			and not context.retrigger_joker
		then
			if G.GAME.current_round.hands_left <= 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_extinct_ex"),
					colour = G.C.FILTER,
				}
			elseif G.GAME.current_round.hands_left <= 1 then
				local eval = function(card)
					return G.GAME.current_round.hands_left <= 1 and not G.RESET_JIGGLES
				end
				juice_card_until(card, eval, true)
			end
		elseif context.first_hand_drawn and not context.blueprint and not context.retrigger_joker then
			if next(find_joker("cry-panopticon")) then
				local eval = function(card)
					return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES
				end
				juice_card_until(card, eval, true)
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true
						end,
					}))
					return true
				end,
			}))
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				Emult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Linus Goof Balls",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Jevonn",
		},
	},
}
local busdriver = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-busdriver",
	key = "busdriver",
	config = { extra = { mult = 50, odds = 4 } },
	pos = { x = 5, y = 1 },
	rarity = 2,
	cost = 7,
	order = 46,
	atlas = "atlasthree",
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		local prob = cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged)
		local oddy = math.max(1, card.ability.extra.odds)
		return {
			vars = {
				(oddy - 1 / prob),
				number_format(card.ability.extra.mult),
				oddy,
				(1 / prob),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.mult) > to_big(0)) then
			local oddy = math.max(1, card.ability.extra.odds)
			if
				pseudorandom("busdriver")
				< 1
					- (1 / (cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged) * oddy))
			then
				return {
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = { number_format(card.ability.extra.mult) },
					}),
					mult_mod = lenient_bignum(card.ability.extra.mult),
					colour = G.C.MULT,
				}
			else
				return {
					message = localize({
						type = "variable",
						key = "a_mult_minus",
						vars = { number_format(card.ability.extra.mult) },
					}),
					mult_mod = lenient_bignum(to_big(card.ability.extra.mult) * -1),
					colour = G.C.MULT,
				}
			end
		end
		if context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
				colour = G.C.MULT,
			}
		end
	end,
	cry_credits = {
		idea = {
			"Linus Goof Balls",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"Jevonn",
		},
	},
}
local translucent = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"banana",
		},
	},
	name = "cry-translucent Joker",
	key = "translucent",
	pos = { x = 5, y = 2 },
	rarity = 1,
	cost = 4,
	order = 52,
	immutable = true,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	atlas = "atlasthree",
	loc_vars = function(self, info_queue, card)
		local aaa
		if G.jokers then
			for k, v in ipairs(G.jokers.cards) do
				if (v.edition and v.edition.negative) and G.localization.descriptions.Other.remove_negative then
					aaa = {}
					localize({ type = "other", key = "remove_negative", nodes = aaa, vars = {} })
					aaa = aaa[1]
					break
				end
			end
		end
		return {
			main_end = aaa,
		}
	end,
	calculate = function(self, card, context)
		if context.selling_self and not context.retrigger_joker or context.forcetrigger then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].debuff then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers > 0 then
				if #G.jokers.cards <= G.jokers.config.card_limit then
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_duplicated_ex") }
					)
					local chosen_joker = pseudorandom_element(jokers, pseudoseed("trans"))
					local _card =
						copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
					_card:add_to_deck()
					_card:set_banana(true)
					_card.ability.perishable = true -- Done manually to bypass perish compat
					_card.ability.perish_tally = G.GAME.perishable_rounds
					G.jokers:emplace(_card)
					return nil, true
				else
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_no_room_ex") }
					)
				end
			else
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_no_other_jokers") }
				)
			end
		end
	end,
	cry_credits = {
		idea = {
			"SDM_0",
		},
		art = {
			"SDM_0",
		},
		code = {
			"SDM_0",
		},
	},
}
local morse = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-morse",
	key = "morse",
	pos = { x = 5, y = 1 },
	config = {
		extra = {
			bonus = 2,
			money = 1,
		},
	},
	gameset_config = {
		modest = {
			extra = {
				bonus = 1,
				money = 1,
			},
		},
	},
	rarity = 1,
	cost = 5,
	order = 57,
	perishable_compat = false,
	blueprint_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.bonus),
				number_format(center.ability.extra.money),
			},
		}
	end,
	atlas = "atlastwo",
	calculate = function(self, card, context)
		if context.selling_card and context.card.edition and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "money",
				scalar_value = "bonus",
			})
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "money",
				scalar_value = "bonus",
				no_message = true,
			})
			ease_dollars(lenient_bignum(card.ability.extra.money))
		end
	end,
	calc_dollar_bonus = function(self, card)
		if to_big(card.ability.extra.money) > to_big(0) then
			return lenient_bignum(card.ability.extra.money)
		end
	end,
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
}
local membershipcard = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-membershipcard",
	key = "membershipcard",
	config = { extra = { Xmult_mod = 0.1 } },
	pos = { x = 6, y = 2 },
	soul_pos = { x = 6, y = 1 },
	rarity = 4,
	cost = 20,
	order = 35,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasthree",
	loc_vars = function(self, info_queue, card)
		local aaa
		if not Cryptid_config.HTTPS then
			if G.localization.descriptions.Other.cry_https_disabled then
				aaa = {}
				localize({ type = "other", key = "cry_https_disabled", nodes = aaa, vars = {} })
				aaa = aaa[1]
			end
		end
		return {
			vars = {
				number_format(card.ability.extra.Xmult_mod),
				number_format(lenient_bignum(to_big(card.ability.extra.Xmult_mod) * Cryptid.member_count)),
			},
			main_end = aaa,
		}
	end,
	calculate = function(self, card, context)
		if
			(context.joker_main and to_big(card.ability.extra.Xmult_mod) * to_big(Cryptid.member_count) > to_big(1))
			or context.forcetrigger
		then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = {
						number_format(lenient_bignum(to_big(card.ability.extra.Xmult_mod) * Cryptid.member_count)),
					},
				}),
				Xmult_mod = lenient_bignum(to_big(card.ability.extra.Xmult_mod) * Cryptid.member_count),
			}
		end
	end,
	cry_credits = {
		idea = {
			"Toneblock",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Toneblock",
		},
	},
}
local kscope = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-kscope",
	key = "kscope",
	pos = { x = 3, y = 4 },
	rarity = 3,
	cost = 7,
	order = 55,
	atlas = "atlasthree",
	demicoloncompat = true,
	immutable = true,
	calculate = function(self, card, context)
		if
			(
				context.end_of_round
				and G.GAME.blind.boss
				and not context.individual
				and not context.repetition
				and not context.blueprint
			) or context.forcetrigger
		then
			local eligiblejokers = {}
			for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.edition and v ~= card then
					table.insert(eligiblejokers, v)
				end
			end
			if #eligiblejokers > 0 then
				--you just lost the game
				local eligible_card =
					pseudorandom_element(eligiblejokers, pseudoseed("nevergonnagiveyouupnevergonnaletyoudown"))
				local edition = { polychrome = true }
				eligible_card:set_edition(edition, true)
				check_for_unlock({ type = "have_edition" })
				if not context.retrigger_joker then
					card:juice_up(0.5, 0.5)
				end
			end
		end
	end,
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
}
local cryptidmoment = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry_cryptidmoment",
	key = "cryptidmoment",
	pos = { x = 6, y = 0 },
	config = {
		extra = { money = 1 },
		immutable = { max_added_val = 1 },
	},
	loc_vars = function(self, info_queue, center)
		return { vars = { math.max(center.ability.immutable.max_added_val, math.floor(center.ability.extra.money)) } }
	end,
	rarity = 1,
	cost = 4,
	order = 65,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	atlas = "atlasthree",
	calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger then
			for k, v in ipairs(G.jokers.cards) do
				if v.set_cost then
					v.ability.extra_value = (v.ability.extra_value or 0)
						+ math.max(card.ability.immutable.max_added_val, math.floor(card.ability.extra.money))
					v:set_cost()
				end
			end
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_val_up"), colour = G.C.MONEY }
			)
		end
	end,
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"Yamper",
		},
		code = {
			"Jevonn",
		},
	},
}
local flipside = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"e_cry_double_sided",
		},
	},
	name = "cry-Flip Side",
	key = "flip_side",
	pos = { x = 3, y = 6 },
	rarity = 2,
	cost = 7,
	order = 107,
	atlas = "atlastwo",
	no_dbl = true,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_double_sided
	end,
	add_to_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].edition and G.jokers.cards[i].edition.cry_double_sided then
				G.jokers.cards[i]:remove_from_deck(true)
				local dummy = G.jokers.cards[i]:get_other_side_dummy()
				if dummy then
					Card.add_to_deck(dummy, true)
				end
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].edition and G.jokers.cards[i].edition.cry_double_sided then
				G.jokers.cards[i]:add_to_deck(true)
				local dummy = G.jokers.cards[i]:get_other_side_dummy(true)
				if dummy then
					dummy.added_to_deck = true
					Card.remove_from_deck(dummy, true)
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
			if context.other_context and context.other_card.edition and context.other_card.edition.cry_double_sided then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
	end,
	cry_credits = {
		idea = {
			"Axolotus",
		},
		art = {
			"Pyrocreep",
		},
		code = {
			"Math",
			"lord-ruby",
		},
	},
}
local oldinvisible = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Old Invisible Joker",
	key = "oldinvisible",
	pos = { x = 4, y = 4 },
	config = { extra = 0 },
	rarity = 4,
	cost = 20,
	order = 78,
	atlas = "atlasthree",
	immutable = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	calculate = function(self, card, context)
		if
			(
				context.selling_card
				and context.card.ability.set == "Joker"
				and not context.blueprint
				and not context.retrigger_joker
			) or context.forcetrigger
		then
			if card.ability.extra >= 3 then
				card.ability.extra = 0
				local eligibleJokers = {}
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].ability.name ~= card.ability.name and G.jokers.cards[i] ~= context.card then
						eligibleJokers[#eligibleJokers + 1] = G.jokers.cards[i]
					end
				end
				if #eligibleJokers > 0 then
					G.E_MANAGER:add_event(Event({
						func = function()
							local card =
								copy_card(pseudorandom_element(eligibleJokers, pseudoseed("cry_oldinvis")), nil)
							card:add_to_deck()
							G.jokers:emplace(card)
							return true
						end,
					}))
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_duplicated_ex") }
					)
					return nil, true
				else
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_no_other_jokers") }
					)
				end
				return
			else
				card.ability.extra = card.ability.extra + 1
				if card.ability.extra == 3 then
					local eval = function(card)
						return (card.ability.extra == 3)
					end
					juice_card_until(card, eval, true)
				end
				return {
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = card.ability.extra .. "/4",
						colour = G.C.FILTER,
					}),
				}
			end
		end
	end,
	cry_credits = {
		idea = {
			"LocalThunk",
		},
		art = {
			"LocalThunk",
		},
		code = {
			"Jevonn",
		},
	},
}
local fractal = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
		},
	},
	name = "cry-FractalFingers",
	key = "fractal",
	pos = { x = 6, y = 4 },
	config = { extra = 2 },
	rarity = 3,
	cost = 7,
	order = 76,
	atlas = "atlasthree",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra = math.min(math.floor(card.ability.extra), 1000)
		SMODS.change_play_limit(card.ability.extra)
		SMODS.change_discard_limit(card.ability.extra)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1 * card.ability.extra)
		SMODS.change_discard_limit(-1 * card.ability.extra)
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"HexaCryonic",
		},
	},
}
local universe = {
	cry_credits = {
		idea = { "Mystic Misclick" },
		art = { "spire_winder" },
		code = { "spire_winder" },
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"e_cry_astral",
		},
	},
	name = "cry-universe",
	key = "universe",
	pos = { x = 8, y = 0 },
	atlas = "atlasthree",
	config = { extra = { emult = 1.2 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return { vars = { number_format(center.ability.extra.emult) } }
	end,
	rarity = 3,
	cost = 6,
	order = 121,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.cry_astral == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.extra.emult) },
				}),
				Emult_mod = lenient_bignum(card.ability.extra.emult),
				colour = G.C.DARK_EDITION,
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.cry_astral == true then
				return {
					e_mult = lenient_bignum(card.ability.extra.emult),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.cry_astral == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					e_mult = lenient_bignum(card.ability.extra.emult),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				e_mult = lenient_bignum(card.ability.extra.emult),
				colour = G.C.DARK_EDITION,
				card = card,
			}
		end
	end,
}
local astral_bottle = {
	cry_credits = {
		idea = { "AlexZGreat" },
		art = { "spire_winder" },
		code = { "spire_winder" },
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"e_cry_astral",
		},
	},
	name = "cry-astral_bottle",
	extra_gamesets = { "exp_modest", "exp_mainline", "exp_madness" },
	key = "astral_bottle",
	eternal_compat = false,
	pos = { x = 7, y = 0 },
	atlas = "atlasthree",
	rarity = 2,
	cost = 6,
	order = 122,
	blueprint_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return {
			key = Cryptid.gameset_loc(
				self,
				{ exp_modest = "mainline", exp_mainline = "mainline", exp_madness = "madness" }
			),
		}
	end,
	calculate = function(self, card, context)
		if (context.selling_self and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
			local g = Cryptid.gameset(card)
			local effect = { { astral = true, perishable = true } }
			if g == "exp_modest" or g == "exp_mainline" then
				effect = { { astral = true }, { perishable = true } }
			end
			if g == "exp_madness" then
				effect = { { astral = true } }
			end
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].debuff and not G.jokers.cards[i].edition then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers >= #effect then
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_duplicated_ex") })
				for i = 1, #effect do
					local chosen_joker = pseudorandom_element(jokers, pseudoseed("astral_bottle"))
					if effect[i].astral then
						chosen_joker:set_edition({ cry_astral = true })
					end
					if effect[i].perishable then
						chosen_joker.ability.perishable = true -- Done manually to bypass perish compat
						chosen_joker.ability.perish_tally = G.GAME.perishable_rounds
					end
					for i = 1, #jokers do
						if jokers[i] == chosen_joker then
							table.remove(jokers, i)
							break
						end
					end
				end
				return nil, true
			else
				card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_no_other_jokers") })
			end
		end
	end,
}
local kittyprinter = {
	dependencies = {
		items = {
			"tag_cry_cat",
		},
	},
	object_type = "Joker",
	name = "cry-kittyprinter",
	key = "kittyprinter",
	config = { extra = { Xmult = 2 } },
	pos = { x = 3, y = 5 },
	rarity = 2,
	cost = 6,
	atlas = "atlasone",
	order = 133,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.Xmult) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.Xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
			}
		end
	end,
}
local kidnap = {
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	object_type = "Joker",
	name = "cry-kidnap",
	key = "kidnap",
	order = 23,
	pos = { x = 1, y = 2 },
	config = {
		extra = { money = 4 },
	},
	gameset_config = {
		modest = {
			extra = {
				money = 1,
			},
		},
	},
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_jolly
		info_queue[#info_queue + 1] = G.P_CENTERS.j_zany
		info_queue[#info_queue + 1] = G.P_CENTERS.j_mad
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crazy
		info_queue[#info_queue + 1] = G.P_CENTERS.j_droll
		info_queue[#info_queue + 1] = G.P_CENTERS.j_sly
		info_queue[#info_queue + 1] = G.P_CENTERS.j_wily
		info_queue[#info_queue + 1] = G.P_CENTERS.j_clever
		info_queue[#info_queue + 1] = G.P_CENTERS.j_devious
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crafty
		local value = 0
		if G.GAME and G.GAME.jokers_sold then
			for _, v in ipairs(G.GAME.jokers_sold) do
				if
					G.P_CENTERS[v].effect == "Type Mult"
					or G.P_CENTERS[v].effect == "Cry Type Mult"
					or G.P_CENTERS[v].effect == "Cry Type Chips"
					or G.P_CENTERS[v].effect == "Boost Kidnapping"
					or (
						G.P_CENTERS[v].name == "Sly Joker"
						or G.P_CENTERS[v].name == "Wily Joker"
						or G.P_CENTERS[v].name == "Clever Joker"
						or G.P_CENTERS[v].name == "Devious Joker"
						or G.P_CENTERS[v].name == "Crafty Joker"
					)
				then
					value = value + 1
				end
			end
		end
		return {
			vars = {
				number_format(center.ability.extra.money),
				number_format(lenient_bignum(to_big(center.ability.extra.money) * value)),
			},
		}
	end,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if context.forcetrigger then
			local value = 0
			for _, v in ipairs(G.GAME.jokers_sold) do
				if
					G.P_CENTERS[v].effect == "Type Mult"
					or G.P_CENTERS[v].effect == "Cry Type Mult"
					or G.P_CENTERS[v].effect == "Cry Type Chips"
					or G.P_CENTERS[v].effect == "Boost Kidnapping"
					or (
						G.P_CENTERS[v].name == "Sly Joker"
						or G.P_CENTERS[v].name == "Wily Joker"
						or G.P_CENTERS[v].name == "Clever Joker"
						or G.P_CENTERS[v].name == "Devious Joker"
						or G.P_CENTERS[v].name == "Crafty Joker"
					)
				then
					value = value + 1
				end
			end
			ease_dollars(lenient_bignum(to_big(card.ability.extra.money) * value) or 0)
		end
	end,
	calc_dollar_bonus = function(self, card)
		local value = 0
		for _, v in ipairs(G.GAME.jokers_sold) do
			if
				G.P_CENTERS[v].effect == "Type Mult"
				or G.P_CENTERS[v].effect == "Cry Type Mult"
				or G.P_CENTERS[v].effect == "Cry Type Chips"
				or G.P_CENTERS[v].effect == "Boost Kidnapping"
				or (
					G.P_CENTERS[v].name == "Sly Joker"
					or G.P_CENTERS[v].name == "Wily Joker"
					or G.P_CENTERS[v].name == "Clever Joker"
					or G.P_CENTERS[v].name == "Devious Joker"
					or G.P_CENTERS[v].name == "Crafty Joker"
				)
			then
				value = value + 1
			end
		end
		if value == 0 then
			return
		end
		return lenient_bignum(to_big(card.ability.extra.money) * value)
	end,
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
}
local exposed = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Exposed",
	key = "exposed",
	pos = { x = 0, y = 5 },
	config = {
		extra = { retriggers = 2 },
		immutable = { max_retriggers = 40 },
	},
	rarity = 3,
	cost = 8,
	order = 123,
	atlas = "atlastwo",
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	update = function(self, card, dt)
		if G.deck and card.added_to_deck then
			for i, v in pairs(G.deck.cards) do
				if v:is_face() then
					v:set_debuff(true)
				end
			end
		end
		if G.hand and card.added_to_deck then
			for i, v in pairs(G.hand.cards) do
				if v:is_face() then
					v:set_debuff(true)
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if not context.other_card:is_face() then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
					),
					card = card,
				}
			end
		end
	end,
}
local mask = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Mask",
	key = "mask",
	pos = { x = 1, y = 5 },
	config = {
		extra = { retriggers = 3 },
		immutable = { max_retriggers = 40 },
	},
	rarity = 3,
	cost = 7,
	atlas = "atlastwo",
	order = 124,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	update = function(self, card, dt)
		if G.deck and card.added_to_deck then
			for i, v in pairs(G.deck.cards) do
				if not v:is_face() then
					v:set_debuff(true)
				end
			end
		end
		if G.hand and card.added_to_deck then
			for i, v in pairs(G.hand.cards) do
				if not v:is_face() then
					v:set_debuff(true)
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:is_face() then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
					),
					card = card,
				}
			end
		end
	end,
}
local tropical_smoothie = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Tropical Smoothie",
	key = "tropical_smoothie",
	pos = { x = 2, y = 5 },
	config = { extra = 1.5 },
	rarity = 3,
	eternal_compat = false,
	demicoloncompat = true,
	cost = 5,
	order = 125,
	atlas = "atlastwo",
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra) } }
	end,
	calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger then
			local check = false
			for i, v in pairs(G.jokers.cards) do
				if v ~= card then
					if not Card.no(v, "immutable", true) then
						Cryptid.manipulate(v, { value = card.ability.extra })
						check = true
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end
	end,
	cry_credits = {
		art = {
			"Ori",
		},
	},
}
local pumpkin = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	key = "pumpkin",
	pos = { x = 0, y = 6 },
	rarity = 3,
	cost = 10,
	atlas = "atlastwo",
	order = 131,
	config = {
		extra = {
			scoreReq = 50,
			enabled = true,
		},
	},
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.scoreReq) } }
	end,
	calculate = function(self, card, context)
		if
			context.game_over
			and to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(card.ability.extra.scoreReq / 100)
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound("tarot1")
					return true
				end,
			}))
			return {
				message = localize("k_saved_ex"),
				saved = true,
				colour = G.C.RED,
			}
		end

		if context.selling_self then
			card.ability.extra.enabled = false
		end

		if context.cry_start_dissolving and context.card == card and card.ability.extra.enabled == true then
			local newcard = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_carved_pumpkin")
			newcard:add_to_deck()
			G.jokers:emplace(newcard)
		end
	end,
	cry_credits = {
		idea = {
			"Squiddy",
		},
		art = {
			"B",
		},
		code = {
			"wawa person",
		},
	},
}
local carved_pumpkin = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	key = "carved_pumpkin",
	pos = { x = 1, y = 6 },
	rarity = 3,
	cost = 10,
	atlas = "atlastwo",
	order = 132,
	config = { extra = { disables = 5 } },
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.disables) } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
			if G.GAME.blind:get_type() == "Boss" then
				card.ability.extra.disables = lenient_bignum(to_big(card.ability.extra.disables) - 1)
				card:juice_up()
				if card.ability.extra.disables <= 0 then
					card:start_dissolve()
				end
			end
		end
		if context.setting_blind and G.GAME.blind:get_type() == "Boss" and not G.GAME.blind.disabled then
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("ph_boss_disabled") }
			)
			G.GAME.blind:disable()
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return false
	end,
	cry_credits = {
		idea = {
			"Squiddy",
		},
		art = {
			"B",
		},
		code = {
			"wawa person",
		},
	},
}
local cookie = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	key = "clicked_cookie",
	pos = { x = 2, y = 6 },
	rarity = 1,
	cost = 4,
	atlas = "atlastwo",
	order = 133,
	config = {
		extra = {
			chips = 200,
			chip_mod = 1,
		},
	},
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.chips),
				number_format(center.ability.extra.chip_mod),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				card = card,
				chip_mod = lenient_bignum(card.ability.extra.chips),
				message = "+" .. number_format(card.ability.extra.chips),
				colour = G.C.CHIPS,
				operation = "-",
			}
		end
		if context.cry_press then
			if to_big(card.ability.extra.chips) - to_big(card.ability.extra.chip_mod) <= to_big(0) then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_eaten_ex"), colour = G.C.CHIPS }
				)
			else
				SMODS.scale_card(card, {
					operation = "-",
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_mod",
					scaling_message = {
						message = "-" .. number_format(card.ability.extra.chip_mod),
						colour = G.C.CHIPS,
					},
				})
			end
		end
	end,
	cry_credits = {
		idea = {
			"playerrWon",
		},
		art = {
			"lolxDdj",
		},
		code = {
			"wawa person",
		},
	},
}
local necromancer = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Necromancer",
	key = "necromancer",
	pos = { x = 3, y = 5 },
	config = {
		extra = {},
		immutable = { sell_cost_min = 0 },
	},
	rarity = 2,
	cost = 5,
	atlas = "atlastwo",
	order = 126,
	immutable = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.immutable.sell_cost_min } }
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and context.card.sell_cost > card.ability.immutable.sell_cost_min
			and context.card.config.center.set == "Joker"
			and G.GAME.jokers_sold
			and #G.GAME.jokers_sold > 0
			and not context.blueprint
			and not context.retrigger_joker
		then
			local new_card = create_card(
				"Joker",
				G.jokers,
				nil,
				nil,
				nil,
				nil,
				G.GAME.jokers_sold[pseudorandom("cry_necromancer", 1, #G.GAME.jokers_sold)]
			)
			new_card.sell_cost = card.ability.immutable.sell_cost_min
			new_card:add_to_deck()
			G.jokers:emplace(new_card)
			new_card:start_materialize()
		end
	end,
	cry_credits = {
		idea = {
			"Pyrocreep",
		},
		art = {
			"Pyrocreep",
		},
		code = {
			"Foegro",
		},
	},
}
local oil_lamp = { --You want it? It's yours my friend
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Oil-Lamp",
	key = "oil_lamp",
	pos = { x = 4, y = 5 },
	config = { extra = { increase = 1.2 } },
	rarity = 3,
	cost = 10,
	order = 127,
	atlas = "atlastwo",
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			vars = { number_format(card.ability.extra.increase) },
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
				end
			end
			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							check = true
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = card.ability.extra.increase })
						end
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end
	end,
	cry_credits = {
		idea = {
			"AlexZGreat",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"Foegro",
		},
	},
}
local tax_fraud = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Tax-Fraud",
	key = "tax_fraud",
	pos = { x = 4, y = 6 },
	config = { extra = { money = 6 } },
	rarity = 3,
	cost = 10,
	order = 128,
	atlas = "atlastwo",
	demicoloncompat = true,
	in_pool = function(self)
		if not G.GAME.modifiers.enable_rentals_in_shop then
			return false
		end
		return true
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.money) } }
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			ease_dollars(
				lenient_bignum(
					to_big(card.ability.extra.money) * #Cryptid.advanced_find_joker(nil, nil, nil, { "rental" }, true)
				)
			)
		end
	end,
	calc_dollar_bonus = function(self, card)
		if #Cryptid.advanced_find_joker(nil, nil, nil, { "rental" }, true) ~= 0 then
			return lenient_bignum(
				to_big(card.ability.extra.money) * #Cryptid.advanced_find_joker(nil, nil, nil, { "rental" }, true)
			)
		end
	end,
	cry_credits = {
		idea = {
			"DoNotSus",
		},
		art = {
			"Dragokillfist",
		},
		code = {
			"Foegro",
		},
	},
}

local pity_prize = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Pity-Prize",
	key = "pity_prize",
	pos = { x = 5, y = 5 },
	config = {},
	rarity = 1,
	cost = 2,
	atlas = "atlastwo",
	order = 129,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { key = Cryptid.gameset_loc(self, { modest = "modest" }), vars = {} }
	end,
	calculate = function(self, card, context)
		if context.skipping_booster or context.forcetrigger then
			local tag_key
			repeat
				tag_key = get_next_tag_key("cry_pity_prize")
			until tag_key ~= "tag_boss" and tag_key ~= "tag_cry_gambler" --I saw pickle not generating boss tags because it apparently causes issues, so I did the same here

			local tag = Cryptid.get_next_tag()
			if tag then
				tag_key = tag
			end

			-- this is my first time seeing repeat... wtf
			-- ^^ using repeat...until in this economy? absurd!
			local tag = Tag(tag_key)
			tag.ability.shiny = Cryptid.is_shiny()
			if tag.name == "Orbital Tag" then
				local _poker_hands = {}
				for k, v in pairs(G.GAME.hands) do
					if v.visible then
						_poker_hands[#_poker_hands + 1] = k
					end
				end
				tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("cry_pity_prize"))
			end
			add_tag(tag)
			if
				Card.get_gameset(card) == "modest"
				and ((not context.blueprint and not context.retrigger_joker) or context.forcetrigger)
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_extinct_ex"), colour = G.C.FILTER }
				)
			end
			return nil, true
		end
	end,
	cry_credits = {
		idea = {
			"Pyrocreep",
		},
		art = {
			"Pyrocreep",
		},
		code = {
			"Foegro",
		},
	},
}
local digitalhallucinations = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Digital Hallucinations",
	key = "digitalhallucinations",
	pos = { x = 0, y = 7 },
	order = 130,
	config = { odds = 2 },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { SMODS.get_probability_vars(card, 1, card.ability.odds, "Digital Hallucinations") },
		}
	end,
	atlas = "atlasthree",
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	calculate = function(self, card, context)
		-- you know, i was totally ready to do something smart here but vanilla hardcodes this stuff, so i will too
		-- some cards need to be handled slightly differently anyway, adding mod support can't really be automatic in some circumstances
		if
			context.open_booster
			and (SMODS.pseudorandom_probability(card, "digi", 1, card.ability.odds, "Digital Hallucinations"))
		then
			local boosty = context.card
			-- finally mod compat?
			if boosty.config.center.cry_digital_hallucinations then
				local conf = boosty.config.center.cry_digital_hallucinations
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						conf.create()
						return true
					end,
				}))
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize(conf.loc_key), colour = conf.colour }
				)
				return nil, true
			end
			local consums = { "Arcana", "Celestial", "Spectral" }
			local short1 = { "tarot", "planet", "spectral" }
			local short2 = { "Tarot", "Planet", "Spectral" }
			for i = 1, #consums do
				if boosty.ability.name:find(consums[i]) then
					G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.0,
						func = function()
							local ccard = create_card(short2[i], G.consumeables, nil, nil, nil, nil, nil, "diha")
							ccard:set_edition({ negative = true }, true)
							ccard:add_to_deck()
							G.consumeables:emplace(ccard)
							return true
						end,
					}))
					card_eval_status_text(
						context.blueprint_card or card,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("k_plus_" .. short1[i]), colour = G.C.SECONDARY_SET[short2[i]] }
					)
					return nil, true -- this triggers BEFORE a retrigger joker and looks like jank. i can't get a message showing up without status text so this is the best option rn
				end
			end
			if boosty.ability.name:find("Buffoon") then
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						local ccard = create_card(
							boosty.ability.name:find("meme") and "Meme" or "Joker",
							G.jokers,
							nil,
							nil,
							nil,
							nil,
							nil,
							"diha"
						) -- who up wasting their cycles rn
						ccard:set_edition({ negative = true }, true)
						ccard:add_to_deck()
						G.jokers:emplace(ccard)
						ccard:start_materialize()
						return true
					end,
				}))
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_plus_joker"), colour = G.C.FILTER }
				)
				return nil, true
			end
			if boosty.ability.name:find("Standard") then
				G.E_MANAGER:add_event(Event({
					func = function()
						local front = pseudorandom_element(G.P_CARDS, pseudoseed("diha_p"))
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local ccard = Card(
							G.play.T.x + G.play.T.w / 2,
							G.play.T.y,
							G.CARD_W,
							G.CARD_H,
							front,
							G.P_CENTERS.c_base,
							{ playing_card = G.playing_card }
						)
						ccard:set_edition({ negative = true }, true)
						ccard:start_materialize({ G.C.SECONDARY_SET.Enhanced })
						G.play:emplace(ccard)
						playing_card_joker_effects({ ccard }) -- odd timing
						table.insert(G.playing_cards, ccard)
						return true
					end,
				}))
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("cry_plus_card"), colour = G.C.FILTER }
				)

				G.E_MANAGER:add_event(Event({
					func = function()
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						return true
					end,
				}))
				draw_card(G.play, G.deck, 90, "up", nil)
				return nil, true
			end
		end
	end,
	cry_credits = {
		idea = {
			"lolxddj",
		},
		art = {
			"lolxddj",
		},
		code = {
			"toneblock",
		},
	},
}
local arsonist = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Arsonist",
	key = "arsonist",
	pos = { x = 0, y = 5 },
	config = {},
	rarity = 3,
	cost = 5,
	atlas = "atlasone",
	order = 131,
	loc_vars = function(self, info_queue, center)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.destroying_card then
			local eval = evaluate_poker_hand(context.full_hand)
			if next(eval["Full House"]) then
				return not SMODS.is_eternal(context.destroying_card)
			end
		end
	end,
	cry_credits = {
		idea = {
			"AlexZGreat",
		},
		art = {
			"Darren_The_Frog",
		},
		code = {
			"AlexZGreat",
		},
	},
}
local zooble = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-Zooble",
	key = "zooble",
	pos = { x = 1, y = 5 },
	config = {
		extra = {
			mult = 0,
			a_mult = 1,
		},
	},
	rarity = 2,
	cost = 6,
	atlas = "atlasone",
	order = 132,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.mult),
				number_format(center.ability.extra.a_mult),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			if not (next(context.poker_hands["Straight"]) or next(context.poker_hands["Straight Flush"])) then
				local unique_ranks = {}
				for i, v in pairs(context.scoring_hand) do
					if not (SMODS.has_no_rank(v) and not v.vampired) then
						local not_unique = false
						for i = 1, #unique_ranks do
							if unique_ranks[i] == v:get_id() then
								not_unique = true
							end
						end
						if not not_unique then
							unique_ranks[#unique_ranks + 1] = v:get_id()
						end
					end
				end
				if #unique_ranks >= 1 then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "mult",
						scalar_value = "a_mult",
						operation = function(ref_table, ref_value, initial, scaling)
							ref_table[ref_value] = initial + scaling * #unique_ranks
						end,
					})
				end
			end
		end
		if context.joker_main and to_big(card.ability.extra.mult) > to_big(0) then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
			}
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "a_mult",
				message_key = "a_mult",
				message_colour = G.C.RED,
			})
			return {
				mult_mod = lenient_bignum(card.ability.extra.mult),
			}
		end
	end,
	cry_credits = {
		idea = {
			"lolxDdj",
		},
		art = {
			"lolxDdj",
		},
		code = {
			"AlexZGreat",
		},
	},
}
local lebaron_james = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-LeBaron James",
	pools = { ["Meme"] = true },
	key = "lebaron_james",
	pos = { x = 2, y = 5 },
	config = {
		extra = { h_mod = 1 },
		immutable = {
			max_h_mod = 1000,
			added_h = 0,
		},
	},
	blueprint_compat = true,
	rarity = 3,
	cost = 6,
	atlas = "atlasone",
	order = 133,
	no_dbl = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.h_mod, center.ability.immutable.added_h } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if context.other_card:get_id() == 13 then
				local h_mod = card.ability.extra.h_mod
				local added_h = card.ability.immutable.added_h
				local max_h_mod = card.ability.immutable.max_h_mod

				local available_h = math.max(0, max_h_mod - added_h)
				local h_size = to_number(math.max(0, math.min(available_h, h_mod)))

				if h_size > 0 then
					-- Apply hand size bonus
					G.hand:change_size(math.floor(h_size))
					G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + math.floor(h_size)

					-- Update the added_h tracker
					card.ability.immutable.added_h = added_h + math.floor(h_size)

					return {
						message = localize({ type = "variable", key = "a_handsize", vars = { math.floor(h_size) } }),
						colour = G.C.FILTER,
						card = card,
					}
				end
			end
		elseif
			context.end_of_round
			and not context.repetition
			and not context.individual
			and not context.blueprint
			and not context.retrigger_joker
		then
			card.ability.immutable.added_h = 0
		end
	end,
	cry_credits = {
		idea = {
			"indefenite_idiot",
			"HexaCryonic",
		},
		code = {
			"AlexZGreat",
		},
		art = {
			"lamborghiniofficial",
		},
	},
	init = function(self)
		-- Calculate enhancements for kings as if held in hand
		-- Note that for enhancements that work when played and held in hand, this will fail
		-- Not tested since no enhancements use this yet (Steel is weird, and Gold won't work)
		local cce = Card.calculate_enhancement
		function Card:calculate_enhancement(context)
			local ret = cce(self, context)
			if
				not ret
				and next(SMODS.find_card("j_cry_lebaron_james"))
				and SMODS.Ranks[self.base.value].key == "King"
				and context.cardarea == G.play
			then
				context.cardarea = G.hand
				local ret = cce(self, context)
				context.cardarea = G.play
			end
			return ret
		end
	end,
}
local huntingseason = { -- If played hand contains three cards, destroy the middle card after scoring
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-huntingseason",
	key = "huntingseason",
	pos = { x = 4, y = 5 },
	order = 134,
	immutable = true,
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	atlas = "atlasone",
	calculate = function(self, card, context)
		if
			(context.cardarea == G.play or context.cardarea == "unscored")
			and context.destroy_card == context.full_hand[2]
			and #context.full_hand == 3 -- 3 cards in played hand
			and not context.blueprint
			and not context.retrigger_joker
		then
			return { remove = not SMODS.is_eternal(context.destroy_card) }
		end
	end,
	cry_credits = {
		art = {
			"Unexian",
		},
		idea = {
			"Nova",
		},
		code = {
			"Nova",
		},
	},
}
local cat_owl = { -- Lucky Cards are considered Echo Cards and vice versa
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
			"m_cry_echo",
			"set_cry_misc",
		},
	},
	name = "cry-cat_owl",
	pools = { ["Meme"] = true },
	key = "cat_owl",
	pos = { x = 6, y = 5 },
	order = 135,
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_echo
	end,
	calculate = function(self, card, context)
		if context.check_enhancement then
			if context.other_card.config.center.key == "m_lucky" then
				return { m_cry_echo = true }
			end
			if context.other_card.config.center.key == "m_cry_echo" then
				return { m_lucky = true }
			end
		end
	end,
	cry_credits = {
		idea = {
			"Math",
		},
		code = {
			"Math",
		},
		art = {
			"George the Rat",
		},
	},
}
local eyeofhagane = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-eyeofhagane",
	key = "eyeofhagane",
	order = 136,
	pos = { x = 5, y = 6 },
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	immutable = true,
	atlas = "atlastwo", -- https://discord.com/channels/1264429948970733782/1274103559113150629/1351479917367263312
	calculate = function(self, card, context)
		if context.before then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then
					faces[#faces + 1] = v
					v:set_ability(G.P_CENTERS.m_steel, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end,
					}))
				end
			end
			if #faces > 0 then
				return {
					message = "Steel",
					colour = G.C.UI.TEXT_INACTIVE,
					card = self,
				}
			end
		end
	end,
	cry_credits = {
		idea = { "Soren" },
		code = { "Lexi" },
		art = { "Soren" },
	},
}
-- At the end of round: if the player has more than 19$ take away 19$ and make a random meme Joker
local familiar_currency = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry-Familiar Currency",
	key = "familiar_currency",
	pos = { x = 0, y = 6 },
	config = { extra = 19 },
	order = 137,
	rarity = 3,
	cost = 0,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "atlasone",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not (context.blueprint_card or card).getting_sliced
		then
			if
				to_big(G.GAME.dollars - G.GAME.bankrupt_at) >= to_big(card.ability.extra)
				and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
			then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				ease_dollars(-card.ability.extra)
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({ set = "Meme", key_append = "fcc" })
						G.GAME.joker_buffer = 0
						return true
					end,
				}))
				card_eval_status_text(
					context.blueprint_card or card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_plus_joker"), colour = G.C.BLUE }
				)
			end
		end
		if context.forcetrigger then
			ease_dollars(-card.ability.extra)
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({ set = "Meme", key_append = "fcc" })
					G.GAME.joker_buffer = 0
					return true
				end,
			}))
		end
	end,
	cry_credits = {
		idea = {
			"Gud Username",
			"y_not_tony",
		},
		code = {
			"SDM_0",
		},
		art = {
			"Gud Username",
		},
	},
}
local highfive = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-highfive",
	key = "highfive",
	order = 137,
	atlas = "atlastwo",
	pos = { x = 4, y = 1 },
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	rarity = 3,
	cost = 5,
	calculate = function(self, card, context)
		if context.final_scoring_step then
			local maximum = -1
			local fives = 0
			for k, v in ipairs(context.scoring_hand) do
				if not SMODS.has_no_rank(v) then
					local thunk = v:get_id() == 14 and 1 or v:get_id()
					if thunk == 5 then
						fives = fives + 1
					end
					if thunk > maximum then
						maximum = thunk
					end
				end
			end

			local whapoosh = false
			if maximum == 5 and fives ~= #context.scoring_hand then
				for index = 1, #context.scoring_hand do
					local v = context.scoring_hand[index]
					if v:get_id() ~= 5 and not SMODS.has_no_rank(v) then
						whapoosh = true
						G.E_MANAGER:add_event(Event({
							func = function()
								assert(SMODS.change_base(v, _, "5"))
								v:juice_up()
								return true
							end,
						}))
					end
				end

				if whapoosh then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound("cry_whapoosh")
							return true
						end,
					}))
					return {
						message = localize("cry_highfive_ex"),
					}
				end
			end
		end
	end,
	cry_credits = {
		idea = { "cassknows" },
		art = { "MarioFan597" },
		code = { "astrapboy" },
	},
}
local sock_and_sock = {
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
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"m_cry_abstract",
		},
	},
	name = "cry-sock_and_sock",
	key = "sock_and_sock",
	pos = { x = 6, y = 6 },
	config = {
		extra = { retriggers = 1 },
		immutable = { max_retriggers = 40 },
	},
	enhancement_gate = "m_cry_abstract",
	rarity = 2,
	cost = 7,
	order = 138,
	atlas = "atlastwo",
	blueprint_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_abstract
		return { vars = { math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers) } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_cry_abstract") then
				return {
					message = localize("k_again_ex"),
					repetitions = to_number(
						math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
					),
					card = card,
				}
			end
		end
	end,
}
local brokenhome = { -- X11.4 Mult, 1 in 4 chance to self-destruct at end of round
	cry_credits = {
		idea = {
			"Poppip10",
		},
		art = {
			"GeorgeTheRat",
		},
		code = {
			"gemstonez",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_meme",
		},
	},
	name = "cry_brokenhome",
	key = "brokenhome",
	atlas = "atlasthree",
	pos = { x = 1, y = 7 },
	rarity = 3,
	cost = 8,
	order = 139,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	config = { extra = { Xmult = 11.4, odds = 4 } },
	gameset_config = {
		modest = {
			extra = {
				Xmult = 3,
				odds = 4,
			},
		},
	},
	loc_vars = function(self, info_queue, card) -- the humble cavendish example mod:
		return {
			vars = {
				card.ability.extra.Xmult,
				SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Broken Home"),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult,
			}
		end
		if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "brokenhome", 1, card.ability.extra.odds, "Broken Home") then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("cry_divorced"),
					colour = G.C.FILTER,
				}
			else
				return {
					message = localize("k_safe_ex"),
					colour = G.C.FILTER,
				}
			end
		end
		if context.forcetrigger then
			if SMODS.pseudorandom_probability(card, "brokenhome", 1, card.ability.extra.odds, "Broken Home") then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
			end
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
				Xmult_mod = card.ability.extra.Xmult,
			}
		end
	end,
}

local yarnball = { -- +1 to all listed probabilities for the highest cat tag level
	cry_credits = {
		idea = {
			"Saturn",
		},
		art = {
			"Darren_The_Frog",
		},
		code = {
			"Lily Felli",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"tag_cry_cat",
		},
	},
	name = "cry_yarnball",
	key = "yarnball",
	atlas = "atlasthree",
	pos = { x = 2, y = 7 },
	rarity = 3,
	cost = 8,
	order = 140,
	demicoloncompat = false,
	in_pool = function(self)
		if not G.GAME.tags or #G.GAME.tags == 0 then
			return false
		end
		for _, tag in pairs(G.GAME.tags) do
			if tag.key == "tag_cry_cat" then
				return true
			end
		end
		return false
	end,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			local highest_cat_lvl = 0
			for _, tag in pairs(G.GAME.tags) do
				local lvl = tag.ability.level
				if highest_cat_lvl < 1 and tag.key == "tag_cry_cat" then
					highest_cat_lvl = 1
				end
				if lvl and lvl > highest_cat_lvl then
					highest_cat_lvl = lvl
				end
			end

			return {
				numerator = context.numerator + highest_cat_lvl,
			}
		end
	end,
}

local pizza = {
	cry_credits = {
		idea = {
			"Enemui",
		},
		art = {
			"George The Rat",
		},
		code = {
			"lord.ruby",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
			"j_cry_pizza_slice",
		},
	},
	name = "cry-pizza",
	key = "pizza",
	atlas = "atlastwo",
	pos = { x = 6, y = 5 },
	rarity = 3,
	cost = 8,
	order = 141,
	demicoloncompat = true,
	eternal_compat = false,
	blueprint_compat = true,
	config = { extra = { rounds_needed = 3, rounds_left = 3, slices = 6 }, immutable = { max_spawn = 100 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_cry_pizza_slice
		return {
			vars = {
				number_format(card.ability.extra.rounds_needed),
				number_format(card.ability.extra.rounds_left),
				number_format(math.min(card.ability.extra.slices, card.ability.immutable.max_spawn)),
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.retrigger_joker
			and not context.blueprint
			and not context.individual
			and not context.repetition
		then
			card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
			if to_big(card.ability.extra.rounds_left) < to_big(0) then
				card.ability.extra.rounds_left = 0
			else
				return {
					message = number_format(card.ability.extra.rounds_needed - card.ability.extra.rounds_left)
						.. "/"
						.. number_format(card.ability.extra.rounds_needed),
					colour = G.C.FILTER,
				}
			end
		end
		if context.selling_self or context.forcetrigger then
			if to_big(card.ability.extra.rounds_left) <= to_big(0) or context.forcetrigger then
				for i = 1, to_number(
					math.min(
						math.min(card.ability.extra.slices, card.ability.immutable.max_spawn),
						G.jokers.config.card_limit - #G.jokers.cards + 1
					)
				) do
					SMODS.add_card({
						key = "j_cry_pizza_slice",
						area = G.jokers,
					})
				end
			end
		end
	end,
}

local pizza_slice = {
	cry_credits = {
		idea = {
			"Enemui",
		},
		art = {
			"George The Rat",
		},
		code = {
			"lord.ruby",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-pizza_slice",
	key = "pizza_slice",
	atlas = "atlastwo",
	pos = { x = 6, y = 4 },
	rarity = 3,
	cost = 8,
	order = 141,
	in_pool = function()
		return false
	end,
	demicoloncompat = true,
	eternal_compat = false,
	blueprint_compat = true,
	config = { extra = { xmult = 1, xmult_mod = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.xmult_mod), number_format(card.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card and context.card.config.center.key == "j_cry_pizza_slice" then
			if context.card ~= card then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_mod",
					message_key = "a_xmult",
					message_colour = G.C.RED,
					no_message = context.forcetrigger,
				})
			end
		end
		if context.joker_main or context.forcetrigger then
			return {
				Xmult_mod = lenient_bignum(card.ability.extra.xmult),
			}
		end
	end,
}

local paved_joker = { -- +1 to all listed probabilities for the highest cat tag level
	cry_credits = {
		idea = {
			"InspectorB",
		},
		art = {
			"gemstonez",
		},
		code = {
			"lord.ruby",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-paved_joker",
	key = "paved_joker",
	atlas = "atlasone",
	pos = { x = 1, y = 6 },
	rarity = 1,
	cost = 4,
	order = 142,
	config = { extra = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(math.floor(card.ability.extra)) } }
	end,
}

local fading_joker = { -- +1 to all listed probabilities for the highest cat tag level
	cry_credits = {
		idea = {
			"DoNotSus",
		},
		art = {
			"lord.ruby",
		},
		code = {
			"lord.ruby",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-paved_joker",
	key = "fading_joker",
	atlas = "atlasone",
	pos = { x = 2, y = 6 },
	rarity = 2,
	cost = 6,
	order = 143,
	demicoloncompat = true,
	blueprint_compat = true,
	config = { extra = { xmult = 1, xmult_mod = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.xmult_mod), number_format(card.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.perishable_debuffed or context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_mod",
				message_key = "a_xmult",
				message_colour = G.C.RED,
				no_message = context.forcetrigger,
			})
		end
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.xmult),
			}
		end
	end,
	in_pool = function()
		for i, v in pairs(G.I.CARD) do
			if v.perishable and v.perish_tally and to_big(v.perish_tally) > to_big(0) then
				return true
			end
		end
	end,
	init = function()
		local calcuate_parishable_ref = Card.calculate_perishable
		function Card:calculate_perishable(...)
			if self.ability.perish_tally == 1 then
				SMODS.calculate_context({ perishable_debuffed = true, other_card = self, cardarea = self.area })
			end
			return calcuate_parishable_ref(self, ...)
		end
	end,
}

local poor_joker = { -- +1 to all listed probabilities for the highest cat tag level
	cry_credits = {
		idea = {
			"DoNotSus",
		},
		art = {
			"Darren_the_frog",
		},
		code = {
			"lord.ruby",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-poor_joker",
	key = "poor_joker",
	atlas = "atlasone",
	pos = { x = 3, y = 6 },
	rarity = 2,
	cost = 6,
	order = 144,
	demicoloncompat = true,
	blueprint_compat = true,
	config = { extra = { mult = 0, mult_mod = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.mult_mod), number_format(card.ability.extra.mult) } }
	end,
	calculate = function(self, card, context)
		if context.rental or context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_mod",
				message_key = "a_mult",
				message_colour = G.C.RED,
				no_message = context.forcetrigger,
			})
		end
		if context.joker_main or context.forcetrigger then
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { number_format(card.ability.extra.mult) },
				}),
				mult_mod = lenient_bignum(card.ability.extra.mult),
			}
		end
	end,
	in_pool = function()
		for i, v in pairs(G.I.CARD) do
			if v.rental then
				return true
			end
		end
	end,
	init = function()
		local calcuate_rental_ref = Card.calculate_rental
		function Card:calculate_rental(...)
			local ret = calcuate_rental_ref(self, ...)
			SMODS.calculate_context({ rental = true, other_card = self, cardarea = self.area })
			return ret
		end
	end,
}

-- Broken Sync Catalyst
-- Swaps 10% of chips with 10% of mult
local broken_sync = {
	cry_credits = {
		idea = {
			"arnideus",
		},
		art = {
			"Tatteredlurker",
		},
		code = {
			"InvalidOS",
		},
	},
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_misc_joker",
		},
	},
	name = "cry-broken_sync_catalyst",
	key = "broken_sync_catalyst",
	atlas = "atlastwo",
	pos = { x = 6, y = 3 },
	rarity = 3,
	cost = 8,
	order = 145,
	demicoloncompat = true,
	blueprint_compat = true,
	config = { extra = { portion = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(Cryptid.clamp(card.ability.extra.portion * 100, 0, 100)) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				cry_broken_swap = card.ability.extra.portion,
			}
		end
	end,
}

local thal = {
	cry_credits = {
		idea = {
			"ODanK8604",
		},
		art = {
			"Pangaea",
		},
		code = {
			"candycanearter",
		},
	},
	object_type = "Joker",
	name = "cry-thalia",
	key = "thalia",
	atlas = "atlasthree",
	pos = { x = 0, y = 8 },
	soul_pos = { x = 1, y = 8 },
	config = { extra = { xmgain = 1 } },
	rarity = 4,
	cost = 20,
	order = 145,
	demicoloncompat = true,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmgain, self:calc_xmult(card) } }
	end,

	calc_xmult = function(self, card)
		if not (G.jokers and G.jokers.cards) then
			return 1
		end

		local seen = {}
		for _, c in ipairs(G.jokers.cards) do
			local rarity = c.config.center.rarity
			if not seen[rarity] then
				seen[rarity] = 1
			end
		end

		-- because lua generates keys automatically we ahve to do this
		local n = 0
		for _, r in pairs(seen) do
			if r then
				n = n + 1
			end
		end

		-- n pick 2, or n!/(n-2)!, simplified bc of how lua is
		local bonus = (n * (n - 1)) / 2
		if bonus < 1 then
			return 1
		end
		return bonus * card.ability.extra.xmgain
	end,

	calculate = function(self, card, context)
		if context.joker_main or context.force_trigger then
			return { xmult = self:calc_xmult(card) }
		end
	end,
}

local keychange = {
	cry_credits = {
		idea = {
			"arnideus",
		},
		art = {
			"Tatteredlurker",
		},
		code = {
			"candycanearter",
		},
	},
	object_type = "Joker",
	name = "cry-keychange",
	key = "keychange",
	atlas = "placeholders",
	pos = { x = 1, y = 1 },
	config = { extra = { xm = 1, xmgain = 0.25 } },
	rarity = 2,
	cost = 5,
	order = 145,
	demicoloncompat = true,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmgain, card.ability.extra.xm } }
	end,

	calculate = function(self, card, context)
		if
			context.before
			and G.GAME.hands[context.scoring_name]
			and G.GAME.hands[context.scoring_name].played_this_round < 2
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xm",
				scalar_value = "mgain",
			})
		end

		if context.joker_main or context.force_trigger then
			return { xmult = card.ability.extra.xm }
		end

		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.xm = 1
			return { message = localize("k_reset") }
		end
	end,
}

local miscitems = {
	jimball_sprite,
	dropshot,
	happyhouse,
	maximized,
	potofjokes,
	queensgambit,
	wee_fib,
	compound_interest,
	whip,
	pickle,
	triplet_rhythm,
	booster,
	chili_pepper,
	lucky_joker,
	cursor,
	cube,
	big_cube,
	nice,
	sus,
	chad,
	jimball,
	waluigi,
	wario,
	eternalflame,
	seal_the_deal,
	fspinner,
	krustytheclown,
	blurred,
	gardenfork,
	lightupthenight,
	nosound,
	antennastoheaven,
	hunger,
	weegaming,
	redbloon,
	apjoker,
	maze,
	panopticon,
	magnet,
	unjust_dagger,
	monkey_dagger,
	pirate_dagger,
	mondrian,
	sapling,
	spaceglobe,
	happy,
	meteor,
	exoplanet,
	stardust,
	rnjoker,
	filler,
	duos,
	home,
	nuts,
	quintet,
	unity,
	swarm,
	coin,
	wheelhope,
	night,
	busdriver,
	oldblueprint,
	morse,
	membershipcard,
	kscope,
	cryptidmoment,
	oldinvisible,
	fractal,
	giggly,
	nutty,
	manic,
	silly,
	delirious,
	wacky,
	kooky,
	dubious,
	shrewd,
	tricksy,
	foxy,
	savvy,
	subtle,
	discreet,
	kittyprinter,
	kidnap,
	exposed,
	mask,
	tropical_smoothie,
	--pumpkin,
	--carved_pumpkin,
	cookie,
	necromancer,
	oil_lamp,
	tax_fraud,
	pity_prize,
	digitalhallucinations,
	arsonist,
	zooble,
	flipside,
	universe,
	astral_bottle,
	stronghold,
	wtf,
	clash,
	the,
	annihalation,
	undefined,
	manylostminds,
	nebulous,
	wordscanteven,
	adroit,
	penetrating,
	treacherous,
	bonkers,
	fuckedup,
	foolhardy,
	translucent,
	lebaron_james,
	huntingseason,
	--cat_owl,
	--eyeofhagane, (apparently this wasn't screened)
	familiar_currency,
	highfive,
	sock_and_sock,
	brokenhome,
	yarnball,
	pizza,
	pizza_slice,
	paved_joker,
	fading_joker,
	poor_joker,
	broken_sync,
	thal,
	keychange,
}

return {
	name = "Misc. Jokers",
	init = function()
		-- Add more calculation contexts (used by Pumpkin and Clicked Cookie)
		local oldfunc = Card.start_dissolve
		function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
			if G and G.jokers and G.jokers.cards then
				SMODS.calculate_context({ cry_start_dissolving = true, card = self })
			end
			return oldfunc(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
		end

		local lcpref = Controller.L_cursor_press
		function Controller:L_cursor_press(x, y)
			lcpref(self, x, y)
			if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
				SMODS.calculate_context({ cry_press = true })
			end
		end
	end,
	items = miscitems,
}
