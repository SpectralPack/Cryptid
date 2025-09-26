local lock = {
	cry_credits = {
		idea = {
			"Ein13",
		},
		art = {
			"Jevonn",
		},
		code = {
			"jenwalter666",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Lock",
	key = "lock",
	pos = { x = 0, y = 1 },
	config = {},
	cost = 4,
	order = 451,
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "eternal", set = "Other" }
	end,
	can_use = function(self, card)
		return #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		check_for_unlock({ cry_used_consumable = "c_cry_lock" })
		local target = #G.jokers.cards == 1 and G.jokers.cards[1]
			or pseudorandom_element(G.jokers.cards, pseudoseed("Dudeman"))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.jokers.cards do
			local percent = 1.15 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.jokers.cards[i]:flip()
					play_sound("card1", percent)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.jokers.cards do
			local CARD = G.jokers.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					CARD.ability.perishable = nil
					CARD.pinned = nil
					CARD.ability.pinned = nil
					CARD:set_rental(nil)
					if not CARD.sob then
						CARD:set_eternal(nil)
					end
					CARD.ability.banana = nil
					CARD.ability.cry_possessed = nil
					SMODS.Stickers.cry_flickering:apply(CARD, nil)
					play_sound("card1", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				play_sound("card1", 0.9)
				target:flip()
				return true
			end,
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.3,
			func = function()
				play_sound("gold_seal", 1.2, 0.4)
				target:juice_up(0.3, 0.3)
				return true
			end,
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				play_sound("card1", 1.1)
				target:flip()
				target.ability.eternal = true
				return true
			end,
		}))
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local vacuum = {
	cry_credits = {
		idea = {
			"Mjiojio",
		},
		art = {
			"Linus Goof Balls",
		},
		code = {
			"jenwalter666",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Vacuum",
	key = "vacuum",
	pos = { x = 3, y = 1 },
	config = { extra = 4 },
	cost = 4,
	order = 452,
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local earnings = 0
		check_for_unlock({ cry_used_consumable = "c_cry_vacuum" })
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("card1", percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			local CARD = G.hand.cards[i]
			if CARD.config.center ~= G.P_CENTERS.c_base then
				earnings = earnings + 1
			end
			if CARD.edition then
				earnings = earnings + 1
			end
			if CARD.seal then
				earnings = earnings + 1
			end
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					CARD:set_ability(G.P_CENTERS.c_base, true, nil)
					CARD:set_edition(nil, true)
					CARD:set_seal(nil, true)
					play_sound("tarot2", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		ease_dollars(earnings * card.ability.extra)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local hammerspace = {
	cry_credits = {
		idea = {
			"jenwalter666",
		},
		art = {
			"AlexZGreat",
		},
		code = {
			"jenwalter666",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Hammerspace",
	key = "hammerspace",
	pos = { x = 4, y = 3 },
	config = {},
	cost = 4,
	order = 453,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		check_for_unlock({ cry_used_consumable = "c_cry_hammerspace" })
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("card1", percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.cards do
			local CARD = G.hand.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					CARD:set_ability(Cryptid.random_consumable("cry_hammerspace", nil, "c_cry_hammerspace", nil, true))
					play_sound("tarot2", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local trade = {
	cry_credits = {
		idea = {
			"5381",
		},
		art = {
			"RattlingSnow353",
		},
		code = {
			"Math",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Trade",
	key = "trade",
	pos = { x = 2, y = 1 },
	config = {},
	cost = 4,
	order = 454,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		local usable_count = 0
		for _, v in pairs(G.vouchers.cards) do
			if not SMODS.is_eternal(v) then
				usable_count = usable_count + 1
			end
		end
		if usable_count > 0 then
			return true
		else
			return false
		end
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local usable_vouchers = {}
		for k, v in ipairs(G.vouchers.cards) do
			local can_use = true
			for kk, vv in ipairs(G.vouchers.cards) do
				local center = G.P_CENTERS[vv.config.center.key]
				if center.requires then
					for _, vvv in pairs(center.requires) do
						if vvv == v.config.center.key then
							can_use = false
							break
						end
					end
				end
			end
			if SMODS.is_eternal(v) then
				can_use = false
			end
			if can_use then
				usable_vouchers[#usable_vouchers + 1] = v
			end
		end
		local unredeemed_voucher = pseudorandom_element(usable_vouchers, pseudoseed("cry_trade"))
		if not unredeemed_voucher then
			return
		end
		--redeem extra voucher code based on Betmma's Vouchers
		local area
		if G.STATE == G.STATES.HAND_PLAYED then
			if not G.redeemed_vouchers_during_hand then
				G.redeemed_vouchers_during_hand =
					CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
			end
			area = G.redeemed_vouchers_during_hand
		else
			area = G.play
		end

		local card = copy_card(unredeemed_voucher)
		card.ability.extra = copy_table(unredeemed_voucher.ability.extra)
		if card.facing == "back" then
			card:flip()
		end

		card:start_materialize()
		area:emplace(card)
		card.cost = 0
		card.shop_voucher = false
		local current_round_voucher = G.GAME.current_round.voucher
		card:unredeem()
		G.GAME.current_round.voucher = current_round_voucher
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			func = function()
				card:start_dissolve()
				unredeemed_voucher:start_dissolve()
				return true
			end,
		}))
		for i = 1, 2 do
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand =
						CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local _pool = get_current_pool("Voucher", nil, nil, nil, true)
			local center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem"))
			local it = 1
			while center == "UNAVAILABLE" do
				it = it + 1
				center = pseudorandom_element(_pool, pseudoseed("cry_trade_redeem_resample" .. it))
			end
			local card = create_card("Voucher", area, nil, nil, nil, nil, center)
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
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local replica = {
	cry_credits = {
		idea = {
			"Mystic Misclick",
		},
		art = {
			"RattlingSnow353",
		},
		code = {
			"Math",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Replica",
	key = "replica",
	pos = { x = 1, y = 1 },
	config = {},
	cost = 4,
	order = 455,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		check_for_unlock({ cry_used_consumable = "c_cry_replica" })
		local chosen_card = pseudorandom_element(G.hand.cards, pseudoseed("cry_replica_choice"))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.hand.cards do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("card1", percent)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		for i = 1, #G.hand.cards do
			if not SMODS.is_eternal(G.hand.cards[i]) then
				G.E_MANAGER:add_event(Event({
					func = function()
						copy_card(chosen_card, G.hand.cards[i])
						return true
					end,
				}))
			end
		end
		for i = 1, #G.hand.cards do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.cards[i]:flip()
					play_sound("tarot2", percent, 0.6)
					G.hand.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.5)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local analog = {
	cry_credits = {
		idea = {
			"y_not_tony",
		},
		art = {
			"RattlingSnow353",
		},
		code = {
			"Math",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Analog",
	key = "analog",
	pos = { x = 6, y = 2 },
	config = { copies = 2, ante = 1, immutable = { max_copies = 200, max_ante = 1e300 } },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				math.min(center.ability.copies, center.ability.immutable.max_copies),
				math.min(center.ability.ante, center.ability.immutable.max_ante),
			},
		}
	end,
	cost = 4,
	order = 456,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		return #G.jokers.cards > (G.GAME.modifiers.cry_beta and 1 or 0)
	end,
	use = function(self, card, area, copier)
		check_for_unlock({ cry_used_consumable = "c_cry_analog" })
		local used_consumable = copier or card
		local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed("cry_analog_choice"))
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v ~= chosen_joker then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				return true
			end,
		}))
		for i = 1, to_number(math.min(card.ability.copies, card.ability.immutable.max_copies)) do
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.4,
				func = function()
					local card = copy_card(chosen_joker)
					card:start_materialize()
					card:add_to_deck()
					G.jokers:emplace(card)
					return true
				end,
			}))
		end
		ease_ante(math.min(card.ability.ante, card.ability.immutable.max_ante))
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local ritual = {
	cry_credits = {
		idea = { "Mystic Misclick" },
		art = { "spire_winder" },
		code = { "spire_winder" },
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
			"e_cry_mosaic",
			"e_cry_astral",
		},
	},
	set = "Spectral",
	name = "cry-Ritual",
	key = "ritual",
	order = 457,
	config = {
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.cry_mosaic) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_mosaic
		end
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		if not center.edition or (center.edition and not center.edition.cry_astral) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
		end
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 5,
	atlas = "atlasnotjokers",
	pos = { x = 5, y = 1 },
	can_use = function(self, card)
		local cards = Cryptid.get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card)
			return not card.edition and not card.will_be_editioned
		end)
		return #cards > 0 and #cards <= card.ability.max_highlighted
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local cards = Cryptid.get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card)
			return not card.edition and not card.will_be_editioned
		end)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
				highlighted.will_be_editioned = true
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						highlighted:juice_up(0.3, 0.5)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if highlighted then
							local random_result = pseudorandom(pseudoseed("cry-Ritual"))
							if random_result >= 5 / 6 then
								highlighted:set_edition({ cry_astral = true })
							else
								if random_result >= 1 / 2 then
									highlighted:set_edition({ cry_mosaic = true })
								else
									highlighted:set_edition({ negative = true })
								end
							end
							highlighted.will_be_editioned = nil
						end
						return true
					end,
				}))
				delay(0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
			end
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local adversary = {
	cry_credits = {
		idea = { "y_not_tony" },
		art = { "Pyrocreep" },
		code = { "spire_winder" },
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Adversary",
	key = "adversary",
	pos = { x = 6, y = 1 },
	config = {},
	cost = 4,
	order = 458,
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.negative) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
	end,
	can_use = function(self, card)
		return #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local target = #G.jokers.cards == 1 and G.jokers.cards[1] or G.jokers.cards[math.random(#G.jokers.cards)]
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.jokers.cards do
			local percent = 1.15 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.jokers.cards[i]:flip()
					play_sound("card1", percent)
					G.jokers.cards[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.jokers.cards do
			local CARD = G.jokers.cards[i]
			local percent = 0.85 + (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					CARD:flip()
					if not CARD.edition then
						CARD:set_edition({ negative = true })
					end
					play_sound("card1", percent)
					CARD:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.cry_shop_joker_price_modifier = G.GAME.cry_shop_joker_price_modifier * 2
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local chambered = {
	cry_credits = {
		idea = { "y_not_tony" },
		art = { "Pyrocreep" },
		code = { "spire_winder" },
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Chambered",
	key = "chambered",
	pos = { x = 5, y = 0 },
	config = { extra = { num_copies = 3 } },
	misprintize_caps = { extra = { num_copies = 100 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.num_copies } }
	end,
	cost = 4,
	order = 459,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		local filteredCons = {}

		-- Copy consumables that aren't Chambered
		for _, item in ipairs(G.consumeables.cards) do
			if item.ability.name ~= "cry-Chambered" then
				table.insert(filteredCons, item)
			end
		end
		return #filteredCons > 0
	end,
	use = function(self, card, area, copier)
		local filteredCons = {}

		-- Copy consumables that aren't Chambered
		for _, item in ipairs(G.consumeables.cards) do
			if item.ability.name ~= "cry-Chambered" then
				table.insert(filteredCons, item)
			end
		end
		target = pseudorandom_element(filteredCons, pseudoseed("chambered"))
		for i = 1, card.ability.extra.num_copies do
			G.E_MANAGER:add_event(Event({
				func = function()
					local card_copy = copy_card(target, nil)
					if Incantation then
						card_copy:setQty(1)
					end
					card_copy:set_edition({ negative = true }, true)
					card_copy:add_to_deck()
					G.consumeables:emplace(card_copy)
					return true
				end,
			}))
			card_eval_status_text(
				target,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_duplicated_ex"), colour = G.C.SECONDARY_SET.Spectral }
			)
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}
local conduit = {
	cry_credits = {
		idea = { "Knockback1 (Oiiman)" },
		art = { "Knockback1 (Oiiman)" },
		code = { "spire_winder" },
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-conduit",
	key = "conduit",
	pos = { x = 6, y = 0 },
	config = {},
	cost = 4,
	order = 460,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		local combinedTable = {}
		dbl = false
		no_dbl = false

		for _, value in ipairs(G.hand.highlighted) do
			if value ~= card then
				if Card.no(value, "dbl") then
					no_dbl = true
				elseif value.edition and value.edition.cry_double_sided then
					dbl = true
				end
				table.insert(combinedTable, value)
			end
		end

		for _, value in ipairs(G.jokers.highlighted) do
			if value ~= card then
				if Card.no(value, "dbl") then
					no_dbl = true
				elseif value.edition and value.edition.cry_double_sided then
					dbl = true
				end
				table.insert(combinedTable, value)
			end
		end
		return (#combinedTable == 2 and not (dbl and no_dbl))
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local combinedTable = Cryptid.get_highlighted_cards({ G.hand, G.jokers }, card, 2, 2)
		local highlighted_1 = combinedTable[1]
		local highlighted_2 = combinedTable[2]
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		local percent = 1.15 - (1 - 0.999) / (1 - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				if not highlighted_1.edition or not highlighted_1.edition.cry_double_sided then
					highlighted_1:flip()
				end
				if not highlighted_2.edition or not highlighted_2.edition.cry_double_sided then
					highlighted_2:flip()
				end
				if highlighted_1.children.flip then
					highlighted_1.children.flip:remove()
					highlighted_1.children.flip = nil
				end

				if highlighted_1.children.merge_ds then
					highlighted_1.children.merge_ds:remove()
					highlighted_1.children.merge_ds = nil
				end
				if highlighted_2.children.flip then
					highlighted_2.children.flip:remove()
					highlighted_2.children.flip = nil
				end

				if highlighted_2.children.merge_ds then
					highlighted_2.children.merge_ds:remove()
					highlighted_2.children.merge_ds = nil
				end
				play_sound("card1", percent)
				highlighted_1:juice_up(0.3, 0.3)
				highlighted_2:juice_up(0.3, 0.3)
				return true
			end,
		}))
		delay(0.2)
		local percent = 0.85 + (1 - 0.999) / (1 - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				local one_edition = highlighted_1.edition
				if not highlighted_1.edition or not highlighted_1.edition.cry_double_sided then
					highlighted_1:flip()
				end
				highlighted_1:set_edition(highlighted_2.edition)
				if not highlighted_2.edition or not highlighted_2.edition.cry_double_sided then
					highlighted_2:flip()
				end
				highlighted_2:set_edition(one_edition)
				play_sound("card1", percent)
				highlighted_1:juice_up(0.3, 0.3)
				highlighted_2:juice_up(0.3, 0.3)
				return true
			end,
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2")
				used_consumable:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				G.jokers:unhighlight_all()
				return true
			end,
		}))
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

local white_hole = {
	cry_credits = {
		idea = {
			"y_not_tony",
		},
		art = {
			"5381",
		},
		code = {
			"Math",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-White Hole",
	key = "white_hole",
	pos = { x = 1, y = 4 },
	cost = 4,
	order = 200000,
	atlas = "atlasnotjokers",
	hidden = true, --default soul_rate of 0.3% in spectral packs is used
	soul_set = "Planet",
	loc_vars = function(self, info_queue, card)
		return { key = Card.get_gameset(card) == "modest" and "c_cry_white_hole" or "c_cry_white_hole2" }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local modest = Card.get_gameset(used_consumable) == "modest"
		--Get most played hand type (logic yoinked from Telescope)
		local _hand, _tally = nil, -1
		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end
		local removed_levels = 0
		for k, v in ipairs(G.handlist) do
			if to_big(G.GAME.hands[v].level) > to_big(1) then
				local this_removed_levels = G.GAME.hands[v].level - 1
				if
					-- Due to how these poker hands are loaded they still techically exist even if Poker Hand Stuff is disabled
					-- Because they still exist, While Hole needs to ignore levels from these if disabled (via Black Hole, Planet.lua, etc...)
					(v ~= "cry_Bulwark" and v ~= "cry_Clusterfuck" and v ~= "cry_UltPair" and v ~= "cry_WholeDeck")
					or Cryptid.enabled("set_cry_poker_hand_stuff") == true
				then
					if v ~= _hand or not modest then
						removed_levels = removed_levels + this_removed_levels
						level_up_hand(used_consumable, v, true, -this_removed_levels)
					end
				end
			end
		end
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(_hand, "poker_hands"),
			chips = G.GAME.hands[_hand].chips,
			mult = G.GAME.hands[_hand].mult,
			level = G.GAME.hands[_hand].level,
		})
		if modest then
			level_up_hand(used_consumable, _hand, false, 4)
		else
			level_up_hand(used_consumable, _hand, false, math.min((3 * removed_levels), 1e300))
		end
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end,
	--Incantation compat
	can_stack = true,
	can_divide = true,
	can_bulk_use = true,
	bulk_use = function(self, card, area, copier, number)
		local used_consumable = copier or card
		local modest = Card.get_gameset(used_consumable) == "modest"
		--Get most played hand type (logic yoinked from Telescope)
		local _hand, _tally = nil, -1
		for k, v in ipairs(G.handlist) do
			if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
				_hand = v
				_tally = G.GAME.hands[v].played
			end
		end
		local removed_levels = 0
		for k, v in ipairs(G.handlist) do
			if to_big(G.GAME.hands[v].level) > to_big(1) then
				local this_removed_levels = G.GAME.hands[v].level - 1
				removed_levels = removed_levels + this_removed_levels
				if v ~= _hand or not modest then
					level_up_hand(used_consumable, v, true, -this_removed_levels)
				end
			end
		end
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(_hand, "poker_hands"),
			chips = G.GAME.hands[_hand].chips,
			mult = G.GAME.hands[_hand].mult,
			level = G.GAME.hands[_hand].level,
		})
		if modest then
			level_up_hand(used_consumable, _hand, false, 4 * number)
		else
			level_up_hand(used_consumable, _hand, false, math.min(((3 ^ number) * removed_levels), 1e300))
		end
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

local typhoon = {
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
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
			"cry_azure",
		},
	},
	set = "Spectral",
	name = "cry-Typhoon",
	key = "typhoon",
	order = 8,
	config = {
		-- This will add a tooltip.
		mod_conv = "cry_azure_seal",
		-- Tooltip args
		seal = { planets_amount = 3 },
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		-- Handle creating a tooltip with set args.
		info_queue[#info_queue + 1] =
			{ set = "Other", key = "cry_azure_seal", specific_vars = { self.config.seal.planets_amount } }
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 4,
	atlas = "atlasnotjokers",
	pos = { x = 0, y = 4 },
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		check_for_unlock({ cry_used_consumable = "c_cry_typhoon" })
		local cards = Cryptid.get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted)
		for i = 1, #cards do
			local highlighted = cards[i]
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					used_consumable:juice_up(0.3, 0.5)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if highlighted then
						highlighted:set_seal("cry_azure", nil, true)
					end
					return true
				end,
			}))
			delay(0.5)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

