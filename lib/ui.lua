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
		if (SMODS.RunSelect.Internals.current_page or 0) >= (SMODS.RunSelect.Pages["cry_edeck_" .. r].page or 9999) then
			sprite = SMODS.RunSelect.Setup.choices["cry_edeck_" .. r]
		end
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
		--or Cryptid.safe_get(G.GAME, "viewed_back", "effect", "center"); fix later
		if back and (self.config.center == back and back.unlocked or not in_run_setup) then
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
				elseif ed ~= "default" then
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
				if sk ~= "default" then
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
				if sl ~= "default" then
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
				if _center and _center.soul_pos and _center.soul_pos.extra then
					self.children.floating_sprite2 = Sprite(
						self.T.x,
						self.T.y,
						self.T.w,
						self.T.h,
						G.ASSET_ATLAS[_center.atlas or _center.set],
						_center.soul_pos.extra
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

-- CCD Drawstep
local interceptorSprite = nil
SMODS.DrawStep({
	key = "ccd_interceptor",
	order = -5,
	func = function(self)
		local card_type = self.ability.set or "None"
		if card_type ~= "Default" and card_type ~= "Enhanced" and self.playing_card and self.facing == "front" then
			interceptorSprite = interceptorSprite
				or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["cry_misc"], { x = 3, y = 1 })
			interceptorSprite.role.draw_major = self
			interceptorSprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
		end
	end,
})

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
	ch(self)
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	-- Remove sell button from cursed jokers
	if
		card.area
		and card.area.config.type == "joker"
		and card.config
		and card.config.center
		and card.config.center.rarity == "cry_cursed"
		and card.ability.name ~= "cry-Monopoly"
	then
		table.remove(abc.nodes[1].nodes, 1)
	end
	if card.config and card.config.center and card.config.center.key == "c_cry_potion" then
		table.remove(abc.nodes[1].nodes, 1)
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
		local m = abc.nodes[1]
		if not card.added_to_deck then
			use.nodes[1].nodes = { use.nodes[1].nodes[2] }
			if card.ability.consumeable then
				m = abc
			end
		end
		m.nodes = m.nodes or {}
		table.insert(m.nodes, { n = G.UIT.R, config = { align = "cl" }, nodes = {
			use,
		} })
		return abc
	end
	return abc
end
