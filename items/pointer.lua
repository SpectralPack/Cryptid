local pointer = {
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
	dependencies = {
		items = {
			"set_cry_code",
			"set_cry_spectral",
		},
	},
	object_type = "Consumable",
	set = "Spectral",
	name = "cry-Pointer",
	key = "pointer",
	pos = { x = 11, y = 3 },
	hidden = true,
	soul_set = "Code",
	order = 20001,
	atlas = "atlasnotjokers",
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if not card.ability.cry_multiuse or to_big(card.ability.cry_multiuse) <= to_big(1) then
			G.GAME.CODE_DESTROY_CARD = copy_card(card)
			G.consumeables:emplace(G.GAME.CODE_DESTROY_CARD)
		else
			card.ability.cry_multiuse = card.ability.cry_multiuse + 1
		end
		G.GAME.USING_CODE = true
		G.OVERLAY_MENU_POINTER = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.USING_POINTER = true
				G.FUNCS.overlay_menu({ definition = create_UIBox_your_collection() })
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
				check_for_unlock({ cry_used_consumable = "c_cry_pointer" })
				return true
			end,
		}))
		G.GAME.POINTER_SUBMENU = nil
	end,
	init = function(self)
		local ccl = Card.click
		function Card:click()
			if G.GAME.USING_POINTER then
				if not self.debuff then
					if self.config.center.consumeable then
						local copy = copy_card(self)
						copy:add_to_deck()
						G.consumeables:emplace(copy)
						G.FUNCS.exit_overlay_menu_code()
						ccl(self)
					elseif self.config.center.set == "Booster" then
						G.FUNCS.exit_overlay_menu_code()
						local card = copy_card(self)
						card.cost = 0
						card.from_tag = true
						G.FUNCS.use_card({ config = { ref_table = card } })
						card:start_materialize()
						created = true
						ccl(self)
					elseif
						self.config.center.key == "c_base"
						or self.config.center.set == "Enhanced"
						or self.edition
						or G.GAME.POINTER_SUBMENU == "Edition"
					then
						--submenu stuff
						if G.GAME.POINTER_SUBMENU == "Rank" then
							G.GAME.POINTER_PLAYING.rank = self.base.value
							G.FUNCS.overlay_menu({
								definition = create_UIBox_pointer_suit(),
							})
						elseif G.GAME.POINTER_SUBMENU == "Suit" then
							G.GAME.POINTER_PLAYING.suit = self.base.suit
							G.FUNCS.overlay_menu({
								definition = create_UIBox_pointer_enhancement(),
							})
						elseif G.GAME.POINTER_SUBMENU == "Enhancement" then
							G.GAME.POINTER_PLAYING.center = self.config.center.key
							G.FUNCS.overlay_menu({
								definition = create_UIBox_pointer_edition(),
							})
						elseif G.GAME.POINTER_SUBMENU == "Edition" then
							if self.edition then
								G.GAME.POINTER_PLAYING.edition = self.edition.key
							end
							G.FUNCS.overlay_menu({
								definition = create_UIBox_pointer_seal(),
							})
						elseif G.GAME.POINTER_SUBMENU == "Seal" then
							G.GAME.POINTER_PLAYING.seal = self.seal
							local card = SMODS.create_card({
								key = G.GAME.POINTER_PLAYING.center,
								rank = G.GAME.POINTER_PLAYING.rank,
								suit = G.GAME.POINTER_PLAYING.suit,
							})
							card:set_ability(G.P_CENTERS[G.GAME.POINTER_PLAYING.center])
							if G.GAME.POINTER_PLAYING.seal then
								card:set_seal(G.GAME.POINTER_PLAYING.seal)
							end
							if G.GAME.POINTER_PLAYING.edition then
								card:set_edition(G.GAME.POINTER_PLAYING.edition)
							end
							if G.STATE == G.STATES.SELECTING_HAND then
								G.hand:emplace(card)
							else
								G.deck:emplace(card)
							end
							table.insert(G.playing_cards, card)
							G.FUNCS.exit_overlay_menu_code()
							G.GAME.POINTER_PLAYING = nil
						end
					else
						G.ENTERED_CARD = self.config.center.key
						local ret = G.FUNCS.pointer_apply()
						G.FUNCS.pointer_cancel()
						if ret then
							G.FUNCS.exit_overlay_menu_code()
							ccl(self)
						else
							G.GAME.USING_CODE = true
							G.GAME.USING_POINTER = true
						end
					end
				end
			else
				ccl(self)
			end
		end
		local emplace_ref = CardArea.emplace
		function CardArea:emplace(card, ...)
			if G.GAME.USING_POINTER then
				if Cryptid.pointergetblist(card.config.center.key)[1] then
					card.debuff = true
				end
			end
			return emplace_ref(self, card, ...)
		end

		function create_UIBox_pointer(card)
			G.E_MANAGER:add_event(Event({
				blockable = false,
				func = function()
					G.REFRESH_ALERTS = true
					return true
				end,
			}))
			local t = create_UIBox_generic_options({
				no_back = true,
				colour = HEX("04200c"),
				outline_colour = G.C.SECONDARY_SET.Code,
				contents = {
					{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = G.C.SET.Code,
								hooked_colour = darken(copy_table(G.C.SET.Code), 0.3),
								w = 4.5,
								h = 1,
								max_length = 100,
								extended_corpus = true,
								prompt_text = localize("cry_code_enter_card"),
								ref_table = G,
								ref_value = "ENTERED_CARD",
								keyboard_offset = 1,
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.SET.Code,
								button = "pointer_apply",
								label = { localize("cry_code_create") },
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.SET.Code,
								button = "your_collection",
								label = { localize("b_collection_cap") },
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.RED,
								button = "pointer_apply_previous",
								label = { localize("cry_code_create_previous") },
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.RED,
								button = "pointer_cancel",
								label = { localize("cry_code_cancel") },
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
				},
			})
			return t
		end
		G.FUNCS.pointer_cancel = function()
			if G.CHOOSE_CARD then
				G.CHOOSE_CARD:remove()
			end
			G.GAME.USING_CODE = false
			G.GAME.USING_POINTER = false
			G.DEBUG_POINTER = false
		end
		G.FUNCS.pointer_apply_previous = function()
			if G.PREVIOUS_ENTERED_CARD then
				G.ENTERED_CARD = G.PREVIOUS_ENTERED_CARD or ""
			end
			G.FUNCS.pointer_apply()
		end
		G.FUNCS.pointer_apply = function()
			local function apply_lower(strn)
				if type(strn) ~= string then -- safety
					strn = tostring(strn)
				end
				-- Remove content within {} and any remaining spaces
				strn = strn:gsub("%b{}", ""):gsub("%s+", "")
				--this weirdness allows you to get m and M separately
				if string.len(strn) == 1 then
					return strn
				end
				return string.lower(strn)
			end
			local current_card -- j_cry_dropshot
			local entered_card = G.ENTERED_CARD
			local valid_check = {}
			G.PREVIOUS_ENTERED_CARD = G.ENTERED_CARD
			current_card = Cryptid.pointergetalias(entered_card) or nil
			valid_check = Cryptid.pointergetblist(current_card)
			if not valid_check[3] then
				current_card = nil
			end
			--if enhancement has a suit or rank override, override above and make nil, so it can proceed with playing card creation
			if current_card ~= nil and string.sub(current_card, 1, 1) == "m" then
				if
					G.P_CENTERS[current_card] and G.P_CENTERS[current_card].specific_suit
					or G.P_CENTERS[current_card].specific_rank
				then
					current_card = nil
				end
			end

			if current_card then -- non-playing card cards
				local created = false -- Joker check
				if not valid_check[1] and valid_check[2] == "Joker" and valid_check[3] then
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, current_card)
					card:add_to_deck()
					G.jokers:emplace(card)
					created = true
				end
				if -- Consumeable check
					not valid_check[1]
					and valid_check[2] == "Consumeable"
					and valid_check[3]
				then
					local card = create_card("Consumeable", G.consumeables, nil, nil, nil, nil, current_card)
					if card.ability.name and card.ability.name == "cry-Chambered" then
						card.ability.extra.num_copies = 1
					end
					card:add_to_deck()
					G.consumeables:emplace(card)
					created = true
				end
				if -- Voucher check
					not valid_check[1]
					and valid_check[2] == "Voucher"
					and valid_check[3]
				then
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
					local card = create_card("Voucher", area, nil, nil, nil, nil, current_card)
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
					created = true
				end
				if -- Booster check
					not valid_check[1]
					and valid_check[2] == "Booster"
					and valid_check[3]
				then
					local card = create_card("Booster", G.hand, nil, nil, nil, nil, current_card)
					card.cost = 0
					card.from_tag = true
					G.FUNCS.use_card({ config = { ref_table = card } })
					card:start_materialize()
					created = true
				end
				if created then
					if G.CHOOSE_CARD then
						G.CHOOSE_CARD:remove()
					end
					G.GAME.USING_CODE = false
					G.GAME.USING_POINTER = false
					G.DEBUG_POINTER = false
					return true
				end
			end

			for i, v in pairs(G.P_TAGS) do -- TAGS
				local blacklist = Cryptid.pointergetblist(i)
				-- gonna be real w/ you idk why pointergetblist is a table now so im just gonna check if everything in it is falsey
				local can_spawn = true
				for _, val in pairs(blacklist) do
					can_spawn = can_spawn and not val
				end

				if Cryptid.pointergetalias(i) and can_spawn then
					if v.name and apply_lower(entered_card) == apply_lower(v.name) then
						current_card = i
						break --no clue why this wasn't done before, you can't create 2 tags with one pointer
					end
					if apply_lower(entered_card) == apply_lower(i) then
						current_card = i
						break
					end
					if
						apply_lower(entered_card) == apply_lower(localize({ type = "name_text", set = v.set, key = i }))
					then
						current_card = i
						break
					end
				end
			end

			if
				current_card
				and (G.DEBUG_POINTER or (not G.P_CENTERS[current_card] and not G.GAME.banned_keys[current_card]))
			then
				local created = false
				local t = Tag(current_card, nil, "Big")
				add_tag(t)
				if current_card == "tag_orbital" then
					local _poker_hands = {}
					for k, v in pairs(G.GAME.hands) do
						if v.visible then
							_poker_hands[#_poker_hands + 1] = k
						end
					end
					t.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("cry_pointer_orbital"))
				end
				if current_card == "tag_cry_rework" then
					--tbh this is the most unbalanced part of the card
					t.ability.rework_edition =
						pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("cry_pointer_edition")).key
					t.ability.rework_key =
						pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed("cry_pointer_joker")).key
				end
				G.CHOOSE_CARD:remove()
				G.GAME.USING_CODE = false
				G.GAME.USING_POINTER = false
				G.DEBUG_POINTER = false
				return
			end
			for i, v in pairs(G.P_BLINDS) do
				if Cryptid.pointergetalias(i) and not Cryptid.pointergetblist(i) then
					if v.name and apply_lower(entered_card) == apply_lower(v.name) then
						current_card = i
					end
					if apply_lower(entered_card) == apply_lower(i) then
						current_card = i
					end
					if
						apply_lower(entered_card)
						== apply_lower(localize({ type = "name_text", set = "Blind", key = i }))
					then
						current_card = i
					end
				end
			end
			if
				current_card
				and not G.P_CENTERS[current_card]
				and not G.P_TAGS[current_card]
				and (G.DEBUG_POINTER or not Cryptid.pointergetblist(current_card))
			then
				local created = false
				if not G.GAME.blind or (G.GAME.blind.name == "" or not G.GAME.blind.blind_set) then
					--from debugplus
					local par = G.blind_select_opts.boss.parent
					G.GAME.round_resets.blind_choices.Boss = current_card

					G.blind_select_opts.boss:remove()
					G.blind_select_opts.boss = UIBox({
						T = { par.T.x, 0, 0, 0 },
						definition = {
							n = G.UIT.ROOT,
							config = {
								align = "cm",
								colour = G.C.CLEAR,
							},
							nodes = {
								UIBox_dyn_container(
									{ create_UIBox_blind_choice("Boss") },
									false,
									get_blind_main_colour("Boss"),
									mix_colours(G.C.BLACK, get_blind_main_colour("Boss"), 0.8)
								),
							},
						},
						config = {
							align = "bmi",
							offset = {
								x = 0,
								y = G.ROOM.T.y + 9,
							},
							major = par,
							xy_bond = "Weak",
						},
					})
					par.config.object = G.blind_select_opts.boss
					par.config.object:recalculate()
					G.blind_select_opts.boss.parent = par
					G.blind_select_opts.boss.alignment.offset.y = 0

					for i = 1, #G.GAME.tags do
						if G.GAME.tags[i]:apply_to_run({
							type = "new_blind_choice",
						}) then
							break
						end
					end
					created = true
				else
					G.GAME.blind:set_blind(G.P_BLINDS[current_card])
					ease_background_colour_blind(G.STATE)
					created = true
				end
				if created then
					G.CHOOSE_CARD:remove()
					G.GAME.USING_CODE = false
					G.GAME.USING_POINTER = false
					G.DEBUG_POINTER = false
					return true
				end
			end
			if not current_card then -- if card isn't created yet, try playing cards
				local words = {}
				for i in string.gmatch(string.lower(entered_card), "%S+") do -- not using apply_lower because we actually want the spaces here
					table.insert(words, i)
				end

				local rank_table = {
					{ "stone" },
					{ "2", "Two", "II" },
					{ "3", "Three", "III" },
					{ "4", "Four", "IV" },
					{ "5", "Five", "V" },
					{ "6", "Six", "VI" },
					{ "7", "Seven", "VII" },
					{ "8", "Eight", "VIII" },
					{ "9", "Nine", "IX" },
					{ "10", "1O", "Ten", "X", "T" },
					{ "J", "Jack" },
					{ "Q", "Queen" },
					{ "K", "King" },
					{ "A", "Ace", "One", "1", "I" },
					{ "Abstract", "Abstracted", "TADC" },
				} -- ty variable
				local _rank = nil
				for m = #words, 1, -1 do -- the legendary TRIPLE LOOP, checking from end since rank is most likely near the end
					for i, v in pairs(rank_table) do
						for j, k in pairs(v) do
							if words[m] == string.lower(k) then
								_rank = i
								break
							end
						end
						if _rank then
							break
						end
					end
					if _rank then
						break
					end
				end
				if _rank then -- a playing card is going to get created at this point, but we can find additional descriptors
					local suit_table = {
						["Spades"] = { "spades" },
						["Hearts"] = { "hearts" },
						["Clubs"] = { "clubs" },
						["Diamonds"] = { "diamonds" },
					}
					for k, v in pairs(SMODS.Suits) do
						local index = v.key
						local current_name = G.localization.misc.suits_plural[index]
						if not suit_table[v.key] then
							suit_table[v.key] = { string.lower(current_name) }
						end
					end
					-- i'd rather be pedantic and not forgive stuff like "spade", there's gonna be a lot of checks
					-- can change that if need be
					local enh_table = {
						["m_lucky"] = { "lucky" },
						["m_mult"] = { "mult" },
						["m_bonus"] = { "bonus" },
						["m_wild"] = { "wild" },
						["m_steel"] = { "steel" },
						["m_glass"] = { "glass" },
						["m_gold"] = { "gold" },
						["m_stone"] = { "stone" },
						["m_cry_echo"] = { "echo" },
						["m_cry_abstract"] = { "abstract" },
					}
					for k, v in pairs(G.P_CENTER_POOLS.Enhanced) do
						local index = v.key
						local current_name = G.localization.descriptions.Enhanced[index].name
						current_name = current_name:gsub(" Card$", "")
						if not enh_table[v.key] then
							enh_table[v.key] = { string.lower(current_name) }
						end
					end
					local ed_table = {
						["e_base"] = { "base" },
						["e_foil"] = { "foil" },
						["e_holo"] = { "holo" },
						["e_polychrome"] = { "polychrome" },
						["e_negative"] = { "negative" },
						["e_cry_mosaic"] = { "mosaic" },
						["e_cry_oversat"] = { "oversat" },
						["e_cry_glitched"] = { "glitched" },
						["e_cry_astral"] = { "astral" },
						["e_cry_blur"] = { "blurred" },
						["e_cry_gold"] = { "golden" },
						["e_cry_glass"] = { "fragile" },
						["e_cry_m"] = { "jolly" },
						["e_cry_noisy"] = { "noisy" },
						["e_cry_double_sided"] = { "double-sided", "double_sided", "double" }, -- uhhh sure
					}
					for k, v in pairs(G.P_CENTER_POOLS.Edition) do
						local index = v.key
						local current_name = G.localization.descriptions.Edition[index].name
						if not ed_table[v.key] then
							ed_table[v.key] = { string.lower(current_name) }
						end
					end
					local seal_table = {
						["Red"] = { "red" },
						["Blue"] = { "blue" },
						["Purple"] = { "purple" },
						["Gold"] = { "gold", "golden" }, -- don't worry we're handling seals differently
						["cry_azure"] = { "azure" },
						["cry_green"] = { "green" },
					}
					local sticker_table = {
						["eternal"] = { "eternal" },
						["perishable"] = { "perishable" },
						["rental"] = { "rental" },
						["pinned"] = { "pinned" },
						["banana"] = { "banana" }, -- no idea why this evades prefixing
						["cry_rigged"] = { "rigged" },
						["cry_global_sticker"] = { "global" },
						["cry_flickering"] = { "flickering" },
						["cry_possessed"] = { "possessed" },
						["cry_absolute"] = { "absolute" },
					}
					local function parsley(_table, _word)
						for i, v in pairs(_table) do
							for j, k in pairs(v) do
								if _word == string.lower(k) then
									return i
								end
							end
						end
						return ""
					end
					local function to_rank(rrank)
						if rrank <= 10 then
							return tostring(rrank)
						elseif rrank == 11 then
							return "Jack"
						elseif rrank == 12 then
							return "Queen"
						elseif rrank == 13 then
							return "King"
						elseif rrank == 14 then
							return "Ace"
						end
					end

					-- ok with all that fluff out the way now we can figure out what on earth we're creating

					local _seal_att = false
					local _suit = ""
					local _enh = ""
					local _ed = ""
					local _seal = ""
					local _stickers = {}
					for m = #words, 1, -1 do
						-- we have a word. figure out what that word is
						-- this is dodgy spaghetti but w/ever
						local wword = words[m]
						if _suit == "" then
							_suit = parsley(suit_table, wword)
						end
						if _enh == "" then
							_enh = parsley(enh_table, wword)
							if _enh == "m_gold" and _seal_att == true then
								_enh = ""
							end
						end
						if _ed == "" then
							_ed = parsley(ed_table, wword)
							if _ed == "e_cry_gold" and _seal_att == true then
								_ed = ""
							end
						end
						if _seal == "" then
							_seal = parsley(seal_table, wword)
							if _seal == "Gold" and _seal_att == false then
								_seal = ""
							end
						end
						local _st = parsley(sticker_table, wword)
						if _st then
							_stickers[#_stickers + 1] = _st
						end
						if wword == "seal" or wword == "sealed" then
							_seal_att = true
						else
							_seal_att = false
						end -- from end so the next word should describe the seal
					end

					-- now to construct the playing card
					-- i'm doing this by applying everything but maybe it's a bit janky?

					G.CHOOSE_CARD:remove()
					G.GAME.USING_CODE = false
					G.GAME.USING_POINTER = false
					G.DEBUG_POINTER = false

					G.E_MANAGER:add_event(Event({
						func = function()
							G.playing_card = (G.playing_card and G.playing_card + 1) or 1
							local _card = create_card("Base", G.play, nil, nil, nil, nil, nil, "pointer")
							SMODS.change_base(
								_card,
								_suit ~= "" and _suit
									or pseudorandom_element(
										{ "Spades", "Hearts", "Diamonds", "Clubs" },
										pseudoseed("sigil")
									),
								_rank > 1 and to_rank(_rank) or nil
							)
							if _enh ~= "" then
								_card:set_ability(G.P_CENTERS[_enh])
							end
							if _rank == 1 then
								_card:set_ability(G.P_CENTERS["m_stone"])
							end
							--Abstracted
							if
								_rank == 15
								or string.lower(_suit) == "abstract"
								or string.lower(_suit) == "abstracted"
							then
								_card:set_ability(G.P_CENTERS["m_cry_abstract"])
							end
							if _seal ~= "" then
								_card:set_seal(_seal, true, true)
							end
							if _ed ~= "" then
								_card:set_edition(_ed, true, true)
							end
							for i = 1, #_stickers do
								_card.ability[_stickers[i]] = true
								if _stickers[i] == "pinned" then
									_card.pinned = true
								end
							end
							_card:start_materialize()
							G.play:emplace(_card)
							table.insert(G.playing_cards, _card)
							playing_card_joker_effects({ _card })
							return true
						end,
					}))
					G.E_MANAGER:add_event(Event({
						func = function()
							G.deck.config.card_limit = G.deck.config.card_limit + 1
							return true
						end,
					}))
					draw_card(G.play, G.deck, 90, "up", nil)
					return true
				end
			end
		end
	end,
}

