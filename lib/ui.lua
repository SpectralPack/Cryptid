-- ui.lua - Code used for new UI elements/changes in Cryptid

-- Add/modify Steamodded Draw Steps to work with Cryptid

-- Edition Decks

--gets sprite key to use for the given type
local function get_edeck_sprite_key(run_setup, type)
	local sprite = nil
	if run_setup then
		local r = ({
			edition = "ed",
			enhancement = "enh",
			sticker = "sk",
			suit = "st",
			seal = "sl",
		})[type]
		sprite = Cryptid.safe_get(SMODS.RunSelect, "Setup", "choices", "cry_edeck_" .. r)
			or Cryptid.safe_get(G.PROFILES, G.SETTINGS.profile, "last_choices", "cry_edeck_" .. r)
	else
		sprite = G.GAME["cry_selected_" .. type]
	end
	return sprite or "default"
end

SMODS.DrawStep({
	key = "back_edition",
	order = 5,
	func = function(self)
		if self.area and self.area == SMODS.RunSelect.Internals.stake_tower then --why is this even an issue ???????
			return
		end
		local in_run_setup = self.area
				and (self.area.config.run_select or self.area.config.run_select_deck_preview)
				and true
			or false
		local back = self.ability.set == "Back" and in_run_setup and self.config.center or G.GAME.selected_back_key
		if in_run_setup then
			local cp = Cryptid.safe_get(SMODS.RunSelect, "Internals", "current_page")
			if cp then
				if Cryptid.safe_get(SMODS.RunSelect, "Pages", "cry_edeck_ed", "page") == cp then
					back = G.P_CENTERS.b_cry_e_deck
				elseif Cryptid.safe_get(SMODS.RunSelect, "Pages", "cry_edeck_enh", "page") == cp then
					back = G.P_CENTERS.b_cry_et_deck
				elseif Cryptid.safe_get(SMODS.RunSelect, "Pages", "cry_edeck_sk", "page") == cp then
					back = G.P_CENTERS.b_cry_sk_deck
				elseif Cryptid.safe_get(SMODS.RunSelect, "Pages", "cry_edeck_st", "page") == cp then
					back = G.P_CENTERS.b_cry_st_deck
				elseif Cryptid.safe_get(SMODS.RunSelect, "Pages", "cry_edeck_sl", "page") == cp then
					back = G.P_CENTERS.b_cry_sl_deck
				end
			end
		end
		if
			not self.cry_antimatter_locked
			and back
			and ((type(back) == "table" and back.unlocked) or not in_run_setup)
		then
			if back.key == "b_cry_antimatter" then
				self.children.back:draw_shader("negative", nil, self.ARGS.send_to_shader, true)
				self.children.back:draw_shader("negative_shine", nil, self.ARGS.send_to_shader, true)
			end
			if back.key == "b_cry_e_deck" then
				local ed = get_edeck_sprite_key(in_run_setup, "edition")
				Cryptid.update_edeck_sprite(self, "edition", ed)
				if ed == "e_negative" then
					self.children.back:draw_shader("negative", nil, self.ARGS.send_to_shader, true)
					self.children.back:draw_shader("negative_shine", nil, self.ARGS.send_to_shader, true)
				elseif ed ~= "default" and ed ~= "random" then
					local shader = G.SHADERS[ed:sub(3)] and ed:sub(3)
						or Cryptid.safe_get(G.P_CENTERS, ed, "shader")
						or nil
					self.children.back:draw_shader(shader, nil, self.ARGS.send_to_shader, true)
				end
			end
			if back.key == "b_cry_et_deck" then
				local enh = get_edeck_sprite_key(in_run_setup, "enhancement")
				Cryptid.update_edeck_sprite(self, "enhancement", enh)
			end
			if back.key == "b_cry_sk_deck" then
				local sk = get_edeck_sprite_key(in_run_setup, "sticker")
				Cryptid.update_edeck_sprite(self, "sticker", sk)
				if sk == "all" then
					for _, c in ipairs(SMODS.Sticker.obj_buffer) do
						if not SMODS.Stickers[c].no_edeck then
							if type(SMODS.Stickers[c].draw) == "function" then
								SMODS.Stickers[c]:draw(self)
							else
								G.shared_stickers[c].role.draw_major = self
								G.shared_stickers[c]:draw_shader("dissolve", nil, nil, true, self.children.center)
								G.shared_stickers[c]:draw_shader(
									"voucher",
									nil,
									self.ARGS.send_to_shader,
									true,
									self.children.center
								)
							end
						end
					end
				elseif sk ~= "default" and sk ~= "random" then
					if type(SMODS.Stickers[sk].draw) == "function" then
						SMODS.Stickers[sk]:draw(self)
					else
						G.shared_stickers[sk].role.draw_major = self
						G.shared_stickers[sk]:draw_shader("dissolve", nil, nil, true, self.children.center)
						G.shared_stickers[sk]:draw_shader(
							"voucher",
							nil,
							self.ARGS.send_to_shader,
							true,
							self.children.center
						)
					end
				end
			end
			if back.key == "b_cry_st_deck" then
				local st = get_edeck_sprite_key(in_run_setup, "suit")
				Cryptid.update_edeck_sprite(self, "suit", st)
			end
			if back.key == "b_cry_sl_deck" then
				local sl = get_edeck_sprite_key(in_run_setup, "seal")
				Cryptid.update_edeck_sprite(self, "seal", sl)
				if sl ~= "default" and sl ~= "random" then
					G.shared_seals[sl].role.draw_major = self
					G.shared_seals[sl]:draw_shader("dissolve", nil, nil, true, self.children.center)
					if sl == "Gold" then --figure out handling shader `draw` funcs later
						G.shared_seals[sl]:draw_shader(
							"voucher",
							nil,
							self.ARGS.send_to_shader,
							true,
							self.children.center
						)
					end
				end
			end
		end
	end,
	conditions = { vortex = false, facing = "back" },
})

