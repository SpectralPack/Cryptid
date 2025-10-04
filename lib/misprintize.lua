-- misprintize.lua - functions for card value randomization

--Redefine these here because they're always used
Cryptid.base_values = {}

Cryptid.misprintize_value_blacklist = {
	perish_tally = false,
	id = false,
	suit_nominal = false,
	base_nominal = false,
	face_nominal = false,
	qty = false,
	h_x_chips = false,
	d_size = false,
	h_size = false,
	selected_d6_face = false,
	cry_hook_id = false,
	colour = false,
	suit_nominal_original = false,
	times_played = false,
	extra_slots_used = false,
	card_limit = false,
	-- TARGET: Misprintize Value Blacklist (format: key = false, )
}
Cryptid.misprintize_bignum_blacklist = {
	odds = false,
	cry_prob = false,
	perma_repetitions = false,
	repetitions = false,
	nominal = false, --keep here, please.
}
Cryptid.misprintize_value_cap = {
	perma_repetitions = 40,
	repetitions = 40,
}

function Cryptid.calculate_misprint(initial, min, max, grow_type, pow_level)
	local big_initial = (type(initial) ~= "table" and to_big(initial)) or initial
	local big_min = (type(min) ~= "table" and to_big(min)) or min
	local big_max = (type(max) ~= "table" and to_big(max)) or max

	local grow = Cryptid.log_random(pseudoseed("cry_misprint" .. G.GAME.round_resets.ante), big_min, big_max)

	local calc = big_initial
	if not grow_type then
		calc = calc * grow
	elseif grow_type == "+" then
		calc = calc + grow
	elseif grow_type == "-" then
		calc = calc - grow
	elseif grow_type == "/" then
		calc = calc / grow
	elseif grow_type == "^" then
		pow_level = pow_level or 1
		if pow_level == 1 then
			calc = calc ^ grow
		else
			local function hyper(level, base, height)
				local big_base = (type(base) ~= "table" and to_big(base)) or base
				local big_height = (type(height) ~= "table" and to_big(height)) or height

				if height == 1 then
					return big_base
				elseif level == 1 then
					return big_base ^ big_height
				else
					local inner = hyper(level, base, height - 1)
					return hyper(level - 1, base, inner)
				end
			end

			calc = hyper(pow_level, calc, grow)
		end
	end

	if calc > to_big(-1e100) and calc < to_big(1e100) then
		calc = to_number(calc)
	end

	return calc
end

