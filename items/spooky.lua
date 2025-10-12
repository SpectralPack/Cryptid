local cotton_candy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "cotton_candy",
	pos = { x = 2, y = 0 },
	rarity = "cry_candy",
	cost = 10,
	atlas = "atlasspooky",
	order = 130,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	pools = { ["Food"] = true },
	calculate = function(self, card, context)
		if
			(context.selling_self and not context.retrigger_joker and not context.blueprint_card)
			or context.forcetrigger
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						G.jokers.cards[i - 1]:set_edition({ negative = true })
					end
					if i < #G.jokers.cards then
						G.jokers.cards[i + 1]:set_edition({ negative = true })
					end
				end
			end
		end
	end,
}
local wrapped = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "wrapped",
	pos = { x = 5, y = 0 },
	rarity = "cry_candy",
	cost = 10,
	atlas = "atlasspooky",
	order = 131,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	immutable = true,
	config = { extra = { rounds = 2 } },
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Other", key = "food_jokers" }
		return { vars = { center.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds > 0 then
				return {
					message = { localize("cry_minus_round") },
					colour = G.C.FILTER,
				}
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
				local card = create_card("Food", G.jokers, nil, nil, nil, nil, nil, "cry_wrapped")
				card:add_to_deck()
				G.jokers:emplace(card)
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
			end
		end
		if context.forcetrigger then
			local card = create_card("Food", G.jokers, nil, nil, nil, nil, nil, "cry_wrapped")
			card:add_to_deck()
			G.jokers:emplace(card)
		end
	end,
}
local choco_dice = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "chocolate_dice",
	pos = { x = 1, y = 0 },
	rarity = 3,
	cost = 10,
	order = 132,
	atlas = "atlasspooky",
	config = { extra = { roll = 0 } },
	immutable = true,
	no_dbl = true,
	loc_vars = function(self, info_queue, center)
		if not center then --tooltip
		else
			SMODS.Events["ev_cry_choco" .. center.ability.extra.roll]:loc_vars(info_queue, center)
		end
		return {
			vars = { not center and "None" or center.ability.extra.roll == 0 and "None" or center.ability.extra.roll },
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
			and G.GAME.blind.boss
		then
			--todo: check if duplicates of event are already started/finished
			SMODS.Events["ev_cry_choco" .. card.ability.extra.roll]:finish()
			card.ability.extra.roll = Cryptid.roll("cry_choco", 2, 10, { ignore_value = card.ability.extra.roll })
			SMODS.Events["ev_cry_choco" .. card.ability.extra.roll]:start()
			return {
				message = tostring(card.ability.extra.roll),
				colour = G.C.GREEN,
			}
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.Events["ev_cry_choco" .. card.ability.extra.roll]:finish()
		end
	end,
}
local choco_base_event = {
	object_type = "Event",
	key = "choco0",
}
local choco1 = {
	object_type = "Event",
	key = "choco1",
	loc_vars = function(self, info_queue, center)
		local _, aaa = SMODS.get_probability_vars(self, 1, 6, "Chocolate Dice 1")
		info_queue[#info_queue + 1] = { set = "Other", key = self.key } --todo specific_vars
		info_queue[#info_queue + 1] = { set = "Other", key = "cry_flickering_desc", specific_vars = { 5 } }
		info_queue[#info_queue + 1] = {
			set = "Joker",
			key = "j_cry_ghost",
			specific_vars = { SMODS.get_probability_vars(self, 1, 2, "Chocolate Dice 1"), aaa },
		}
	end,
	start = function(self)
		G.GAME.events[self.key] = true
		local areas = { "jokers", "deck", "hand", "play", "discard" }
		for k, v in pairs(areas) do
			for i = 1, #G[v].cards do
				if SMODS.pseudorandom_probability(self, "cry_choco_possession", 1, 3, "Chocolate Dice 1") then
					SMODS.Stickers.cry_flickering:apply(G[v].cards[i], true)
				end
			end
		end
		--create a ghost
		local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_ghost")
		card:add_to_deck()
		G.jokers:emplace(card)
	end,
}
local choco2 = {
	object_type = "Event",
	key = "choco2",
	--everything here is done with lovely patches or hooks, search for ev_cry_choco2
	calculate = function(self, context)
		if context.cash_out then
			G.GAME.current_round.rerolled = false
		end
	end,
	init = function(self)
		--track if rerolled
		local gfrs = G.FUNCS.reroll_shop
		G.FUNCS.reroll_shop = function(e)
			local ret = gfrs(e)
			G.GAME.current_round.rerolled = true
			return ret
		end
		local gfcr = G.FUNCS.can_reroll
		G.FUNCS.can_reroll = function(e)
			if G.GAME.events.ev_cry_choco2 and G.GAME.current_round.rerolled then
				e.config.colour = G.C.UI.BACKGROUND_INACTIVE
				e.config.button = nil
				return
			end
			return gfcr(e)
		end
	end,
}
local num_potions = 3 --note: must be changed whenever new potion effects are added
local choco3 = {
	object_type = "Event",
	key = "choco3",
	start = function(self)
		if not G.GAME.events[self.key] then
			G.GAME.events[self.key] = { potions = {} }
		end
		for i = 1, 3 do
			local card = create_card("Unique", G.consumeables, nil, nil, nil, nil, "c_cry_potion")
			card:add_to_deck()
			card.ability.random_event = pseudorandom(pseudoseed("cry_choco_witch"), 1, num_potions)
			G.consumeables:emplace(card)
		end
	end,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Other", key = self.key } --todo specific_vars
		info_queue[#info_queue + 1] = { set = "Unique", key = "c_cry_potion" } -- bugged rn
	end,
	finish = function(self)
		--Reverse all potion effects
		if G.GAME.events[self.key].potions and G.GAME.events[self.key].potions[2] then
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling
				/ (1.15 ^ G.GAME.events[self.key].potions[2])
		end
		if G.GAME.events[self.key].potions and G.GAME.events[self.key].potions[3] then
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + G.GAME.events[self.key].potions[3]
			ease_hands_played(G.GAME.events[self.key].potions[3])
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + G.GAME.events[self.key].potions[3]
			ease_discard(G.GAME.events[self.key].potions[3])
		end
		G.GAME.events[self.key] = nil
	end,
	calculate = function(self, context)
		--bug: if this event finishes and starts, every potion gets instantly destroyed
		--bug: crashes if all 3 are used on blind skip
		if
			context.pre_jokers
			and (context.skip_blind or (context.end_of_round and not context.individual and not context.repetition))
			and not context.blueprint
			and not context.retrigger_joker
		then
			--Detect if a potion has been used
			local used_potion = false
			for i = 1, num_potions do
				if G.GAME.events[self.key].potions[i] then
					used_potion = true
					break
				end
			end
			if used_potion then
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = #G.consumeables.cards, 1, -1 do
							if G.consumeables.cards[i].config.center.key == "c_cry_potion" then
								G.consumeables.cards[i]:start_dissolve()
							end
						end
						return true
					end,
				}))
			else
				--these animations are still a bit goofy, idk why
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = #G.consumeables.cards, 1, -1 do
							if G.consumeables.cards[i].config.center.key == "c_cry_potion" then
								G.consumeables.cards[i].config.center:use(G.consumeables.cards[i], G.consumeables)
								G.consumeables.cards[i]:start_dissolve()
							end
						end
						return true
					end,
				}))
			end
		end
	end,
	--todo: loc_vars potions
}
local potion = {
	object_type = "Consumable",
	set = "Unique",
	key = "potion",
	name = "cry-Potion",
	pos = { x = 0, y = 1 },
	pixel_size = { w = 35 / 69 * 71, h = 35 / 69 * 71 },
	config = { random_event = 2 },
	cost = 4,
	no_doe = true,
	no_ccd = true,
	order = 1,
	immutable = true,
	no_dbl = true,
	no_grc = true,
	no_collection = true,
	atlas = "atlasspooky",
	can_use = function(self, card)
		return true
	end,
	in_pool = function()
		return false
	end,
	use = function(self, card, area, copier)
		if not (G.GAME.events and G.GAME.events.ev_cry_choco3) then
			return
		end -- Just in case a potion is found out side of the event
		G.GAME.events.ev_cry_choco3.potions[card.ability.random_event] = (
			G.GAME.events.ev_cry_choco3.potions[card.ability.random_event] or 0
		) + 1
		--Announce event
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("timpani", 1)
				attention_text({
					scale = 1.4,
					text = localize("cry_potion" .. card.ability.random_event),
					hold = 2,
					align = "cm",
					offset = { x = 0, y = -2.7 },
					major = G.play,
				})
				return true
			end,
		}))
		if card.ability.random_event == 1 then -- -1 to all hand levels
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			update_hand_text({ delay = 0 }, { mult = "-", StatusText = true })
			update_hand_text({ delay = 0 }, { chips = "-", StatusText = true })
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(used_consumable, k, true, -1)
			end
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		end
		if card.ability.random_event == 2 then -- X1.15 blind size
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 1.15
			if G.GAME.blind and G.GAME.blind.chips then
				G.GAME.blind.chips = G.GAME.blind.chips * 1.15
			end
		end
		if card.ability.random_event == 3 then -- -1 Hand and Discard
			G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
			ease_hands_played(-1)
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
			ease_discard(-1)
		end
		delay(12 / G.SETTINGS.GAMESPEED)
	end,
}
local choco4 = { --lunar abyss
	object_type = "Event",
	key = "choco4",
	calculate = function(self, context)
		if
			context.pre_jokers
			and context.before
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
		then
			for i = 1, #G.play.cards do
				if SMODS.pseudorandom_probability(self, "cry_choco_lunar", 1, 4, "Chocolate Dice 4") then
					local faces = {}
					for _, v in ipairs(SMODS.Rank.obj_buffer) do
						local r = SMODS.Ranks[v]
						if r.face then
							table.insert(faces, r)
						end
					end
					local _rank = pseudorandom_element(faces, pseudoseed("cry_choco_lunar_create")).card_key
					G.play.cards[i]:set_base(G.P_CARDS["C_" .. _rank])
				end
			end
		end
		if
			context.post_jokers
			and context.joker_main
			and not context.blueprint_card
			and not context.retrigger_joker
		then
			local faces = 0
			for i = 1, #G.play.cards do
				if G.play.cards[i]:is_face() then
					faces = faces + 1
				end
			end
			if faces > 1 then
				mult = mult / faces
				update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
			end
		end
	end,
}
local choco5 = { --bloodsucker
	object_type = "Event",
	key = "choco5",
	calculate = function(self, context)
		if
			context.pre_jokers
			and context.before
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
		then
			for k, v in ipairs(context.scoring_hand) do
				if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
					v:set_ability(G.P_CENTERS.c_base, nil, true)
					v.vampired = true
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							v.vampired = nil
							return true
						end,
					}))
				end
			end
		end
		if
			context.post_jokers
			and context.destroying_card
			and not context.blueprint
			and not context.retrigger_joker
		then
			if context.destroying_card:is_suit("Hearts") or context.destroying_card:is_suit("Diamonds") then
				if SMODS.pseudorandom_probability(self, "cry_choco_blood", 1, 3, "Chocolate Dice 5") then
					context.destroying_card.will_shatter = true
					local destroying_card = context.destroying_card
					G.E_MANAGER:add_event(Event({
						func = function()
							if destroying_card then
								destroying_card:start_dissolve()
							end
							return true
						end,
					}))
				end
			end
		end
	end,
}
local choco6 = { --please take one
	object_type = "Event",
	key = "choco6",
	calculate = function(self, context)
		if context.pre_cash then
			G.E_MANAGER:add_event(Event({
				func = function()
					local key = get_pack("cry_take_one").key
					local card = Card(
						G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
						G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
						G.CARD_W * 1.27,
						G.CARD_H * 1.27,
						G.P_CARDS.empty,
						G.P_CENTERS[key],
						{ bypass_discovery_center = true, bypass_discovery_ui = true }
					)
					card.cost = 0
					card.from_tag = true
					G.FUNCS.use_card({ config = { ref_table = card } })
					card:start_materialize()
					pack_opened = true
					return true
				end,
			}))
		end
		if context.setting_blind then
			pack_opened = nil
		end
	end,
}
local choco7 = {
	object_type = "Event",
	key = "choco7",
	start = function(self)
		G.GAME.events[self.key] = true
		for i = 1, 3 do
			local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_trick_or_treat")
			card:add_to_deck()
			G.jokers:emplace(card)
		end
		local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cry_candy_basket")
		card:add_to_deck()
		G.jokers:emplace(card)
	end,
	calculate = function(self, context)
		if context.start_shop then
			local tag = Tag("tag_cry_rework")
			if not tag.ability then
				tag.ability = {}
			end
			tag.ability.rework_key = "j_cry_trick_or_treat"
			tag.ability.rework_edition = "e_base"
			add_tag(tag)
		end
	end,
	init = function(self)
		--candy gives $3
		local catd = Card.add_to_deck
		function Card:add_to_deck(debuff)
			if not debuff and self.config.center.rarity == "cry_candy" then
				if G.GAME.events.ev_cry_choco7 then
					ease_dollars(3)
				end
				if G.GAME.events.ev_cry_choco8 then
					local card = create_card(
						"Joker",
						G.jokers,
						nil,
						nil,
						nil,
						nil,
						pseudorandom_element(Cryptid.food, pseudoseed("cry_candy_rain"))
					)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
			end
			return catd(self, debuff)
		end
	end,
}
local choco8 = {
	object_type = "Event",
	key = "choco8",
	calculate = function(self, context)
		if context.cash_out then
			for i = 1, G.GAME.current_round.hands_left do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_choco8")
				card:add_to_deck()
				G.jokers:emplace(card)
			end
		end
	end,
}
local choco9 = {
	object_type = "Event",
	key = "choco9",
	start = function(self)
		G.GAME.events[self.key] = true
		ease_dollars(10) --will already be X2 = 20
	end,
	init = function(self)
		local ed = ease_dollars
		function ease_dollars(mod, instant)
			if to_big(mod) == to_big(0) then
				return
			end
			if G.GAME.events.ev_cry_choco9 and to_big(mod) > to_big(0) then
				mod = mod * 2
			end
			return ed(mod, instant)
		end
	end,
}
local choco10 = { --revered antique
	object_type = "Event",
	key = "choco10",
	--everything here is lovely patches or hooks
	init = function(self)
		--antique can only be bought as last item
		local gfcb = G.FUNCS.can_buy
		function G.FUNCS.can_buy(e)
			if e.config.ref_table and e.config.ref_table.ability and e.config.ref_table.ability.cry_antique then
				if not (#G.shop_jokers.cards == 0 and #G.shop_booster.cards == 0 and #G.shop_vouchers.cards == 1) then
					e.config.colour = G.C.UI.BACKGROUND_INACTIVE
					e.config.button = nil
					return
				end
			end
			return gfcb(e)
		end
	end,
}
local spy = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "spy",
	pos = { x = 0, y = 0 },
	rarity = 1,
	cost = 8,
	atlas = "atlasspooky",
	config = { x_mult = 0.5, extra = { secret_card = "", revealed = false } },
	immutable = true,
	source_gate = "sho",
	order = 133,
	no_dbl = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize({
					type = "name_text",
					set = "Joker",
					key = center.ability and center.ability.extra and center.ability.extra.secret_card,
				}),
				center.ability.x_mult,
			},
		}
	end,
	update = function(self, card, front)
		if card.ability.extra.secret_card == "" then
			secret_card = pseudorandom_element(
				G.P_CENTER_POOLS.Joker,
				pseudoseed("cry_spy" .. (card.area and card.area.config.collection and "_collection" or ""))
			)
			card.ability.extra.secret_card = secret_card.key
			if not (card.area and card.area.config.collection) then
				card.pos = secret_card.pos
				card.config.center.rarity = secret_card.rarity
				card.cost = secret_card.cost
				card:set_sprites(G.P_CENTERS[card.ability.extra.secret_card])
				card.children.center:set_sprite_pos(secret_card.pos)
			end
		end
		if card.area and card.area.config.collection then
			card.config.center.rarity = "cry_cursed"
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		card.ability.perishable = true
		card.ability.perish_tally = G.GAME.perishable_rounds
		card.config.center.rarity = "cry_cursed"
		card:set_sprites(card.config.center)
		card.ability.extra.revealed = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.x_mult } }),
				Xmult_mod = card.ability.x_mult,
				colour = G.C.MULT,
			}
		end
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if card.ability.extra.revealed or (card.area and card.area.config.collection) then
			if card.area and card.area.config.collection then
				card:update(0.016)
			end
			local target = {
				type = "descriptions",
				key = self.key,
				set = self.set,
				nodes = desc_nodes,
				vars = specific_vars or {},
			}
			local res = {}
			if self.loc_vars and type(self.loc_vars) == "function" then
				res = self:loc_vars(info_queue, card) or {}
				target.vars = res.vars or target.vars
				target.key = res.key or target.key
				target.set = res.set or target.set
			end
			if desc_nodes == full_UI_table.main and not full_UI_table.name then
				full_UI_table.name =
					localize({ type = "name", set = target.set, key = target.key, nodes = full_UI_table.name })
			elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
				desc_nodes.name = localize({ type = "name_text", key = target.key, set = target.set })
			end
			if specific_vars and specific_vars.debuffed and not res.replace_debuff then
				target = {
					type = "other",
					key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
					nodes = desc_nodes,
				}
			end
			if res.main_start then
				desc_nodes[#desc_nodes + 1] = res.main_start
			end
			localize(target)
			if res.main_end then
				desc_nodes[#desc_nodes + 1] = res.main_end
			end
		else
			local secret_card = Cryptid.deep_copy(G.P_CENTERS[card.ability.extra.secret_card])
			secret_card.ability = secret_card.config
			local target = {
				type = "descriptions",
				key = secret_card.key,
				set = secret_card.set,
				nodes = desc_nodes,
				vars = specific_vars or {},
			}
			local res = {}
			if secret_card.loc_vars and type(secret_card.loc_vars) == "function" then
				res = secret_card:loc_vars(info_queue, secret_card) or {}
				target.vars = res.vars or target.vars
				target.key = res.key or target.key
				target.set = res.set or target.set
			end
			if desc_nodes == full_UI_table.main and not full_UI_table.name then
				full_UI_table.name =
					localize({ type = "name", set = target.set, key = target.key, nodes = full_UI_table.name })
			elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
				desc_nodes.name = localize({ type = "name_text", key = target.key, set = target.set })
			end
			if specific_vars and specific_vars.debuffed and not res.replace_debuff then
				target = {
					type = "other",
					key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
					nodes = desc_nodes,
				}
			end
			if res.main_start then
				desc_nodes[#desc_nodes + 1] = res.main_start
			end
			localize(target)
			if res.main_end then
				desc_nodes[#desc_nodes + 1] = res.main_end
			end
		end
	end,
}
local flickering = {
	object_type = "Sticker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	atlas = "sticker",
	pos = { x = 5, y = 4 }, --placeholder
	key = "flickering",
	badge_colour = HEX("747474"),
	loc_vars = function(self, info_queue, card)
		return { vars = { 5, card.ability.flick_tally or 5 } }
	end,
	apply = function(self, card, val)
		if not SMODS.is_eternal(card) or G.GAME.modifiers.cry_sticker_sheet then
			card.ability[self.key] = val
			if card.ability[self.key] then
				card.ability.flick_tally = 5
			end
		end
	end,
	calculate = function(self, card, context)
		if not card.ability.flick_tally then
			card.ability.flick_tally = 5
		end
		if card.ability.set == "Joker" then
			if context.post_trigger and context.other_joker == card then
				card.ability.flick_tally = card.ability.flick_tally - 1
				if card.ability.flick_tally > 0 then
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_remaining",
							vars = {
								card.ability.flick_tally,
							},
						}),
						colour = G.C.FILTER,
						delay = 0.45,
					})
				else
					card.will_shatter = true
					G.E_MANAGER:add_event(Event({
						func = function()
							card:start_dissolve()
							return true
						end,
					}))
				end
			end
		elseif context.from_playing_card and not card.debuff and not context.repetition_only and context.ret then
			context.ret.jokers = nil
			if next(context.ret) ~= nil then
				card.ability.flick_tally = card.ability.flick_tally - 1
				if card.ability.flick_tally > 0 then
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_remaining",
							vars = { card.ability.flick_tally },
						}),
						colour = G.C.FILTER,
						delay = 0.45,
					})
				else
					card.will_shatter = true
					G.E_MANAGER:add_event(Event({
						func = function()
							card:start_dissolve()
							return true
						end,
					}))
				end
			end
		end
	end,
}
local trick_or_treat = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
			"set_cry_cursed",
		},
	},
	config = {
		extra = {
			odds = 4,
			num_candies = 2,
		},
		immutable = {
			prob_mod = 3,
			max_candies = 40,
		},
	},

	key = "trick_or_treat",
	pos = { x = 2, y = 1 },
	rarity = 2,
	cost = 5,
	order = 134,
	atlas = "atlasspooky",
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.selling_self then
			if
				SMODS.pseudorandom_probability(
					card,
					"cry_trick_or_treat",
					3,
					card and card.ability.extra.odds or self.config.extra.odds
				)
			then
				local spawn_num =
					to_number(math.min(card.ability.immutable.max_candies, card.ability.extra.num_candies))

				for i = 1, spawn_num do
					local new_card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_trick_candy")
					new_card:add_to_deck()
					G.jokers:emplace(new_card)
				end
			else
				local new_cursed = create_card("Joker", G.jokers, nil, "cry_cursed", nil, nil, nil, "cry_trick_curse")
				new_cursed:add_to_deck()
				G.jokers:emplace(new_cursed)
			end
		end
		if context.forcetrigger then
			local spawn_num = to_number(math.min(card.ability.immutable.max_candies, card.ability.extra.num_candies))

			for i = 1, spawn_num do
				local new_card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_trick_candy")
				new_card:add_to_deck()
				G.jokers:emplace(new_card)
			end
		end
	end,
	loc_vars = function(self, info_queue, center)
		local num, denom =
			SMODS.get_probability_vars(card, 3, card and card.ability.extra.odds or self.config.extra.odds)
		return {
			vars = {
				num,
				denom,
				number_format(center.ability.extra.num_candies),
			},
		}
	end,
}
local candy_basket = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "candy_basket",
	pos = { x = 4, y = 0 },
	rarity = 2,
	cost = 6,
	order = 135,
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	config = {
		extra = {
			candies = 0,
			candy_mod = 1,
			candy_boss_mod = 2,
		},
		immutable = {
			current_win_count = 0,
			wins_needed = 2,
			max_spawn = 100,
		},
	},
	calculate = function(self, card, context)
		if context.selling_self then
			for i = 1, math.floor(math.min(card.ability.immutable.max_spawn, card.ability.extra.candies)) do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_candy_basket")
				card:add_to_deck()
				G.jokers:emplace(card)
			end
		end
		if context.end_of_round and not context.individual and not context.repetition then
			card.ability.immutable.current_win_count = card.ability.immutable.current_win_count + 1

			if G.GAME.blind.boss then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "candies",
					scalar_value = "candy_boss_mod",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + change * card.ability.extra.candy_boss_mod
					end,
					no_message = true,
				})
			end
			if card.ability.immutable.current_win_count >= card.ability.immutable.wins_needed then
				card.ability.immutable.current_win_count = 0
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "candies",
					scalar_value = "candy_mod",
				})
			end
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "candies",
				scalar_value = "candy_boss_mod",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + change * card.ability.extra.candy_boss_mod
				end,
				no_message = true,
			})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "candies",
				scalar_value = "candy_mod",
			})
			for i = 1, math.floor(math.min(card.ability.immutable.max_spawn, card.ability.extra.candies)) do
				local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_candy_basket")
				card:add_to_deck()
				G.jokers:emplace(card)
			end
		end
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(math.floor(math.min(center.ability.immutable.max_spawn, center.ability.extra.candies))),
				number_format(center.ability.extra.candy_mod),
				center.ability.immutable.wins_needed,
				number_format(
					lenient_bignum(to_big(center.ability.extra.candy_mod) * center.ability.extra.candy_boss_mod)
				),
			},
		}
	end,
}
local blacklist = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "blacklist",
	pos = { x = 2, y = 2 },
	rarity = "cry_cursed",
	cost = 0,
	atlas = "atlasspooky",
	order = 136,
	config = { extra = { blacklist = 14 } },
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	no_dbl = true,
	immutable = true,
	calculate = function(self, card, context)
		if context.joker_main then
			local blacklist = false
			for i = 1, #G.play.cards do
				if G.play.cards[i]:get_id() == card.ability.extra.blacklist then
					blacklist = true
					break
				end
			end
			for i = 1, #G.hand.cards do
				if G.hand.cards[i]:get_id() == card.ability.extra.blacklist then
					blacklist = true
					break
				end
			end
			if blacklist then
				hand_chips = to_big(0)
				mult = to_big(0)
				update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
				return {
					message = localize("k_nope_ex"),
					colour = G.C.BLACK,
				}
			else
				for i = 1, #G.discard.cards do
					if G.discard.cards[i]:get_id() == card.ability.extra.blacklist then
						blacklist = true
						break
					end
				end
				for i = 1, #G.deck.cards do
					if G.deck.cards[i]:get_id() == card.ability.extra.blacklist then
						blacklist = true
						break
					end
				end
				if not blacklist then
					G.E_MANAGER:add_event(Event({
						func = function()
							card:start_dissolve()
							return true
						end,
					}))
				end
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					card:start_dissolve()
					return true
				end,
			}))
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.blacklist =
			pseudorandom_element(SMODS.Ranks, pseudoseed("cry_blacklist" .. G.GAME.round_resets.ante)).id
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize(
					center.ability.extra.blacklist == 14 and "Ace"
						or center.ability.extra.blacklist == 13 and "King"
						or center.ability.extra.blacklist == 12 and "Queen"
						or center.ability.extra.blacklist == 11 and "Jack"
						or number_format(center.ability.extra.blacklist),
					"ranks"
				),
			},
		}
	end,
}
local ghost = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "ghost",
	pos = { x = 3, y = 0 },
	config = {
		extra = {
			odds = 1,
			possess_rate = 2,
			destroy_rate = 6,
		},
	},
	rarity = "cry_cursed",
	cost = 0,
	order = 137,
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	no_dbl = true,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
		then
			if
				SMODS.pseudorandom_probability(
					card,
					"cry_ghost_destroy",
					1,
					(card and card.ability.extra.odds or self.config.extra.odds) * card.ability.extra.destroy_rate
				)
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						card:start_dissolve()
						for i = 1, #G.jokers.cards do
							if G.jokers.cards[i].ability.cry_possessed then
								if SMODS.is_eternal(G.jokers.cards[i]) then
									G.jokers.cards[i].ability.cry_possessed = nil
								else
									G.jokers.cards[i]:start_dissolve()
								end
							end
						end
						return true
					end,
				}))
				return
			end
			--todo: let multiple ghosts possess multiple jokers
			if
				SMODS.pseudorandom_probability(
					card,
					"ghostdestroy",
					1,
					(card and card.ability.extra.odds or self.config.extra.odds) * card.ability.extra.possess_rate
				)
			then
				for i = 1, #G.jokers.cards do
					G.jokers.cards[i].ability.cry_possessed = nil
				end
				local eligible_cards = {}
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].config.center.key ~= "j_cry_ghost" then
						table.insert(eligible_cards, i)
					end
				end
				if #eligible_cards ~= 0 then
					G.jokers.cards[pseudorandom_element(eligible_cards, pseudoseed("cry_ghost_possess_choice"))].ability.cry_possessed =
						true
				end
				return
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "cry_possessed" }
		local num, denom = SMODS.get_probability_vars(
			card,
			1,
			(card and card.ability.extra.odds or self.config.extra.odds) * card.ability.extra.destroy_rate
		)
		local num2, denom2 = SMODS.get_probability_vars(
			card,
			1,
			(card and card.ability.extra.odds or self.config.extra.odds) * card.ability.extra.possess_rate
		)
		return {
			vars = {
				num2,
				num1,
				denom2,
				denom1,
			},
		}
	end,
}
local possessed = {
	object_type = "Sticker",
	dependencies = {
		items = {
			"set_cry_cursed",
			"j_cry_ghost",
		},
	},
	atlas = "sticker",
	pos = { x = 6, y = 0 }, --todo
	key = "possessed",
	no_sticker_sheet = true,
	badge_colour = HEX("aaaaaa"),
}