local aliases = {
	---- Vanilla Cards
	-- Vanilla Jokers
	j_joker = {
		"Joker",
		"Jimbo",
	},
	j_greedy_joker = {
		"Greedy Joker",
		"Diamond Joker",
	},
	j_lusty_joker = {
		"Lusty Joker",
		"Horny Joker",
		"Heart Joker",
	},
	j_wrathful_joker = {
		"Wrathful Joker",
		"Spade Joker",
	},
	j_gluttenous_joker = {
		"Gluttonous Joker",
		"Fatass Joker",
		"Fat Ass Joker",
		"Big Back",
		"Big Back Joker",
		"Club Joker",
	},
	j_jolly = {
		"Jolly Joker",
		"Joseph, J. Joker",
		"Pair Mult",
	},
	j_zany = {
		"Zany Joker",
		"Zany",
	},
	j_mad = {
		"Mad Joker",
		"Mad",
	},
	j_crazy = {
		"Crazy Joker",
		"Crazy",
	},
	j_droll = {
		"Droll Joker",
		"Droll",
	},
	j_sly = {
		"Sly Joker",
		"Sly",
	},
	j_wily = {
		"Wily Joker",
		"Wily",
	},
	j_clever = {
		"Clever Joker",
		"Clever",
	},
	j_devious = {
		"Devious Joker",
		"Devious",
	},
	j_crafty = {
		"Crafty Joker",
		"Crafty",
	},
	j_half = {
		"Half Joker",
		"Semi Joker",
	},
	j_stencil = {
		"Joker Stencil",
		"Stencil",
	},
	j_four_fingers = {
		"Four Fingers",
		"4 Fingers",
		"Fourfingers",
		"4fingers",
	},
	j_mime = {
		"Mime",
	},
	j_credit_card = {
		"Credit Card",
		"Debit Card",
	},
	j_ceremonial = {
		"Ceremonial Dagger",
		"Dagger",
	},
	j_banner = {
		"Banner",
	},
	j_mystic_summit = {
		"Mystic Summit",
	},
	j_marble = {
		"Marble Joker",
		"Lexi",
	},
	j_loyalty_card = {
		"Loyalty Card",
	},
	j_8_ball = {
		"8 Ball",
		"8-Ball",
		"Eight Ball",
		"Eightball",
	},
	j_misprint = {
		"Misprint",
	},
	j_dusk = {
		"Dusk",
	},
	j_raised_fist = {
		"Raised Fist",
		"1984",
	},
	j_chaos = {
		"Chaos the Clown",
	},
	j_fibonacci = {
		"Fibonacci",
		"Fibbonaci",
		"Fibonnaci",
	},
	j_steel_joker = {
		"Steel Joker",
	},
	j_scary_face = {
		"Scary Face",
		"Spooky Face",
	},
	j_abstract = {
		"Abstract Joker",
	},
	j_delayed_grat = {
		"Delayed Gratification",
		"Delayed Grat",
	},
	j_hack = {
		"Hack",
	},
	j_pareidolia = {
		"Pareidolia",
		"All Face Cards",
		"Pariedolia",
	},
	j_gros_michel = {
		"Gros Michel",
		"Banana",
	},
	j_even_steven = {
		"Even Steven",
		"Steven",
	},
	j_odd_todd = {
		"Odd Todd",
		"Todd",
	},
	j_scholar = {
		"Scholar",
		"Dr Spectred",
		"Dr. Spectred",
		"drspectred",
		"Balatro University",
		"Balatro University Joker",
		"Balatro Uni",
	},
	j_business = {
		"Business Card",
	},
	j_supernova = {
		"Supernova",
	},
	j_ride_the_bus = {
		"Ride the Bus",
		"Bus",
	},
	j_space = {
		"Space Joker",
	},
	j_egg = {
		"Egg",
		"Egg Joker",
	},
	j_burglar = {
		"Burglar",
	},
	j_blackboard = {
		"Blackboard",
	},
	j_runner = {
		"Runner",
	},
	j_ice_cream = {
		"Ice Cream",
	},
	j_dna = {
		"DNA",
	},
	j_splash = {
		"Splash",
		"Wet Joker",
	},
	j_blue_joker = {
		"Blue Joker",
	},
	j_sixth_sense = {
		"Sixth Sense",
		"6th Sense",
	},
	j_constellation = {
		"Constellation",
	},
	j_hiker = {
		"Hiker",
	},
	j_faceless = {
		"Faceless Joker",
	},
	j_green_joker = {
		"Green Joker",
		"Grimbo",
	},
	j_superposition = {
		"Superposition",
	},
	j_todo_list = {
		"To Do List",
		"Todo List",
		"To-Do List",
	},
	j_cavendish = {
		"Cavendish",
		"Glitch",
	},
	j_card_sharp = {
		"Card Sharp",
	},
	j_red_card = {
		"Red Card",
	},
	j_madness = {
		"Madness",
	},
	j_square = {
		"Square Joker",
	},
	j_seance = {
		"Seance",
	},
	j_riff_raff = {
		"Riff-raff",
		"Riff Raff",
		"RiffRaff",
	},
	j_vampire = {
		"Vampire",
	},
	j_shortcut = {
		"Shortcut",
	},
	j_hologram = {
		"Hologram",
	},
	j_vagabond = {
		"Vagabond",
	},
	j_baron = {
		"Baron",
	},
	j_cloud_9 = {
		"Cloud 9",
		"Murphy's Favorite",
		"Murphy Favorite",
		"Murphys Favorite",
		"Murphy Fav",
	},
	j_rocket = {
		"Rocket",
	},
	j_obelisk = {
		"Obelisk",
	},
	j_midas_mask = {
		"Midas Mask",
	},
	j_luchador = {
		"Luchador",
	},
	j_photograph = {
		"Photograph",
		"Photo",
	},
	j_gift = {
		"Gift Card",
	},
	j_turtle_bean = {
		"Turtle Bean",
		"Bean",
	},
	j_erosion = {
		"Erosion",
	},
	j_reserved_parking = {
		"Reserved Parking",
	},
	j_mail = {
		"Mail-In Rebate",
		"Mail In Rebate",
		"Rebate",
		"Mail Rebate",
	},
	j_to_the_moon = {
		"To the Moon",
	},
	j_hallucination = {
		"Hallucination",
	},
	j_fortune_teller = {
		"Fortune Teller",
	},
	j_juggler = {
		"Juggler",
		"+1 hand size",
	},
	j_drunkard = {
		"Drunkard",
		"+1 Discard",
	},
	j_stone = {
		"Stone Joker",
	},
	j_golden = {
		"Golden Joker",
	},
	j_lucky_cat = {
		"Lucky Cat",
	},
	j_baseball = {
		"Baseball Card",
		"Baseball Huh?",
	},
	j_bull = {
		"Bull",
	},
	j_diet_cola = {
		"Diet Cola",
		"Cola",
		"Tag Soda",
		"Tag Cola",
	},
	j_trading = {
		"Trading Card",
	},
	j_flash = {
		"Flash Card",
	},
	j_popcorn = {
		"Popcorn",
	},
	j_trousers = {
		"Spare Trousers",
	},
	j_ancient = {
		"Ancient Joker",
		"Anceint Joker",
	},
	j_ramen = {
		"Ramen",
	},
	j_walkie_talkie = {
		"Walkie Talkie",
	},
	j_selzer = {
		"Seltzer",
	},
	j_castle = {
		"Castle",
	},
	j_smiley = {
		"Smiley Face",
		"Smiley",
	},
	j_campfire = {
		"Campfire",
	},
	j_ticket = {
		"Golden Ticket",
		"Gold Ticket",
	},
	j_mr_bones = {
		"Mr. Bones",
		"Mr Bones",
	},
	j_acrobat = {
		"Acrobat",
	},
	j_sock_and_buskin = {
		"Sock and Buskin",
	},
	j_swashbuckler = {
		"Swashbuckler",
	},
	j_troubadour = {
		"Troubadour",
	},
	j_certificate = {
		"Certificate",
	},
	j_smeared = {
		"Smeared Joker",
		"Smeared",
	},
	j_throwback = {
		"Throwback",
	},
	j_hanging_chad = {
		"Hanging Chad",
	},
	j_rough_gem = {
		"Rough Gem",
	},
	j_bloodstone = {
		"Bloodstone",
	},
	j_arrowhead = {
		"Arrowhead",
	},
	j_onyx_agate = {
		"Onyx Agate",
	},
	j_glass = {
		"Glass Joker",
	},
	j_ring_master = {
		"Showman",
	},
	j_flower_pot = {
		"Flower Pot",
	},
	j_blueprint = {
		"Blueprint",
		"BP",
	},
	j_wee = {
		"Wee Joker",
		"WEEEE",
		"Wee",
	},
	j_merry_andy = {
		"Merry Andy",
	},
	j_oops = {
		"Oops! All 6s",
		"OA6s",
		"OA6",
		"O A 6s",
		"Oops 6s",
		"Oops 6",
		"Oop 6s",
	},
	j_idol = {
		"The Idol",
		"Idol",
	},
	j_seeing_double = {
		"Seeing Double",
	},
	j_matador = {
		"Matador",
	},
	j_hit_the_road = {
		"Hit the Road",
	},
	j_duo = {
		"The Duo",
		"Duo",
	},
	j_trio = {
		"The Trio",
		"Trio",
	},
	j_family = {
		"The Family",
		"Family",
	},
	j_order = {
		"The Order",
		"Order",
	},
	j_tribe = {
		"The Tribe",
		"Tribe",
	},
	j_stuntman = {
		"Stuntman",
	},
	j_invisible = {
		"Invisible Joker",
		"Invisible",
	},
	j_brainstorm = {
		"Brainstorm",
	},
	j_satellite = {
		"Satellite",
	},
	j_shoot_the_moon = {
		"Shoot the Moon",
	},
	j_drivers_license = {
		"Driver's License",
	},
	j_cartomancer = {
		"Cartomancer",
	},
	j_astronomer = {
		"Astronomer",
	},
	j_burnt = {
		"Burnt Joker",
	},
	j_bootstraps = {
		"Bootstraps",
	},
	j_caino = {
		"Caino",
	},
	j_triboulet = {
		"Triboulet",
	},
	j_yorick = {
		"Yorick",
	},
	j_chicot = {
		"Chicot",
	},
	j_perkeo = {
		"Perkeo",
	},

	-- Vanilla Tarots
	c_fool = {
		"The Fool",
		"Fool",
	},
	c_high_priestess = {
		"The High Priestess",
		"High Priestess",
	},
	c_empress = {
		"The Empress",
		"Empress",
		"Mult Tarot",
	},
	c_emperor = {
		"The Emperor",
		"Emperor",
	},
	c_heirophant = {
		"The Hierophant",
		"Hierophant",
		"The Heirophant",
		"Heirophant",
		"Bonus Tarot",
	},
	c_lovers = {
		"The Lovers",
		"Lovers",
		"Wild Tarot",
	},
	c_chariot = {
		"The Chariot",
		"Chariot",
		"Steel Tarot",
	},
	c_justice = {
		"Justice",
		"Glass Tarot",
	},
	c_hermit = {
		"The Hermit",
		"Hermit",
		"Doubles Money",
	},
	c_wheel_of_fortune = {
		"The Wheel Of Fortune",
		"Wheel Of Fortune",
		"tWoF",
		"WoF",
		"Gambling",
		"Wheel",
	},
	c_strength = {
		"Strength",
	},
	c_hanged_man = {
		"The Hanged Man",
		"Hanged Man",
		"Hang Man",
		"Hung Man",
	},
	c_death = {
		"Death",
		"Turn The Left Card Into The Right Card",
	},
	c_temperance = {
		"Temperance",
		"The Temperance",
		"Joker Money",
	},
	c_devil = {
		"The Devil",
		"Devil",
		"Gold Tarot",
	},
	c_tower = {
		"The Tower",
		"Tower",
		"Stone Tarot",
	},
	c_star = {
		"The Star",
		"Star",
		"Diamond Tarot",
	},
	c_moon = {
		"The Moon",
		"Moon",
		"Club Tarot",
	},
	c_sun = {
		"The Sun",
		"Sun",
		"Heart Tarot",
	},
	c_judgement = {
		"Judgement",
		"The Judgement",
		"Judgement Day",
		"Minos Prime",
	},
	c_world = {
		"The World",
		"World",
		"Spade Tarot",
	},

	-- Vanilla Planets
	c_mercury = {
		"Mercury",
		"Merc",
		"M planet",
		"Mlanet",
		"Pair",
		"2oak",
	},
	c_venus = {
		"Venus",
		"3 planet",
		"3oak",
		"Aphrodite",
		"Penus",
	},
	c_earth = {
		"Earth",
		"Terra",
		"3+2",
		"Gaia",
		"Hell",
		"Here",
		"erth",
		"erf",
		"Full House",
		"1987 Sitcom by Jeff Franklin",
		"Spawn",
		"Spawnpoint",
	},
	c_mars = {
		"Mars",
		"4oak",
		"Not 2 Pairs",
		"Ares",
		"Red Planet",
	},
	c_jupiter = {
		"Jupiter",
		"Flush",
		"The big one",
		"Zeus",
	},
	c_saturn = {
		"Saturn",
		"Straight",
		"Chronos",
		"Rings",
	},
	c_uranus = {
		"Uranus",
		"Uranus but in greek",
		"2 pair",
		"22",
		"anus",
		"haha get it cuz uranus is like ur-anus and anus means butt so its funny come on guys please laugh",
	},
	c_neptune = {
		"Neptune",
		"Neptunus",
		"Poseidon",
		"Straight Flush",
		"Slush",
		"Royal",
	},
	c_pluto = {
		"Pluto",
		"Hades",
		"1oak",
		"One",
		"High Card",
		"Not Planet",
		"Dwarf",
	},
	c_planet_x = {
		"Planet X",
		"5oak",
		"Twitter",
		"Five Guys",
	},
	c_ceres = {
		"Ceres",
		"Demeter",
		"Flush House",
		"Reaper",
	},
	c_eris = {
		"Eris",
		"fish",
		"Flush Five",
		"F5",
	},

	-- Vanilla Spectrals
	c_familiar = {
		"Familiar",
		"The Familiar",
	},
	c_grim = {
		"Grim",
		"The Grim",
	},
	c_incantation = {
		"Incantation",
		"The Incantation",
		"Consumable Stacker",
		"Incant",
		"Inct",
		"Inc",
	},
	c_talisman = {
		"Talisman",
		"The Talisman",
		"Bignum mod",
		"Omeganum mod",
		"Skip Animations",
		"Skip Anim",
		"Talis",
		"Tali",
	},
	c_aura = {
		"Aura",
		"The Aura",
		"WoF 2",
	},
	c_wraith = {
		"Wraith",
		"The Wraith",
		"Obelisk Spawner 2",
		"Wrath",
	},
	c_sigil = {
		"Sigil",
		"The Sigil",
		"Suit Equalizer",
	},
	c_ouija = {
		"Ouija",
		"The Ouija",
		"Ouija Board",
		"Weegee",
	},
	c_ectoplasm = {
		"Ectoplasm",
		"The Ectoplasm",
		"White Glop",
		"Ghost Matter",
		"Ecto",
		"Plasm",
		"One Negative Popcorn Pretty Please",
	},
	c_immolate = {
		"Immolate",
		"Imolate",
		"The Immolate",
		"The Imolate",
		"Immolation",
		"Immolator",
		"Oh Boy 20 Dollars",
	},
	c_ankh = {
		"Ankh",
		"Life",
		"Egyptian Cross",
	},
	c_deja_vu = {
		"Deja vu",
		"Deja vu",
		"Deja",
		"vu",
		"Again!",
		"Deja vu",
		"Deja vu",
	},
	c_hex = {
		"Hex",
		"The Hex",
		"Vex",
		"This Hexes Me",
	},
	c_trance = {
		"Trance",
		"The Trance",
		"Transe",
		"Trans",
		"Trams",
	},
	c_medium = {
		"Medium",
		"The Medium",
		"Ourple",
	},
	c_cryptid = {
		"Cryptid",
		"The Cryptid",
		"+2",
		"The Mod",
		"Cry",
	},
	c_soul = {
		"Soul",
		"The Soul",
		"Jazz",
		"Spirit",
		"Legendary",
		"White Rock",
		"Blank Rune",
	},
	c_black_hole = {
		"Black Hole",
		"The Black Hole",
		"Bhole",
		"Oprah",
	},

	-- Vanilla Booster Packs
	p_arcana_normal_1 = {
		"Arcana Pack",
		"Arcana Fool",
		"Arcana Pack 1",
	},
	p_arcana_normal_2 = {
		"Arcana",
		"Arcana Temperance",
		"Arcana Pack 2",
	},
	p_arcana_normal_3 = {
		"Arcana Hierophant",
		"Arcana Pack 3",
	},
	p_arcana_normal_4 = {
		"Arcana World",
		"Arcana Pack 4",
	},
	p_arcana_jumbo_1 = {
		"Jumbo Arcana",
		"Jumbo Arcana Pack",
		"Arcana Death",
		"Jumbo Arcana 1",
		"Jumbo Arcana Pack 1",
	},
	p_arcana_jumbo_2 = {
		"Arcana Emperor",
		"Jumbo Arcana 2",
		"Jumbo Arcana Pack 2",
	},
	p_arcana_mega_1 = {
		"Mega Arcana",
		"Mega Arcana Pack",
		"Arcana Tower",
		"Mega Arcana 1",
		"Mega Arcana Pack 1",
	},
	p_arcana_mega_2 = {
		"Arcana Hermit",
		"Mega Arcana 2",
		"Mega Arcana Pack 2",
	},

	p_celestial_normal_1 = {
		"Celestial Pack",
		"Celestial Mercury",
		"Celestial Pack 1",
	},
	p_celestial_normal_2 = {
		"Celestial",
		"Celestial Jupiter",
		"Celestial Pack 2",
	},
	p_celestial_normal_3 = {
		"Celestial Earth",
		"Celestial Pack 3",
	},
	p_celestial_normal_4 = {
		"Celestial Uranus",
		"Celestial Pack 4",
	},
	p_celestial_jumbo_1 = {
		"Jumbo Celestial",
		"Jumbo Celestial Pack",
		"Celestial Mars",
		"Jumbo Celestial 1",
		"Jumbo Celestial Pack 1",
	},
	p_celestial_jumbo_2 = {
		"Celestial Pluto",
		"Jumbo Celestial 2",
		"Jumbo Celestial Pack 2",
	},
	p_celestial_mega_1 = {
		"Mega Celestial",
		"Mega Celestial Pack",
		"Celestial Saturn",
		"Mega Celestial 1",
		"Mega Celestial Pack 1",
	},
	p_celestial_mega_2 = {
		"Celestial Venus",
		"Mega Celestial 2",
		"Mega Celestial Pack 2",
	},
	p_standard_normal_1 = {
		"Standard Pack",
		"Standard Pack 1",
	},
	p_standard_normal_2 = {
		"Standard",
		"Standard Pack 2",
	},
	p_standard_normal_3 = {
		"Standard Pack 3",
	},
	p_standard_normal_4 = {
		"Standard Pack 4",
	},
	p_standard_jumbo_1 = {
		"Jumbo Standard",
		"Jumbo Standard Pack",
		"Jumbo Standard 1",
		"Jumbo Standard Pack 1",
	},
	p_standard_jumbo_2 = {
		"Jumbo Standard 2",
		"Jumbo Standard Pack 2",
	},
	p_standard_mega_1 = {
		"Mega Standard",
		"Mega Standard Pack",
		"Mega Standard 1",
		"Mega Standard Pack 1",
	},
	p_standard_mega_2 = {
		"Mega Standard 2",
		"Mega Standard Pack 2",
	},
	p_buffoon_normal_1 = {
		"Buffoon Pack",
		"Buffoon Hack",
		"Buffoon Pack 1",
	},
	p_buffoon_normal_2 = {
		"Jimbo Pack",
		"Buffoon",
		"Buffoon Juggler",
		"Buffoon Pack 2",
	},
	p_buffoon_jumbo_1 = {
		"Jumbo Jimbo",
		"Jumbo Jimbo Pack",
		"Buffoon Banner",
		"Jumbo Buffoon",
		"Jumbo Buffoon Pack",
	},
	p_buffoon_mega_1 = {
		"Mega Jimbo",
		"Mega Jimbo Pack",
		"Buffoon Brainstom",
		"Mega Buffoon",
		"Mega Buffoon Pack",
	},
	p_spectral_normal_1 = {
		"Spectral Pack",
		"Spectral Grim",
		"Spectral Pack 1",
	},
	p_spectral_normal_2 = {
		"Spectral",
		"Spectral Pack 2",
	},
	p_spectral_jumbo_1 = {
		"Jumbo Spectral",
		"Spectral Incantation",
		"Jumbo Spectral Pack",
	},
	p_spectral_mega_1 = {
		"Mega Spectral",
		"Spectral Ectoplasm",
		"Mega Spectral Pack",
	},

	-- Vanilla Tags
	-- everybody forgor
	tag_uncommon = {
		"Uncommon Tag",
		"Tag Uncommon",
	},
	tag_rare = {
		"Rare Tag",
		"Tag Rare",
	},
	tag_negative = {
		"Negative Tag",
		"Tag Negative",
	},
	tag_foil = {
		"Foil Tag",
		"Tag Foil",
	},
	tag_holo = {
		"Holo Tag",
		"Tag Holo",
		"Holographic Tag",
		"Tag Holographic",
	},
	tag_polychrome = {
		"Polychrome Tag",
		"Tag Polychrome",
	},
	tag_investment = {
		"Investment Tag",
		"Tag Investment",
		"Invest Tag",
		"Tag Invest",
		"Investment",
	},
	tag_voucher = {
		"Voucher Tag",
		"Tag Voucher",
		"Vouch Tag",
	},
	tag_boss = {
		"Boss Tag",
		"Tag Boss",
	},
	tag_standard = {
		"Standard Tag",
		"Tag Standard",
	},
	tag_charm = {
		"Charm Tag",
		"Tag Charm",
		"Tarot Tag",
		"Acrana Tag",
		"Arcana Tag",
		"Tag Tarot",
		"Tag Arcana",
		"Charm Pack Tag",
		"Tarot Pack Tag",
		"Arcana Pack Tag",
		"Acrana Pack Tag",
	},
	tag_meteor = {
		"Meteor Tag",
		"Tag Meteor",
		"Celestial Tag",
		"Tag Celestial",
		"Planet Tag",
		"Tag Planet",
		"Celestial Pack Tag",
		"Planet Pack Tag",
	},
	tag_buffoon = {
		"Buffoon Tag",
		"Tag Buffoon",
		"Joker Pack Tag",
		"Joker Tag",
		"Buffoon Pack Tag",
	},
	tag_handy = {
		"Handy Tag",
		"Tag Handy",
	},
	tag_garbage = {
		"Garbage Tag",
		"Tag Garbage",
		"Discard Tag",
		"Tag Discard",
	},
	tag_ethereal = {
		"Ethereal Tag",
		"Tag Ethereal",
		"Spectral Tag",
		"Tag Spectral",
	},
	tag_coupon = {
		"Coupon Tag",
		"Tag Coupon",
		"Free Tag",
		"Shop Tag Free",
		"Shop Free Tag",
		"Shop Tag",
	},
	tag_double = {
		"Double Tag",
		"Tag Double",
		"Extra Tag",
		"2 Tag",
	},
	tag_juggle = {
		"Juggle Tag",
		"Tag Juggle",
		"Juggler Tag",
		"Tag Juggler",
		"Hand Size Tag",
		"Tag Hand Size",
	},
	tag_d_six = {
		"D Six Tag",
		"Tag D Six",
		"D6 Tag",
		"Tag D6",
		"Reroll Tag",
		"Tag Reroll",
		"Rerolling Tag",
		"Tag Rerolling",
		"DSix Tag",
		"Tag DSix",
		"D6",
		"D 6",
		"D 6 Tag",
		"Tag D 6",
	},
	tag_top_up = {
		"Top Up Tag",
		"Tag Top Up",
		"Top Up",
		"2 common tag",
	},
	tag_skip = {
		"Skip Tag",
		"Tag Skip",
		"Skipping Tag",
		"Tag Skipping",
	},
	tag_orbital = {
		"Orbital Tag",
		"Tag Orbital",
		"Orbital",
		"Planet Tag",
	},
	tag_economy = {
		"Economy Tag",
		"Tag Economy",
		"Econ tag",
		"Eco tag",
		"money tag",
		"Tag Money",
		"Tag Econ",
		"Tag Eco",
	},
	-- Vanilla Vouchers

	v_overstock_norm = {
		"Overstock",
		"Over Stock",
	},
	v_overstock_plus = {
		"Overstock Plus",
		"Over Stock Plus",
		"Overstockplus",
		"Overstock+",
		"Overstock 2",
	},
	v_clearance_sale = {
		"Clearance Sale",
		"Clearancesale",
		"Clearance",
	},
	v_liquidation = {
		"Liquidation",
		"Clearance Sale+",
		"Clearance Sale Plus",
		"Clearance Sale 2",
	},
	v_hone = {
		"Hone",
	},
	v_glow_up = {
		"Glow Up",
		"Glow-Up",
		"Glowup",
		"Hone+",
		"Hone Plus",
		"Hone 2",
	},
	v_reroll_surplus = {
		"Reroll Surplus",
		"Rerollsurplus",
		"Reroll Voucher",
	},
	v_reroll_glut = {
		"Reroll Glut",
		"Rerollglut",
		"Reroll Surplus+",
		"Reroll Surplus Plus",
		"Reroll Surplus 2",
	},
	v_crystal_ball = {
		"Crystal Ball",
		"Crystalball",
		"Consumable Slot",
		"Consumable Voucher",
		"Consumable Slot Voucher",
	},
	v_omen_globe = {
		"Omen Globe",
		"Omenglobe",
		"Crystal Ball+",
		"Crystal Ball Plus",
		"Crystal Ball 2",
	},
	v_telescope = {
		"Telescope",
		"Teliscope",
	},
	v_observatory = {
		"Observatory",
		"Telescope+",
		"Telescope Plus",
		"Telescope 2",
		"Perkeo Voucher",
	},
	v_grabber = {
		"Grabber",
		"Hand Voucher",
	},
	v_nacho_tong = {
		"Nacho Tong",
		"Nachotong",
		"Grabber+",
		"Grabber Plus",
		"Grabber 2",
	},
	v_wasteful = {
		"Wasteful",
		"Discard Voucher",
	},
	v_recyclomancy = {
		"Recyclomancy",
		"Wasteful+",
		"Wasteful Plus",
		"Wasteful 2",
	},
	v_tarot_merchant = {
		"Tarot Merchant",
		"Tarotmerchant",
		"Tarot Voucher",
	},
	v_tarot_tycoon = {
		"Tarot Tycoon",
		"Tarot Merchant+",
		"Tarot Merchant Plus",
		"Tarot Merchant 2",
	},
	v_planet_merchant = {
		"Planet Merchant",
		"Planetmerchant",
		"Planet Voucher",
	},
	v_planet_tycoon = {
		"Planet Tycoon",
		"Planet Merchant+",
		"Planet Merchant Plus",
		"Planet Merchant 2",
	},
	v_seed_money = {
		"Seed Money",
		"Interest Voucher",
		"Seedmoney",
	},
	v_money_tree = {
		"Money Tree",
		"Moneytree",
		"Seed Money+",
		"Seed Money Plus",
		"Seed Money 2",
	},
	v_blank = {
		"Blank",
		"Blank Voucher",
		"Blank?",
		"Does Nothing",
	},
	v_antimatter = {
		"Antimatter",
		"Anti Matter",
		"Antematter",
		"Blank+",
		"Blank Plus",
		"Blank 2",
		"Joker Slot Voucher",
	},
	v_magic_trick = {
		"Magic Trick",
		"Magictrick",
		"Card Voucher",
		"Hologram Voucher",
	},
	v_illusion = {
		"Illusion",
		"Magic Trick+",
		"Magic Trick Plus",
		"Magic Trick 2",
	},
	v_hieroglyph = {
		"Hieroglyph",
		"Heiroglyph",
		"Hiroglyph",
	},
	v_petroglyph = {
		"Petroglyph",
		"Hieroglyph+",
		"Hieroglyph Plus",
		"Hieroglyph 2",
	},
	v_directors_cut = {
		"Director's Cut",
		"Directors Cut",
		"Directorscut",
	},
	v_retcon = {
		"Retcon",
		"Boss Reroll",
		"Director's Cut+",
		"Director's Cut Plus",
		"Director's Cut 2",
	},
	v_paint_brush = {
		"Paint Brush",
		"Paintbrush",
		"Hand Size Voucher",
	},
	v_palette = {
		"Palette",
		"Pallete",
		"Paint Brush+",
		"Paint Brush Plus",
		"Paint Brush 2",
	},

	---- Cryptid Cards
	-- M jokers
	j_cry_m = {
		"m",
		"lowercase m",
	},
	j_cry_mprime = {
		"Flesh Panopticon",
		"Minos Prime",
		"M Prime",
	},
	j_cry_M = {
		"M",
		"Capital M",
	},
	j_cry_bubblem = {
		"BubbleM",
		"Bubble M",
	},
	j_cry_foodm = {
		"McDonalds",
		"McDonald's",
		"Food M",
		"Fast Food M",
	},
	j_cry_mstack = {
		"Stack M",
		"M Stack",
	},
	j_cry_mneon = {
		"Neon M",
		"mneon",
	},
	j_cry_notebook = {
		"Notebook",
		"The Notebook",
		"The Motebook",
		"Motebook",
		"Noting this down",
		"Moting this down",
	},
	j_cry_bonk = {
		"Bonk",
	},
	j_cry_loopy = {
		"Loopy",
		"Loopy M",
	},
	j_cry_scrabble = {
		"Scrabble",
		"Scrabble Tile",
		"Scrabble M",
		"Letter M",
	},
	j_cry_sacrifice = {
		"Sacrifice",
	},
	j_cry_reverse = {
		"Uno Card",
		"Uno Reverse",
		"Reverse Card",
		"Uno Reverse Card",
		"Reverse Uno Card",
	},
	j_cry_longboi = {
		"Monster",
		"longboi",
		"long boi",
	},
	j_cry_megg = {
		"Megg",
		"Jolly Egg",
	},
	j_cry_macabre = {
		"Macabre",
		"Macabre Joker",
		"M Dagger",
	},
	j_cry_smallestm = {
		"Tiny",
		"Tiny M",
		"very small m",
		"teeny m",
	},
	j_cry_virgo = {
		"Virgo",
		"Virgin",
	},
	j_cry_doodlem = {
		"Doodle",
		"Doodle M",
		"The anniversary is back on!",
	},
	j_cry_jollysus = {
		"Jolly Joker?",
		"jolly sus",
		"blue sus",
		"sus jolly",
	},
	j_cry_biggestm = {
		"Huge",
		"Big Boned",
		"not fat",
		"Massive",
		"Huge M",
	},

	-- SpOoOky jokers
	j_cry_cotton_candy = {
		"Cotton Candy",
	},
	j_cry_wrapped = {
		"Wrapped Candy",
	},
	j_cry_chocolate_dice = {
		"Chocolate Dice",
		"Chocolate Die",
		"Choco Dice",
		"Choco Die",
	},
	j_cry_trick_or_treat = {
		"Trick or Treat",
		"Trickortreat",
		"Trick-or-Treat",
	},
	j_cry_candy_basket = {
		"Candy Basket",
	},
	j_cry_candy_dagger = {
		"Candy Dagger",
	},
	j_cry_candy_cane = {
		"Candy Cane",
	},
	j_cry_candy_buttons = {
		"Candy Buttons",
	},
	j_cry_jawbreaker = {
		"Jawbreaker",
	},
	j_cry_mellowcreme = {
		"Mellowcreme",
		"Mellowcream",
	},
	j_cry_brittle = {
		"Brittle Candy",
	},
	j_cry_candy_sticks = {
		"Candy Sticks",
	},
	j_cry_wonka_bar = {
		"Wonka Bar",
		"Wonka",
	},

	-- Cursed Jokers
	j_cry_blacklist = {
		"Blacklist",
	},
	j_cry_monopoly_money = {
		"Monopoly Money",
		"Monopoly",
	},

	-- Code Jokers (not code cards)
	j_cry_CodeJoker = {
		"Code Joker",
		"Codejoker",
	},
	j_cry_copypaste = {
		"Copy Paste",
		"Copy-Paste",
		"Copy/Paste",
		"Copypaste",
		"Copypasta",
	},
	j_cry_cut = {
		"Cut",
	},
	j_cry_blender = {
		"Blender",
	},
	j_cry_python = {
		"Python",
	},

	-- Secret Placeholder 1
	-- Smaller Placeholder

	-- Misc Jokers
	j_cry_oil_lamp = {
		"Oil Lamp",
		"Oillamp",
	},
	j_cry_tropical_smoothie = {
		"Tropical Smoothie",
		"Tropical",
		"Smoothie",
	},
	-- bigger placeholder

	-- Epic Jokers
	j_cry_altgoogol = {
		"Nostalgic Googol Play Card",
		"NGPC",
		"Nostalgic Googol",
		"Nostalgic Google Play Card",
	},
	-- epic placeholder

	-- Exotic Jokers
	-- exotic placeholder

	-- Cryptid Tarots
	-- placeholder for the like 5 there is

	-- Cryptid Planets
	c_cry_planetlua = {
		"Planet.lua",
		"Lua Planet",
	},
	c_cry_abelt = {
		"Asteroid Belt",
		"Bulwark",
	},
	c_cry_void = {
		"Void",
		"Clusterfuck",
		"Cluster",
	},
	c_cry_marsmoons = {
		"Mars Moons",
		"Phobos",
		"Phobos and Deimos",
		"Ultimate Pair",
	},
	c_cry_universe = {
		"Universe",
		"The Universe In Its Entirety",
		"The Universe In Its Fucking Entirety",
		"The Entire Deck",
		"The Entire Fucking Deck",
	},
	c_cry_nstar = {
		"Neutron Star",
		"Random Hand",
	},
	c_cry_sunplanet = {
		"Sol",
		"Sun Planet",
		"Ascended Hands",
		"Ascended Hand",
	},
	c_cry_Timantti = {
		"Ruutu",
		"Diamond Planet",
		"High Card Pair Two Pair",
	},
	c_cry_Klubi = {
		"Risti",
		"Club Planet",
		"Three of a Kind Straight Flush",
		"3oak Straight Flush",
	},
	c_cry_Sydan = {
		"Hertta",
		"Heart Planet",
		"Full House Four of a Kind Straight Flush",
		"Full House 4oak Straight Flush",
	},
	c_cry_Lapio = {
		"Pata",
		"Spade Planet",
		"Five of a Kind Flush House Flush Five",
		"5oak Flush House Flush Five",
	},
	c_cry_Kaikki = {
		"Kaikki",
		"Wild Planet",
		"Bulwark Clusterfuck Ultimate Pair",
		"Bulwark Cluster Ultimate Pair",
	},

	-- Cryptid Spectrals
	c_cry_lock = {
		"Lock",
	},
	c_cry_vacuum = {
		"Vacuum",
	},
	c_cry_hammerspace = {
		"Hammerspace",
		"CCD",
	},
	c_cry_trade = {
		"Trade",
	},
	c_cry_summoning = {
		"Summoning",
	},
	c_cry_replica = {
		"Replica",
	},
	c_cry_analog = {
		"Analog",
	},
	c_cry_typhoon = {
		"Typhoon",
		"Azure Seal",
	},
	c_cry_ritual = {
		"Ritual",
	},
	c_cry_adversary = {
		"Adversary",
	},
	c_cry_chambered = {
		"Chambered",
	},
	c_cry_conduit = {
		"Conduit",
	},
	c_cry_white_hole = {
		"White Hole",
	},
	c_cry_gateway = {
		"Gateway",
		"Exotic",
	},
	c_cry_source = {
		"Source",
		"Green Seal",
	},
	c_cry_pointer = {
		"Pointer",
		"Pointer://",
		"://Pointer",
		"self",
	},

	-- Cryptid Unique Consumeables
	-- probably not going to be used ever

	-- Cryptid Code Cards
	-- 01010000 01001100 01000001 01000011 01000101 01001000 01001111 01001100 01000100 01000101 01010010

	-- Secret Placeholder 2
	-- another smaller placeholder

	-- Cryptid Booster Packs
	-- placeholder in a placeholder in a placeholder in a holdplacer in a placeholder

	-- Cryptid Tags
	tag_cry_astral = {
		"Astral Tag",
		"Astral",
		"Free Astral",
	},
	tag_cry_banana = {
		"Banana Tag",
	},
	tag_cry_bettertop_up = {
		"Better Top-Up Tag",
		"Better Top-Up",
		"Better Top Up Tag",
		"Better Top Up",
		"Uncommon Top Up",
	},
	tag_cry_better_voucher = {
		"Tier 3 tag",
		"Tier 3 voucher tag",
		"Golden Voucher",
		"Golden Voucher Tag",
		"Better Voucher Tag",
	},
	tag_cry_blur = {
		"Blurred Tag",
		"Blurred",
		"Free Blurred",
	},
	tag_cry_booster = {
		"Booster Tag",
		"Double Booster Tag",
		"Double Booster",
	},
	tag_cry_bundle = {
		"Bundle Tag",
		"Bundle",
	},
	tag_cry_cat = {
		"Cat Tag",
		"meow",
		"mrow",
		"mrrp",
		"purr",
	},
	tag_cry_console = {
		"Console Tag",
		"Console",
		"Code Tag",
	},
	tag_cry_double_m = {
		"Double M",
		"Double M Tag",
		"Jolly M",
	},
	tag_cry_empowered = {
		"Empowered Tag",
		"Better Spectral",
		"Better Spectral Tag",
	},
	tag_cry_epic = {
		"Epic Tag",
		"Half-price Epic Joker",
		"Half price Epic Joker",
		"Half price Epic",
		"Half-price Epic",
	},
	tag_cry_gambler = {
		"Gambler Tag",
		"Gambling Tag",
		"Gambling",
		"Gambler's Tag",
		"LETS GO GAMBLING!",
	},
	tag_cry_glass = {
		"Fragile Tag",
		"Fragile",
		"Glass Tag",
		"Free Fragile",
	},
	tag_cry_glitched = {
		"Glitched Tag",
		"Glitched",
		"Free Glitched",
	},
	tag_cry_gold = {
		"Gold Tag",
		"Golden Tag",
		"Gold",
		"Free Golden",
	},
	tag_cry_gourmand = {
		"Gourmand",
		"Gourmand Tag",
		"Free Food",
	},
	tag_cry_loss = {
		"Loss",
		"Loss Tag",
		"Meme Tag",
		"Meme Pack Tag",
	},
	tag_cry_m = {
		"M Tag",
		"Jolly Tag",
		"Jolly",
		"Free Jolly",
	},
	tag_cry_memory = {
		"Memory Tag",
		"Memory",
	},
	tag_cry_mosaic = {
		"Mosaic",
		"Mosaic Tag",
		"Free Mosaic",
	},
	tag_cry_oversat = {
		"Oversat",
		"Free Oversat",
		"Oversaturated",
		"Free Oversaturated",
		"Oversaturated Tag",
	},
	tag_cry_quadruple = {
		"Quadruple",
		"Quadruple Tag",
	},
	tag_cry_quintuple = {
		"Quintuple",
		"Quintuple Tag",
	},
	tag_cry_rework = {
		"Rework Tag",
	},
	tag_cry_schematic = {
		"Schematic",
		"Schematic Tag",
		"Guaranteed Brainstorm",
	},
	tag_cry_scope = {
		"Scope Tag",
		"Scope",
	},
	tag_cry_triple = {
		"Triple",
		"Triple Tag",
	},

	-- Cryptid Vouchers
	-- placeholder (T1 T2 T1 T2 pattern)

	-- Cryptid T3 Vouchers
	-- super strong placeholder

	--[[
	Format:
		<joker key> = {
			"<alias1>",
			"<alias2>",
			...
			"<aliasN>",
		},
	]]
	-- TARGET: Add Jokers to Alias List
}

