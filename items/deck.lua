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
	cry_antimatter_vouchers = function(self, voucher_table)
		for _, v in ipairs(self.config.vouchers) do
			voucher_table[#voucher_table + 1] = v
		end
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
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
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

			if G.GAME.modifiers.cry_redeemed then
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
		if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
			if G.jokers then
				if #G.jokers.cards < G.jokers.config.card_limit then
					if
						SMODS.pseudorandom_probability(
							self,
							"cry_legendary",
							1,
							self.config.cry_legendary_rate,
							"Legendary Deck"
						)
					then
						local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "")
						card:add_to_deck()
						card:start_materialize()
						G.jokers:emplace(card)
						return true
					else
						card_eval_status_text(
							G.jokers,
							"jokers",
							nil,
							nil,
							nil,
							{ message = localize("k_nope_ex"), colour = G.C.RARITY[4] }
						)
					end
				else
					card_eval_status_text(
						G.jokers,
						"jokers",
						nil,
						nil,
						nil,
						{ message = localize("k_no_room_ex"), colour = G.C.RARITY[4] }
					)
				end
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
					local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
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
		if Cryptid.safe_get(G, "jokers") then
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
		local _, aaa = SMODS.get_probability_vars(self, 1, self.config.cry_crit_miss_rate, "Critical Deck")
		local bbb, ccc = SMODS.get_probability_vars(self, 1, self.config.cry_crit_rate, "Critical Deck")
		return { vars = { bbb, ccc, aaa } }
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step then
			local aaa =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_rate, "Critical Deck")
			local bbb =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_miss_rate, "Critical Deck")
			local check
			if aaa then
				check = 2
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("talisman_emult", 1)
						attention_text({
							scale = 1.4,
							text = localize("cry_critical_hit_ex"),
							hold = 2,
							align = "cm",
							offset = { x = 0, y = -2.7 },
							major = G.play,
						})
						return true
					end,
				}))
			elseif bbb then
				check = 0.5
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("timpani", 1)
						attention_text({
							scale = 1.4,
							text = localize("cry_critical_miss_ex"),
							hold = 2,
							align = "cm",
							offset = { x = 0, y = -2.7 },
							major = G.play,
						})
						return true
					end,
				}))
			end
			delay(0.6)
			if check then
				return {
					emult = check,
					no_message = true,
				}
			end
		end
	end,
	cry_antimatter_calculate = function(self, context)
		if context.final_scoring_step then
			local aaa =
				SMODS.pseudorandom_probability(self, "cry_critical", 1, self.config.cry_crit_rate, "Critical Deck")
			if aaa then
				return {
					emult = 2,
				}
			end
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if Cryptid.safe_get(G, "jokers") then
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
		if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
			for i = 1, #G.jokers.cards do
				if not Card.no(G.jokers.cards[i], "immutable", true) then
					Cryptid.manipulate(G.jokers.cards[i], { value = 1.25 })
				end
			end
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
			--Blue Deck
			if check("b_blue") then
				G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			end
			--Yellow Deck
			if check("b_yellow") then
				G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + 10
			end
			--Abandoned Deck
			if check("b_abandoned") then
				G.GAME.starting_params.no_faces = true
			end
			--Ghost Deck
			if check("b_ghost") then
				G.GAME.spectral_rate = 2
			end
			-- Red Deck
			if check("b_red") then
				G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			end
			-- Checkered Deck
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
			-- Erratic Deck
			if check("b_erratic") then
				G.GAME.starting_params.erratic_suits_and_ranks = true
			end
			-- Black Deck
			if check("b_black") then
				G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
			end
			-- Painted Deck
			if check("b_painted") then
				G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 2
			end
			-- Green Deck
			if check("b_green") then
				G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
				G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + 1
			end
			--Mod Compat
			for _, v in ipairs(G.P_CENTER_POOLS.Back) do
				if v.cry_antimatter_apply and check(v.key) then
					v:cry_antimatter_apply()
				end
			end
			--All Consumables (see Cryptid.get_antimatter_consumables)
			local querty = Cryptid.get_antimatter_consumables(nil, skip, custom)
			if #querty > 0 then
				delay(0.4)
				G.E_MANAGER:add_event(Event({
					func = function()
						for k, v in ipairs(querty) do
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
			-- All Decks with Vouchers (see Cryptid.get_antimatter_vouchers)
			local vouchers = Cryptid.get_antimatter_vouchers(nil, skip, custom)
			if #vouchers > 0 then
				for k, v in pairs(vouchers) do
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
		function Cryptid.get_antimatter_vouchers(voucher_table, skip, custom)
			-- Create a table or use one that is passed into the function
			if not voucher_table or type(voucher_table) ~= "table" then
				voucher_table = {}
			end
			-- Add Vouchers into the table by key
			-- Ignores duplicates
			local function already_exists(t, voucher)
				for _, v in ipairs(t) do
					if v == voucher then
						return true
					end
				end
				return false
			end
			local function Add_voucher_to_the_table(t, voucher)
				if not already_exists(t, voucher) then
					table.insert(t, voucher)
				end
			end
			local function check(back)
				return SMODS.RunSelect.Setup.choices.cry_antimatter[back]
			end
			--Nebula Deck
			if check("b_nebula") then
				Add_voucher_to_the_table(voucher_table, "v_telescope")
			end
			-- Magic Deck
			if check("b_magic") then
				Add_voucher_to_the_table(voucher_table, "v_crystal_ball")
			end
			-- Zodiac Deck
			if check("b_zodiac") then
				Add_voucher_to_the_table(voucher_table, "v_tarot_merchant")
				Add_voucher_to_the_table(voucher_table, "v_planet_merchant")
				Add_voucher_to_the_table(voucher_table, "v_overstock_norm")
			end
			for _, v in ipairs(G.P_CENTER_POOLS.Back) do
				if v.cry_antimatter_vouchers and check(v.key) then
					v:cry_antimatter_vouchers(voucher_table)
				end
			end
			local clean_table = {}
			for _, v in ipairs(voucher_table) do
				Add_voucher_to_the_table(clean_table, v)
			end
			return clean_table
		end
		--Does this even need to be a function idk
		function Cryptid.get_antimatter_consumables(consumable_table, skip, custom)
			local function check(back)
				return SMODS.RunSelect.Setup.choices.cry_antimatter[back]
			end
			if not consumable_table or type(consumable_table) ~= "table" then
				consumable_table = {}
			end
			if check("b_magic") then
				table.insert(consumable_table, "c_fool")
				table.insert(consumable_table, "c_fool")
			end
			if check("b_ghost") then
				table.insert(consumable_table, "c_hex")
			end
			for _, v in ipairs(G.P_CENTER_POOLS.Back) do
				if v.cry_antimatter_consumables and check(v.key) then
					v:cry_antimatter_consumables(consumable_table)
				end
			end
			return consumable_table
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

--[[
Customize your Antimatter Deck here for the TRUE Sandbox experience!
How to use Custom Antimatter Deck:
1: Add decks to the antimatter_custom table with the format deck_key = true
2: Win a run on Gold Stake for each deck
3: Go to Mods > Cryptid > Thematic Sets > Decks > Antimatter Deck
4: Switch Gameset to  "Custom"

]]
--
local antimatter_custom = {
	["b_red"] = true,
	["b_blue"] = true,
	["b_yellow"] = true,
	["b_green"] = true,
	["b_black"] = true,
}

return {
	name = "Misc. Decks",
	init = function()
		G.SETTINGS.custom_antimatter_deck = antimatter_custom
	end,
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