local rotten_egg = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "rotten_egg",
	pos = { x = 3, y = 3 },
	config = {
		extra = {
			starting_money = 1,
			lose_money = 1,
			needed_money = 10,
			left_money = 10,
		},
	},
	rarity = "cry_cursed",
	cost = 0,
	order = 136.1, --gross but cryptid doesnt partition orderings and im not shifting everything
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	no_dbl = true,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.cry_rotten_amount = card.ability.extra.starting_money
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then
				v:set_cost()
			end
		end
	end,
	remove_from_deck = function()
		G.GAME.cry_rotten_amount = nil
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then
				v:set_cost()
			end
		end
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			for i, v in pairs(G.jokers.cards) do
				v.sell_cost = v.sell_cost - 1
			end
			return {
				message = localize("k_downgraded_ex"),
			}
		end
		if
			context.selling_card
			and context.card.ability.set == "Joker"
			and context.card
			and context.card.sell_cost ~= 0
		then
			card.ability.extra.left_money = card.ability.extra.left_money - context.card.sell_cost
			if to_big(card.ability.extra.left_money) <= to_big(0) then
				G.E_MANAGER:add_event(Event({
					func = function()
						card:start_dissolve()
						return true
					end,
				}))
			else
				return {
					message = number_format(card.ability.extra.needed_money - card.ability.extra.left_money)
						.. "/"
						.. number_format(card.ability.extra.needed_money),
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					card:start_dissolve()
					return true
				end,
			}))
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.starting_money),
				number_format(card.ability.extra.lose_money),
				number_format(card.ability.extra.needed_money),
				number_format(card.ability.extra.left_money),
			},
		}
	end,
}

