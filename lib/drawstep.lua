-- Drawing steps for cards (eg midground layer on Surreals)

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

end

-- Custom soul effects 
-- Taken from Grim

--[[local vanf_soul = SMODS.DrawSteps['soul'].func
SMODS.DrawSteps['soul'].func = function(self)
	if self.ability.name == 'Macrocosm' and (self.config.center.discovered or self.bypass_discovery_center) then
		local scale_mod = 0
		local rotate_mod = 0

		G.macrocosm.role.draw_major = self
		G.macrocosm:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        G.macrocosm:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod+(math.sin(G.TIMERS.REAL/3)/9), rotate_mod)
	end
	if self.ability.name == 'Genesis' and (self.config.center.discovered or self.bypass_discovery_center) then
		local scale_mod = math.sin(G.TIMERS.REAL/3)/6
		local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2 + (math.random(-500, 500)/10000)

		G.genesis.role.draw_major = self
		G.genesis:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        G.genesis:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end
    if self.ability.name == 'SooS' and (self.config.center.discovered or self.bypass_discovery_center) then
		local scale_mod = 0.05 - 0.05*math.sin(1.8*G.TIMERS.REAL) - 0.07*math.sin(0.5 * (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 + (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^1.5
        local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) - 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 + (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^1.7

        G.soul_upsd.role.draw_major = self
        G.soul_upsd:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        G.soul_upsd:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end
    vanf_soul(self)
end]]

may.generic_soul_anims = {}

may.generic_soul_anims['diskus_spin'] = function(self, layer)
	if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
		if not G.SETTINGS.reduced_motion then
			rotate_mod = G.TIMERS.REAL * 0.2
		end
		self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
		if self.edition then 
			for k, v in pairs(G.P_CENTER_POOLS.Edition) do
				--if v.apply_to_float then
					if self.edition[v.key:sub(3)] then
						self.children.floating_sprite:draw_shader(v.shader, nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
					end
				--end
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
			for k, v in pairs(G.P_CENTER_POOLS.Edition) do
				--if v.apply_to_float then
					if self.edition[v.key:sub(3)] then
						self.children.floating_sprite:draw_shader(v.shader, nil, nil, nil, self.children.center, 0.1 + (math.sin(G.TIMERS.REAL) * 0.03), rotate_mod or 0, 0, 0)
					end
				--end
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
		--[[if self.config.center_key == "j_may_diskus" 
		or self.config.center_key == "j_may_diskus_kollectum" 
		or self.config.center_key == "j_may_diskus_kollectum_maximus" 
		or self.config.center_key == "j_may_diskus_distruktum" 
		or self.config.center_key == "j_may_rondo_discoteca"
		) then
		
			if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
				local scale_mod = 0.1
				
				if not G.SETTINGS.reduced_motion then
					local r_time = G.TIMERS.REAL
					
					if self.config.center_key == "j_may_diskus" then
						x = r_time * 0.2
						rotate_mod = x
					end
					
					if self.config.center_key == "j_may_diskus_kollectum" then
						x = r_time * 0.3
						rotate_mod = x + math.sin(x)
					end
					
					if self.config.center_key == "j_may_diskus_kollectum_maximus" then
						x = r_time * 0.3
						rotate_mod = x + (0.85 * math.abs(math.sin(x)))
					end
					
					if self.config.center_key == "j_may_diskus_distruktum" then
						x = r_time * 0.3
						rotate_mod = (x + (math.cos(x) + math.sin(x)) ^ 4) * 2.5
					end
					
					if self.config.center_key == "j_may_rondo_discoteca" then
						x = r_time * 0.1
						rotate_mod = math.min(math.abs((math.cos(x)) / (math.cos(x) ^ 2)), x) + math.min(math.max(math.tan(x + 0.25) * 0.0125, -x), x) + (x + (0.85 * math.abs(math.sin(x + 0.5)))) + (x + math.sin(x + 0.5)) + ((math.cos(x + 0.75) + math.sin(x + 0.75)) ^ 4) * 2
					end
					
				end
				
				local xmod = 0
				local ymod = 0
				self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod, xmod, ymod)
				
				if self.edition then 
					for k, v in pairs(G.P_CENTER_POOLS.Edition) do
						--if v.apply_to_float then
							if self.edition[v.key:sub(3)] then
								self.children.floating_sprite:draw_shader(v.shader, nil, nil, nil, self.children.center, scale_mod, rotate_mod)
							end
						--end
					end
				end
				
			end
		end]]
	end
})