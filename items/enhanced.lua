local atlasedition = {
	object_type = "Atlas",
	key = "atlaseditiondeck",
	path = "atlaseditiondeck.png",
	px = 71,
	py = 95,
}

Cryptid.edeck_sprites = {
	edition = {
		order = 1,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		e_foil = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 0 } },
		e_holo = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 0 } },
		e_polychrome = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 0 } },
		e_negative = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 0 } },
		e_cry_glitched = { atlas = "cry_atlaseditiondeck", pos = { x = 4, y = 0 } },
		e_cry_mosaic = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 1 } },
		e_cry_oversat = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 1 } },
		e_cry_glass = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 1 } },
		e_cry_gold = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 1 } },
		e_cry_blur = { atlas = "cry_atlaseditiondeck", pos = { x = 0, y = 2 } },
		e_cry_noisy = { atlas = "cry_atlaseditiondeck", pos = { x = 1, y = 2 } },
		e_cry_astral = { atlas = "cry_atlaseditiondeck", pos = { x = 2, y = 2 } },
		e_cry_m = { atlas = "cry_atlaseditiondeck", pos = { x = 3, y = 2 } },
	},
	enhancement = {
		order = 2,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		m_bonus = { atlas = "cry_atlasdeck", pos = { x = 3, y = 3 } },
		m_mult = { atlas = "cry_atlasdeck", pos = { x = 2, y = 3 } },
		m_wild = { atlas = "cry_atlasdeck", pos = { x = 5, y = 3 } },
		m_glass = { atlas = "cry_atlasdeck", pos = { x = 4, y = 3 } },
		m_steel = { atlas = "cry_atlasdeck", pos = { x = 8, y = 4 } },
		m_stone = { atlas = "cry_atlasdeck", pos = { x = 6, y = 4 } },
		m_gold = { atlas = "cry_atlasdeck", pos = { x = 7, y = 4 } },
		m_lucky = { atlas = "cry_atlasdeck", pos = { x = 6, y = 3 } },
		m_cry_echo = { atlas = "cry_atlasdeck", pos = { x = 1, y = 5 } },
		m_cry_light = { atlas = "cry_atlasdeck", pos = { x = 7, y = 3 } },
	},
	sticker = {
		order = 3,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		all = { atlas = "cry_placeholders", pos = { x = 3, y = 2 } },
		eternal = { atlas = "cry_atlasdeck", pos = { x = 6, y = 0 } },
		perishable = { atlas = "cry_atlasdeck", pos = { x = 7, y = 0 } },
		rental = { atlas = "cry_atlasdeck", pos = { x = 8, y = 0 } },
		pinned = { atlas = "cry_atlasdeck", pos = { x = 7, y = 1 } },
		banana = { atlas = "cry_atlasdeck", pos = { x = 6, y = 1 } },
		cry_rigged = { atlas = "cry_atlasdeck", pos = { x = 8, y = 1 } },
		cry_absolute = { atlas = "cry_atlasdeck", pos = { x = 8, y = 2 } },
		cry_possessed = { atlas = "cry_atlasdeck", pos = { x = 7, y = 2 } },
		cry_flickering = { atlas = "cry_atlasdeck", pos = { x = 6, y = 2 } },
	},
	suit = {
		order = 4,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		Diamonds = { atlas = "cry_atlasdeck", pos = { x = 2, y = 1 } },
		Hearts = { atlas = "cry_atlasdeck", pos = { x = 3, y = 1 } },
		Spades = { atlas = "cry_atlasdeck", pos = { x = 4, y = 1 } },
		Clubs = { atlas = "cry_atlasdeck", pos = { x = 5, y = 1 } },
	},
	seal = {
		order = 5,
		default = { atlas = "cry_placeholders", pos = { x = 4, y = 2 } },
		Gold = { atlas = "cry_atlasdeck", pos = { x = 3, y = 2 } },
		Red = { atlas = "cry_atlasdeck", pos = { x = 0, y = 2 } },
		Blue = { atlas = "cry_atlasdeck", pos = { x = 2, y = 2 } },
		Purple = { atlas = "cry_atlasdeck", pos = { x = 1, y = 2 } },
		cry_azure = { atlas = "cry_atlasdeck", pos = { x = 8, y = 3 } },
		cry_green = { atlas = "cry_atlasdeck", pos = { x = 3, y = 5 } },
	},
}