function Cryptid.misprintize_tbl(name, ref_tbl, ref_value, clear, override, stack, big, grow_type, pow_level)
	local prob_max = 1e69 -- funny number
	local max_slots = 100
	local max_booster_slots = 25

	local function num_too_big(initial, min, max, limit)
		return (
			to_big(initial) > to_big(limit)
			or (min and to_big(initial) * min > to_big(limit))
			or (max and to_big(initial) * max > to_big(limit))
		)
	end

	if name and ref_tbl and ref_value then
		local tbl = Cryptid.deep_copy(ref_tbl[ref_value])

		local function can_misprintize_value(k, v)
			if
				(k == "x_mult" and v == 1 and not tbl.override_x_mult_check)
				or (k == "x_chips" and v == 1 and not tbl.override_x_chips_check)
			then
				return false
			end
			for key, val in pairs(Cryptid.misprintize_value_blacklist) do
				if tostring(k) == tostring(key) then
					return val
				end
			end
			return true
		end

		for k, v in pairs(tbl) do
			if (type(tbl[k]) ~= "table") or is_number(tbl[k]) then
				if is_number(tbl[k]) and can_misprintize_value(k, tbl[k]) then
					if not Cryptid.base_values[name] then
						Cryptid.base_values[name] = {}
					end
					if not Cryptid.base_values[name][k .. ref_value] then
						Cryptid.base_values[name][k .. ref_value] = tbl[k]
					end
					local initial = (stack and tbl[k] or Cryptid.base_values[name][k .. ref_value])
					local min = override and override.min or G.GAME.modifiers.cry_misprint_min
					local max = override and override.max or G.GAME.modifiers.cry_misprint_max

					if
						(
							k == "cry_prob"
							-- Hack for vanilla jokers that use the extra field to describe their odds
							or (
								(
									name == "j_8_ball"
									or name == "j_business"
									or name == "j_space"
									or name == "j_hallucination"
								) and k == "extra"
							)
						) and num_too_big(initial, min, max, prob_max)
					then
						initial = Cryptid.base_values[name][k .. ref_value] * prob_max
						min = 1
						max = 1
					end

					tbl[k] = Cryptid.sanity_check(
						clear and Cryptid.base_values[name][k .. ref_value]
							or cry_format(Cryptid.calculate_misprint(initial, min, max, grow_type, pow_level), "%.2g"),
						big
					)
				end
			elseif not (k == "immutable") and not (k == "colour") then
				for _k, _v in pairs(tbl[k]) do
					if is_number(tbl[k][_k]) and can_misprintize_value(_k, tbl[k][_k]) then
						if not Cryptid.base_values[name] then
							Cryptid.base_values[name] = {}
						end
						if not Cryptid.base_values[name][_k .. k] then
							if
								G.P_CENTERS[name]
								and type(G.P_CENTERS[name].config[k]) == "table"
								and G.P_CENTERS[name].config[k][_k]
							then
								Cryptid.base_values[name][_k .. k] = G.P_CENTERS[name].config[k][_k]
							else
								Cryptid.base_values[name][_k .. k] = tbl[k][_k]
							end
						end

						local initial = (stack and tbl[k][_k] or Cryptid.base_values[name][_k .. k])
						local min = override and override.min or G.GAME.modifiers.cry_misprint_min
						local max = override and override.max or G.GAME.modifiers.cry_misprint_max

						if (_k == "odds") and num_too_big(initial, min, max, prob_max) then
							initial = Cryptid.base_values[name][_k .. k] * prob_max
							min = 1
							max = 1
						end

						if
							(_k == "slots" and (name == "j_cry_tenebris" or name == "j_cry_negative"))
							and num_too_big(initial, min, max, max_slots)
						then
							initial = max_slots
							min = 1
							max = 1
						end

						if
							(_k == "booster_slots" and (name == "j_cry_booster"))
							and num_too_big(initial, min, max, max_booster_slots)
						then
							initial = max_booster_slots
							min = 1
							max = 1
						end

						tbl[k][_k] = Cryptid.sanity_check(
							clear and Cryptid.base_values[name][_k .. k]
								or cry_format(
									Cryptid.calculate_misprint(initial, min, max, grow_type, pow_level),
									"%.2g"
								),
							big
						)
					end
				end
			end
		end
		ref_tbl[ref_value] = tbl
	end
end
function Cryptid.misprintize_val(val, override, big, grow_type, pow_level)
	if is_number(val) then
		val = Cryptid.sanity_check(
			cry_format(
				Cryptid.calculate_misprint(
					val,
					override and override.min or G.GAME.modifiers.cry_misprint_min,
					override and override.max or G.GAME.modifiers.cry_misprint_max,
					grow_type,
					pow_level
				),
				"%.2g"
			),
			big
		)
	end
	return val
end
function Cryptid.sanity_check(val, is_big)
	if is_big then
		if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
			val = 1e300
		end
		if type(val) == "table" then
			return val
		end
		if val > 1e100 or val < -1e100 then
			return to_big(val)
		end
	end
	if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
		return 1e300
	end
	if type(val) == "table" then
		if val > to_big(1e300) then
			return 1e300
		end
		if val < to_big(-1e300) then
			return -1e300
		end
		return to_number(val)
	end
	return val