if SMODS.DrawSteps and SMODS.DrawSteps.seal then
	local orig_seal_draw = SMODS.DrawSteps.seal.func
	SMODS.DrawSteps.seal.func = function(self, layer)
		if self.seal == "random" or not G.shared_seals[self.seal] then
			local seal = G.P_SEALS[self.seal]
			if seal and type(seal.draw) == "function" then
				seal:draw(self, layer)
			end
			return
		end
		return orig_seal_draw(self, layer)
	end
end

local update_alert_ref = Card.update_alert
function Card:update_alert()
	if self.seal and not G.P_SEALS[self.seal] then
		return
	end
	return update_alert_ref(self)
end

if SMODS.has_playing_card_property then
	local orig_has_property = SMODS.has_playing_card_property
	SMODS.has_playing_card_property = function(card, key)
		for k, _ in pairs(SMODS.get_enhancements(card)) do
			if G.P_CENTERS[k] and G.P_CENTERS[k][key] then
				return true
			end
		end
		if (G.P_CENTERS[(card.edition or {}).key] or {})[key] then
			return true
		end
		if (G.P_SEALS[card.seal or {}] or {})[key] then
			return true
		end
		for k, v in pairs(SMODS.Stickers) do
			if v[key] and card.ability and card.ability[k] then
				return true
			end
		end
		return false
	end
end