function Cryptid.update_edeck_sprite(card, type, key)
	local sprites = Cryptid.edeck_sprites[type]
	if not sprites then
		return
	end
	local sprite = sprites[key]
	if not sprite then
		sprite = sprites.default
	end
	if not card then
		return
	end
	card.children.back.atlas = G.ASSET_ATLAS[sprite.atlas]
	card.children.back:set_sprite_pos(sprite.pos)
end

local e_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Edition Deck",
	key = "e_deck",
	order = 17,
	pos = { x = 5, y = 2 },
	loc_vars = function(self, info_queue, center)
		if
			SMODS.RunSelect.Internals.preview_area
			and (SMODS.RunSelect.Internals.current_page or 0) < SMODS.RunSelect.Pages.cry_edeck_ed.page
		then
			return {
				key = self.key .. "_preview",
			}
		end
		local edition = Cryptid.enhanced_deck_info(self)
		return {
			vars = {
				edition == "random" and "Random" or localize({ type = "name_text", set = "Edition", key = edition }),
				colours = {
					edition == "random" and G.C.DARK_EDITION
						or (G.P_CENTERS[edition] and G.P_CENTERS[edition].badge_colour or G.C.DARK_EDITION),
				},
			},
		}
	end,
	edeck_type = "edition",
	config = { cry_no_edition_price = true },
	apply = function(self)
		local edition = Cryptid.enhanced_deck_info({})
		G.GAME.cry_lock_edition = true
		if edition == "random" then
			G.GAME.modifiers.cry_force_random_edition = true
			G.GAME.modifiers.cry_force_edition = nil
		else
			G.GAME.modifiers.cry_force_edition = edition
		end
		--Ban Edition tags (They will never redeem)
		for k, v in pairs(G.P_TAGS) do
			if v.config and v.config.edition then
				G.GAME.banned_keys[k] = true
			end
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					if edition == "random" then
						G.playing_cards[c]:set_edition(Cryptid.poll_random_edition(), true, true)
					else
						G.playing_cards[c]:set_edition(edition, true, true)
					end
				end
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.type == "discover_amount" then
			if G.DISCOVER_TALLIES.editions.tally / G.DISCOVER_TALLIES.editions.of >= 1 then
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
	attributes = { "edition" },
}
local et_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Enhancement Deck",
	key = "et_deck",
	order = 18,
	pos = { x = 5, y = 2 },
	edeck_type = "enhancement",
	config = {},
	loc_vars = function(self, info_queue, center)
		if
			SMODS.RunSelect.Internals.preview_area
			and (SMODS.RunSelect.Internals.current_page or 0) < SMODS.RunSelect.Pages.cry_edeck_enh.page
		then
			return {
				key = self.key .. "_preview",
			}
		end
		local _, enhancement = Cryptid.enhanced_deck_info(self)
		return {
			vars = {
				enhancement == "random" and "Random"
					or localize({ type = "name_text", set = "Enhanced", key = enhancement }),
				colours = {
					enhancement == "random" and G.C.FILTER
						or (G.P_CENTERS[enhancement] and G.P_CENTERS[enhancement].badge_colour or G.C.FILTER),
				},
			},
		}
	end,
	apply = function(self)
		local _, enhancement = Cryptid.enhanced_deck_info(self)
		G.GAME.cry_lock_enhancement = true
		if enhancement == "random" then
			G.GAME.modifiers.cry_force_random_enhancement = true
			G.GAME.modifiers.cry_force_enhancement = nil
		else
			G.GAME.modifiers.cry_force_enhancement = enhancement
		end
		if G.GAME.modifiers.cry_ccd then
			return
		end --Dont override starting deck ccd modifier
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					if enhancement == "random" then
						G.playing_cards[c]:set_ability(Cryptid.poll_random_enhancement())
					else
						G.playing_cards[c]:set_ability(G.P_CENTERS[enhancement])
					end
				end
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	draw = cry_edeck_draw,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_vacuum" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "enhancements" },
}
local sk_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Sticker Deck",
	key = "sk_deck",
	order = 19,
	pos = { x = 5, y = 2 },
	edeck_type = "sticker",
	config = {},
	loc_vars = function(self, info_queue, center)
		if
			SMODS.RunSelect.Internals.preview_area
			and (SMODS.RunSelect.Internals.current_page or 0) < SMODS.RunSelect.Pages.cry_edeck_sk.page
		then
			return {
				key = self.key .. "_preview",
			}
		end
		local _, _, sticker = Cryptid.enhanced_deck_info(self)
		return {
			vars = {
				sticker == "random" and "Random" or sticker == "all" and "All" or localize({
					type = "name_text",
					set = "Other",
					key = sticker == "pinned" and "pinned_left" or sticker,
				}),
				colours = {
					(sticker == "random" or sticker == "all") and G.C.FILTER
						or (SMODS.Stickers[sticker] and SMODS.Stickers[sticker].badge_colour or G.C.FILTER),
				},
			},
		}
	end,
	apply = function(self)
		local _, _, sticker = Cryptid.enhanced_deck_info(self)
		if sticker == "random" then
			G.GAME.modifiers.cry_force_random_sticker = true
			G.GAME.modifiers.cry_force_sticker = nil
			G.GAME.modifiers.cry_force_all_stickers = nil
		elseif sticker == "all" then
			G.GAME.modifiers.cry_force_all_stickers = true
			G.GAME.modifiers.cry_force_random_sticker = nil
			G.GAME.modifiers.cry_force_sticker = nil
		else
			G.GAME.modifiers.cry_force_sticker = sticker
			G.GAME.modifiers.cry_force_random_sticker = nil
			G.GAME.modifiers.cry_force_all_stickers = nil
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					if sticker == "all" then
						for _, st in ipairs(SMODS.Sticker.obj_buffer) do
							if not SMODS.Stickers[st].no_edeck then
								G.playing_cards[c]:add_sticker(st, true)
							end
						end
					else
						local st = sticker == "random" and Cryptid.poll_random_sticker() or sticker
						if SMODS.Stickers[st] then
							G.playing_cards[c]:add_sticker(st, true)
						else
							G.playing_cards[c]["set_" .. st](G.playing_cards[c], true)
						end
					end
				end
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_lock" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "sticker" },
}
local st_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Suit Deck",
	key = "st_deck",
	config = {},
	order = 20,
	pos = { x = 5, y = 2 },
	edeck_type = "suit",
	loc_vars = function(self, info_queue, center)
		if
			SMODS.RunSelect.Internals.preview_area
			and (SMODS.RunSelect.Internals.current_page or 0) < SMODS.RunSelect.Pages.cry_edeck_st.page
		then
			return {
				key = self.key .. "_preview",
			}
		end
		local _, _, _, suit = Cryptid.enhanced_deck_info(self)
		return {
			vars = {
				suit == "random" and "Random" or localize(suit, "suits_plural"),
				colours = { suit == "random" and G.C.FILTER or G.C.SUITS[suit] },
			},
		}
	end,
	apply = function(self)
		local _, _, _, suit = Cryptid.enhanced_deck_info(self)
		G.GAME.cry_lock_suit = true
		if suit == "random" then
			G.GAME.modifiers.cry_force_random_suit = true
			G.GAME.modifiers.cry_force_suit = nil
		else
			for _, blind in pairs(G.P_BLINDS) do
				if Cryptid.safe_get(blind, "debuff", "suit") == suit then --ban all blinds that debuff the selected suit (in the normal way)
					G.GAME.banned_keys[blind.key] = true
				end
			end
			G.GAME.modifiers.cry_force_suit = suit
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					local st = suit == "random" and Cryptid.poll_random_suit() or suit
					G.playing_cards[c]:change_suit(st)
				end
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_replica" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "suit" },
}
local sl_deck = {
	object_type = "Back",
	dependencies = {
		items = {
			"set_cry_deck",
		},
	},
	name = "cry-Seal Deck",
	key = "sl_deck",
	order = 21,
	pos = { x = 5, y = 2 },
	config = {},
	edeck_type = "seal",
	loc_vars = function(self, info_queue, center)
		if
			SMODS.RunSelect.Internals.preview_area
			and (SMODS.RunSelect.Internals.current_page or 0) < SMODS.RunSelect.Pages.cry_edeck_st.page
		then
			return {
				key = self.key .. "_preview",
			}
		end
		local _, _, _, _, seal = Cryptid.enhanced_deck_info(self)
		return {
			vars = {
				seal == "random" and "Random"
					or localize({ type = "name_text", set = "Other", key = seal:lower() .. "_seal" }),
				colours = {
					seal == "random" and G.C.FILTER or (G.P_SEALS[seal] and G.P_SEALS[seal].badge_colour or G.C.FILTER),
				},
			},
		}
	end,
	apply = function(self)
		local _, _, _, _, seal = Cryptid.enhanced_deck_info(self)
		G.GAME.cry_lock_seal = true
		if seal == "random" then
			G.GAME.modifiers.cry_force_random_seal = true
			G.GAME.modifiers.cry_force_seal = nil
		else
			G.GAME.modifiers.cry_force_seal = seal
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for c = #G.playing_cards, 1, -1 do
					local sl = seal == "random" and Cryptid.poll_random_seal() or seal
					G.playing_cards[c]:set_seal(sl, true)
				end
				return true
			end,
		}))
	end,
	cry_antimatter_apply = function(self)
		self:apply()
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		if args.cry_used_consumable == "c_cry_typhoon" then
			unlock_card(self)
		end
		if args.type == "cry_lock_all" then
			lock_card(self)
		end
		if args.type == "cry_unlock_all" then
			unlock_card(self)
		end
	end,
	attributes = { "seals" },
}