local spookydeck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_spooky",
			"set_cry_cursed",
			"set_cry_deck",
			"j_cry_chocolate_dice",
		},
	},
	key = "spooky",
	config = { cry_curse_rate = 0.25 },
	pos = { x = 3, y = 1 },
	order = 16,
	atlas = "atlasspooky",
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
	init = function(self)
		local Backapply_to_runRef = Back.apply_to_run
		function Back.apply_to_run(self)
			Backapply_to_runRef(self)
			if self.effect.config.cry_spooky then
				G.GAME.modifiers.cry_spooky = true
				G.GAME.modifiers.cry_curse_rate = self.effect.config.cry_curse_rate or 0.25
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
		end
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if Cryptid.safe_get(G, "jokers") then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.rarity == "cry_candy" then
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
}
local candy_dagger = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	name = "cry-Candy Dagger",
	key = "candy_dagger",
	pos = { x = 4, y = 2 },
	rarity = 2,
	cost = 8,
	order = 138,
	atlas = "atlasspooky",
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	calculate = function(self, card, context)
		local my_pos = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				my_pos = i
				break
			end
		end
		if
			context.setting_blind
			and not (context.blueprint_card or self).getting_sliced
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
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_candy",
					vars = { 1 },
				}),
				colour = G.C.RARITY["cry_candy"],
				no_juice = true,
			})
			local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_candy_dagger")
			card:add_to_deck()
			G.jokers:emplace(card)
			return nil, true
		end
		if context.forcetrigger and my_pos and G.jokers.cards[my_pos + 1] then
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
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_candy",
					vars = { 1 },
				}),
				colour = G.C.RARITY["cry_candy"],
				no_juice = true,
			})
			local card = create_card("Joker", G.jokers, nil, "cry_candy", nil, nil, nil, "cry_candy_dagger")
			card:add_to_deck()
			G.jokers:emplace(card)
		end
	end,
}
local candy_cane = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "candy_cane",
	pos = { x = 1, y = 1 },
	rarity = "cry_candy",
	config = { extra = { rounds = 11, dollars = 4 } },
	cost = 10,
	order = 139,
	atlas = "atlasspooky",
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.rounds),
				number_format(center.ability.extra.dollars),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if not context.other_card.candy_caned then
				context.other_card.candy_caned = true
				local c = context.other_card
				G.E_MANAGER:add_event(Event({
					func = function()
						if c then
							c.candy_caned = nil
						end
						return true
					end,
				}))
			else
				ease_dollars(lenient_bignum(card.ability.extra.dollars))
			end
		end
		if
			context.end_of_round
			and not context.blueprint
			and not context.individual
			and not context.repetition
			and not context.retrigger_joker
		then
			card.ability.extra.rounds = lenient_bignum(to_big(card.ability.extra.rounds) - 1)
			if to_big(card.ability.extra.rounds) > to_big(0) then
				return {
					message = { localize("cry_minus_round") },
					colour = G.C.FILTER,
				}
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
			ease_dollars(lenient_bignum(card.ability.extra.dollars))
			card.ability.extra.rounds = lenient_bignum(to_big(card.ability.extra.rounds) - 1)
			if to_big(card.ability.extra.rounds) > to_big(0) then
				return {
					message = { localize("cry_minus_round") },
					colour = G.C.FILTER,
				}
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
}
local candy_buttons = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "candy_buttons",
	name = "cry-candybuttons",
	pos = { x = 1, y = 2 },
	order = 140,
	rarity = "cry_candy",
	config = { extra = { rerolls = 15 } },
	cost = 10,
	atlas = "atlasspooky",
	blueprint_compat = true,
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.rerolls) } }
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.rerolls = lenient_bignum(to_big(card.ability.extra.rerolls) - 1)
			if to_big(card.ability.extra.rerolls) <= to_big(0) then
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
			return nil, true
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		-- The find_joker check in calculate_reroll_cost doesn't work if this is the only copy when added to deck (Too early)
		G.GAME.reroll_limit_buffer = 1
		calculate_reroll_cost(true)
		G.GAME.reroll_limit_buffer = nil
	end,
	remove_from_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
}
local jawbreaker = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "jawbreaker",
	pos = { x = 3, y = 2 },
	rarity = "cry_candy",
	cost = 10,
	order = 141,
	atlas = "atlasspooky",
	blueprint_compat = false,
	demicoloncompat = true,
	pools = { ["Food"] = true },
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and G.GAME.blind.boss
			and not context.blueprint_card
			and not context.retrigger_joker
		then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.manipulate(G.jokers.cards[i - 1], { value = 2 })
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = 2 })
						end
					end
				end
			end
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
		if context.forcetrigger then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							Cryptid.manipulate(G.jokers.cards[i - 1], { value = 2 })
						end
					end
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
							Cryptid.manipulate(G.jokers.cards[i + 1], { value = 2 })
						end
					end
				end
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
	remove_from_deck = function(self, card, from_debuff)
		calculate_reroll_cost(true)
	end,
}
local mellowcreme = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "mellowcreme",
	pos = { x = 0, y = 2 },
	rarity = "cry_candy",
	cost = 10,
	order = 142,
	atlas = "atlasspooky",
	config = { extra = { sell_mult = 4 } },
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.sell_mult) } }
	end,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger then
			for k, v in ipairs(G.consumeables.cards) do
				if v.set_cost then
					v.ability.extra_value = lenient_bignum(
						(to_big(v.ability.extra_value) or 0)
							+ (math.max(1, math.floor(to_big(v.cost) / 2)) + (v.ability.extra_value or 0))
								* (to_big(card.ability.extra.sell_mult) - 1)
					)
					v:set_cost()
				end
			end
		end
	end,
}
local brittle = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "brittle",
	pos = { x = 5, y = 1 },
	rarity = "cry_candy",
	cost = 10,
	atlas = "atlasspooky",
	order = 143,
	config = { extra = { rounds = 9 } },
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return { vars = { number_format(center.ability.extra.rounds) } }
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint_card
			and not context.retrigger_joker
			and context.scoring_hand
		then
			local _card = context.scoring_hand[#context.scoring_hand]
			if _card and not _card.brittled then
				card.ability.extra.rounds = lenient_bignum(to_big(card.ability.extra.rounds) - 1)
				local enhancement = pseudorandom_element({ "m_stone", "m_gold", "m_steel" }, pseudoseed("cry_brittle"))
				_card.brittled = true
				_card:set_ability(G.P_CENTERS[enhancement], nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:juice_up()
						_card.brittled = nil
						return true
					end,
				}))
				if to_big(card.ability.extra.rounds) > to_big(0) then
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
		end
	end,
}
local monopoly_money = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
	key = "monopoly_money",
	name = "cry-Monopoly",
	pos = { x = 4, y = 1 },
	config = { extra = { odds = 4 } },
	order = 144,
	rarity = "cry_cursed",
	cost = 0,
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	no_dbl = true,
	calculate = function(self, card, context)
		if
			context.buying_card
			and not context.blueprint_card
			and not context.retrigger_joker
			and not (context.card == card)
		then
			if
				SMODS.pseudorandom_probability(
					card,
					"cry_monopoly",
					1,
					card and card.ability.extra.odds or self.config.extra.odds
				)
			then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.card:start_dissolve()
						card_eval_status_text(card, "extra", nil, nil, nil, {
							message = localize("k_nope_ex"),
							colour = G.C.BLACK,
						})
						return true
					end,
				}))
			end
			return nil, true
		end
		if context.selling_self and not context.blueprint_card and not context.retrigger_joker then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_dollars(math.floor(0.5 * G.GAME.dollars - G.GAME.dollars))
					return true
				end,
			}))
			return nil, true
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_dollars(math.floor(0.5 * G.GAME.dollars - G.GAME.dollars))
					return true
				end,
			}))
		end
	end,
	loc_vars = function(self, info_queue, card)
		local num, denom =
			SMODS.get_probability_vars(card, 1, card and card.ability.extra.odds or self.config.extra.odds)
		return {
			vars = {
				num,
				denom,
			},
		}
	end,
}
local candy_sticks = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "candy_sticks",
	name = "cry-Candy-Sticks",
	pos = { x = 5, y = 2 },
	order = 145,
	config = {
		extra = { hands = 1 },
		immutable = {
			boss = {},
			clockscore = 0,
		},
	},
	rarity = "cry_candy",
	cost = 3,
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	no_dbl = true,
	calculate = function(self, card, context)
		if context.setting_blind and not self.getting_sliced and not context.blueprint and context.blind.boss then
			card.ability.immutable.boss = G.GAME.blind:save()
			if G.GAME.blind.name == "The Clock" then
				card.ability.immutable.clockscore = G.GAME.blind.chips
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound("timpani")
							delay(0.4)
							return true
						end,
					}))
					card_eval_status_text(self, "extra", nil, nil, nil, { message = localize("ph_boss_disabled") })
					return true
				end,
			}))
		end
		if context.after and G.GAME.blind:get_type() == "Boss" then
			card.ability.extra.hands = lenient_bignum(to_big(card.ability.extra.hands) - 1)
		end
		if
			(
				(context.selling_self and G.GAME.blind and G.GAME.blind:get_type() == "Boss")
				or to_big(card.ability.extra.hands) <= to_big(0)
			) and G.GAME.blind.disabled
		then
			G.GAME.blind:load(card.ability.immutable.boss)
			if not context.selling_self then
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
		if context.end_of_round and G.GAME.blind:get_type() == "Boss" then
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
	end,
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.hands) } }
	end,
	cry_credits = {
		idea = {
			"Squiddy",
		},
		art = {
			"lolxddj",
		},
		code = {
			"Foegro",
		},
	},
}
-- Wonka Bar
-- Sell this card to permanently gain +1 card selection limit
local wonka_bar = {
	object_type = "Joker",
	dependencies = {
		items = {
			"set_cry_spooky",
		},
	},
	key = "wonka_bar",
	name = "cry_wonka_bar",
	config = { extra = 1 },
	pos = { x = 1, y = 3 },
	order = 146,
	rarity = "cry_candy",
	cost = 10,
	eternal_compat = false,
	demicoloncompat = true,
	blueprint_compat = true,
	atlas = "atlasspooky",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
	calculate = function(self, card, context)
		if context.selling_self or context.forcetrigger then
			SMODS.change_play_limit(math.floor(card.ability.extra))
			SMODS.change_discard_limit(math.floor(card.ability.extra))
		end
	end,
	cry_credits = {
		idea = {
			"Inspector_B",
		},
		art = {
			"George the Rat",
		},
		code = {
			"Glitchkat10",
		},
	},
}