-- Third Layer
SMODS.DrawStep({
	key = "floating_sprite2",
	order = 59,
	func = function(self)
		if self.ability.name == "cry-Gateway" and (self.config.center.discovered or self.bypass_discovery_center) then
			local scale_mod2 = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod2 = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			self.children.floating_sprite2:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod2,
				rotate_mod2,
				nil,
				0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
				nil,
				0.6
			)
			self.children.floating_sprite2:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod2,
				rotate_mod2
			)

			local scale_mod = 0.05
				+ 0.05 * math.sin(1.8 * G.TIMERS.REAL)
				+ 0.07
					* math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
			local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
				+ 0.07
					* math.sin(G.TIMERS.REAL * math.pi * 5)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

			self.children.floating_sprite.role.draw_major = self
			self.children.floating_sprite:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			self.children.floating_sprite:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod
			)
		end
		if
			self.config.center.soul_pos
			and self.config.center.soul_pos.extra
			and (self.config.center.discovered or self.bypass_discovery_center)
		then
			local scale_mod = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
			if self.children.floating_sprite2 then
				self.children.floating_sprite2:draw_shader(
					"dissolve",
					0,
					nil,
					nil,
					self.children.center,
					scale_mod,
					rotate_mod,
					nil,
					0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
					nil,
					0.6
				)
				self.children.floating_sprite2:draw_shader(
					"dissolve",
					nil,
					nil,
					nil,
					self.children.center,
					scale_mod,
					rotate_mod
				)
			else
				local center = self.config.center
				if center and center.soul_pos and center.soul_pos.extra then
					self.children.floating_sprite2 = Sprite(
						self.T.x,
						self.T.y,
						self.T.w,
						self.T.h,
						G.ASSET_ATLAS[center.atlas or center.set],
						center.soul_pos.extra
					)
					self.children.floating_sprite2.role.draw_major = self
					self.children.floating_sprite2.states.hover.can = false
					self.children.floating_sprite2.states.click.can = false
				end
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})
SMODS.draw_ignore_keys.floating_sprite2 = true
SMODS.clean_up_children_ignore.cry_ccd_sprite = true
SMODS.draw_ignore_keys.cry_ccd_sprite = true

function Cryptid.get_split_shader(shader_name, half)
	local key = "cry_split_" .. half .. "_" .. shader_name
	if G.SHADERS[key] then
		return key
	end

	local base_name = shader_name:match("^cry_(.+)$") or shader_name
	local raw_code = nil

	-- 1. Try love.filesystem for vanilla shaders
	for _, name in ipairs({ shader_name, base_name }) do
		local ok, code = pcall(love.filesystem.read, "resources/shaders/" .. name .. ".fs")
		if ok and code and #code > 0 then
			raw_code = code
			break
		end
	end

	-- 2. Try SMODS.Shaders
	if not raw_code and SMODS and SMODS.Shaders then
		for _, name in ipairs({ shader_name, base_name, "cry_" .. base_name }) do
			local smods_shader = SMODS.Shaders[name]
			if smods_shader and smods_shader.full_path and NFS then
				local nfs_ok, nfs_code = pcall(NFS.read, smods_shader.full_path)
				if nfs_ok and nfs_code and #nfs_code > 0 then
					raw_code = nfs_code
					break
				end
			end
		end
	end

	-- 3. Try Cryptid assets directory
	if not raw_code and NFS and Cryptid and Cryptid.path then
		for _, name in ipairs({ shader_name, base_name }) do
			local p_ok, p_code = pcall(NFS.read, Cryptid.path .. "assets/shaders/" .. name .. ".fs")
			if p_ok and p_code and #p_code > 0 then
				raw_code = p_code
				break
			end
		end
	end

	if not raw_code then
		return shader_name
	end

	local split_condition = (half == "top_left")
		and "\n\tif ((uv.x + uv.y) >= 1.0) { return vec4(0.0); }\n"
		or "\n\tif ((uv.x + uv.y) < 1.0) { return vec4(0.0); }\n"

	local modified_code, count = string.gsub(
		raw_code,
		"(vec2%s+uv%s*=%s*.-;)",
		"%1" .. split_condition,
		1
	)

	if count > 0 then
		local compile_ok, new_shader = pcall(love.graphics.newShader, modified_code)
		if compile_ok and new_shader then
			G.SHADERS[key] = new_shader
			return key
		end
	end

	return shader_name
end

