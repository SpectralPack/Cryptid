local very_fair = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "Very Fair Deck",
	key = "very_fair",
	config = { hands = -2, discards = -2 },
	pos = { x = 4, y = 0 },
	order = 1,
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_no_vouchers = true
	end,
	init = function(self)
		very_fair_quip = {}
		local avts = SMODS.add_voucher_to_shop
		function SMODS.add_voucher_to_shop(...)
			if G.GAME.modifiers.cry_no_vouchers then
				return
			end
			return avts(...)
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
			if get_deck_win_stake("b_cry_blank") > 0 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "discard", "hands", "voucher" },
}
local equilibrium = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Equilibrium",
	key = "equilibrium",
	order = 3,
	config = { vouchers = { "v_overstock_norm", "v_overstock_plus" } },
	pos = { x = 0, y = 1 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_equilibrium = true
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if Cryptid.safe_get(G, "jokers") then
			local count = 0
			for i = 1, #G.jokers.cards do
				count = count + 1
			end
			if count >= 100 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "shop", "voucher" },
}
local misprint = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Misprint",
	key = "misprint",
	order = 4,
	config = { cry_misprint_min = 0.1, cry_misprint_max = 10 },
	pos = { x = 4, y = 2 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_misprint_min = (G.GAME.modifiers.cry_misprint_min or 1) * self.config.cry_misprint_min
		G.GAME.modifiers.cry_misprint_max = (G.GAME.modifiers.cry_misprint_max or 1) * self.config.cry_misprint_max
	end,
	cry_antimatter_apply = function(self)
		G.GAME.modifiers.cry_misprint_min = G.GAME.modifiers.cry_misprint_min or 1
		G.GAME.modifiers.cry_misprint_max = (G.GAME.modifiers.cry_misprint_max or 1) * self.config.cry_misprint_max
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if Cryptid.safe_get(G, "jokers") then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].edition and G.jokers.cards[i].edition.cry_glitched then
					unlock_card(self)
					break
				end
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "value_manip" },
}
local infinite = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Infinite",
	key = "infinite",
	order = 2,
	config = { hand_size = 1 },
	pos = { x = 3, y = 0 },
	atlas = "atlasdeck",
	unlocked = false,
	apply = function(self)
		G.GAME.infinitedeck = true
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.7,
			func = function()
				SMODS.change_play_limit(1e6)
				SMODS.change_discard_limit(1e6)
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	check_for_unlock = function(self, args)
		if args.type == "hand_contents" then
			if #args.cards >= 6 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "hand_size", "play_limit", "discard_limit" },
}
local conveyor = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Conveyor",
	key = "conveyor",
	order = 7,
	pos = { x = 1, y = 1 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_conveyor = true
	end,
	cry_antimatter_apply = function(self)
		G.GAME.modifiers.cry_antimatter_conveyor = true
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_analog" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "generation", "destroy_card", "joker", "position" },
}
local CCD = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-CCD",
	key = "CCD",
	order = 5,
	config = { cry_ccd = true },
	pos = { x = 0, y = 0 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_ccd = true
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_hammerspace" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "ccd" },
}
local wormhole = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
			"set_cry_exotic",
		},
	},
	name = "cry-Wormhole",
	key = "wormhole",
	order = 6,
	config = { cry_negative_rate = 20, joker_slot = -2 },
	pos = { x = 3, y = 4 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_negative_rate = self.config.cry_negative_rate
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_wormhole")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					return true
				end
			end,
		}))
	end,
	cry_antimatter_apply = function(self) --joker slots are handled via the default functionality, so this doesnt need to do anything
		self:apply()
	end,
	init = function(self)
		SMODS.Edition:take_ownership("negative", {
			get_weight = function(self)
				return self.weight * (G.GAME.modifiers.cry_negative_rate or 1)
			end,
		}, true)
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if Cryptid.safe_get(G, "jokers") then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.rarity == "cry_exotic" then
					unlock_card(self)
				end
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "joker_slot", "joker", "edition", "rarity" },
}
local redeemed = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Redeemed",
	key = "redeemed",
	order = 8,
	pos = { x = 4, y = 4 },
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_redeemed = true
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	init = function(self)
		local cr = Card.redeem
		function Card:redeem()
			cr(self)

			if G.GAME.modifiers.cry_redeemed and not self.cry_monopoly_destroyed then
				if
					#G.play.cards == 0
					and (not G.redeemed_vouchers_during_hand or #G.redeemed_vouchers_during_hand.cards == 0)
				then
					G.cry_redeemed_buffer = {}
				end
				for k, v in pairs(G.P_CENTER_POOLS["Voucher"]) do
					if v.requires and not G.GAME.used_vouchers[v] then
						for _, vv in pairs(v.requires) do
							if vv == self.config.center.key then
								--redeem extra voucher code based on Betmma's Vouchers
								local area
								if G.STATE == G.STATES.HAND_PLAYED then
									if not G.redeemed_vouchers_during_hand then
										G.redeemed_vouchers_during_hand = CardArea(
											G.play.T.x,
											G.play.T.y,
											G.play.T.w,
											G.play.T.h,
											{ type = "play", card_limit = 5 }
										)
									end
									area = G.redeemed_vouchers_during_hand
								else
									area = G.play
								end
								if not G.cry_redeemed_buffer then
									G.cry_redeemed_buffer = {}
								end
								if not G.cry_redeemed_buffer[v.key] and v.unlocked then
									for _, a in ipairs(G.I.CARDAREA) do --nested in here so it only does this when actually necessary
										if a.handle_card_limit then
											a:handle_card_limit()
										end
									end
									local card = create_card("Voucher", area, nil, nil, nil, nil, v.key)
									G.cry_redeemed_buffer[v.key] = true
									card:start_materialize()
									area:emplace(card)
									card.cost = 0
									card.shop_voucher = false
									local current_round_voucher = G.GAME.current_round.voucher
									card:redeem()
									G.GAME.current_round.voucher = current_round_voucher
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0,
										func = function()
											card:start_dissolve()
											return true
										end,
									}))
								end
							end
						end
					end
				end
			end
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "discover_amount" then
			if G.DISCOVER_TALLIES.vouchers.tally / G.DISCOVER_TALLIES.vouchers.of >= 1 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "voucher", "generation" },
}
local legendary = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Legendary",
	key = "legendary",
	config = { cry_legendary = true, cry_legendary_rate = 5 },
	pos = { x = 0, y = 6 },
	atlas = "atlasdeck",
	order = 15,
	loc_vars = function(self, info_queue, center)
		return { vars = { SMODS.get_probability_vars(self, 1, self.config.cry_legendary_rate, "Legendary Deck") } }
	end,
	calculate = function(self, back, context)
		if context.end_of_round and context.main_eval and context.beat_boss and G.jokers then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				if
					SMODS.pseudorandom_probability(
						self,
						"cry_legendary",
						1,
						self.config.cry_legendary_rate,
						"Legendary Deck"
					)
				then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({ --legendary = true isnt needed as you need to have legendaries unlocked to unlock this anyway
								set = "Joker",
								rarity = "Legendary",
								key_append = "cry_legendary_joker",
							})
							return true
						end,
					}))
					return { message = localize("k_plus_joker"), colour = G.C.RARITY[4], message_card = G.jokers }
				else
					return { message = localize("k_nope_ex"), colour = G.C.RARITY[4], message_card = G.jokers }
				end
			else
				return { message = localize("k_no_room_ex"), colour = G.C.RARITY[4], message_card = G.jokers }
			end
		end
	end,
	cry_antimatter_calculate = function(self, context)
		return self:calculate(nil, context)
	end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card({
						set = "Joker",
						rarity = "Legendary",
						key_append = "cry_legendary_joker",
					})
					return true
				end
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if G.jokers then
			local count = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.rarity == 4 then
					count = count + 1
				end
			end
			if count >= 2 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "chance", "generation", "joker", "rarity" },
}
local critical = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Critical",
	key = "critical",
	order = 10,
	config = { cry_crit_rate = 4, cry_crit_miss_rate = 8 },
	pos = { x = 4, y = 5 },
	atlas = "atlasdeck",
	loc_vars = function(self, info_queue, center)
		local _, miss_denom = SMODS.get_probability_vars(self, 1, self.config.cry_crit_miss_rate, "Critical Deck")
		local crit_num, crit_denom = SMODS.get_probability_vars(self, 1, self.config.cry_crit_rate, "Critical Deck")
		return { vars = { crit_num, crit_denom, miss_denom } }
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step then
			local hit =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_rate, "Critical Deck")
			local miss =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_miss_rate, "Critical Deck")
			local check, sound, text
			if hit then
				check, sound, text = 2, "talisman_emult", localize("cry_critical_hit_ex")
			elseif miss then
				check, sound, text = 0.5, "timpani", localize("cry_critical_miss_ex")
			end
			if check then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound(sound, 1)
						attention_text({
							scale = 1.4,
							text = text,
							hold = 2,
							align = "cm",
							offset = { x = 0, y = -2.7 },
							major = G.play,
						})
						local deck_card = G.deck.cards[1] or G.deck
						attention_text({
							text = "^" .. number_format(check),
							scale = 0.7,
							hold = 1.4,
							backdrop_colour = G.C.emult or G.C.DARK_EDITION,
							align = "tm",
							major = deck_card,
							offset = { x = 0, y = -0.05 * G.CARD_H },
						})
						if deck_card and deck_card.juice_up then
							deck_card:juice_up(0.6, 0.1)
						end
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						return true
					end,
				}))
				return {
					emult = check,
					remove_default_message = true,
				}
			end
		end
	end,
	cry_antimatter_calculate = function(self, context)
		if context.final_scoring_step then
			local hit =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_rate, "Critical Deck")
			if hit then
				return {
					emult = 2,
				}
			end
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if G.jokers then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.cry_rigged then
					unlock_card(self)
					break
				end
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "emult", "chance" },
}
local glowing = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Glowing",
	key = "glowing",
	-- is this config even used for anything
	config = { cry_glowing = true },
	pos = { x = 4, y = 2 },
	order = 9,
	loc_vars = function(self, info_queue, center)
		return { vars = { " " } }
	end,
	atlas = "glowing",
	calculate = function(self, back, context)
		if context.end_of_round and context.main_eval and context.beat_boss then
			for i = 1, #G.jokers.cards do
				if not Card.no(G.jokers.cards[i], "immutable", true) then
					Cryptid.manipulate(G.jokers.cards[i], { value = 1.25 })
					SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, G.jokers.cards[i])
				end
			end
			return nil, true
		end
	end,
	cry_antimatter_calculate = function(self, context)
		self:calculate(nil, context)
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
			if get_deck_win_stake("b_cry_beige") > 0 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "modify_card", "jokers", "value_manip" },
}
local beta = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Beta",
	key = "beta",
	config = { cry_beta = true },
	pos = { x = 5, y = 5 },
	order = 13,
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_beta = true
	end,
	cry_antimatter_apply = function(self) --nostalgic deck but without the -1 slot and without the blinds
		G.GAME.modifiers.cry_antimatter_beta = true
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
			if get_deck_win_stake() >= 9 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "joker_slot", "consumable_slot", "boss_blind" },
}
local bountiful = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Bountiful",
	key = "bountiful",
	pos = { x = 2, y = 6 },
	order = 14,
	atlas = "atlasdeck",
	calculate = function(self, back, context)
		if
			context.drawing_cards
			and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0)
		then
			return { cards_to_draw = 5 }
		end
	end,
	cry_antimatter_calculate = function(self, context)
		if
			context.drawing_cards
			and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0)
			and context.amount < 5
		then
			return { cards_to_draw = 5 }
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "round_win" then
			if
				G.GAME.blind.name == "The Serpent"
				and G.GAME.current_round.discards_left == G.GAME.round_resets.discards
			then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
}
local beige = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Beige",
	key = "beige",
	pos = { x = 1, y = 6 },
	order = 15,
	atlas = "atlasdeck",
	apply = function(self)
		G.GAME.modifiers.cry_common_value_quad = true
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "discover_amount" then
			if args.amount >= 200 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "joker", "value_manip", "rarity" },
}
local blank = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Blank",
	key = "blank",
	order = 75,
	pos = { x = 1, y = 0 },
	atlas = "atlasdeck",
	discovered = true,
}
local antimatter = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	extra_gamesets = { "Custom" },
	loc_vars = function(self, info_queue, center)
		return { key = Cryptid.gameset_loc(self, { mainline = "balanced", modest = "balanced", Custom = "custom" }) }
	end,
	name = "cry-Antimatter",
	order = 76,
	key = "antimatter",
	config = {
		cry_antimatter = true,
		cry_crit_rate = 4, --Critical Deck
		cry_legendary_rate = 5, --Legendary Deck
		-- Enhanced Decks
		cry_force_enhancement = "random",
		cry_force_edition = "random",
		cry_force_seal = "random",
		cry_forced_draw_amount = 5,
	},
	pos = { x = 2, y = 0 },
	calculate = function(self, back, context)
		return Cryptid.antimatter_trigger(
			self,
			context,
			Cryptid.gameset(G.P_CENTERS.b_cry_antimatter) == "madness",
			Cryptid.gameset(G.P_CENTERS.b_cry_antimatter) == "Custom"
		)
	end,
	apply = function(self)
		Cryptid.antimatter_apply(
			Cryptid.gameset(G.P_CENTERS.b_cry_antimatter) == "madness",
			Cryptid.gameset(G.P_CENTERS.b_cry_antimatter) == "Custom"
		)
	end,
	atlas = "atlasdeck",
	init = function(self)
		function Cryptid.antimatter_apply(skip, custom)
			local function check(back)
				return SMODS.RunSelect.Setup.choices.cry_antimatter[back]
			end
			-- editions is unused vanilla functionality but ill add compat anyway
			local vouchers, consumables, editions = {}, {}, {}
			-- Checkered Deck (this is the only one that needs manual compat now lmao)
			if check("b_checkered") then
				G.E_MANAGER:add_event(Event({
					func = function()
						for k, v in pairs(G.playing_cards) do
							if v.base.suit == "Clubs" then
								v:change_suit("Spades")
							end
							if v.base.suit == "Diamonds" then
								v:change_suit("Hearts")
							end
						end
						return true
					end,
				}))
			end
			--Mod Compat + Config value autocompat stuff
			for _, v in ipairs(G.P_CENTER_POOLS.Back) do
				if check(v.key) then
					-- APPLY FUNCS
					if type(v.cry_antimatter_apply) == "function" and check(v.key) then
						v:cry_antimatter_apply()
					end
					-- CONSUMABLES
					if type(v.cry_antimatter_consumables) == "function" then
						v:cry_antimatter_consumables(consumables)
					elseif v.config and v.config.consumables then
						for _, c in ipairs(v.config.consumables) do
							consumables[#consumables + 1] = c
						end
					end
					-- VOUCHERS
					if type(v.cry_antimatter_vouchers) == "function" then
						v:cry_antimatter_vouchers(vouchers)
					elseif v.config and v.config.vouchers then
						for _, c in ipairs(v.config.vouchers) do
							vouchers[#vouchers + 1] = c
						end
					elseif v.config and v.config.voucher then
						vouchers[#vouchers + 1] = v.config.voucher
					end
					-- EVERYTHING ELSE
					if v.config then
						if v.config.hands and v.config.hands > 0 then
							G.GAME.starting_params.hands = G.GAME.starting_params.hands + v.config.hands
						end
						if v.config.dollars and v.config.dollars > 0 then
							G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + v.config.dollars
						end
						if v.config.remove_faces then
							G.GAME.starting_params.no_faces = true
						end
						if v.config.spectral_rate then
							G.GAME.starting_params.spectral_rate =
								math.max(G.GAME.starting_params.spectral_rate or 0, v.config.spectral_rate)
						end
						if v.config.discards and v.config.discards > 0 then
							G.GAME.starting_params.discards = G.GAME.starting_params.discards + v.config.discards
						end
						if v.config.reroll_discount and v.config.reroll_discount > 0 then
							G.GAME.starting_params.reroll_cost = G.GAME.starting_params.reroll_cost
								- v.config.reroll_discount
						end
						if v.config.edition then
							for _ = 1, v.config.edition_count do
								editions[#editions + 1] = v.config.edition
							end
						end
						if v.config.randomize_rank_suit then
							G.GAME.starting_params.erratic_suits_and_ranks = true
						end
						if v.config.joker_slot and v.config.joker_slot > 0 then
							G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots
								+ v.config.joker_slot
						end
						if v.config.hand_size and v.config.hand_size > 0 then
							G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + v.config.hand_size
						end
						-- Only every reduce blind size multiplier
						if v.config.ante_scaling then
							G.GAME.starting_params.ante_scaling =
								math.min(G.GAME.starting_params.ante_scaling, v.config.ante_scaling)
						end
						if v.config.consumable_slot and v.config.consumable_slot > 0 then
							G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots
								+ v.config.consumable_slot
						end
						if v.config.extra_hand_bonus then
							G.GAME.modifiers.money_per_hand =
								math.max(G.GAME.modifiers.money_per_hand or 1, v.config.extra_hand_bonus)
						end
						if (v.config.extra_discard_bonus or 0) > 0 then
							G.GAME.modifiers.money_per_discard =
								math.max(G.GAME.modifiers.money_per_discard or 0, v.config.extra_discard_bonus)
						end
					end
				end
			end
			-- Create consumables
			if #consumables > 0 then
				delay(0.4)
				G.E_MANAGER:add_event(Event({
					func = function()
						for k, v in ipairs(consumables) do
							if G.P_CENTERS[v] then
								local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, v, "deck")
								card:add_to_deck()
								G.consumeables:emplace(card)
							end
						end
						return true
					end,
				}))
			end
			-- Sanitize and apply vouchers
			local clean_vouchers, applied_vouchers = {}, {}
			for _, v in ipairs(vouchers) do
				if not applied_vouchers[v] then
					clean_vouchers[#clean_vouchers + 1] = v
					applied_vouchers[v] = true
				end
			end
			if #clean_vouchers > 0 then
				for k, v in pairs(clean_vouchers) do
					if G.P_CENTERS[v] then
						G.GAME.used_vouchers[v] = true
						G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
						G.E_MANAGER:add_event(Event({
							func = function()
								Card.apply_to_run(nil, G.P_CENTERS[v])
								return true
							end,
						}))
					end
				end
			end
			if #editions > 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						local editionless_cards = {}
						for _, c in ipairs(G.playing_cards) do
							if not c.edition then
								editionless_cards[#editionless_cards + 1] = c
							end
						end
						for _, edition in ipairs(editions) do
							local card, idx = pseudorandom_element(editionless_cards, "edition_deck")
							card:set_edition({ [edition] = true }, nil, true)
							table.remove(editionless_cards, idx)
						end
						return true
					end,
				}))
			end
		end
		function Cryptid.antimatter_trigger(self, context, skip, custom)
			local function check(back)
				return (G.GAME.cry_antimatter_decks or {})[back]
			end
			local rets = {}
			if context.final_scoring_step then
				--Plasma Deck
				if check("b_plasma") then
					rets[#rets + 1] = { balance = true }
				end
			end
			if context.round_eval and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
				--Anaglyph Deck
				if check("b_anaglyph") then
					G.E_MANAGER:add_event(Event({
						func = function()
							add_tag(Tag("tag_double"))
							play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
							play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
							return true
						end,
					}))
				end
			end
			--Mod Compat
			for _, v in ipairs(G.P_CENTER_POOLS.Back) do
				if v.cry_antimatter_calculate and check(v.key) then
					rets[#rets + 1] = v:cry_antimatter_calculate(context)
				end
			end
			if next(rets) then
				return SMODS.merge_effects(rets)
			end
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
			if get_deck_win_stake("b_cry_blank") >= 8 then
				unlock_card(self)
			end
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "copying" },
}

-- Dont customize your antimatter deck here its in the base mod

return {
	name = "Misc. Decks",
	items = {
		very_fair,
		equilibrium,
		misprint,
		infinite,
		conveyor,
		CCD,
		wormhole,
		redeemed,
		legendary,
		critical,
		glowing,
		beta,
		bountiful,
		beige,
		blank,
		antimatter,
	},
}
