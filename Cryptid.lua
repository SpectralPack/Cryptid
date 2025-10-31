-- Welcome to the Cryptid source code!
-- This is the main file for the mod, where everything is loaded and initialized.
-- If you're looking for a specific feature, browse the items folder to see how it is implemented.
-- If you're looking for a specific function, check the lib folder to see if it is there.

if not Cryptid then
	Cryptid = {}
end
local mod_path = "" .. SMODS.current_mod.path -- this path changes when each mod is loaded, but the local variable will retain Cryptid's path
Cryptid.path = mod_path
Cryptid_config = SMODS.current_mod.config or {} --is this nil check needed? idk but i saw crash reports related to this

-- Lovely Patch Target, toggles being able to change gameset config. Here for mod support
Cryptid_config.gameset_toggle = true

-- Enable optional features
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	-- Here are some other ones Steamodded has
	-- Cryptid doesn't use them YET, but these should be uncommented if Cryptid uses them
	-- These ones add new card areas that Steamodded will calculate through
	-- Might already be useful for sticker calc

	-- Cryptid uses cardarea deck now
	cardareas = {
		deck = true,
		discard = true, -- used by scorch
	},
}

--Load Library Files
local files = NFS.getDirectoryItems(mod_path .. "lib")
for _, file in ipairs(files) do
	print("[CRYPTID] Loading library file " .. file)
	local f, err = SMODS.load_file("lib/" .. file)
	if err then
		error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
	end
	f()
