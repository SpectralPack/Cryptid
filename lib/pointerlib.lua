-- if it works, it works
Cryptid.pointerblist = {}
Cryptid.pointerblisttype = {}
Cryptid.pointeralias = {}

function Cryptid.pointerblistify(target, remove) -- Add specific joker to blacklist, must input either a card object or a key as string, eg:
	if not Cryptid.pointerblist then
		Cryptid.pointerblist = {}
	end
	if not remove then
		Cryptid.pointerblist[#Cryptid.pointerblist + 1] = target
		return true
	else
		for i = 1, #Cryptid.pointerblist do
			if Cryptid.pointerblist[i] == target then
				table.remove(Cryptid.pointerblisttype, i)
			end
		end
	end
	return false
end

function Cryptid.pointeraliasify(target, key, remove) -- Add a specific alias/key combo to the alias list
	if string.len(key) ~= 1 then
		key = string.lower(key:gsub("%b{}", ""):gsub("%s+", ""))
	end
	if not remove then
		if not Cryptid.pointeralias[target] then
			Cryptid.pointeralias[target] = {}
		end
		Cryptid.pointeralias[target][#Cryptid.pointeralias[target] + 1] = key
		return true
	else
		for v = 1, #Cryptid.pointeralias[target] do
			if Cryptid.pointeralias[target][v] == key then
				table.remove(Cryptid.pointeralias, v)
				return true
			end
		end
	end
	return false
end

function Cryptid.pointerblistifytype(target, key, remove) -- eg: blacklists a certain card value, see pointer.lua
	if not remove then
		for target1, key1 in pairs(Cryptid.pointerblisttype) do
			if target1 == target then
				for _, key2 in ipairs(Cryptid.pointerblisttype[target]) do
					if key2 == key then
						return true
					end
				end
				Cryptid.pointerblisttype[target][(#Cryptid.pointerblisttype[target] + 1)] = key
				return true
			end
		end
		if not Cryptid.pointerblisttype[target] then
			Cryptid.pointerblisttype[target] = {}
		end
		Cryptid.pointerblisttype[target][1] = key
		return true
	else
		if Cryptid.pointerblisttype[target] then
			for index, value in ipairs(Cryptid.pointerblisttype[target]) do
				if key == value then
					table.remove(Cryptid.pointerblisttype[target][index])
					return true
				end
			end
			if key == nil then
				table.remove(Cryptid.pointerblisttype[target])
				return true
			end
		end
	end
	return false
end

function Cryptid.pointergetalias(target) -- "Is this alias legit?"
	target = tostring(target)
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
	for keym, card in pairs(G.P_CENTERS) do
		if apply_lower(card.name) == apply_lower(target) then
			return keym
		end
		if apply_lower(card.original_key) == apply_lower(target) then
			return keym
		end
		if apply_lower(keym) == apply_lower(target) then
			return keym
		end
	end
	for card, _ in pairs(Cryptid.pointeralias) do
		if card == target then
			return card
		end
		for _, alias in ipairs(Cryptid.pointeralias[card]) do
			if alias == target then
				return card
			end
		end
	end
	return false
end

function Cryptid.pointergetblist(target) -- "Is this card pointer banned?"
	target = Cryptid.pointergetalias(target)
	if not target then
		return true
	end
	if G.GAME.banned_keys[target] then
		return true
	end
	for index, value in ipairs(Cryptid.pointerblist) do
		if target == value then
			return true
		end
	end
	target = G.P_CENTERS[target]
	for value, power in pairs(Cryptid.pointerblisttype) do
		for index, val2 in pairs(target) do
			if value == index then
				if power == ({} or true or nil) then
					return true
				end
				for _, val3 in ipairs(power) do
					if target[index] == val3 then
						return true
					end
				end
			end
		end
	end
	return false
end