end
function Cryptid.misprintize(card, override, force_reset, stack, grow_type, pow_level)
	local clamps = card.config.center.misprintize_caps or {}
	if Card.no(card, "immutable", true) then
		force_reset = true
	end
	--infinifusion compat
	if card.infinifusion then
		if card.config.center == card.infinifusion_center or card.config.center.key == "j_infus_fused" then
			calculate_infinifusion(card, nil, function(i)
				Cryptid.misprintize(card, override, force_reset, stack, grow_type, pow_level)
			end)
		end
	end
	if
		(not force_reset or G.GAME.modifiers.cry_jkr_misprint_mod)
			and (G.GAME.modifiers.cry_misprint_min or override or card.ability.set == "Joker")
			and not stack
		or not Card.no(card, "immutable", true)
	then
		if G.GAME.modifiers.cry_jkr_misprint_mod and card.ability.set == "Joker" then
			if not override then
				override = {}
			end
			override.min = override.min or G.GAME.modifiers.cry_misprint_min or 1
			override.max = override.max or G.GAME.modifiers.cry_misprint_max or 1
			override.min = override.min * G.GAME.modifiers.cry_jkr_misprint_mod
			override.max = override.max * G.GAME.modifiers.cry_jkr_misprint_mod
		end
		if G.GAME.modifiers.cry_misprint_min or override and override.min then
			Cryptid.misprintize_tbl(
				card.config.center_key,
				card,
				"ability",
				nil,
				override,
				stack,
				Cryptid.is_card_big(card),
				grow_type,
				pow_level
			)
			if card.base then
				Cryptid.misprintize_tbl(
					card.config.card_key,
					card,
					"base",
					nil,
					override,
					stack,
					Cryptid.is_card_big(card),
					grow_type,
					pow_level
				)
			end
		end
		if G.GAME.modifiers.cry_misprint_min then
			--card.cost = cry_format(card.cost / Cryptid.log_random(pseudoseed('cry_misprint'..G.GAME.round_resets.ante),override and override.min or G.GAME.modifiers.cry_misprint_min,override and override.max or G.GAME.modifiers.cry_misprint_max),"%.2f")
			card.misprint_cost_fac = 1
				/ Cryptid.log_random(
					pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
					override and override.min or G.GAME.modifiers.cry_misprint_min,
					override and override.max or G.GAME.modifiers.cry_misprint_max
				)
			card:set_cost()
		end
	else
		Cryptid.misprintize_tbl(
			card.config.center_key,
			card,
			"ability",
			true,
			nil,
			nil,
			Cryptid.is_card_big(card),
			grow_type,
			pow_level
		)
	end
	if clamps then
		for i, v in pairs(clamps) do
			if type(v) == "table" and not v.tetrate then
				for i2, v2 in pairs(v) do
					if to_big(card.ability[i][i2]) > to_big(v2) then
						card.ability[i][i2] = Cryptid.sanity_check(v2, Cryptid.is_card_big(card))
						if
							to_big(card.ability[i][i2]) > to_big(-1e100)
							or to_big(card.ability[i][i2]) < to_big(1e100)
						then
							card.ability[i][i2] = to_number(card.ability[i][i2])
						end
					end
				end
			elseif (type(v) == "table" and v.tetrate) or type(v) == "number" then
				if to_big(card.ability[i]) > to_big(v) then
					card.ability[i] = Cryptid.sanity_check(v, Cryptid.is_card_big(card))
					if to_big(card.ability[i]) > to_big(-1e100) or to_big(card.ability[i]) < to_big(1e100) then
						card.ability[i] = to_number(card.ability[i])
					end
				end
			end
		end
	end
	if card.ability.consumeable then
		for k, v in pairs(card.ability.consumeable) do
			card.ability.consumeable[k] = Cryptid.deep_copy(card.ability[k])
		end
	end
end
function Cryptid.log_random(seed, min, max)
	math.randomseed(seed)
	local lmin = math.log(min, 2.718281828459045)
	local lmax = math.log(max, 2.718281828459045)
	local poll = math.random() * (lmax - lmin) + lmin
	return math.exp(poll)