local sprite_draw_shader_ref = Sprite.draw_shader
function Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
	if not self.cry_split_half or not _shader then
		return sprite_draw_shader_ref(self, _shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
	end

	local target_shader_key = Cryptid.get_split_shader(_shader, self.cry_split_half)
	local shader_obj = G.SHADERS[target_shader_key]
	if not shader_obj or target_shader_key == _shader then
		return sprite_draw_shader_ref(self, _shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
	end

	if G.SETTINGS.reduced_motion then _no_tilt = true end
	local _draw_major = self.role.draw_major or self
	if _shadow_height then
		self.VT.y = self.VT.y - _draw_major.shadow_parrallax.y * _shadow_height
		self.VT.x = self.VT.x - _draw_major.shadow_parrallax.x * _shadow_height
		self.VT.scale = self.VT.scale * (1 - 0.2 * _shadow_height)
	end

	if custom_shader then
		if _send then
			for _, v in ipairs(_send) do
				if shader_obj:hasUniform(v.name) then
					shader_obj:send(v.name, v.val or (v.func and v.func()) or v.ref_table[v.ref_value])
				end
			end
		end
	elseif _shader == "vortex" then
		if shader_obj:hasUniform("vortex_amt") then
			shader_obj:send("vortex_amt", G.TIMERS.REAL - (G.vortex_time or 0))
		end
	else
		self.ARGS.prep_shader = self.ARGS.prep_shader or {}
		self.ARGS.prep_shader.cursor_pos = self.ARGS.prep_shader.cursor_pos or {}
		self.ARGS.prep_shader.cursor_pos[1] = _draw_major.tilt_var
			and _draw_major.tilt_var.mx * G.CANV_SCALE
			or G.CONTROLLER.cursor_position.x * G.CANV_SCALE
		self.ARGS.prep_shader.cursor_pos[2] = _draw_major.tilt_var
			and _draw_major.tilt_var.my * G.CANV_SCALE
			or G.CONTROLLER.cursor_position.y * G.CANV_SCALE

		if shader_obj:hasUniform("mouse_screen_pos") then
			shader_obj:send("mouse_screen_pos", self.ARGS.prep_shader.cursor_pos)
		end
		if shader_obj:hasUniform("screen_scale") then
			shader_obj:send("screen_scale", G.TILESCALE * G.TILESIZE * (_draw_major.mouse_damping or 1) * G.CANV_SCALE)
		end
		if shader_obj:hasUniform("hovering") then
			shader_obj:send(
				"hovering",
				((_shadow_height and not tilt_shadow) or _no_tilt) and 0 or (_draw_major.hover_tilt or 0) * (tilt_shadow or 1)
			)
		end
		if shader_obj:hasUniform("dissolve") then
			shader_obj:send("dissolve", math.abs(_draw_major.dissolve or 0))
		end
		if shader_obj:hasUniform("time") then
			shader_obj:send("time", 123.33412 * (_draw_major.ID / 1.14212 or 12.5123152) % 3000)
		end
		if shader_obj:hasUniform("texture_details") then
			shader_obj:send("texture_details", self:get_pos_pixel())
		end
		if shader_obj:hasUniform("image_details") then
			shader_obj:send("image_details", self:get_image_dims())
		end
		if shader_obj:hasUniform("burn_colour_1") then
			shader_obj:send("burn_colour_1", _draw_major.dissolve_colours and _draw_major.dissolve_colours[1] or G.C.CLEAR)
		end
		if shader_obj:hasUniform("burn_colour_2") then
			shader_obj:send("burn_colour_2", _draw_major.dissolve_colours and _draw_major.dissolve_colours[2] or G.C.CLEAR)
		end
		if shader_obj:hasUniform("shadow") then
			shader_obj:send("shadow", not not _shadow_height)
		end
		if _send then
			if shader_obj:hasUniform(_shader) then
				shader_obj:send(_shader, _send)
			else
				local base_uniform = _shader:match("^cry_(.+)$")
				if base_uniform and shader_obj:hasUniform(base_uniform) then
					shader_obj:send(base_uniform, _send)
				end
			end
		end
	end

	love.graphics.setShader(shader_obj, shader_obj)

	if other_obj then
		self:draw_from(other_obj, ms, mr, mx, my)
	else
		self:draw_self()
	end

	love.graphics.setShader()

	if _shadow_height then
		self.VT.y = self.VT.y + _draw_major.shadow_parrallax.y * _shadow_height
		self.VT.x = self.VT.x + _draw_major.shadow_parrallax.x * _shadow_height
		self.VT.scale = self.VT.scale / (1 - 0.2 * _shadow_height)
	end
end

-- CCD Drawstep
local interceptorSprite = nil
SMODS.DrawStep({
	key = "ccd_interceptor",
	order = -5,
	func = function(self)
		if self.cry_ccd and self.facing == "front" then
			if not self.children.cry_ccd_sprite then
				local atlas = G.ASSET_ATLAS[self.cry_ccd.center.atlas or self.cry_ccd.center.set] or G.ASSET_ATLAS["Tarot"]
				if atlas then
					self.children.cry_ccd_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, atlas, self.cry_ccd.center.pos)
					self.children.cry_ccd_sprite.states.hover = self.states.hover
					self.children.cry_ccd_sprite.states.click = self.states.click
					self.children.cry_ccd_sprite.states.drag = self.states.drag
					self.children.cry_ccd_sprite.states.collide.can = false
					self.children.cry_ccd_sprite:set_role({ major = self, role_type = "Glued", draw_major = self })
				end
			end
			local is_enhanced = self.config.center.set == "Enhanced"
			if self.children.cry_ccd_sprite and not self.greyed then
				local shader_name = (is_enhanced and G.SHADERS["cry_ccd_split"]) and "cry_ccd_split" or "dissolve"
				self.children.cry_ccd_sprite:draw_shader(shader_name, nil, nil, nil, self.children.center)
			end
			if not is_enhanced then
				interceptorSprite = interceptorSprite
					or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["cry_misc"], { x = 3, y = 1 })
				interceptorSprite.role.draw_major = self
				interceptorSprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
			end
		elseif
			(self.ability.set ~= "Default" and self.ability.set ~= "Enhanced")
			and self.facing == "front"
			and (self.playing_card or (self.area and self.area.config.view_deck))
		then
			-- Legacy fallback for classic CCD cards
			interceptorSprite = interceptorSprite
				or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["cry_misc"], { x = 3, y = 1 })
			interceptorSprite.role.draw_major = self
			interceptorSprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
		end
	end,
})

