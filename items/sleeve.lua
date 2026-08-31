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
		attributes = { "hands", "discard", "voucher" },
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
		attributes = { "hand_size", "play_limit", "discard_limit" },
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
		attributes = { "shop", "voucher" },
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
		attributes = { "value_manip" },
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
		attributes = { "ccd" },
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
		attributes = { "rarity", "joker", "joker_slot", "edition" },
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
		attributes = { "position", "generation", "destroy_card", "joker" },
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
		attributes = { "voucher" },
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
		attributes = { "value_manip", "modify_card", "joker" },
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
				local crit_hit = SMODS.pseudorandom_probability(
					self,
					"cry_critical",
					1,
					self.config.cry_crit_rate,
					"Critical Sleeve"
				)
				local crit_miss = SMODS.pseudorandom_probability(
					self,
					"cry_critical",
					1,
					self.config.cry_crit_miss_rate,
					"Critical Sleeve"
				)
				if crit_hit then
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
				elseif crit_miss then
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
		attributes = { "emult", "chance" },
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
		attributes = { "joker", "code", "consumable" },
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
		attributes = { "joker_slot", "consumable_slot", "boss_blind" },
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

		calculate = function(self, back, context)
			if
				context.drawing_cards
				and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0)
			then
				return { cards_to_draw = 5 }
			end
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
		attributes = { "value_manip" },
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
			if args.context == "eval" and G.GAME.last_blind and Cryptid.is_boss_blind(G.GAME.last_blind) then
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
		attributes = { "rarity", "joker", "generation", "chance" },
	})
	local spookysleeve = CardSleeves.Sleeve({
		key = "spooky_sleeve",
		name = "Spooky Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 2, y = 1 },
		config = { cry_curse_rate = 0.25 },
		unlocked = true,
		unlock_condition = { deck = "Spooky Deck", stake = 1 },
		loc_vars = function(self)
			return { vars = {} }
		end,

		calculate = function(self, blind, context)
			if context.modify_ante and context.ante_end then
				local card
				if pseudorandom(pseudoseed("cry_spooky_curse")) < self.config.cry_curse_rate then
					card = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "cry_spooky")
				else
					card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_spooky")
				end
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
			end
		end,
		apply = function(self)
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
		attributes = { "joker", "rarity", "generation" },
	})
	function Cryptid.get_sleeve_matching_deck(sleeve)
		if not sleeve then
			return nil
		end
		local key = sleeve.key_base or sleeve.key or ""
		if sleeve.matching_deck then
			return sleeve.matching_deck
		end
		if sleeve.unlock_condition and sleeve.unlock_condition.deck and G.P_CENTERS[sleeve.unlock_condition.deck] then
			return sleeve.unlock_condition.deck
		end
		if G.P_CENTERS["b_" .. key] then
			return "b_" .. key
		end
		local stripped = key:gsub("_sleeve$", "")
		if G.P_CENTERS["b_cry_" .. stripped] then
			return "b_cry_" .. stripped
		end
		if G.P_CENTERS["b_" .. stripped] then
			return "b_" .. stripped
		end
		return nil
	end

	local function is_synergy_active(sleeve, sleeve_obj)
		local cur_deck = (sleeve_obj and sleeve_obj.get_current_deck_key and sleeve_obj.get_current_deck_key())
			or (CardSleeves and CardSleeves.Sleeve and CardSleeves.Sleeve.get_current_deck_key and CardSleeves.Sleeve.get_current_deck_key())
			or (G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key)
			or ""
		local matching_deck = Cryptid.get_sleeve_matching_deck(sleeve)
		if not matching_deck then
			return false
		end
		if cur_deck == matching_deck then
			return true
		end
		if Cryptid.antimatter_compat(matching_deck) then
			return true
		end
		return false
	end

	local function create_sleeve_proxy(sleeve, deck_key)
		local proxy_config = {}
		local proxy = {
			get_current_deck_key = function()
				return deck_key or "b_none"
			end,
		}
		setmetatable(proxy, {
			__index = function(t, k)
				if k == "config" then
					return proxy_config
				end
				return sleeve[k]
			end,
			__newindex = function(t, k, v)
				if k == "config" then
					proxy_config = v
				else
					sleeve[k] = v
				end
			end,
		})
		return proxy
	end

	local function with_sleeve_context(sleeve, deck_key, func, ...)
		local proxy = create_sleeve_proxy(sleeve, deck_key)
		local success, ret1, ret2 = pcall(func, proxy, ...)
		if not success then
			sendErrorMessage("Error running sleeve " .. tostring(sleeve.key) .. ": " .. tostring(ret1), "Cryptid")
		else
			return ret1, ret2
		end
	end

	local special_antimatter_sleeves = {
		["sleeve_cry_very_fair_sleeve"] = true, -- Skip downside-only challenge sleeve
		["sleeve_cry_wormhole_sleeve"] = function(sleeve, action, context)
			if action == "apply" then
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							local card = create_card("Joker", G.jokers, nil, "cry_exotic", nil, nil, nil, "cry_wormholesleeve")
							card:add_to_deck()
							card:start_materialize()
							G.jokers:emplace(card)
							return true
						end
					end,
				}))
				G.GAME.modifiers.cry_negative_rate = (G.GAME.modifiers.cry_negative_rate or 1) * 20
			end
		end,
		["sleeve_cry_encoded_sleeve"] = function(sleeve, action, context)
			if action == "apply" then
				G.E_MANAGER:add_event(Event({
					func = function()
						if G.jokers then
							if G.P_CENTERS["j_cry_CodeJoker"] and (not G.GAME.banned_keys or not G.GAME.banned_keys["j_cry_CodeJoker"]) then
								local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_CodeJoker")
								card:add_to_deck()
								card:start_materialize()
								G.jokers:emplace(card)
							end
							if G.P_CENTERS["j_cry_copypaste"] and (not G.GAME.banned_keys or not G.GAME.banned_keys["j_cry_copypaste"]) then
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
		end,
		["sleeve_cry_critical_sleeve"] = function(sleeve, action, context)
			if (action == "calculate" or action == "trigger_effect") and context and context.context == "final_scoring_step" then
				if SMODS.pseudorandom_probability(sleeve, "cry_critical", 1, sleeve.config.cry_crit_rate or 4, "Antimatter Sleeve") then
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
		end,
		["sleeve_cry_misprint_sleeve"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.modifiers.cry_misprint_min = 1
				G.GAME.modifiers.cry_misprint_max = (G.GAME.modifiers.cry_misprint_max or 1) * 10
			end
		end,
		["sleeve_cry_conveyor_sleeve"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.modifiers.cry_antimatter_conveyor = true
			end
		end,
		["sleeve_cry_beta_sleeve"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.modifiers.cry_antimatter_beta = true
			end
		end,
		["sleeve_cry_bountiful_sleeve"] = function(sleeve, action, context)
			if (action == "calculate" or action == "trigger_effect") and context and context.drawing_cards then
				if (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) and context.amount and context.amount < 5 then
					return { cards_to_draw = 5 }
				end
			end
		end,
		["sleeve_casl_black"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
			end
		end,
		["sleeve_casl_painted"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 2
				if is_synergy_active(sleeve) then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						func = function()
							SMODS.change_play_limit(1)
							SMODS.change_discard_limit(1)
							return true
						end,
					}))
				end
			elseif (action == "calculate" or action == "trigger_effect") and is_synergy_active(sleeve) then
				if CardSleeves and CardSleeves.Sleeve and CardSleeves.Sleeve.obj_table and CardSleeves.Sleeve.obj_table["sleeve_casl_painted"] then
					local orig = CardSleeves.Sleeve.obj_table["sleeve_casl_painted"]
					if orig.calculate then
						return orig:calculate(sleeve, context)
					end
				end
			end
		end,
		["sleeve_casl_nebula"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.used_vouchers["v_telescope"] = true
				G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						Card.apply_to_run(nil, G.P_CENTERS["v_telescope"])
						return true
					end,
				}))
				if is_synergy_active(sleeve) then
					G.GAME.used_vouchers["v_observatory"] = true
					G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							Card.apply_to_run(nil, G.P_CENTERS["v_observatory"])
							return true
						end,
					}))
				end
			end
		end,
		["sleeve_casl_green"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + 1
				G.GAME.modifiers.money_per_discard = (G.GAME.modifiers.money_per_discard or 0) + 1
				if is_synergy_active(sleeve) then
					sleeve.config.debt_bonus = 2
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						func = function()
							sleeve.config.added_bankrupt = sleeve.config.debt_bonus * (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
							G.GAME.bankrupt_at = G.GAME.bankrupt_at - sleeve.config.added_bankrupt
							return true
						end,
					}))
				end
			elseif (action == "calculate" or action == "trigger_effect") and is_synergy_active(sleeve) then
				if sleeve.config.debt_bonus and (context.end_of_round and not context.individual and not context.repetition) then
					if not sleeve.config.added_bankrupt then
						sleeve.config.added_bankrupt = sleeve.config.debt_bonus * (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
					end
					G.GAME.bankrupt_at = G.GAME.bankrupt_at + sleeve.config.added_bankrupt
					sleeve.config.added_bankrupt = sleeve.config.debt_bonus * (G.GAME.round_resets.discards + G.GAME.round_resets.hands)
					G.GAME.bankrupt_at = G.GAME.bankrupt_at - sleeve.config.added_bankrupt
				end
			end
		end,
		["sleeve_casl_red"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			end
		end,
		["sleeve_casl_blue"] = function(sleeve, action, context)
			if action == "apply" then
				G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			end
		end,
	}
	-- Aliases
	special_antimatter_sleeves["very_fair_sleeve"] = special_antimatter_sleeves["sleeve_cry_very_fair_sleeve"]
	special_antimatter_sleeves["wormhole_sleeve"] = special_antimatter_sleeves["sleeve_cry_wormhole_sleeve"]
	special_antimatter_sleeves["encoded_sleeve"] = special_antimatter_sleeves["sleeve_cry_encoded_sleeve"]
	special_antimatter_sleeves["critical_sleeve"] = special_antimatter_sleeves["sleeve_cry_critical_sleeve"]
	special_antimatter_sleeves["misprint_sleeve"] = special_antimatter_sleeves["sleeve_cry_misprint_sleeve"]
	special_antimatter_sleeves["conveyor_sleeve"] = special_antimatter_sleeves["sleeve_cry_conveyor_sleeve"]
	special_antimatter_sleeves["beta_sleeve"] = special_antimatter_sleeves["sleeve_cry_beta_sleeve"]
	special_antimatter_sleeves["nostalgic_sleeve"] = special_antimatter_sleeves["sleeve_cry_beta_sleeve"]
	special_antimatter_sleeves["sleeve_cry_nostalgic_sleeve"] = special_antimatter_sleeves["sleeve_cry_beta_sleeve"]
	special_antimatter_sleeves["bountiful_sleeve"] = special_antimatter_sleeves["sleeve_cry_bountiful_sleeve"]
	special_antimatter_sleeves["black"] = special_antimatter_sleeves["sleeve_casl_black"]
	special_antimatter_sleeves["painted"] = special_antimatter_sleeves["sleeve_casl_painted"]
	special_antimatter_sleeves["nebula"] = special_antimatter_sleeves["sleeve_casl_nebula"]
	special_antimatter_sleeves["green"] = special_antimatter_sleeves["sleeve_casl_green"]
	special_antimatter_sleeves["red"] = special_antimatter_sleeves["sleeve_casl_red"]
	special_antimatter_sleeves["blue"] = special_antimatter_sleeves["sleeve_casl_blue"]

	local function is_sleeve_selected(slv)
		local s_key = slv.key or ""
		local s_key_base = slv.key_base or ""
		local selected = G.GAME.cry_antimatter_sleeves
			or (G.PROFILES and G.PROFILES[G.SETTINGS.profile] and G.PROFILES[G.SETTINGS.profile].last_choices and G.PROFILES[G.SETTINGS.profile].last_choices.cry_antimatter_sleeve)
			or (SMODS.RunSelect and SMODS.RunSelect.Setup and SMODS.RunSelect.Setup.choices and SMODS.RunSelect.Setup.choices.cry_antimatter_sleeve)
		if selected and type(selected) == "table" then
			if selected[s_key] ~= nil then
				return selected[s_key] == true
			end
			if s_key_base ~= "" and selected[s_key_base] ~= nil then
				return selected[s_key_base] == true
			end
			if selected["sleeve_" .. s_key] ~= nil then
				return selected["sleeve_" .. s_key] == true
			end
			return false
		end
		return Cryptid.antimatter_sleeve_compat(s_key) or (s_key_base ~= "" and Cryptid.antimatter_sleeve_compat(s_key_base))
	end

	local antimattersleeve = CardSleeves.Sleeve({
		key = "antimatter_sleeve",
		name = "Antimatter Sleeve",
		atlas = "atlasSleeves",
		pos = { x = 0, y = 1 },
		config = {
			voucher = {},
			cry_antimatter = true,
		},
		unlocked = true,
		unlock_condition = { deck = "Antimatter Deck", stake = 1 },
		loc_vars = function(self, info_queue, center)
			return { key = Cryptid.gameset_loc(self, { mainline = "balanced", modest = "balanced" }) }
		end,
		calculate = function(self, sleeve, context)
			if self.is_calculating then
				return
			end
			self.is_calculating = true
			local res_chips, res_mult
			for _, slv in ipairs(G.P_CENTER_POOLS.Sleeve) do
				local s_key = slv.key
				if s_key and s_key ~= "sleeve_cry_antimatter_sleeve" and s_key ~= "sleeve_casl_none" and s_key ~= "sleeve_none" then
					if is_sleeve_selected(slv) then
						local override = special_antimatter_sleeves[s_key] or (slv.key_base and special_antimatter_sleeves[slv.key_base])
						if type(override) == "function" then
							override(slv, "calculate", context)
						elseif override ~= true then
							local matching_deck = Cryptid.get_sleeve_matching_deck(slv)
							local synergy = is_synergy_active(slv, self)

							-- 1. Standard (Normal) Calculation
							local norm_r1, norm_r2 = with_sleeve_context(slv, "b_none", function(proxy)
								if proxy.loc_vars and type(proxy.loc_vars) == "function" then
									proxy:loc_vars()
								end
								if type(proxy.calculate) == "function" then
									return proxy:calculate(proxy, context)
								elseif type(proxy.trigger_effect) == "function" then
									return proxy:trigger_effect(context)
								end
							end)
							if norm_r1 or norm_r2 then
								if type(norm_r1) == "number" and type(norm_r2) == "number" then
									res_chips, res_mult = norm_r1, norm_r2
								elseif type(norm_r1) == "table" then
									self.is_calculating = false
									return norm_r1
								end
							end

							-- 2. Special Synergy Calculation (if active)
							if synergy and matching_deck then
								local syn_r1, syn_r2 = with_sleeve_context(slv, matching_deck, function(proxy)
									if proxy.loc_vars and type(proxy.loc_vars) == "function" then
										proxy:loc_vars()
									end
									if type(proxy.calculate) == "function" then
										return proxy:calculate(proxy, context)
									elseif type(proxy.trigger_effect) == "function" then
										return proxy:trigger_effect(context)
									end
								end)
								if syn_r1 or syn_r2 then
									if type(syn_r1) == "number" and type(syn_r2) == "number" then
										res_chips, res_mult = syn_r1, syn_r2
									elseif type(syn_r1) == "table" then
										self.is_calculating = false
										return syn_r1
									end
								end
							end
						end
					end
				end
			end
			self.is_calculating = false
			if res_chips and res_mult then
				return res_chips, res_mult
			end
		end,
		trigger_effect = function(self, args)
			return self:calculate(self, args)
		end,
		apply = function(self)
			if self.is_applying then
				return
			end
			self.is_applying = true
			G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			for _, slv in ipairs(G.P_CENTER_POOLS.Sleeve) do
				local s_key = slv.key
				if s_key and s_key ~= "sleeve_cry_antimatter_sleeve" and s_key ~= "sleeve_casl_none" and s_key ~= "sleeve_none" then
					if is_sleeve_selected(slv) then
						local override = special_antimatter_sleeves[s_key] or (slv.key_base and special_antimatter_sleeves[slv.key_base])
						if type(override) == "function" then
							override(slv, "apply")
						elseif override ~= true and type(slv.apply) == "function" then
							local matching_deck = Cryptid.get_sleeve_matching_deck(slv)
							local synergy = is_synergy_active(slv, self)

							-- 1. Apply Standard (Normal) Effect
							with_sleeve_context(slv, "b_none", function(proxy)
								if proxy.loc_vars and type(proxy.loc_vars) == "function" then
									proxy:loc_vars()
								end
								proxy:apply(proxy)
							end)

							-- 2. Apply Special Synergy Effect (if active)
							if synergy and matching_deck then
								with_sleeve_context(slv, matching_deck, function(proxy)
									if proxy.loc_vars and type(proxy.loc_vars) == "function" then
										proxy:loc_vars()
									end
									proxy:apply(proxy)
								end)
							end
						end
					end
				end
			end
			self.is_applying = false
		end,
		attributes = { "copying" },
	})
end
return { name = "Sleeves", init = function() end }