end
function cry_format(number, str)
	if math.abs(to_big(number)) >= to_big(1e300) then
		return number
	end
	return tonumber(str:format((Big and to_number(to_big(number)) or number)))
end
--use ID to work with glitched/misprint
function Card:get_nominal(mod)
	local mult = 1
	local rank_mult = 1
	if mod == "suit" then
		mult = 1000000
	end
	if self.ability.effect == "Stone Card" or (self.config.center.no_suit and self.config.center.no_rank) then
		mult = -10000
	elseif self.config.center.no_suit then
		mult = 0
	elseif self.config.center.no_rank then
		rank_mult = 0
	end
	return 10 * (self.base.id or 0.1) * rank_mult
		+ self.base.suit_nominal * mult
		+ (self.base.suit_nominal_original or 0) * 0.0001 * mult
		+ 10 * self.base.face_nominal * rank_mult
		+ 0.000001 * self.unique_val
end

function Cryptid.manipulate(card, args)
	if not Card.no(card, "immutable", true) or (args and args.bypass_checks) then
		if not args then
			return Cryptid.manipulate(card, {
				min = (G.GAME.modifiers.cry_misprint_min or 1) * (G.GAME.modifiers.cry_jkr_misprint_mod or 1),
				max = (G.GAME.modifiers.cry_misprint_max or 1) * (G.GAME.modifiers.cry_jkr_misprint_mod or 1),
				type = "X",
				dont_stack = true,
				no_deck_effects = true,
			})
		else
			local func = function(card)
				if not args.type then
					args.type = "X"
				end
				--hardcoded whatever
				if card.config.center.set == "Booster" then
					args.big = false
				end
				local caps = card.config.center.misprintize_caps or {}
				if card.infinifusion then
					if card.config.center == card.infinifusion_center or card.config.center.key == "j_infus_fused" then
						calculate_infinifusion(card, nil, function(i)
							Cryptid.manipulate(card, args)
						end)
					end
				end
				Cryptid.manipulate_table(card, card, "ability", args)
				if card.base then
					Cryptid.manipulate_table(card, card, "base", args)
				end
				if G.GAME.modifiers.cry_misprint_min then
					--card.cost = cry_format(card.cost / Cryptid.log_random(pseudoseed('cry_misprint'..G.GAME.round_resets.ante),override and override.min or G.GAME.modifiers.cry_misprint_min,override and override.max or G.GAME.modifiers.cry_misprint_max),"%.2f")
					card.misprint_cost_fac = 1
						/ Cryptid.log_random(
							pseudoseed("cry_misprint" .. G.GAME.round_resets.ante),
							override and override.min or G.GAME.modifiers.cry_misprint_min,
							override and override.max or G.GAME.modifiers.cry_misprint_max
						)
					card:set_cost()
				end
				if caps then
					for i, v in pairs(caps) do
						if type(v) == "table" and not v.tetrate then
							for i2, v2 in pairs(v) do
								if to_big(card.ability[i][i2]) > to_big(v2) then
									card.ability[i][i2] = Cryptid.sanity_check(v2, Cryptid.is_card_big(card))
								end
							end
						elseif (type(v) == "table" and v.tetrate) or type(v) == "number" then
							if to_big(card.ability[i]) > to_big(v) then
								card.ability[i] = Cryptid.sanity_check(v, Cryptid.is_card_big(card))
							end
						end
					end
				end
			end
			local config = copy_table(card.config.center.config)
			if not Cryptid.base_values[card.config.center.key] then
				Cryptid.base_values[card.config.center.key] = {}
				for i, v in pairs(config) do
					if (type(v) == "table" and v.tetrate) or type(v) == "number" and to_big(v) ~= to_big(0) then
						Cryptid.base_values[card.config.center.key][i .. "ability"] = v
					elseif type(v) == "table" then
						for i2, v2 in pairs(v) do
							Cryptid.base_values[card.config.center.key][i2 .. i] = v2
						end
					end
				end
			end
			if not args.bypass_checks and not args.no_deck_effects then
				Cryptid.with_deck_effects(card, func)
			else
				func(card)
			end
			if card.ability.consumeable then
				for k, v in pairs(card.ability.consumeable) do
					card.ability.consumeable[k] = Cryptid.deep_copy(card.ability[k])
				end
			end
			--ew ew ew ew
			G.P_CENTERS[card.config.center.key].config = config
		end
		return true
	end