-- How to use the functions to add cards to the list (all case insensitive)
--
-- Cryptid.pointeratlasify(cardkey, alias, remove)
-- Adds a specified alias to the pointer alias list
-- cardkey = the card's key; "j_joker", "j_cry_dropshot" (string)
-- alias = the alias you want to refer to the card; "Dropshot", "Default Joker" (string)
-- remove = a check for if you wish to remove the specified alias; true or nil (accepts anything lua treats as true)
--
-- Cryptid.pointerblistify(cardkey, remove)
-- Blacklists a certain card key from being used in pointer (ignored if debug pointer)
-- cardkey = see above
-- remove = see above
--
-- Cryptid.pointerblistifytype(valkey, value, remove)
-- Blacklists a certain card data from being used in pointer (ignored if debug pointer)
-- valkey = the value you want to compare against; "rarity", "immutable" (string)
-- value = the value you want to blacklist; "cry_exotic", true (any)
-- remove = see above

local pointeritems = {
	pointer,
}

return {
	name = "Pointer://",
	items = pointeritems,
	init = function()
		function Cryptid.inject_pointer_aliases()
			--print("[CRYPTID] Inserting Pointer Aliases")
			local alify = Cryptid.pointeraliasify
			Cryptid.pointerblistifytype("rarity", "cry_exotic", nil)
			for key, aliasesTable in pairs(aliases) do
				for _, alias in pairs(aliasesTable) do
					alify(key, alias, nil)
				end
				alify(key, key, nil)
			end
			for _, group in pairs(G.localization.descriptions) do
				if
					_ ~= "Back"
					and _ ~= "Content Set"
					and _ ~= "Edition"
					and _ ~= "Enhanced"
					and _ ~= "Stake"
					and _ ~= "Other"
				then
					for key, card in pairs(group) do
						if G.P_CENTERS[key] then
							alify(key, type(card.name) == "table" and card.name[1] or card.name, nil)
							if G.P_CENTERS[key].name then
								alify(key, G.P_CENTERS[key].name, nil)
							end
							if G.P_CENTERS[key].original_key then
								alify(key, G.P_CENTERS[key].original_key, nil)
							end
						end
					end
				end
			end
		end
	end,
}