local meld = {
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
			"e_cry_double_sided",
		},
	},
	set = "Spectral",
	name = "cry-Meld",
	key = "meld",
	order = 9,
	pos = { x = 4, y = 4 },
	cost = 4,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		local cards = Cryptid.get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1, function(card)
			return not Card.no(card, "dbl") and not card.edition
		end)
		return #cards == 1
	end,
	cry_credits = {
		art = {
			"George The Rat",
		},
		code = {
			"Math",
		},
		jolly = {
			"Jolly Open Winner",
			"Axolotolus",
		},
	},
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_double_sided
	end,
	use = function(self, card, area, copier)
		local cards = Cryptid.get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1)
		if #cards == 1 then
			if cards[1].area == G.jokers then
				cards[1]:remove_from_deck(true)
				cards[1]:set_edition({ cry_double_sided = true })
				cards[1]:add_to_deck(true)
				G.jokers:remove_from_highlighted(cards[1])
			else
				cards[1]:set_edition({ cry_double_sided = true })
				G.hand:remove_from_highlighted(cards[1])
			end
		end
	end,
	in_pool = function()
		return G.GAME.used_vouchers.v_cry_double_slit
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		self:use(card, area)
	end,
}

-- Summoning: To Be Moved Into Epic.lua
-- Destroy a random joker and create an epic joker
local summoning = {
	cry_credits = {
		idea = {
			"AlexZGreat",
		},
		art = {
			"Nova",
		},
		code = {
			"Jevonn",
		},
	},
	object_type = "Consumable",
	dependencies = {
		items = {
			"set_cry_spectral",
		},
	},
	set = "Spectral",
	name = "cry-Summoning",
	key = "summoning",
	pos = { x = 3, y = 4 },
	cost = 4,
	order = 5,
	atlas = "atlasnotjokers",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				Cryptid.enabled("set_cry_epic") == true and localize("k_cry_epic") or localize("k_rare"),
				colours = { G.C.RARITY[Cryptid.enabled("set_cry_epic") == true and "cry_epic" or 3] },
			},
		}
	end,
	can_use = function(self, card)
		return #G.jokers.cards <= G.jokers.config.card_limit
			--Prevent use if slots are full and all jokers are eternal (would exceed limit)
			and #Cryptid.advanced_find_joker(nil, nil, nil, { "eternal" }, true, "j") < G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed("cry_summoning"))
		local value = Cryptid.enabled("set_cry_epic") == true and "cry_epic" or 0.99
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v == chosen_joker then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, value, nil, nil, nil, "cry_summoning")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
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

local spectrals = {
	lock,
	vacuum,
	hammerspace,
	trade,
	replica,
	analog,
	ritual,
	adversary,
	chambered,
	conduit,
	meld,
	summoning, -- to be moved to epic.lua
	typhoon, -- to be moved to misc.lua
	white_hole,
}
return {
	name = "Spectrals",
	items = spectrals,
}
