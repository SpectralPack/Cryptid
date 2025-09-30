-- Asteroid Belt
-- Levels up Bulwark (+50/+1)
local abelt = {
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
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "asteroidbelt",
	config = { hand_type = "cry_Bulwark", softlock = true },
	pos = { x = 1, y = 5 },
	order = 1,
	atlas = "atlasnotjokers",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_disc"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("cry_hand_bulwark"),
				G.GAME.hands["cry_Bulwark"].level,
				G.GAME.hands["cry_Bulwark"].l_mult,
				G.GAME.hands["cry_Bulwark"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["cry_Bulwark"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_Bulwark"].level))]
					),
				},
			},
		}
	end,
	generate_ui = 0,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Void
-- Upgrades Clusterfuck (+40/+4)
local void = {
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
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "void",
	order = 2,
	config = { hand_type = "cry_Clusterfuck", softlock = true },
	pos = { x = 0, y = 5 },
	atlas = "atlasnotjokers",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge("", get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("cry_Clusterfuck"),
				G.GAME.hands["cry_Clusterfuck"].level,
				G.GAME.hands["cry_Clusterfuck"].l_mult,
				G.GAME.hands["cry_Clusterfuck"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["cry_Clusterfuck"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_Clusterfuck"].level))]
					),
				},
			},
		}
	end,
	generate_ui = 0,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Phobos & Deimos
-- Upgrades Ultimate Pair (+40/+4)
local marsmoons = {
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
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "marsmoons",
	order = 3,
	config = { hand_type = "cry_UltPair", softlock = true },
	pos = { x = 2, y = 5 },
	atlas = "atlasnotjokers",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_satellite"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		local levelone = G.GAME.hands["cry_UltPair"].level or 1
		local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		if levelone == 1 then
			planetcolourone = G.C.UI.TEXT_DARK
		end
		return {
			vars = {
				localize("cry_UltPair"),
				G.GAME.hands["cry_UltPair"].level,
				G.GAME.hands["cry_UltPair"].l_mult,
				G.GAME.hands["cry_UltPair"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["cry_UltPair"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_UltPair"].level))]
					),
				},
			},
		}
	end,
	generate_ui = 0,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}

-- Order 4 reserved for possible None planet
-- hehehehehehe
local nibiru = {
	cry_credits = {
		idea = {
			"cassknows",
		},
		art = {
			"cassknows",
		},
	},
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "nibiru",
	order = 4,
	config = { hand_type = "cry_None", softlock = true },
	pos = { x = 0, y = 6 },
	atlas = "atlasnotjokers",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		--use whichever of these fits best, the second literally just removes the badge, and the first is a blank badge
		--badges[1] = create_badge("", get_type_colour(self or card.config, card), nil, 1.2)

		if badges[1] and badges[1].remove then
			badges[1]:remove()
		end
		badges[1] = nil
	end,
	loc_vars = function(self, info_queue, center)
		local levelone = G.GAME.hands["cry_None"].level or 1
		local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		if levelone == 1 then
			planetcolourone = G.C.UI.TEXT_DARK
		end
		return {
			vars = {
				localize("cry_None"),
				G.GAME.hands["cry_None"].level,
				G.GAME.hands["cry_None"].l_mult,
				G.GAME.hands["cry_None"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["cry_None"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_None"].level))]
					),
				},
			},
		}
	end,
	generate_ui = 0,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	cry_credits = {
		art = { "cassknows" },
		code = { "lord-ruby" },
	},
}

-- The Universe In Its Fucking Entirety
-- Upgrades The Entire Fucking Deck (+5.25252e28/+5.25252e27)
local universe = {
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
	dependencies = {
		items = {
			"set_cry_poker_hand_stuff",
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "universe",
	config = { hand_type = "cry_WholeDeck", softlock = true },
	pos = { x = 4, y = 5 },
	order = 5,
	atlas = "atlasnotjokers",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_universe"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		--[[if Cryptid.safe_get(G, "GAME", "used_vouchers", "v_observatory") then
			-- won't show up for some fucking reason
			info_queue[#info_queue + 1] = {
				key = "o_cry_universe",
				set = "Other",
				specific_vars = {
					G.P_CENTERS.v_observatory.config.extra,
					localize("cry_WholeDeck"),
				}
			}
		end]]
		return {
			vars = {
				localize("cry_WholeDeck"),
				G.GAME.hands["cry_WholeDeck"].level,
				G.GAME.hands["cry_WholeDeck"].l_mult,
				G.GAME.hands["cry_WholeDeck"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["cry_WholeDeck"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_WholeDeck"].level))]
					),
				},
			},
		}
	end,
	generate_ui = 0,

	-- give emult instead of xmult
	calculate = function(self, card, context)
		if context.cry_observatory and card.ability.consumeable.hand_type == context.scoring_name then
			local value = context.cry_observatory.ability.extra

			-- because it's ((n^a)^a)^a
			if Overflow then
				value = value ^ to_big(card:getQty())
			end

			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(context.cry_observatory.ability.extra),
					},
				}),
				Emult_mod = lenient_bignum(context.cry_observatory.ability.extra),
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}

