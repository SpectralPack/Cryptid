if CardSleeves then
	local veryfairsleeve = CardSleeves.Sleeve({
		key = "very_fair_sleeve",
		name = "Very Fair Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 6, y = 1 },
		config = { hands = -2, discards = -2 },
		unlocked = true,
		unlock_condition = { deck = "Very Fair Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
			G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
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
	})

	local infinitesleeve = CardSleeves.Sleeve({
		key = "infinite_sleeve",
		name = "Unlimited Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 4, y = 0 },
		config = { hand_size = 1 },
		unlocked = true,
		unlock_condition = { deck = "Infinite Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		trigger_effect = function(self, args) end,
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
	})

	local equilibriumsleeve = CardSleeves.Sleeve({
		key = "equilibrium_sleeve",
		name = "Balanced Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 2, y = 0 },
		config = { vouchers = { "v_overstock_norm", "v_overstock_plus" }, cry_equilibrium = true },
		unlocked = true,
		unlock_condition = { deck = "Deck of Equilibrium", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			change_shop_size(2)
			G.GAME.modifiers.cry_equilibrium = true
		end,
	})

	local misprintsleeve = CardSleeves.Sleeve({
		key = "misprint_sleeve",
		name = "Misprinted Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 3, y = 0 },
		config = { cry_misprint_min = 0.1, cry_misprint_max = 10 },
		unlocked = true,
		unlock_condition = { deck = "Misprint Deck", stake = 1 },
		apply = function(self)
			G.GAME.modifiers.cry_misprint_min = (G.GAME.modifiers.cry_misprint_min or 1) * self.config.cry_misprint_min
			G.GAME.modifiers.cry_misprint_max = (G.GAME.modifiers.cry_misprint_max or 1) * self.config.cry_misprint_max
			if self.get_current_deck_key() == "b_cry_antimatter" then
				G.GAME.modifiers.cry_misprint_min = 1
			end
		end,
	})

	local CCDsleeve = CardSleeves.Sleeve({
		key = "ccd_sleeve",
		name = "CCD Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 6, y = 0 },
		config = { cry_conveyor = true },
		unlocked = true,
		unlock_condition = { deck = "CCD Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.modifiers.cry_ccd = true
		end,
	})

	local wormholesleeve = CardSleeves.Sleeve({
		key = "wormhole_sleeve",
		name = "Wormhole Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 0, y = 0 },
		config = { cry_wormhole = true, cry_negative_rate = 20, joker_slot = -2 },
		unlocked = true,
		unlock_condition = { deck = "Wormhole Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		apply = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local card =
							create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_wormholesleeve")
						card:add_to_deck()
						card:start_materialize()
						G.jokers:emplace(card)
						return true
					end
				end,
			}))
			G.GAME.modifiers.cry_negative_rate = (G.GAME.modifiers.cry_negative_rate or 1)
				* self.config.cry_negative_rate
			G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.joker_slot
		end,
	})

	local conveyorsleeve = CardSleeves.Sleeve({
		key = "conveyor_sleeve",
		name = "Conveyor Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 5, y = 0 },
		config = { cry_conveyor = true },
		unlocked = true,
		unlock_condition = { deck = "Conveyor Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.modifiers.cry_conveyor = true
		end,
	})

	local redeemedsleeve = CardSleeves.Sleeve({
		key = "redeemed_sleeve",
		name = "Redeemed Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 7, y = 0 },
		config = {},
		unlocked = true,
		unlock_condition = { deck = "Redeemed Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		apply = function(self)
			G.GAME.modifiers.cry_redeemed = true
		end,
	})

	local glowingsleeve = CardSleeves.Sleeve({
		key = "glowing_sleeve",
		name = "Glowing Sleeve",
		atlas = "glowingSleeve",
		pos = { x = 4, y = 2 },
		config = { cry_glowing = true },
		unlocked = true,
		unlock_condition = { deck = "Glowing Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = { " " } }
		end,
		calculate = function(self, back, context)
			if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
				for i = 1, #G.jokers.cards do
					if not Card.no(G.jokers.cards[i], "immutable", true) then
						Cryptid.manipulate(G.jokers.cards[i], { value = 1.25 })
					end
				end
			end
		end,
	})

	local criticalsleeve = CardSleeves.Sleeve({
		key = "critical_sleeve",
		name = "Critical Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 8, y = 0 },
		config = { cry_crit_rate = 4, cry_crit_miss_rate = 8 },
		unlocked = true,
		unlock_condition = { deck = "Redeemed Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		apply = function(self) end,
		trigger_effect = function(self, args)
			if args.context == "final_scoring_step" then
				local aaa = SMODS.pseudorandom_probability(
					self,
					"cry_critical",
					1,
					self.config.cry_crit_rate,
					"Critical Sleeve"
				)
				local bbb = SMODS.pseudorandom_probability(
					self,
					"cry_critical",
					1,
					self.config.cry_crit_miss_rate,
					"Critical Sleeve"
				)
				if aaa then
					args.mult = args.mult ^ 2
					update_hand_text({ delay = 0 }, { mult = args.mult, chips = args.chips })
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
					args.mult = args.mult ^ 0.5
					update_hand_text({ delay = 0 }, { mult = args.mult, chips = args.chips })
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
				return args.chips, args.mult
			end
		end,
	})

	local encodedsleeve = CardSleeves.Sleeve({
		key = "encoded_sleeve",
		name = "Encoded Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 1, y = 0 },
		config = {},
		unlocked = true,
		unlock_condition = { deck = "Encoded Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						-- Adding a before spawning becuase jen banned copy_paste
						if
							G.P_CENTERS["j_cry_CodeJoker"]
							and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_CodeJoker"])
						then
							local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_CodeJoker")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
						end
						if
							G.P_CENTERS["j_cry_copypaste"]
							and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_copypaste"])
						then
							local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_copypaste")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
						end
						return true
					end
				end,
			}))

			--DOWNSIDE:

			G.GAME.joker_rate = 0
			G.GAME.planet_rate = 0
			G.GAME.tarot_rate = 0
			G.GAME.code_rate = 1e100
		end,
	})

	local nostalgicsleeve = CardSleeves.Sleeve({
		key = "beta_sleeve",
		name = "Nostalgic Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 4, y = 1 },
		config = { cry_beta = true },
		unlocked = true,
		unlock_condition = { deck = "Nostalgic Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.modifiers.cry_beta = true
		end,
	})

	local bountifulsleeve = CardSleeves.Sleeve({
		key = "bountiful_sleeve",
		name = "Bountiful Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 5, y = 1 },
		config = { cry_forced_draw_amount = 5 },
		unlocked = true,
		unlock_condition = { deck = "Bountiful Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.modifiers.cry_forced_draw_amount = self.config.cry_forced_draw_amount
		end,
	})

	local beigesleeve = CardSleeves.Sleeve({
		key = "beige_sleeve",
		name = "Beige Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 3, y = 1 },
		unlocked = true,
		unlock_condition = { deck = "Beige Deck", stake = 1 },
		loc_vars = function(self)
			local key
			if self.get_current_deck_key() == "b_cry_beige" then
				key = self.key .. "_alt"
				return { key = key, vars = {} }
			end
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			if self.get_current_deck_key() ~= "b_cry_beige" then
				G.GAME.modifiers.cry_common_value_quad = true
			else
				G.GAME.modifiers.cry_uncommon_value_quad = true
			end
		end,
	})

	local legendarysleeve = CardSleeves.Sleeve({
		key = "legendary_sleeve",
		name = "Legendary Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 1, y = 1 },
		config = { cry_legendary = true, cry_legendary_rate = 5 },
		unlocked = true,
		unlock_condition = { deck = "Legendary Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,
		trigger_effect = function(self, args)
			if args.context == "eval" and G.GAME.last_blind and G.GAME.last_blind.boss then
				if G.jokers then
					if #G.jokers.cards < G.jokers.config.card_limit then
						if
							SMODS.pseudorandom_probability(
								self,
								"cry_legendary",
								1,
								self.config.cry_legendary_rate,
								"Legendary Sleeve"
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
	})
	local spookysleeve = CardSleeves.Sleeve({
		key = "spooky_sleeve",
		name = "Spooky Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 2, y = 1 },
		config = { cry_spooky = true, cry_curse_rate = 0.25 },
		unlocked = true,
		unlock_condition = { deck = "Spooky Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		trigger_effect = function(self, args) end,
		apply = function(self)
			G.GAME.modifiers.cry_spooky = true
			G.GAME.modifiers.cry_curse_rate = self.config.cry_curse_rate or 0.25
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_chocolate_dice")
						card:add_to_deck()
						card:start_materialize()
						card:set_eternal(true)
						G.jokers:emplace(card)
						return true
					end
				end,
			}))
		end,
	})
	local antimattersleeve = CardSleeves.Sleeve({
		key = "antimatter_sleeve",
		name = "Antimatter Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 0, y = 1 },
		config = {
			voucher = {},
			cry_antimatter = true,
			cry_crit_rate = 4, -- Critical Sleeve, Effect Rate
			cry_legendary_rate = 5, -- Legendary Sleeve, Effect Rate
			cry_negative_rate = 20,
			cry_highlight_limit = 1e20,
		},
		unlocked = true,
		unlock_condition = { deck = "Antimatter Deck", stake = 1 },
		loc_vars = function(self, info_queue, center)
			-- Green Sleeve, Debt Effect
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_green",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					self.get_current_deck_key() == "b_green"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_green", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					self.config.debt_bonus = 2
					if G.STAGE == G.STAGES.RUN then
						-- only calculate if we're in a run, otherwise it's bogus
						self.config.added_bankrupt = self.config.debt_bonus
							* (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
					end
				end
			end

			-- CCD Sleeve, set config. (I do not know if this is important, I am just implementing everything that the corresponding Sleeve had)
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_ccd_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				self.config.cry_conveyor = true
			end

			-- Spooky Sleeve, set config. (Ditto w/ CCD)
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_spooky_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				self.config.cry_spooky = true
			end

			return { key = Cryptid.gameset_loc(self, { mainline = "balanced", modest = "balanced" }) }
		end,
		calculate = function(self, sleeve, context)
			if context.create_card and context.card then
				local card = context.card
				local is_booster_pack = card.ability.set == "Booster"

				-- Ghost Sleeve, Special Options
				if
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_ghost",
						"wins_by_key",
						"stake_gold"
					) or 0 ~= 0
				then
					if
						self.get_current_deck_key() == "b_ghost"
						or (
							self.get_current_deck_key() == "b_cry_antimatter"
							and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_ghost", "wins", 8)
								or 0 ~= 0
							)
						)
					then
						local is_spectral_pack = is_booster_pack and (card.ability.name:find("Spectral"))
						if is_spectral_pack then
							print("is spectral pack!")
							card.ability.extra = card.ability.extra + 2
						end
					end
				end

				-- Zodiac Sleeve, Special
				if
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_zodiac",
						"wins_by_key",
						"stake_gold"
					) or 0 ~= 0
				then
					if
						self.get_current_deck_key() == "b_zodiac"
						or (
							self.get_current_deck_key() == "b_cry_antimatter"
							and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_zodiac", "wins", 8)
								or 0 ~= 0
							)
						)
					then
						if is_booster_pack then
						end
						local is_arcana_pack = is_booster_pack and (card.ability.name:find("Arcana"))
						if is_arcana_pack then
							card.ability.extra = card.ability.extra + 2
						end

						local is_celestial_pack = is_booster_pack and (card.ability.name:find("Celestial"))
						if is_celestial_pack then
							card.ability.extra = card.ability.extra + 2
						end
					end
				end
			end

			-- Glowing Sleeve
			if
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_cry_glowing_sleeve",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			then
				if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
					for i = 1, #G.jokers.cards do
						if not Card.no(G.jokers.cards[i], "immutable", true) then
							Cryptid.manipulate(G.jokers.cards[i], { value = 1.25 })
						end
					end
				end
			end

			-- Plasma Sleeve, Shop Effect
			if context.shop_final_pass or context.reroll_shop then
				if
					self.get_current_deck_key() == "b_plasma"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_plasma", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					-- stop controller/mouse from doing anything
					local hold = 0.6 -- how long to take to ease the costs, and how long to hold the player
					G.CONTROLLER.locks.shop_reroll = true
					if G.CONTROLLER:save_cardarea_focus("shop_jokers") then
						G.CONTROLLER.interrupt.focus = true
					end

					local cardareas = {}
					for _, obj in pairs(G) do
						if type(obj) == "table" and obj["is"] and obj:is(CardArea) and obj.config.type == "shop" then
							cardareas[#cardareas + 1] = obj
						end
					end
					local total_cost, total_items_for_sale = 0, 0
					for _, cardarea in pairs(cardareas) do
						for _, card in pairs(cardarea.cards) do
							card:set_cost()
							local has_coupon_tag = card.area
								and card.ability.couponed
								and (card.area == G.shop_jokers or card.area == G.shop_booster)
							if has_coupon_tag then
								-- tags that set price to 0 (coupon, uncommon, rare, etc)
								card.cost = 0
								card.ability.couponed = false
							end
							total_cost = total_cost + card.cost
							total_items_for_sale = total_items_for_sale + 1
						end
					end
					local avg_cost = math.floor((total_cost - 1) / total_items_for_sale) -- make it always be in favour of the player
					for _, cardarea in pairs(cardareas) do
						for _, card in pairs(cardarea.cards) do
							card.cost = math.max(card.cost, card.base_cost)
							local mod = avg_cost - card.cost
							--		 table, value,	mod, floor, timer, not_blockable, delay, ease_type
							ease_value(card, "cost", mod, nil, nil, true, hold, "quad")
							-- card.cost = avg_cost
							-- card:set_cost()
						end
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound("gong", 1.2, 0.2)
							play_sound("gong", 1.2 * 1.5, 0.1)
							play_sound("tarot1", 1.6, 0.8)
							attention_text({
								scale = 1.3,
								colour = G.C.GOLD,
								text = localize("k_balanced"),
								hold = 1.5,
								align = "cm",
								offset = { x = 0, y = -3.5 },
								major = G.play,
							})
							return true
						end,
					}))
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = hold,
						func = function()
							-- allow player to buy cards again, ONLY after having eased prices
							G.CONTROLLER.interrupt.focus = false
							G.CONTROLLER.locks.shop_reroll = false
							G.CONTROLLER:recall_cardarea_focus("shop_jokers")
							return true
						end,
					}))
				end
			end

			-- Green Sleeve, Debt Effect
			if sleeve.config.debt_bonus then
				if context.end_of_round and not context.individual and not context.repetition then
					if not sleeve.config.added_bankrupt then
						sleeve.config.added_bankrupt = sleeve.config.debt_bonus
							* (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
					end
					G.GAME.bankrupt_at = G.GAME.bankrupt_at + sleeve.config.added_bankrupt
					sleeve.config.added_bankrupt = sleeve.config.debt_bonus
						* (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
					G.GAME.bankrupt_at = G.GAME.bankrupt_at - sleeve.config.added_bankrupt
				end
			end

			-- Checkered Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_checkered",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					not (
						self.get_current_deck_key() == "b_checkered"
						or (
							self.get_current_deck_key() == "b_cry_antimatter"
							and (
									Cryptid.safe_get(
										G.PROFILES,
										G.SETTINGS.profile,
										"deck_usage",
										"b_checkered",
										"wins",
										8
									) or 0
								)
								~= 0
						)
					)
				then
					local card = context.card
					local force_suits = { ["Clubs"] = "Spades", ["Diamonds"] = "Hearts" }
					local is_playing_card = card
						and (card.ability.set == "Default" or card.ability.set == "Enhanced")
						and card.config.card_key
					if (context.create_card or context.modify_playing_card) and card and is_playing_card then
						for from_suit, to_suit in pairs(force_suits) do
							if card.base.suit == from_suit then
								local base = SMODS.Suits[to_suit].card_key
									.. "_"
									.. SMODS.Ranks[card.base.value].card_key
								local initial = G.GAME.blind == nil or context.create_card
								card:set_base(G.P_CARDS[base], initial)
							end
						end
					end
				end
			end
		end,

		trigger_effect = function(self, args)
			-- Legendary Sleeve, Create Joker On Boss Clear
			if args.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
				if G.jokers then
					if #G.jokers.cards < G.jokers.config.card_limit then
						local legendary_poll = pseudorandom(pseudoseed("cry_legendary"))
						legendary_poll = legendary_poll / (G.GAME.probabilities.normal or 1)
						if
							SMODS.pseudorandom_probability(
								self,
								"cry_legendary",
								1,
								self.config.cry_legendary_rate,
								"Antimatter Sleeve"
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
		apply = function(self)
			local function get_random() -- borrowed from CardSleeves
				return pseudorandom("slv", 3, 6)
			end
			Cryptid.antimattersleeve_apply(self)

			-- Green Sleeve, Debt Effect
			if self.config.debt_bonus then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						self.config.added_bankrupt = self.config.debt_bonus
							* (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
						G.GAME.bankrupt_at = G.GAME.bankrupt_at - self.config.added_bankrupt
						return true
					end,
				}))
			end

			-- Legendary Sleeve, Start Joker
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_legendary_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
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
			end

			-- Encoded Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_encoded_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							-- Adding a before spawning becuase jen banned copy_paste
							if
								G.P_CENTERS["j_cry_CodeJoker"]
								and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_CodeJoker"])
							then
								local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_CodeJoker")
								card:add_to_deck()
								card:start_materialize()
								G.jokers:emplace(card)
							end
							if
								G.P_CENTERS["j_cry_copypaste"]
								and (G.GAME.banned_keys and not G.GAME.banned_keys["j_cry_copypaste"])
							then
								local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_copypaste")
								card:add_to_deck()
								card:start_materialize()
								G.jokers:emplace(card)
							end
							return true
						end
					end,
				}))
			end

			-- Wormhole Sleeve, Starting Joker
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_wormhole_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							local card =
								create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_wormholesleeve")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
							return true
						end
					end,
				}))
			end

			-- Bountiful Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_bountiful_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_forced_draw_amount = 5
			end
			-- Infinite Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_infinite_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_highlight_limit = self.config.cry_highlight_limit
			end
			-- Misprint Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_misprint_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_misprint_min = 1
				G.GAME.modifiers.cry_misprint_max = (G.GAME.modifiers.cry_misprint_max or 1) * 10
			end
			-- CCD Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_ccd_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_ccd = true
			end
			-- Spooky Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_spooky_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_spooky = true
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_chocolate_dice")
							card:add_to_deck()
							card:start_materialize()
							card:set_eternal(true)
							G.jokers:emplace(card)
							return true
						end
					end,
				}))
			end
			-- Redeemed Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_redeemed_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_redeemed = true
			end
			-- Balanced Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_misprint_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_equilibrium = true
			end
			-- Beige Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_beige_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					self.get_current_deck_key() == "b_cry_beige"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_cry_beige", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					G.GAME.modifiers.cry_uncommon_value_quad = true
				else
					G.GAME.modifiers.cry_common_value_quad = true
				end
			end
			-- Wormhole Sleeve, Negative Rate
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_cry_wormhole_sleeve",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.modifiers.cry_negative_rate = (G.GAME.modifiers.cry_negative_rate or 1)
					* self.config.cry_negative_rate
			end
			-- Abandoned Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_abandoned",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.starting_params.no_faces = true
			end
			-- Erratic Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_erratic",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					self.get_current_deck_key() == "b_erratic"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_erratic", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + get_random()
					G.GAME.starting_params.discards = G.GAME.starting_params.discards + get_random()
					G.GAME.starting_params.hands = G.GAME.starting_params.hands + get_random()
					G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + get_random()
				else
					G.GAME.starting_params.erratic_suits_and_ranks = true
				end
			end
			-- Red Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_red",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			end
			-- Blue Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_blue",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			end
			-- Yellow Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_yellow",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					not (
						self.get_current_deck_key() == "b_yellow"
						or (
							self.get_current_deck_key() == "b_cry_antimatter"
							and (
									Cryptid.safe_get(
										G.PROFILES,
										G.SETTINGS.profile,
										"deck_usage",
										"b_yellow",
										"wins",
										8
									) or 0
								)
								~= 0
						)
					)
				then
					G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + 10
				end
			end
			-- Green Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_green",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					not (
						self.get_current_deck_key() == "b_green"
						or (
							self.get_current_deck_key() == "b_cry_antimatter"
							and (
									Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_green", "wins", 8)
									or 0
								)
								~= 0
						)
					)
				then
					G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 0) + 2
					G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + 1
				end
			end
			-- Black Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_black",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
			end
			-- Ghost Sleeve, Special Spectral Rate
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_ghost",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					self.get_current_deck_key() == "b_ghost"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_ghost", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					G.GAME.spectral_rate = G.GAME.spectral_rate * 2
				end
			end
			-- Painted Sleeve
			if
				(
					Cryptid.safe_get(
						G.PROFILES,
						G.SETTINGS.profile,
						"sleeve_usage",
						"sleeve_casl_painted",
						"wins_by_key",
						"stake_gold"
					) or 0
				) ~= 0
			then
				if
					self.get_current_deck_key() == "b_painted"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
								Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_painted", "wins", 8)
								or 0
							)
							~= 0
					)
				then
					if not G.GAME.modifiers.cry_highlight_limit then
						G.GAME.modifiers.cry_highlight_limit = 5
					end
					G.GAME.modifiers.cry_highlight_limit = G.GAME.modifiers.cry_highlight_limit + 1
				else
					G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 2
				end
			end
		end,
		int = function(self)
			function Cryptid.antimattersleeve_trigger_final_scoring(self, context, skip)
				-- Critical Sleeve
				if
					(
							Cryptid.safe_get(
								G.PROFILES,
								G.SETTINGS.profile,
								"sleeve_usage",
								"sleeve_cry_critical_sleeve",
								"wins_by_key",
								"stake_gold"
							) or 0
						)
						~= 0
					or skip
				then
					if context.context == "final_scoring_step" then
						if
							SMODS.pseudorandom_probability(
								self,
								"cry_critical",
								1,
								self.config.cry_crit_rate,
								"Antimatter Sleeve"
							)
						then
							context.mult = context.mult ^ 2
							update_hand_text({ delay = 0 }, { mult = context.mult, chips = context.chips })
							G.E_MANAGER:add_event(Event({
								func = function()
									play_sound("talisman_emult", 1)
									attention_text({
										scale = 1.4,
										text = localize("cry_critical_hit_ex"),
										hold = 4,
										align = "cm",
										offset = { x = 0, y = -1.7 },
										major = G.play,
									})
									return true
								end,
							}))
							delay(0.6)
						end
					end
				end

				-- Plasma Sleeve
				if
					(self.get_current_deck_key() == "b_plasma" or self.get_current_deck_key() == "b_cry_antimatter")
					and (
						(
								Cryptid.safe_get(
									G.PROFILES,
									G.SETTINGS.profile,
									"sleeve_usage",
									"sleeve_casl_plasma",
									"wins_by_key",
									"stake_gold"
								) or 0
							)
							~= 0
						or skip
					)
				then
					local tot = context.chips + context.mult
					context.chips = math.floor(tot / 2)
					context.mult = math.floor(tot / 2)
					update_hand_text({ delay = 0 }, { mult = context.mult, chips = context.chips })

					G.E_MANAGER:add_event(Event({
						func = function()
							local text = localize("k_balanced")
							play_sound("gong", 0.94, 0.3)
							play_sound("gong", 0.94 * 1.5, 0.2)
							play_sound("tarot1", 1.5)
							ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
							ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
							attention_text({
								scale = 1.4,
								text = text,
								hold = 2,
								align = "cm",
								offset = { x = 0, y = -2.7 },
								major = G.play,
							})
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								blockable = false,
								blocking = false,
								delay = 4.3,
								func = function()
									ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
									ease_colour(G.C.UI_MULT, G.C.RED, 2)
									return true
								end,
							}))
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								blockable = false,
								blocking = false,
								no_delete = true,
								delay = 6.3,
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
					delay(0.6)
				end
				return context.chips, context.mult
			end
			function Cryptid.antimattersleeve_trigger(self, context, skip)
				-- If Last Blind was a Boss
				if context.context == "eval" and Cryptid.safe_get(G.GAME, "last_blind", "boss") then
					-- Glowing Sleeve, Mult Values Effect
					if
						(
								Cryptid.safe_get(
									G.PROFILES,
									G.SETTINGS.profile,
									"sleeve_usage",
									"sleeve_cry_glowing_sleeve",
									"wins_by_key",
									"stake_gold"
								) or 0
							)
							~= 0
						or skip
					then
						for i = 1, #G.jokers.cards do
							Cryptid.manipulate(G.jokers.cards[i], { value = 1.25 })
						end
					end

					-- Legendary Sleeve, Create New Card Effect
					if G.jokers then
						if
							(
									Cryptid.safe_get(
										G.PROFILES,
										G.SETTINGS.profile,
										"sleeve_usage",
										"sleeve_cry_legendary_sleeve",
										"wins_by_key",
										"stake_gold"
									) or 0
								)
								~= 0
							or skip
						then
							if #G.jokers.cards < G.jokers.config.card_limit then
								local legendary_poll = pseudorandom(pseudoseed("cry_legendary"))
								legendary_poll = legendary_poll / (G.GAME.probabilities.normal or 1)
								if legendary_poll < self.config.cry_legendary_rate then
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

					-- Anaglyph Sleeve, Normal
					if
						(
								(
									Cryptid.safe_get(
										G.PROFILES,
										G.SETTINGS.profile,
										"sleeve_usage",
										"sleeve_casl_anaglyph",
										"wins_by_key",
										"stake_gold"
									) or 0
								) ~= 0
							)
							and not (self.get_current_deck_key() == "b_anaglyph" or (self.get_current_deck_key() == "b_cry_antimatter" and (Cryptid.safe_get(
								G.PROFILES,
								G.SETTINGS.profile,
								"deck_usage",
								"b_anaglyph",
								"wins",
								8
							) or 0) ~= 0))
						or skip
					then
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

				-- Anaglyph Sleeve, Special
				if context.context == "eval" and not Cryptid.safe_get(G.GAME, "last_blind", "boss") then
					if
						self.get_current_deck_key() == "b_anaglyph"
						or (self.get_current_deck_key() == "b_cry_antimatter" and (Cryptid.safe_get(
							G.PROFILES,
							G.SETTINGS.profile,
							"deck_usage",
							"b_anaglyph",
							"wins",
							8
						) or 0) ~= 0)
						or skip
					then
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
			end
		end,
	})
	function Cryptid.antimattersleeve_apply(self, skip)
		G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
		-- All Decks with Vouchers (see Cryptid.get_antimatter_vouchers)
		local vouchers = Cryptid.get_antimattersleeve_vouchers(self, nil, skip)
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
		--All Consumables (see Cryptid.get_antimatter_consumables)
		local querty = Cryptid.get_antimattersleeve_consumables(self, nil, skip)
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
	end
	function Cryptid.get_antimattersleeve_vouchers(self, voucher_table, skip)
		-- Create a table or use one that is passed into the function
		if not voucher_table or type(voucher_table) ~= "table" then
			voucher_table = {}
		end
		-- Add Vouchers into the table by key
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
		-- Yellow Sleeve, Vouchers (Special)
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_yellow",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				self.get_current_deck_key() == "b_yellow"
				or (
					self.get_current_deck_key() == "b_cry_antimatter"
					and (
						Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_yellow", "wins", 8)
						or 0 ~= 0
					)
				)
			then
				Add_voucher_to_the_table(voucher_table, "v_seed_money")
			end
		end

		-- Magic Sleeve, Vouchers
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_magic",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				self.get_current_deck_key() == "b_magic"
				or (
					self.get_current_deck_key() == "b_cry_antimatter"
					and (Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_magic", "wins", 8) or 0 ~= 0)
				)
			then
				Add_voucher_to_the_table(voucher_table, "v_omen_globe")
			else
				Add_voucher_to_the_table(voucher_table, "v_crystal_ball")
			end
		end

		-- Nebula Sleeve, Vouchers
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_nebula",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				self.get_current_deck_key() == "b_nebula"
				or (
					self.get_current_deck_key() == "b_cry_antimatter"
					and (
						Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_nebula", "wins", 8)
						or 0 ~= 0
					)
				)
			then
				Add_voucher_to_the_table(voucher_table, "v_observatory")
			else
				Add_voucher_to_the_table(voucher_table, "v_telescope")
			end
		end

		-- Zodiac Sleeve, Vouchers
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_zodiac",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				not (
					self.get_current_deck_key() == "b_zodiac"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
							Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_zodiac", "wins", 8)
							or 0 ~= 0
						)
					)
				)
			then
				Add_voucher_to_the_table(voucher_table, "v_tarot_merchant")
				Add_voucher_to_the_table(voucher_table, "v_planet_merchant")
				Add_voucher_to_the_table(voucher_table, "v_overstock_norm")
			end
		end

		-- Balanced Sleeve, Vouchers
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_cry_equilibrium_sleeve",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				self.get_current_deck_key() == "b_cry_equilibrium"
				or (
					self.get_current_deck_key() == "b_cry_antimatter"
					and (
						Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_cry_equilibrium", "wins", 8)
						or 0 ~= 0
					)
				)
			then
				-- I thought that overstock multi would be a good way to extend the theme of this deck, without letting the game add duplicate vouchers. ~ Slaaneshi Kitten
				Add_voucher_to_the_table(voucher_table, "v_cry_overstock_multi")
			else
				Add_voucher_to_the_table(voucher_table, "v_overstock_norm")
				Add_voucher_to_the_table(voucher_table, "v_overstock_plus")
			end
		end

		return voucher_table
	end
	function Cryptid.get_antimattersleeve_consumables(self, consumable_table, skip)
		if not consumable_table or type(consumable_table) ~= "table" then
			consumable_table = {}
		end

		-- Magic Sleeve, Consumables
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_magic",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				not (
					self.get_current_deck_key() == "b_magic"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
							Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_magic", "wins", 8)
							or 0 ~= 0
						)
					)
				)
			then
				table.insert(consumable_table, "c_fool")
				table.insert(consumable_table, "c_fool")
			end
		end

		-- Ghost Sleeve, Consumables
		if
			(
				Cryptid.safe_get(
					G.PROFILES,
					G.SETTINGS.profile,
					"sleeve_usage",
					"sleeve_casl_ghost",
					"wins_by_key",
					"stake_gold"
				) or 0 ~= 0
			) or skip
		then
			if
				not (
					self.get_current_deck_key() == "b_ghost"
					or (
						self.get_current_deck_key() == "b_cry_antimatter"
						and (
							Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "deck_usage", "b_ghost", "wins", 8)
							or 0 ~= 0
						)
					)
				)
			then
				table.insert(consumable_table, "c_hex")
			end
		end
		return consumable_table
	end
	local sleeveitems = {}
	if CardSleeves then
		sleeveitems = {
			veryfairsleeve,
			infinitesleeve,
			equilibriumsleeve,
			misprintsleeve,
			CCDsleeve,
			wormholesleeve,
			conveyorsleeve,
			redeemedsleeve,
			glowingsleeve,
			criticalsleeve,
			encodedsleeve,
			nostalgicsleeve,
			bountifulsleeve,
			beigesleeve,
			legendarysleeve,
			spookysleeve,
			antimattersleeve,
		}
	end
end
return { name = "Sleeves", init = function() end, items = { sleeveitems } }