if SMODS.DrawSteps and SMODS.DrawSteps.edition then
	local orig_edition_draw = SMODS.DrawSteps.edition.func
	SMODS.DrawSteps.edition.func = function(self, layer)
		if not self.cry_ccd then
			return orig_edition_draw(self, layer)
		end

		local is_enhanced = self.config.center.set == "Enhanced"
		local edition = self.delay_edition or self.edition
		if edition then
			for _, v in pairs(G.P_CENTER_POOLS.Edition) do
				if edition[v.key:sub(3)] and v.shader then
					if type(v.draw) == "function" then
						v:draw(self, layer)
					else
						if is_enhanced then
							self.children.center.cry_split_half = "top_left"
							pcall(self.children.center.draw_shader, self.children.center, v.shader, nil, self.ARGS.send_to_shader)
							self.children.center.cry_split_half = nil

							if self.children.cry_ccd_sprite then
								self.children.cry_ccd_sprite.cry_split_half = "bottom_right"
								pcall(
									self.children.cry_ccd_sprite.draw_shader,
									self.children.cry_ccd_sprite,
									v.shader,
									nil,
									self.ARGS.send_to_shader,
									nil,
									self.children.center
								)
								self.children.cry_ccd_sprite.cry_split_half = nil
							end
						else
							if self.children.cry_ccd_sprite then
								self.children.cry_ccd_sprite:draw_shader(
									v.shader,
									nil,
									self.ARGS.send_to_shader,
									nil,
									self.children.center
								)
							end
							if interceptorSprite then
								interceptorSprite:draw_shader(
									v.shader,
									nil,
									self.ARGS.send_to_shader,
									nil,
									self.children.center
								)
							end
						end

						if self.children.front and not self:should_hide_front() then
							self.children.front:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
						end
					end
				end
			end
		end

		local is_antimatter = self.ability.name == "Antimatter"
			and (self.config.center.discovered or self.bypass_discovery_center)
		if (edition and edition.negative) or is_antimatter then
			if is_enhanced then
				self.children.center.cry_split_half = "top_left"
				pcall(
					self.children.center.draw_shader,
					self.children.center,
					"negative_shine",
					nil,
					self.ARGS.send_to_shader
				)
				self.children.center.cry_split_half = nil

				if self.children.cry_ccd_sprite then
					self.children.cry_ccd_sprite.cry_split_half = "bottom_right"
					pcall(
						self.children.cry_ccd_sprite.draw_shader,
						self.children.cry_ccd_sprite,
						"negative_shine",
						nil,
						self.ARGS.send_to_shader,
						nil,
						self.children.center
					)
					self.children.cry_ccd_sprite.cry_split_half = nil
				end
			else
				if self.children.cry_ccd_sprite then
					self.children.cry_ccd_sprite:draw_shader(
						"negative_shine",
						nil,
						self.ARGS.send_to_shader,
						nil,
						self.children.center
					)
				end
				if interceptorSprite then
					interceptorSprite:draw_shader(
						"negative_shine",
						nil,
						self.ARGS.send_to_shader,
						nil,
						self.children.center
					)
				end
			end
		end
	end
