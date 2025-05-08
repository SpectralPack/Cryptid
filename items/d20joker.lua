local d20 = {
	object_type = "Joker",
	dependencies = {
		items = {
		},
	},
	is_d20 = true,
	name = "cry-d20",
	key = "d20",
	pos = { x = 1, y = 6 },
	config = { extra = { misprintedvalue = 1} },
	rarity = 3,
	cost = 10,	
	atlas = "atlasone",
	order = 133,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.misprintedvalue, 20 * center.ability.extra.misprintedvalue, 2 * center.ability.extra.misprintedvalue , 0.5 / center.ability.extra.misprintedvalue } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.cardarea == G.jokers then
			local rolled = roll({amount = 1, sides = 20}, "D20")
			if rolled <= 1 then
				return {
					mult = rolled * card.ability.extra.misprintedvalue,
				    xmult = 0.5 / card.ability.extra.misprintedvalue,
				}
                
            elseif rolled >= 20 then
				return {
					mult = rolled * card.ability.extra.misprintedvalue,
				    xmult = 2 * card.ability.extra.misprintedvalue,
				}
			else
				return {
					mult = rolled * card.ability.extra.misprintedvalue,
				}
			end
				
		end
	end,
	cry_credits = {
		idea = {
			"vexastrae",
		},
		art = {
			"vexastrae",
		},
		code = {
			"SMG9000",
		},
	},
}
local gameofyoumustdice = {
	object_type = "Joker",
	dependencies = {
		items = {
		},
	},
	is_d20 = true,
	name = "cry-gameofyoumustdice",
	key = "gameofyoumustdice",
	pos = { x = 4, y = 5 },
	config = { extra = { misprintedvalue2 = 0.1, xmult = 1} },
	rarity = "cry_epic",
	cost = 10,	
	atlas = "atlasepic",
	order = 134,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.misprintedvalue2, center.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.retrigger_joker and not context.blueprint then
			local y = roll({amount = 1, sides = 10}, "Gameofyoumustdice")
			local z = roll({amount = y, sides = 4}, "Gameofyoumustdice")
			local gain = roll({amount = z, sides = y}, "Gameofyoumustdice")
			card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.extra.misprintedvalue2 * gain)
		end
		if context.joker_main and context.cardarea == G.jokers then
			return {
				xmult = card.ability.extra.xmult,
			}	
		end
	end,
	cry_credits = {
		idea = {
			"HexaCryonic",
		},
		art = {
			"GeorgeTheRat",
		},
		code = {
			"SMG9000",
		},
	},
}
--[[local feliz = {
	object_type = "Joker",
	dependencies = {
		items = {
		},
	},
	is_d20 = true,
	name = "cry-d20",
	key = "feliz_seis",
	pos = { x = 2, y = 5 },
	config = { extra = {} },
	rarity = 1,
	immutable = true,
	cost = 10,	
	atlas = "atlasone",
	order = 133,
	loc_vars = function(self, info_queue, center)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local rank = context.other_card:get_id()
			if rank == 6 then
				local dice = roll({amount = 1, sides = 6}, "feliz_seis")
				return {
					mult = dice,
					colour = G.C.MULT,
					card = card,
				}
			end
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.retrigger_joker and not context.blueprint then
			G.GAME.current_round.semicolon = true
		end
	end,
	cry_credits = {
		idea = {
			"vexastrae",
		},
		art = {
			"vexastrae",
		},
		code = {
			"SMG9000",
		},
	},
}]]
local d20items = {
    d20,
	gameofyoumustdice,
	feliz,
}
return {
	name = "D20 Jokers",
	init = function()
		local gfer = G.FUNCS.evaluate_round
		function G.FUNCS.evaluate_round()
			if G.GAME.current_round.semicolon then
				add_round_eval_row({ dollars = 0, name = "blind1", pitch = 0.95, saved = true })
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 1.3 * math.min(G.GAME.blind.dollars + 2, 7) / 2 * 0.15 + 0.5,
					func = function()
						G.GAME.blind:defeat()
						return true
					end,
				}))
				delay(0.2)
				add_round_eval_row({ name = "bottom", dollars = 0 })
			else
				return gfer()
			end
		end
	end,
	items = d20items,
}
