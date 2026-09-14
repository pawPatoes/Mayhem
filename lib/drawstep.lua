-- Drawing steps for cards (eg midground layer on Opalescents)

-- CCD interceptor
-- Copy and paste from Cryptid
if #SMODS.find_mod('Cryptid') == 0 then

local interceptorSprite = nil
SMODS.DrawStep({
	key = "ccd_interceptor",
	order = -5,
	func = function(self)
		local card_type = self.ability.set or "None"
		if card_type ~= "Default" and card_type ~= "Enhanced" and self.playing_card and self.facing == "front" then
			interceptorSprite = interceptorSprite or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["may_ccd_thing"], { x = 0, y = 0 })
			interceptorSprite.role.draw_major = self
			interceptorSprite:draw_shader("dissolve", nil, nil, nil, self.children.center)
		end
	end,
})

end

SMODS.DrawStep({
	key = 'upsd_spectral_laminate',
	order = 0,
	func = function(self)
		if self.config.center.set == 'upside_down_spectrals' and self.sprite_facing == 'front' then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
        end
	end
})

-- Midground sprites
-- Taken from Cryptid
if #SMODS.find_mod('Cryptid') == 0 then

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front)
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

SMODS.DrawStep({
	key = "floating_sprite2",
	order = 59,
	func = function(self)
		if self.config.center.soul_pos and self.config.center.soul_pos.extra and (self.config.center.discovered or self.bypass_discovery_center) then
			local scale_mod = 0.07
			local rotate_mod = 0
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

end

-- Custom soul effects 
may.generic_soul_anims = {}

may.generic_soul_anims['diskus_spin'] = function(self, layer)
	if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
		if not G.SETTINGS.reduced_motion then
			rotate_mod = G.TIMERS.REAL * 0.2
		end
		self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
		if self.edition then 
			if G.P_CENTERS[self.edition.key].apply_to_float then
				self.children.floating_sprite:draw_shader(G.P_CENTERS[self.edition.key].shader, nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
			end
		end
	end
end

may.generic_soul_anims['diskus_spin_fast'] = function(self, layer)
	if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
		if not G.SETTINGS.reduced_motion then
			rotate_mod = G.TIMERS.REAL * 0.5
		end
		self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.04), rotate_mod or 0, 0, 0)
		if self.edition then 
			if G.P_CENTERS[self.edition.key].apply_to_float then
				self.children.floating_sprite:draw_shader(G.P_CENTERS[self.edition.key].shader, nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
			end
		end
	end
end

-- Base code by fokuto
local vanf_sdsfsf = SMODS.DrawSteps.floating_sprite.func
SMODS.DrawStep:take_ownership('floating_sprite', {
	func = function (self, layer)
		if self and self.gc and self:gc().custom_soul_anim then
			if type(self:gc().custom_soul_anim) == 'function' then
				self:gc().custom_soul_anim(self, layer)
			else
				may.generic_soul_anims[self:gc().custom_soul_anim](self, layer)
			end
		else
			vanf_sdsfsf(self,layer)
		end
	end
})