-- Planet.lua
-- 1 in 5 to upgrade Every poker hand
local planetlua = {
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
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-planetlua",
	key = "planetlua",
	config = { extra = { odds = 5 } },
	pos = { x = 4, y = 2 },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 101,
	loc_vars = function(self, info_queue, card)
		local aaa, bbb = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Planet.lua")
		local xmulttexts = {}
		local loc_mult = " " .. (localize("k_mult")) .. " "
		for i = 0, 100 do
			xmulttexts[#xmulttexts + 1] = "X" .. (1 + (i / 100))
		end
		local o_plua = {
			-- For people "borrowing" this code: There's a lovely patch done in order to get this to work properly on infoqueues, if you don't need this on infoqueues then ignore this line
			-- Small "Correction" to center text a bit more
			{ n = G.UIT.T, config = { text = "  ", colour = G.C.WHITE, scale = 0.32 } },
			-- Xmult text
			{
				n = G.UIT.C,
				config = { align = "m", colour = G.C.RED, r = 0.05, padding = 0.03, res = 0.15 },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = xmulttexts,
								colours = { G.C.WHITE },
								pop_in_rate = 9999999,
								silent = true,
								random_element = true,
								pop_delay = 0.5,
								scale = 0.32,
								min_cycle_time = 0,
							}),
						},
					},
				},
			},
			-- Mult Text
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = {
							{ string = "rand()", colour = G.C.JOKER_GREY },
							{ string = "#@" .. (Cryptid.get_m_jokers()) .. "M", colour = G.C.RED },
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
		if Cryptid.safe_get(G, "GAME", "used_vouchers", "v_observatory") then
			info_queue[#info_queue + 1] = { key = "o_planetlua", set = "Other", plua_extra = o_plua }
		end
		return {
			vars = {
				aaa,
				bbb,
			},
		}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		if SMODS.pseudorandom_probability(card, "planetlua", 1, card.ability.extra.odds, "Planet.lua") then --Code "borrowed" from black hole
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(used_consumable, k, true)
			end
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		else
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function() --"borrowed" from Wheel Of Fortune
					attention_text({
						text = localize("k_nope_ex"),
						scale = 1.3,
						hold = 1.4,
						major = used_consumable,
						backdrop_colour = G.C.SECONDARY_SET.Planet,
						align = (
							G.STATE == G.STATES.TAROT_PACK
							or G.STATE == G.STATES.SPECTRAL_PACK
							or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
						)
								and "tm"
							or "cm",
						offset = {
							x = 0,
							y = (
								G.STATE == G.STATES.TAROT_PACK
								or G.STATE == G.STATES.SPECTRAL_PACK
								or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
							)
									and -0.2
								or 0,
						},
						silent = true,
					})
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound("tarot2", 0.76, 0.4)
							return true
						end,
					}))
					play_sound("tarot2", 1, 0.4)
					used_consumable:juice_up(0.3, 0.5)
					return true
				end,
			}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local used_consumable = copier or card
		local quota = 0
		if card.ability.cry_rigged then
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+" .. number })
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(card, k, true, number)
			end
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		else
			for i = 1, number do
				quota = quota
					+ (
						SMODS.pseudorandom_probability(card, "planetlua", 1, card.ability.extra.odds, "Planet.lua")
							and 1
						or 0
					)
			end
			if quota > 0 then
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
					{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("tarot1")
						used_consumable:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = true
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.9,
					func = function()
						play_sound("tarot1")
						used_consumable:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.9,
					func = function()
						play_sound("tarot1")
						used_consumable:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = nil
						return true
					end,
				}))
				update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+" .. quota })
				delay(1.3)
				for k, v in pairs(G.GAME.hands) do
					level_up_hand(card, k, true, quota)
				end
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = "", level = "" }
				)
			else
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.4,
					func = function()
						attention_text({
							text = localize("k_nope_ex"),
							scale = 1.3,
							hold = 1.4,
							major = used_consumable,
							backdrop_colour = G.C.SECONDARY_SET.Planet,
							align = (
								G.STATE == G.STATES.TAROT_PACK
								or G.STATE == G.STATES.SPECTRAL_PACK
								or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
							)
									and "tm"
								or "cm",
							offset = {
								x = 0,
								y = (
									G.STATE == G.STATES.TAROT_PACK
									or G.STATE == G.STATES.SPECTRAL_PACK
									or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
								)
										and -0.2
									or 0,
							},
							silent = true,
						})
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.06 * G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound("tarot2", 0.76, 0.4)
								return true
							end,
						}))
						play_sound("tarot2", 1, 0.4)
						used_consumable:juice_up(0.3, 0.5)
						return true
					end,
				}))
			end
		end
	end,
	calculate = function(self, card, context)
		if context.cry_observatory then
			-- pseudorandom("cry_googol_play")
			local aaa = pseudorandom("mstar")
			local limit = Card.get_gameset(card) == "modest" and 2 or 1e100
			local formula = aaa + (0.07 * (aaa ^ 5 / (1 - aaa ^ 2)))
			local value = Cryptid.nuke_decimals(math.min(limit, 1.7 ^ formula), 2)
			--[[

			OverFlow Compat TODO
			It needs to be done in a way that keep expected score consistent between having 1 big stack and several smaller stacks
			and ideally doesn't cause a lot of lag at large stacks like the bulk_use does
			
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			]]
			return {
				xmult = value,
			}
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Neutron Star
-- Upgrades a random hand by 1 per Neutron Star used this run
local nstar = {
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
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-nstar",
	key = "nstar",
	pos = { x = 4, y = 1 },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 6,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_q"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		local aaa = Cryptid.safe_get(G, "GAME", "neutronstarsusedinthisrun") or 0
		if Cryptid.safe_get(G, "GAME", "used_vouchers", "v_observatory") then
			info_queue[#info_queue + 1] = { key = "o_nstar", set = "Other", specific_vars = { 0.1, (1 + (0.1 * aaa)) } }
		end
		return { vars = { aaa } }
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		--Add +1 to amount of neutron stars used this run
		G.GAME.neutronstarsusedinthisrun = G.GAME.neutronstarsusedinthisrun + 1
		local neutronhand = Cryptid.get_random_hand(nil, "nstar" .. G.GAME.round_resets.ante) --Random poker hand
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(neutronhand, "poker_hands"),
			chips = G.GAME.hands[neutronhand].chips,
			mult = G.GAME.hands[neutronhand].mult,
			level = G.GAME.hands[neutronhand].level,
		})
		--level up once for each neutron star used this run
		level_up_hand(used_consumable, neutronhand, nil, G.GAME.neutronstarsusedinthisrun)
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end,
	bulk_use = function(self, card, area, copier, number)
		local used_consumable = copier or card
		local handstolv = {}
		local neutronhand = "n/a"
		for i = 1, number do
			G.GAME.neutronstarsusedinthisrun = G.GAME.neutronstarsusedinthisrun + 1
			neutronhand = Cryptid.get_random_hand()
			handstolv[neutronhand] = (handstolv[neutronhand] or 0) + G.GAME.neutronstarsusedinthisrun
		end
		for k, v in pairs(handstolv) do
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
				handname = localize(k, "poker_hands"),
				chips = G.GAME.hands[k].chips,
				mult = G.GAME.hands[k].mult,
				level = G.GAME.hands[k].level,
			})
			card_eval_status_text(
				used_consumable,
				"extra",
				nil,
				nil,
				nil,
				{ message = "+" .. tostring(v), colour = G.C.BLUE }
			)
			level_up_hand(used_consumable, k, nil, v)
		end
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				handstolv = nil
				return true
			end,
		}))
	end,
	calculate = function(self, card, context)
		if context.cry_observatory and G.GAME.neutronstarsusedinthisrun > 0 then
			local value = G.GAME.neutronstarsusedinthisrun
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { 1 + (0.10 * value) },
				}),
				Xmult_mod = 1 + (0.10 * value),
			}
		end
	end,
	init = function(self)
		function Cryptid.get_random_hand(ignore, seed, allowhidden)
			--From JenLib's get_random_hand
			local chosen_hand
			ignore = ignore or {}
			seed = seed or "randomhand"
			if type(ignore) ~= "table" then
				ignore = { ignore }
			end
			while true do
				chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
				if G.GAME.hands[chosen_hand].visible or allowhidden then
					local safe = true
					for _, v in pairs(ignore) do
						if v == chosen_hand then
							safe = false
						end
					end
					if safe then
						break
					end
				end
			end
			return chosen_hand
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Sol
-- Upgrades Ascended Hand Power
local sunplanet = {
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
		},
		code = {
			"Jevonn",
			"Toneblock",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
			"set_cry_poker_hand_stuff",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-sunplanet",
	key = "sunplanet",
	pos = { x = 5, y = 2 },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 150,
	config = {
		extra = { modest = 0.1, not_modest = 0.05 },
	},
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("cry_p_star"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		Cryptid.asc_level_up(card, copier, 1)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.asc_level_up(card, copier, number)
	end,
	loc_vars = function(self, info_queue, center)
		local levelone = Cryptid.safe_get(G, "GAME", "sunlevel") or 1
		local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		if G.STAGE == G.STAGES.RUN then
			local modest = Cryptid.gameset(G.P_CENTERS.c_cry_sunplanet) == "modest"
			local current_power = Cryptid.safe_get(G, "GAME", "current_round", "current_hand", "cry_asc_num")
				or Cryptid.calculate_ascension_power(
					nil,
					nil,
					nil,
					G.GAME.used_vouchers.v_cry_hyperspacetether,
					G.GAME.bonus_asc_power
				)
			local multiplier = modest and 1 + ((0.25 + G.GAME.sunnumber.modest) * current_power)
				or (1.25 + G.GAME.sunnumber.not_modest) ^ current_power
			info_queue[#info_queue + 1] = {
				key = "asc_misc" .. (modest and 2 or ""),
				set = "Other",
				specific_vars = {
					current_power,
					multiplier,
					modest and (G.GAME.sunnumber.modest + 0.25) or (G.GAME.sunnumber.not_modest + 1.25),
				},
			}
		end
		if Cryptid.safe_get(G, "GAME", "used_vouchers", "v_observatory") then
			local super_entropic_local_variable_that_stores_the_amount_of_suns = #find_joker("cry-sunplanet")
				+ #find_joker("cry-Perkele")
			local observatory_power = 0

			if super_entropic_local_variable_that_stores_the_amount_of_suns == 1 then
				observatory_power = 1
			elseif super_entropic_local_variable_that_stores_the_amount_of_suns > 1 then
				observatory_power =
					Cryptid.funny_log(2, super_entropic_local_variable_that_stores_the_amount_of_suns + 1)
			end
			info_queue[#info_queue + 1] = { key = "o_sunplanet", set = "Other", specific_vars = { observatory_power } }
		end
		if levelone == 1 then
			planetcolourone = G.C.UI.TEXT_DARK
		end
		if Cryptid.gameset(center) == "modest" then
			return {
				vars = {
					levelone,
					center.ability.extra.modest,
					(Cryptid.safe_get(G, "GAME", "sunnumber", "modest") or 0) + 0.25,
					colours = { planetcolourone },
				},
				key = "c_cry_sunplanet2",
			}
		else
			return {
				vars = {
					levelone,
					center.ability.extra.not_modest,
					(Cryptid.safe_get(G, "GAME", "sunnumber", "not_modest") or 0) + 1.25,
					colours = { planetcolourone },
				},
			}
		end
	end,
	in_pool = function(self)
		if G.GAME.cry_asc_played and G.GAME.cry_asc_played > 0 then
			return true
		end
		return false
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Ruutu
-- Upgrades High Card, Pair and Two Pair
local ruutu = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"jenwalter666",
		},
		code = {
			"Math",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Ruutu",
	key = "Timantii",
	pos = { x = 0, y = 2 },
	config = { hand_types = { "High Card", "Pair", "Two Pair" } },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 151,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("High Card", "poker_hands"),
				localize("Pair", "poker_hands"),
				localize("Two Pair", "poker_hands"),
				number_format(G.GAME.hands["High Card"].level),
				number_format(G.GAME.hands["Pair"].level),
				number_format(G.GAME.hands["Two Pair"].level),
				colours = {
					(
						to_big(G.GAME.hands["High Card"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["High Card"].level))]
					),
					(
						to_big(G.GAME.hands["Pair"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Pair"].level))]
					),
					(
						to_big(G.GAME.hands["Two Pair"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Two Pair"].level))]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "High Card"
				or context.scoring_name == "Pair"
				or context.scoring_name == "Two Pair"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Risti
-- Upgrades Three Of A Kind, Straight and Flush
local risti = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"jenwalter666",
		},
		code = {
			"Math",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Risti",
	key = "Klubi",
	pos = { x = 1, y = 2 },
	config = { hand_types = { "Three of a Kind", "Straight", "Flush" } },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 152,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("Three of a Kind", "poker_hands"),
				localize("Straight", "poker_hands"),
				localize("Flush", "poker_hands"),
				number_format(G.GAME.hands["Three of a Kind"].level),
				number_format(G.GAME.hands["Straight"].level),
				number_format(G.GAME.hands["Flush"].level),
				colours = {
					(
						to_big(G.GAME.hands["Three of a Kind"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Three of a Kind"].level))]
					),
					(
						to_big(G.GAME.hands["Straight"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Straight"].level))]
					),
					(
						to_big(G.GAME.hands["Flush"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Flush"].level))]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "Three of a Kind"
				or context.scoring_name == "Straight"
				or context.scoring_name == "Flush"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Hertta
-- Upgrades Full House, Four Of A Kind and Straight Flush
local hertta = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"jenwalter666",
		},
		code = {
			"Math",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Hertta",
	key = "Sydan",
	pos = { x = 2, y = 2 },
	config = { hand_types = { "Full House", "Four of a Kind", "Straight Flush" } },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 153,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("Full House", "poker_hands"),
				localize("Four of a Kind", "poker_hands"),
				localize("Straight Flush", "poker_hands"),
				number_format(G.GAME.hands["Full House"].level),
				number_format(G.GAME.hands["Four of a Kind"].level),
				number_format(G.GAME.hands["Straight Flush"].level),
				colours = {
					(
						to_big(G.GAME.hands["Full House"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Full House"].level))]
					),
					(
						to_big(G.GAME.hands["Four of a Kind"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Four of a Kind"].level))]
					),
					(
						to_big(G.GAME.hands["Straight Flush"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Straight Flush"].level))]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "Full House"
				or context.scoring_name == "Four of a Kind"
				or context.scoring_name == "Straight Flush"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Pata
-- Upgrades Five Of A Kind, Flush House and Flush Five
local pata = {
	cry_credits = {
		idea = {
			"Jevonn",
		},
		art = {
			"jenwalter666",
		},
		code = {
			"Math",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Pata",
	key = "Lapio",
	pos = { x = 3, y = 2 },
	config = { hand_types = { "Five of a Kind", "Flush House", "Flush Five" }, softlock = true },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 154,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("Five of a Kind", "poker_hands"),
				localize("Flush House", "poker_hands"),
				localize("Flush Five", "poker_hands"),
				number_format(G.GAME.hands["Five of a Kind"].level),
				number_format(G.GAME.hands["Flush House"].level),
				number_format(G.GAME.hands["Flush Five"].level),
				colours = {
					(
						to_big(G.GAME.hands["Five of a Kind"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Five of a Kind"].level))]
					),
					(
						to_big(G.GAME.hands["Flush House"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Flush House"].level))]
					),
					(
						to_big(G.GAME.hands["Flush Five"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["Flush Five"].level))]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "Five of a Kind"
				or context.scoring_name == "Flush House"
				or context.scoring_name == "Flush Five"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}
-- Kaikki
-- Upgrades Bulwark, Clusterfuck and Ultimate Pair
local kaikki = {
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
	dependencies = {
		items = {
			"set_cry_planet",
			"set_cry_poker_hand_stuff",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Kaikki",
	key = "Kaikki",
	pos = { x = 3, y = 5 },
	config = { hand_types = { "cry_Bulwark", "cry_Clusterfuck", "cry_UltPair" }, softlock = true },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 155,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		local levelone = G.GAME.hands["cry_Bulwark"].level or 1
		local leveltwo = G.GAME.hands["cry_Clusterfuck"].level or 1
		local levelthree = G.GAME.hands["cry_UltPair"].level or 1
		local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		local planetcolourtwo = G.C.HAND_LEVELS[math.min(leveltwo, 7)]
		local planetcolourthree = G.C.HAND_LEVELS[math.min(levelthree, 7)]

		return {
			vars = {
				localize("cry_Bulwark", "poker_hands"),
				localize("cry_Clusterfuck", "poker_hands"),
				localize("cry_UltPair", "poker_hands"),
				G.GAME.hands["cry_Bulwark"].level,
				G.GAME.hands["cry_Clusterfuck"].level,
				G.GAME.hands["cry_UltPair"].level,
				colours = {
					(
						to_big(G.GAME.hands["cry_Bulwark"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_Bulwark"].level))]
					),
					(
						to_big(G.GAME.hands["cry_Clusterfuck"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_Clusterfuck"].level))]
					),
					(
						to_big(G.GAME.hands["cry_UltPair"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["cry_UltPair"].level))]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "cry_Bulwark"
				or context.scoring_name == "cry_Clusterfuck"
				or context.scoring_name == "cry_UltPair"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}

-- Perkele
-- Upgrades None, TEFD, and Ascended Hands
local perkele = {
	cry_credits = {
		idea = {
			"cassknows",
		},
		art = {
			"cassknows",
			"Lil Mr. Slipstream",
		},
		code = {
			"InvalidOS",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
			"set_cry_poker_hand_stuff",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Perkele",
	key = "perkele",
	pos = { x = 2, y = 6 },
	config = {
		-- avoids having to mirror tweaks to sol on perkele
		extra = sunplanet.config.extra,
		-- "cry_asc_hands" is not a hand so don't include it here
		hand_types = { "cry_None", "cry_WholeDeck" },
		level_types = { "cry_None", "cry_WholeDeck", "cry_asc_hands" },
		softlock = true,
	},
	cost = 4,

	-- idk if this even matters
	aurinko = true,

	atlas = "atlasnotjokers",
	order = 166,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		local levels = {
			G.GAME.hands["cry_None"].level or 1,
			G.GAME.hands["cry_WholeDeck"].level or 1,
			Cryptid.safe_get(G, "GAME", "sunlevel") or 1,
		}
		local colours = {}

		for i, lvl in ipairs(levels) do
			colours[i] = to_big(lvl) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[to_number(math.min(7, lvl))]
		end

		-- don't want to entirely rework ascension power just for one consumable
		local modest = Cryptid.gameset(G.P_CENTERS.c_cry_sunplanet) == "modest"

		if G.STAGE == G.STAGES.RUN then
			local current_power = Cryptid.safe_get(G, "GAME", "current_round", "current_hand", "cry_asc_num")
				or Cryptid.calculate_ascension_power(
					nil,
					nil,
					nil,
					G.GAME.used_vouchers.v_cry_hyperspacetether,
					G.GAME.bonus_asc_power
				)
			local multiplier = modest and 1 + ((0.25 + G.GAME.sunnumber.modest) * current_power)
				or (1.25 + G.GAME.sunnumber.not_modest) ^ current_power
			info_queue[#info_queue + 1] = {
				key = "asc_misc" .. (modest and 2 or ""),
				set = "Other",
				specific_vars = {
					current_power,
					multiplier,
					modest and (G.GAME.sunnumber.modest + 0.25) or (G.GAME.sunnumber.not_modest + 1.25),
				},
			}
		end
		if Cryptid.safe_get(G, "GAME", "used_vouchers", "v_observatory") then
			local super_entropic_local_variable_that_stores_the_amount_of_suns = #find_joker("cry-sunplanet")
				+ #find_joker("cry-Perkele")
			local observatory_power = 0

			if super_entropic_local_variable_that_stores_the_amount_of_suns == 1 then
				observatory_power = 1
			elseif super_entropic_local_variable_that_stores_the_amount_of_suns > 1 then
				observatory_power =
					Cryptid.funny_log(2, super_entropic_local_variable_that_stores_the_amount_of_suns + 1)
			end
			info_queue[#info_queue + 1] = {
				key = "o_perkele",
				set = "Other",
				specific_vars = {
					observatory_power,
					G.P_CENTERS.v_observatory.config.extra,
					localize("cry_None", "poker_hands"),
					localize("cry_WholeDeck", "poker_hands"),
				},
			}
		end

		return {
			vars = {
				localize("cry_None", "poker_hands"),
				localize("cry_WholeDeck", "poker_hands"),
				localize("cry_asc_hands"),
				levels[1],
				levels[2],
				levels[3],
				(Cryptid.safe_get(G, "GAME", "sunnumber", modest == "modest" and "modest" or "not_modest") or 0) + 0.25,
				colours = colours,
			},
		}
	end,
	use = function(self, card, area, copier)
		Cryptid.suit_level_up(card, copier, 1, card.config.center.config.level_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		Cryptid.suit_level_up(card, copier, number, card.config.center.config.level_types)
	end,
	calculate = function(self, card, context)
		if context.cry_observatory then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end

			if context.scoring_name == "cry_None" then
				return { xmult = value }
			elseif context.scoring_name == "cry_WholeDeck" then
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = {
							number_format(context.cry_observatory.ability.extra),
						},
					}),
					Emult_mod = lenient_bignum(context.cry_observatory.ability.extra),
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	in_pool = function(self)
		return (G.GAME.cry_asc_played and G.GAME.cry_asc_played > 0)
			or SMODS.is_poker_hand_visible("cry_WholeDeck")
			or SMODS.is_poker_hand_visible("cry_None")
	end,
}

local voxel = {
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"HexaCryonic",
			"Icyethics",
		},
		code = {
			"lord.ruby",
		},
	},
	dependencies = {
		items = {
			"set_cry_planet",
			"set_cry_code",
			"c_cry_declare",
		},
	},
	object_type = "Consumable",
	set = "Planet",
	name = "cry-Voxel",
	key = "voxel",
	pos = { x = 1, y = 6 },
	config = { hand_types = { "cry_Declare0", "cry_Declare1", "cry_Declare2" }, softlock = true },
	cost = 4,
	aurinko = true,
	atlas = "atlasnotjokers",
	order = 167,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, center)
		local levelone = G.GAME.hands["cry_Declare0"] and G.GAME.hands["cry_Declare0"].level or 1
		local leveltwo = G.GAME.hands["cry_Declare1"] and G.GAME.hands["cry_Declare1"].level or 1
		local levelthree = G.GAME.hands["cry_Declare2"] and G.GAME.hands["cry_Declare2"].level or 1
		local planetcolourone = G.C.HAND_LEVELS[math.min(levelone, 7)]
		local planetcolourtwo = G.C.HAND_LEVELS[math.min(leveltwo, 7)]
		local planetcolourthree = G.C.HAND_LEVELS[math.min(levelthree, 7)]

		return {
			vars = {
				G.GAME.hands["cry_Declare0"] and G.GAME.hands["cry_Declare0"].declare_cards and localize(
					"cry_Declare0",
					"poker_hands"
				) or localize("cry_code_empty"),
				G.GAME.hands["cry_Declare1"] and G.GAME.hands["cry_Declare1"].declare_cards and localize(
					"cry_Declare1",
					"poker_hands"
				) or localize("cry_code_empty"),
				G.GAME.hands["cry_Declare2"] and G.GAME.hands["cry_Declare2"].declare_cards and localize(
					"cry_Declare2",
					"poker_hands"
				) or localize("cry_code_empty"),
				G.GAME.hands["cry_Declare0"] and G.GAME.hands["cry_Declare0"].level or 1,
				G.GAME.hands["cry_Declare1"] and G.GAME.hands["cry_Declare1"].level or 1,
				G.GAME.hands["cry_Declare2"] and G.GAME.hands["cry_Declare2"].level or 1,
				colours = {
					(
						to_big(G.GAME.hands["cry_Declare0"] and G.GAME.hands["cry_Declare0"].level or 1)
								== to_big(1)
							and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(
							math.min(7, G.GAME.hands["cry_Declare0"] and G.GAME.hands["cry_Declare0"].level or 1)
						)]
					),
					(
						to_big(G.GAME.hands["cry_Declare1"] and G.GAME.hands["cry_Declare1"].level or 1)
								== to_big(1)
							and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(
							math.min(7, G.GAME.hands["cry_Declare1"] and G.GAME.hands["cry_Declare1"].level or 1)
						)]
					),
					(
						to_big(G.GAME.hands["cry_Declare2"] and G.GAME.hands["cry_Declare2"].level or 1)
								== to_big(1)
							and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(
							math.min(7, G.GAME.hands["cry_Declare2"] and G.GAME.hands["cry_Declare2"].level or 1)
						)]
					),
				},
			},
		}
	end,
	use = function(self, card, area, copier)
		local hand_types = {
			G.GAME.hands.cry_Declare0 and G.GAME.hands.cry_Declare0.declare_cards and "cry_Declare0",
			G.GAME.hands.cry_Declare1 and G.GAME.hands.cry_Declare1.declare_cards and "cry_Declare1",
			G.GAME.hands.cry_Declare2 and G.GAME.hands.cry_Declare2.declare_cards and "cry_Declare2",
		}
		Cryptid.suit_level_up(card, copier, 1, hand_types)
	end,
	bulk_use = function(self, card, area, copier, number)
		local hand_types = {
			G.GAME.hands.cry_Declare0 and G.GAME.hands.cry_Declare0.declare_cards and "cry_Declare0",
			G.GAME.hands.cry_Declare1 and G.GAME.hands.cry_Declare1.declare_cards and "cry_Declare1",
			G.GAME.hands.cry_Declare2 and G.GAME.hands.cry_Declare2.declare_cards and "cry_Declare2",
		}
		Cryptid.suit_level_up(card, copier, number, hand_types)
	end,
	calculate = function(self, card, context)
		if
			context.cry_observatory
			and (
				context.scoring_name == "cry_Declare0"
				or context.scoring_name == "cry_Declare1"
				or context.scoring_name == "cry_Declare2"
			)
		then
			local value = context.cry_observatory.ability.extra
			if Overflow then
				value = value ^ to_big(card:getQty())
			end
			return { xmult = value }
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}

function Cryptid.asc_level_up(card, copier, number, message)
	local number = number or 1
	local used_consumable = copier or card
	G.GAME.sunlevel = G.GAME.sunlevel + number
	G.GAME.sunnumber.modest = G.GAME.sunnumber.modest + number * card.ability.extra.modest
	G.GAME.sunnumber.not_modest = G.GAME.sunnumber.not_modest + number * card.ability.extra.not_modest

	if message then
		SMODS.calculate_effect({
			message = localize("k_level_up_ex"),
		}, card)
	end

	if not Cryptid.safe_get(Talisman, "config_file", "disable_anims") then
		delay(0.4)
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize("cry_asc_hands"),
			chips = "...",
			mult = "...",
			level = to_big(G.GAME.sunlevel - number),
		})
		delay(1.0)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				play_sound("tarot1")
				ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
				ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
				Cryptid.pulse_flame(0.01, G.GAME.sunlevel)
				used_consumable:juice_up(0.8, 0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					blockable = false,
					blocking = false,
					delay = 1.2,
					func = function()
						ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
						ease_colour(G.C.UI_MULT, G.C.RED, 1)
						return true
					end,
				}))
				return true
			end,
		}))
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 },
			{ level = to_big(G.GAME.sunlevel) }
		)
		delay(2.6)
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end
end

function Cryptid.suit_level_up(card, copier, number, poker_hands, message)
	local used_consumable = copier or card
	if not number then
		number = 1
	end
	if not poker_hands then
		poker_hands = { "Two Pair", "Straight Flush" }
	end
	if message then
		SMODS.calculate_effect({
			message = localize("k_level_up_ex"),
		}, card)
	end
	for _, v in pairs(poker_hands) do
		if v == "cry_asc_hands" then
			Cryptid.asc_level_up(card, copier, number, message)
		else
			SMODS.smart_level_up_hand(used_consumable, v, nil, number)
		end
	end
	update_hand_text(
		{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
		{ mult = 0, chips = 0, handname = "", level = "" }
	)
end
local planet_cards = {
	abelt,
	void,
	marsmoons,
	-- reserved for None
	nibiru,
	universe,

	planetlua,
	nstar,

	sunplanet,
	ruutu,
	risti,
	hertta,
	pata,
	kaikki,
	perkele,
	voxel,
}
return {
	name = "Planets",
	init = function() end,
	items = planet_cards,
}