end

--Banished cards drawstep (thank you bandisplay :pray:)
SMODS.DrawStep({
	key = "banished_card",
	order = 69,
	func = function(card, layer)
		if
			not G.GAME.USING_POINTER
			and card.area
			and card.area.config.collection
			and G.GAME.cry_banished_keys[card.config.center_key]
		then
			card.children.center:draw_shader("debuff", nil, card.ARGS.send_to_shader)
		end
		if
			Cryptid.safe_get(card, "params", "run_select_selection_choice", 2) == "cry_antimatter"
			and not SMODS.RunSelect.Setup.choices.cry_antimatter[card.config.center_key]
			and not card.cry_antimatter_locked
		then
			card.children.back:draw_shader("debuff", nil, card.ARGS.send_to_shader, true)
		end
	end,
})

--Quartz Stake - Draw Pinned sticker
SMODS.DrawStep({
	key = "pinned_draw",
	order = 41,
	func = function(card, layer)
		if card.pinned and G.shared_stickers.pinned then
			G.shared_stickers.pinned.role.draw_major = card
			G.shared_stickers["pinned"]:draw_shader("dissolve", nil, nil, nil, card.children.center)
			G.shared_stickers["pinned"]:draw_shader("voucher", nil, card.ARGS.send_to_shader, nil, card.children.center)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

-- Make hover UI collidable - so we can detect collision and display tooltips
local m = Card.move
function Card:move(dt)
	m(self, dt)
	if self.children.h_popup then
		self.children.h_popup.states.collide.can = true
		if not self:force_popup() and not self.states.hover.is then
			self.children.h_popup:remove()
			self.children.h_popup = nil
		end
	end
end

function Card:get_banned_force_popup_areas()
	return { G.pack_cards }
end
-- This defines when we should show a card's description even when it's not hovered
function Card:force_popup()
	-- Must be selected
	if self.highlighted then
		-- Remove all popups in the pause menu (collection excluded)
		if G.SETTINGS.paused and not self.area.config.collection then
			return false
		end
		-- Playing cards
		if
			self.config.center.set == "Default"
			or self.config.center.set == "Base"
			or self.config.center.set == "Enhanced"
		then
			return false
		end
		-- Incantation mod compat
		if SMODS.Mods["incantation"] and self.area == G.consumeables then
			return false
		end
		-- Other areas where it doesn't work well
		for i, v in ipairs(self:get_banned_force_popup_areas()) do
			if self.area == v then
				return false
			end
		end
		return true
	end
end

-- Hacky hook to make cards selectable in the collection
-- Unfortunately this doesn't play nicely with gameset UI
local cainit = CardArea.init
function CardArea:init(X, Y, W, H, config)
	if config and config.collection then
		config.highlight_limit = config.card_limit
	end
	return cainit(self, X, Y, W, H, config)
end

-- Allow highlighting in the collection
local cach = CardArea.can_highlight
function CardArea:can_highlight(card)
	if self.config.collection then
		return true
	end
	return cach(self, card)
end

-- Prevent hover UI from being redrawn
local ch = Card.hover
function Card:hover()
	if self.children.h_popup then
		return
	end
	local is_antimatter = self.cry_antimatter_card
	local has_antimatter_loc_vars = is_antimatter and self.config.center.cry_antimatter_loc_vars
	local orig_loc_vars = nil
	if is_antimatter then
		Cryptid.in_antimatter_hover = self
		if has_antimatter_loc_vars then
			orig_loc_vars = self.config.center.loc_vars
			self.config.center.loc_vars = self.config.center.cry_antimatter_loc_vars
		end
	end
	ch(self)
	if is_antimatter then
		if has_antimatter_loc_vars then
			self.config.center.loc_vars = orig_loc_vars
		end
		Cryptid.in_antimatter_hover = nil
	end
end

local loc_ref = localize
function localize(args, misc_cat)
	if Cryptid.in_antimatter_hover and type(args) == "table" and args.type == "descriptions" and args.set == "Back" then
		if G.localization.descriptions.Back[args.key .. "_antimatter"] then
			args.key = args.key .. "_antimatter"
		end
	end
	return loc_ref(args, misc_cat)
end

local orig_grab_tooltips = SMODS.RunSelect.Functions.grab_tooltips
function SMODS.RunSelect.Functions.grab_tooltips(set, key)
	if Cryptid.in_antimatter_hover and set == "Back" and G.localization.descriptions.Back[key .. "_antimatter"] then
		key = key .. "_antimatter"
	end
	return orig_grab_tooltips(set, key)
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local button_nodes = G_UIDEF_use_and_sell_buttons_ref(card)
	-- Remove sell button from cursed jokers
	if
		card.area
		and card.area.config.type == "joker"
		and card.config
		and card.config.center
		and card.config.center.rarity == "cry_cursed"
		and card.ability.name ~= "cry-Monopoly"
	then
		table.remove(button_nodes.nodes[1].nodes, 1)
	end
	if card.config and card.config.center and card.config.center.key == "c_cry_potion" then
		table.remove(button_nodes.nodes[1].nodes, 1)
	end
	-- i love buttercup
	if
		card.area
		and card.area.config.type == "joker"
		and card.config
		and card.config.center
		and card.ability.name == "cry-Buttercup"
	then
		local use = {
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						maxw = 1.25,
						padding = 0.1,
						r = 0.05,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "store",
						func = "can_store_card",
					},
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.3 } },
						{
							n = G.UIT.T,
							config = {
								text = localize("b_store"),
								colour = G.C.UI.TEXT_LIGHT,
								scale = 0.3,
								shadow = true,
							},
						},
					},
				},
			},
		}
		local target_node = button_nodes.nodes[1]
		if not card.added_to_deck then
			use.nodes[1].nodes = { use.nodes[1].nodes[2] }
			if card.ability.consumeable then
				target_node = button_nodes
			end
		end
		target_node.nodes = target_node.nodes or {}
		table.insert(target_node.nodes, { n = G.UIT.R, config = { align = "cl" }, nodes = {
			use,
		} })
		return button_nodes
	end
	return button_nodes
end