return {
	name = "Enhanced Decks",
	init = function()
		local sa = Card.set_ability
		function Card:set_ability(center, y, z)
			if not G.SETTINGS.paused and Cryptid.safe_get(center, "name") == "Default Base" then -- scuffed
				return sa(
					self,
					(not self.no_forced_enhancement and G.GAME.modifiers.cry_force_enhancement)
							and G.P_CENTERS[G.GAME.modifiers.cry_force_enhancement]
						or center,
					y,
					z
				)
			else
				return sa(self, center, y, z)
			end
		end
		local se = Card.set_edition
		function Card:set_edition(edition, y, z, force)
			if not force and not G.SETTINGS.paused then
				return se(
					self,
					not self.no_forced_edition and G.GAME.modifiers.cry_force_edition or edition,
					y,
					z,
					force
				)
			end
			return se(self, edition, y, z)
		end
		local ss = Card.set_seal
		function Card:set_seal(seal, y, z)
			return ss(
				self,
				not self.no_forced_seal and not G.SETTINGS.paused and G.GAME.modifiers.cry_force_seal or seal,
				y,
				z
			)
		end
		local cs = Card.change_suit
		function Card:change_suit(new_suit)
			return cs(
				self,
				not self.no_forced_suit and not G.SETTINGS.paused and G.GAME.modifiers.cry_force_suit or new_suit
			)
		end
	end,
	items = { e_deck, et_deck, sk_deck, st_deck, sl_deck, atlasedition },
}