end

function Cryptid.manipulate_table(card, ref_table, ref_value, args, tblkey)
	if ref_value == "consumeable" then
		return
	end
	for i, v in pairs(ref_table[ref_value]) do
		if
			(type(v) == "number" or (type(v) == "table" and v.tetrate))
			and Cryptid.misprintize_value_blacklist[i] ~= false
		then
			local num = v
			if args.dont_stack then
				if
					Cryptid.base_values[card.config.center.key]
					and (
						Cryptid.base_values[card.config.center.key][i .. ref_value]
						or (ref_value == "ability" and Cryptid.base_values[card.config.center.key][i .. "consumeable"])
					)
				then
					num = Cryptid.base_values[card.config.center.key][i .. ref_value]
						or Cryptid.base_values[card.config.center.key][i .. "consumeable"]
				end
			end
			local new_val = Cryptid.manipulate_value(num, args, args.big or Cryptid.is_card_big(card), i)
			ref_table[ref_value][i] = new_val

			-- take double scale / scalae into account
			if ref_value == "ability" and ref_table.ability.cry_scaling_info then
				ref_table.ability.cry_scaling_info[i] = new_val
			end
		elseif
			i ~= "immutable"
			and not (ref_value == "ability" and i == "cry_scaling_info")
			and type(v) == "table"
			and Cryptid.misprintize_value_blacklist[i] ~= false
		then
			Cryptid.manipulate_table(card, ref_table[ref_value], i, args)
		end
	end
end

function Cryptid.manipulate_value(num, args, is_big, name)
	if args.func then
		num = args.func(num, args, is_big, name)
	else
		if args.min and args.max then
			local new_args = args
			local big_min = to_big(args.min)
			local big_max = to_big(args.max)
			local new_value = Cryptid.log_random(
				pseudoseed(args.seed or ("cry_misprint" .. G.GAME.round_resets.ante)),
				big_min,
				big_max
			)
			if args.type == "+" then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = num + new_value
				end
			elseif args.type == "X" then
				if
					to_big(num) ~= to_big(0) and (to_big(num) ~= to_big(1) or (name ~= "x_chips" and name ~= "x_mult"))
				then
					num = num * new_value
				end
			elseif args.type == "^" then
				num = to_big(num) ^ new_value
			elseif args.type == "hyper" then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = to_big(num):arrow(args.value.arrows, to_big(new_value))
				end
			end
		elseif args.value then
			if args.type == "+" then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = num + to_big(args.value)
				end
			elseif args.type == "X" then
				if
					to_big(num) ~= to_big(0) and (to_big(num) ~= to_big(1) or (name ~= "x_chips" and name ~= "x_mult"))
				then
					num = num * args.value
				end
			elseif args.type == "^" then
				num = to_big(num) ^ args.value
			elseif args.type == "hyper" then
				num = to_big(num):arrow(args.value.arrows, to_big(args.value.height))
			end
		end
	end
	if Cryptid.misprintize_value_cap[name] then
		num = math.min(num, Cryptid.misprintize_value_cap[name])
	end
	if Cryptid.misprintize_bignum_blacklist[name] == false then
		num = to_number(num)
		return to_number(Cryptid.sanity_check(num, false))
	end
	local val = Cryptid.sanity_check(num, is_big)
	if to_big(val) > to_big(-1e100) and to_big(val) < to_big(1e100) then
		return to_number(val)
	end
	return val
end

local get_nominalref = Card.get_nominal
function Card:get_nominal(...)
	return to_number(get_nominalref(self, ...))
end