-- Buttercup
-- Store items in shop
local buttercup = {
	object_type = "Joker",
	key = "buttercup",
	name = "cry-Buttercup",
	pos = { x = 2, y = 3 },
	config = { extra = { slots = 1 } },
	rarity = "cry_candy",
	cost = 3,
	atlas = "atlasspooky",
	blueprint_compat = false,
	eternal_compat = false,
	demicoloncompat = true,
	no_dbl = true,
	order = 147,
	cry_credits = {
		idea = { "Squiddy" },
		art = { "lolxddj" },
		code = { "#Guigui" },
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.slots },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		if card.cry_storage == nil then
			local storage_area_config = {
				type = "play",
				card_w = G.CARD_W,
			}
			card.cry_storage = CardArea(card.T.x, 2, 1, 1, storage_area_config)
		end
		if G.GAME.next_shop_cards == nil then
			G.GAME.next_shop_cards = {}
		end
	end,
	calculate = function(self, card, context)
		if card.cry_storage == nil then
			local storage_area_config = {
				type = "play",
				card_w = G.CARD_W,
			}
			card.cry_storage = CardArea(card.T.x, 2, 1, 1, storage_area_config)
		end
		if context.selling_self and not context.blueprint and not context.forcetrigger then
			if #card.cry_storage.cards > 0 then
				for i, jok in ipairs(card.cry_storage.cards) do
					jok.T.w = jok.T.orig.w
					jok.T.h = jok.T.orig.h
					G.GAME.next_shop_cards[#G.GAME.next_shop_cards + 1] = jok:save()
					jok:remove()
				end
			end
			card.cry_storage:remove()
		end
		if context.forcetrigger and #card.cry_storage.cards > 0 then
			for i, jok in ipairs(card.cry_storage.cards) do
				-- jok.T.w = jok.T.orig.w
				-- jok.T.h = jok.T.orig.h
				G.GAME.next_shop_cards[#G.GAME.next_shop_cards + 1] = jok:save()
			end
		end
	end,
	init = function()
		local start_dissolveref = Card.start_dissolve
		function Card:start_dissolve(...)
			start_dissolveref(self, card)
			if self.config.center.key == "j_cry_buttercup" then
				G.E_MANAGER:add_event(Event({
					func = function()
						for i, v in pairs((self.cry_storage or {}).cards or {}) do
							v.states.visible = false
							v:start_dissolve()
						end
						if self.cry_storage then
							self.cry_storage:remove()
						end
						return true
					end,
				}))
			end
		end
	end,
}

items = {
	cotton_candy,
	wrapped,
	choco_dice,
	choco_base_event,
	--choco1,
	choco2,
	choco3,
	potion,
	choco4,
	choco5,
	choco6,
	choco7,
	choco8,
	choco9,
	choco10,
	--spy,
	flickering,
	trick_or_treat,
	candy_basket,
	blacklist,
	rotten_egg,
	--ghost,
	--possessed,
	spookydeck,
	candy_dagger,
	candy_cane,
	candy_buttons,
	jawbreaker,
	mellowcreme,
	brittle,
	monopoly_money,
	candy_sticks,
	wonka_bar,
	buttercup,
}
return {
	name = "Spooky",
	init = function() end,
	items = items,
}