end
local function process_items(f, mod)
	local ret = f()
	if not ret.disabled then
		if ret.init and type(ret.init) == "function" then
			ret:init()
		end
		if ret.items then
			for _, item in ipairs(ret.items) do
				if mod then
					-- make the mod use its own prefixes
					item.prefix_config = {
						key = false,
						atlas = false,
					}
					item.mod_path = mod.path
					if item.key then
						if item.object_type and SMODS[item.object_type].class_prefix then
							item.key = SMODS[item.object_type].class_prefix .. "_" .. mod.prefix .. "_" .. item.key
						elseif string.find(item.key, mod.prefix .. "_") ~= 1 then
							item.key = mod.prefix .. "_" .. item.key
						end
					end
					if item.atlas and string.find(item.atlas, mod.prefix .. "_") ~= 1 then
						item.atlas = mod.prefix .. "_" .. item.atlas
					end
					-- this will also display the mod's own badge
					if not item.dependencies then
						item.dependencies = {}
					end
					item.dependencies[#item.dependencies + 1] = mod.id
				end
				if item.init then
					item:init()
				end
				if not Cryptid.object_registry[item.object_type] then
					Cryptid.object_registry[item.object_type] = {}
				end
				if not item.take_ownership then
					if not item.order then
						item.order = 0
					end
					if ret.order then
						item.order = item.order + ret.order
					end
					if mod then
						item.order = item.order + 1e9
					end
					item.cry_order = item.order
					if not Cryptid.object_buffer[item.object_type] then
						Cryptid.object_buffer[item.object_type] = {}
					end
					Cryptid.object_buffer[item.object_type][#Cryptid.object_buffer[item.object_type] + 1] = item
				else
					item.key = SMODS[item.object_type].class_prefix .. "_" .. item.key
					SMODS[item.object_type].obj_table[item.key].mod = SMODS.Mods.Cryptid
					for k, v in pairs(item) do
						if k ~= "key" then
							SMODS[item.object_type].obj_table[item.key][k] = v
						end
					end
				end
				Cryptid.object_registry[item.object_type][item.key] = item
			end
		end
	end
end

Cryptid.object_registry = {}
Cryptid.object_buffer = {}
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[CRYPTID] Loading file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
	end
	process_items(f)
end

-- Check for files in other mods
-- either in [Mod]/Cryptid.lua or [Mod]/Cryptid/*.lua
for _, mod in pairs(SMODS.Mods) do
	-- Note: Crashes with lone lua files
	if not mod.disabled and mod.path and mod.id ~= "Cryptid" then
		local path = mod.path
		local files = NFS.getDirectoryItems(path)
		for _, file in ipairs(files) do
			if file == "Cryptid.lua" then
				print("[CRYPTID] Loading Cryptid.lua from " .. mod.id)
				local f, err = SMODS.load_file("Cryptid.lua", mod.id)
				if err then
					error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
				end
				process_items(f, mod)
			end
			if file == "Cryptid" and path .. "Cryptid/" ~= Cryptid.path then
				local files = NFS.getDirectoryItems(path .. "Cryptid")
				for _, file in ipairs(files) do
					print("[CRYPTID] Loading file " .. file .. " from " .. mod.id)
					local f, err = SMODS.load_file("Cryptid/" .. file, mod.id)
					if err then
						error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
					end
					process_items(f, mod)
				end
			end
		end
	end
end

-- Register all items
for set, objs in pairs(Cryptid.object_buffer) do
	table.sort(objs, function(a, b)
		return a.order < b.order
	end)
	for i = 1, #objs do
		if objs[i].post_process and type(objs[i].post_process) == "function" then
			objs[i]:post_process()
		end
		Cryptid.post_process(objs[i])
		SMODS[set](objs[i])
	end
end
local inj = SMODS.injectItems
function SMODS.injectItems(...)
	inj(...)
	Cryptid.update_obj_registry()
	for _, t in ipairs({
		G.P_CENTERS,
		G.P_BLINDS,
		G.P_TAGS,
		G.P_SEALS,
	}) do
		for k, v in pairs(t) do
			if v and G.PROFILES[G.SETTINGS.profile].all_unlocked then
				v.alerted = true
				v.discovered = true
				v.unlocked = true
			end
		end
	end
	if G.PROFILES[G.SETTINGS.profile].all_unlocked then
		G.PROFILES[G.SETTINGS.profile].cry_none2 = true
		G.PROFILES[G.SETTINGS.profile].cry_none = (Cryptid.enabled("set_cry_poker_hand_stuff") == true)
	end
	G.P_CENTERS.j_stencil.immutable = true
	G.P_CENTERS.j_four_fingers.immutable = true
	G.P_CENTERS.j_mime.immutable = true
	G.P_CENTERS.j_ceremonial.immutable = true
	G.P_CENTERS.j_marble.immutable = true
	G.P_CENTERS.j_dusk.immutable = true
	G.P_CENTERS.j_raised_fist.immutable = true
	G.P_CENTERS.j_chaos.immutable = true
	G.P_CENTERS.j_hack.immutable = true
	G.P_CENTERS.j_pareidolia.immutable = true
	G.P_CENTERS.j_supernova.immutable = true
	G.P_CENTERS.j_space.immutable = true
	G.P_CENTERS.j_dna.immutable = true
	G.P_CENTERS.j_splash.immutable = true
	G.P_CENTERS.j_sixth_sense.immutable = true
	G.P_CENTERS.j_superposition.immutable = true
	G.P_CENTERS.j_seance.immutable = true
	G.P_CENTERS.j_riff_raff.immutable = true
	G.P_CENTERS.j_shortcut.immutable = true
	G.P_CENTERS.j_midas_mask.immutable = true
	G.P_CENTERS.j_luchador.immutable = true
	G.P_CENTERS.j_fortune_teller.immutable = true
	G.P_CENTERS.j_diet_cola.immutable = true
	G.P_CENTERS.j_mr_bones.immutable = true
	G.P_CENTERS.j_sock_and_buskin.immutable = true
	G.P_CENTERS.j_swashbuckler.immutable = true
	G.P_CENTERS.j_certificate.immutable = true
	G.P_CENTERS.j_smeared.immutable = true
	G.P_CENTERS.j_ring_master.immutable = true
	G.P_CENTERS.j_blueprint.immutable = true
	G.P_CENTERS.j_oops.immutable = true
	G.P_CENTERS.j_invisible.immutable = true
	G.P_CENTERS.j_brainstorm.immutable = true
	G.P_CENTERS.j_shoot_the_moon.immutable = true
	G.P_CENTERS.j_cartomancer.immutable = true
	G.P_CENTERS.j_astronomer.immutable = true
	G.P_CENTERS.j_burnt.immutable = true
	G.P_CENTERS.j_chicot.immutable = true
	G.P_CENTERS.j_perkeo.immutable = true
	G.P_CENTERS.j_hanging_chad.misprintize_caps = { extra = 40 }
	G.P_CENTERS.c_high_priestess.misprintize_caps = { planets = 100 }
	G.P_CENTERS.c_emperor.misprintize_caps = { tarots = 100 }
	G.P_CENTERS.c_familiar.misprintize_caps = { extra = 100 }
	G.P_CENTERS.c_grim.misprintize_caps = { extra = 100 }
	G.P_CENTERS.c_incantation.misprintize_caps = { extra = 100 }
	G.P_CENTERS.c_immolate.misprintize_caps = { destroy = 1e300 }
	G.P_CENTERS.c_cryptid.misprintize_caps = { extra = 100, max_highlighted = 100 }
	G.P_CENTERS.c_immolate.misprintize_caps = { destroy = 1e300 }
	Cryptid.inject_pointer_aliases()

	--this has to be here because the colors dont exist earlier then this
	Cryptid.circus_rarities["rare"] = { rarity = 3, base_mult = 2, order = 1, colour = G.C.RARITY.Rare }
	Cryptid.circus_rarities["epic"] = { rarity = "cry_epic", base_mult = 3, order = 2, colour = G.C.RARITY.cry_epic }
	Cryptid.circus_rarities["legendary"] = { rarity = 4, base_mult = 4, order = 3, colour = G.C.RARITY.Legendary }
	Cryptid.circus_rarities["exotic"] =
		{ rarity = "cry_exotic", base_mult = 20, order = 4, colour = G.C.RARITY.cry_exotic }

	Cryptid.reload_localization()
end

local old_repitions = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
	local reps = old_repitions(card, context, reps)
	reps = reps or { 1 }
	return reps
end

local cryptidConfigTab = function()
	cry_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = localize("cry_set_enable_features"),
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.4,
						}),
					},
				},
			},
		},
	}
	left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { left_settings, right_settings } }
	cry_nodes[#cry_nodes + 1] = config
	cry_nodes[#cry_nodes + 1] = UIBox_button({
		colour = G.C.CRY_GREENGRADIENT,
		button = "your_collection_content_sets",
		label = { localize("b_content_sets") },
		count = modsCollectionTally(G.P_CENTER_POOLS["Content Set"]),
		minw = 5,
		minh = 1.7,
		scale = 0.6,
		id = "your_collection_jokers",
	})
	--Add warning notifications later for family mode
	cry_nodes[#cry_nodes + 1] = create_toggle({
		label = localize("cry_family"),
		active_colour = HEX("40c76d"),
		ref_table = Cryptid_config,
		ref_value = "family_mode",
		callback = Cryptid.reload_localization,
	})
	cry_nodes[#cry_nodes + 1] = create_toggle({
		label = localize("cry_experimental"),
		active_colour = HEX("1f8505"),
		ref_table = Cryptid_config,
		ref_value = "experimental",
	})
	cry_nodes[#cry_nodes + 1] = create_toggle({
		label = localize("cry_force_tooltips"),
		active_colour = HEX("22c705"),
		ref_table = Cryptid_config,
		ref_value = "force_tooltips",
	})
	cry_nodes[#cry_nodes + 1] = create_toggle({
		label = localize("cry_feat_https module"),
		active_colour = HEX("b1c78d"),
		ref_table = Cryptid_config,
		ref_value = "HTTPS",
	})
	cry_nodes[#cry_nodes + 1] = create_toggle({
		label = localize("cry_feat_menu"),
		active_colour = HEX("1c5c23"),
		ref_table = Cryptid_config,
		ref_value = "menu",
	})
	cry_nodes[#cry_nodes + 1] = UIBox_button({
		colour = G.C.CRY_ALTGREENGRADIENT,
		button = "reset_gameset_config",
		label = { localize("b_reset_gameset_" .. (G.PROFILES[G.SETTINGS.profile].cry_gameset or "mainline")) },
		minw = 5,
	})
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = cry_nodes,
	}
end

local cryptidTabs = function()
	return {
		{
			label = localize("cry_set_music"),
			tab_definition_function = function()
				-- TODO: Add a button here to reset all Cryptid achievements.
				-- If you want to do that now, add this to the SMODS.InjectItems in Steamodded/loader/loader.lua
				--[[fetch_achievements()
            for k, v in pairs(SMODS.Achievements) do
                G.SETTINGS.ACHIEVEMENTS_EARNED[k] = nil
                G.ACHIEVEMENTS[k].earned = nil
            end
            fetch_achievements()]]
				cry_nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							--{n=G.UIT.O, config={object = DynaText({string = "", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
						},
					},
				}
				settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
				settings.nodes[#settings.nodes + 1] = create_toggle({
					active_colour = G.C.CRY_JOLLY,
					label = localize("cry_mus_jimball"),
					ref_table = Cryptid_config.Cryptid,
					ref_value = "jimball_music",
				})
				settings.nodes[#settings.nodes + 1] = create_toggle({
					active_colour = G.C.CRY_JOLLY,
					label = localize("cry_mus_code"),
					ref_table = Cryptid_config.Cryptid,
					ref_value = "code_music",
				})
				settings.nodes[#settings.nodes + 1] = create_toggle({
					active_colour = G.C.CRY_JOLLY,
					label = localize("cry_mus_exotic"),
					ref_table = Cryptid_config.Cryptid,
					ref_value = "exotic_music",
				})
				settings.nodes[#settings.nodes + 1] = create_toggle({
					active_colour = G.C.CRY_JOLLY,
					label = localize("cry_mus_high_score"),
					ref_table = Cryptid_config.Cryptid,
					ref_value = "big_music",
				})
				settings.nodes[#settings.nodes + 1] = create_toggle({
					active_colour = G.C.CRY_JOLLY,
					label = localize("cry_mus_alt_bg"),
					ref_table = Cryptid_config.Cryptid,
					ref_value = "alt_bg_music",
				})
				config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
				cry_nodes[#cry_nodes + 1] = config
				return {
					n = G.UIT.ROOT,
					config = {
						emboss = 0.05,
						minh = 6,
						r = 0.1,
						minw = 10,
						align = "cm",
						padding = 0.2,
						colour = G.C.BLACK,
					},
					nodes = cry_nodes,
				}
			end,
		},
	}
end
SMODS.current_mod.extra_tabs = cryptidTabs
SMODS.current_mod.config_tab = cryptidConfigTab
