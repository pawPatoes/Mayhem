-- Hooks

vanf_csc = Card.set_cost
function Card:set_cost()
	vanf_csc(self)
	if (self.edition or {}).may_print then self.cost = self.cost * 0.2 end
	if self:gc().set == 'Joker' then
		if G.GAME.power_trip then
			if self:gc().rarity == 2 or self:gc().rarity == 3 then
				self.cost = 0
			end
		end
	end
end

-- Exponential reroll price increase

local vanf_rs = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(e)
	vanf_rs(e)
	G.GAME.may_current_rerolls = (G.GAME.may_current_rerolls or 0) + 1
	if G.GAME.ultrastock then
		if may.conf.Mode == 1 then
			if (G.GAME.ultrastock_mod or 0) < 5 then
				if pseudorandom('may_ultrastock') < G.GAME.probabilities.normal / 4 then
					change_shop_size(1)
					G.GAME.ultrastock_mod = (G.GAME.ultrastock_mod or 0) + 1
					e:juice_up()
					play_sound('highlight2', 1, 0.5)
					play_sound('highlight1')
					play_sound('cardFan2')
				end
			end
		else
			if pseudorandom('may_ultrastock') < G.GAME.probabilities.normal / 4 then
				change_shop_size(1)
				G.GAME.ultrastock_mod = (G.GAME.ultrastock_mod or 0) + 1
				e:juice_up()
				play_sound('highlight2', 1, 0.5)
				play_sound('highlight1')
				play_sound('cardFan2')
			end
		end
	end
	if may.conf.reroll_cost ~= 4 then
		if G.GAME.may_current_rerolls >= may.conf.reroll_cost * 25 and not G.GAME.may_exp_reroll then
			G.GAME.may_exp_reroll = true
			G.GAME.may_exp_reroll_consecutive = (G.GAME.may_exp_reroll_consecutive or 0) + 1
			e:juice_up()
			e.config.colour = G.C.RED
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
		end
	end
	if (G.GAME.may_exp_reroll_consecutive or 0) >= 5 then
		if may.conf.threshold_punishment then
			may.a('Reroll price threshold reached 5 times consecutively! Surreal scaling will activate each reroll, including this one.', '5', 0.3, G.C.RED, 'talisman_eeechip', 0.7, 1)
			G.GAME.may_surreal_scaling = (G.GAME.may_surreal_scaling or 0) + 1
		end
	elseif G.GAME.may_exp_reroll_consecutive == 4 and G.GAME.may_exp_reroll then
		if may.conf.threshold_punishment and not G.GAME.may_consecutive_warned then
			may.a('Surreal scaling will activate if reroll price threshold is reached in next shop!', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
			G.GAME.may_consecutive_warned = true
		end
	end
	if G.GAME.may_exp_reroll then
		G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase * G.GAME.may_current_rerolls * 7.5e5
	end
	if G.GAME.current_round.reroll_cost_increase >= 1e100 then
		if may.conf.reroll_punishment then
			if not G.GAME.may_reroll_punishment_announced then
				may.a('Reroll price is greater than $1e100! Interdimensional scaling activated.', '5', 0.5, G.C.RED, 'talisman_eeechip', 0.7, 1)
				G.GAME.may_reroll_punishment_announced = true
				G.GAME.may_interdimensional_scaling = (G.GAME.may_interdimensional_scaling or 0) + 1
			end
		end
	end
end

local vanf_ts = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
	vanf_ts(e)
	if G.GAME.ultrastock_mod then
		change_shop_size(-G.GAME.ultrastock_mod)
		G.GAME.ultrastock_mod = 0
	end
	G.GAME.may_current_rerolls = 0
	if not G.GAME.may_exp_reroll then
		G.GAME.may_exp_reroll_consecutive = 0
	end
	G.GAME.may_exp_reroll = false
    G.TAROT_INTERRUPT_PULSE = false
	G.GAME.may_consecutive_warned = false
end

local vanf_gu = Game.update
function Game:update(dt)
	vanf_gu(self, dt)
	--[[ Party Time background
	if G.GAME.blind then
		if (#SMODS.find_card('j_may_party_time') ~= 0 or #SMODS.find_card('j_may_aurora_rave') ~= 0 or #SMODS.find_card('j_may_planet_ibiza') ~= 0) and (may.transcendence or 0) == 0 and may.conf.JokerEffects then
			ease_background_colour({ new_colour = copy_table(G.C.BLACK), special_colour = G.C.EDITION, contrast = 2 })
		end	
	end]]
end

local vanf_suph = SMODS.upgrade_poker_hands
function SMODS.upgrade_poker_hands(args)
	if args.level_up then
		if G.GAME.may_ring_bonuses and (G.GAME.may_ring_bonuses.levels or 0) ~= 0 then
		    args.level_up = (args.level_up or 1) + G.GAME.may_ring_bonuses.levels
		    G.GAME.may_temp_ring_levels = G.GAME.may_ring_bonuses.levels
		    G.GAME.may_ring_bonuses.levels = 0
	    end
	    if #SMODS.find_card('v_may_astronomy_1') ~= 0 then
		    args.level_up = math.max((args.level_up or 1), 0) * (2 ^ #SMODS.find_card('v_may_astronomy_1'))
	    end
	    if #SMODS.find_card('v_may_astronomy_3') ~= 0 and hand ~= may.favhand() then
		    args.level_up = args.level_up * (4 ^ #SMODS.find_card('v_may_astronomy_3'))
	    end
	end
	vanf_suph(args)
	if args.level_up then
		may.toggle_ring_display(false)
	end
end 

local vanf_sb = G.FUNCS.select_blind
function G.FUNCS.select_blind(e)
	vanf_sb(e)
	G.GAME.rounds_since_genesis = (G.GAME.rounds_since_genesis or 0) + 1
	if not G.GAME.may_initialized_start_timers then
		if may.conf.round_punishment then
			may.add_round_timer(57, 'mythic_scale_warning')
			may.add_round_timer(117, 'transcendent_scale_warning')
			may.add_round_timer(147, 'interdimensional_scale_warning')
			may.add_round_timer(207, 'ethereal_scale_warning')
			may.add_round_timer(297, 'hyperascendant_scale_warning')
		
			may.add_round_timer(60, 'mythic_scale')
			may.add_round_timer(120, 'transcendent_scale')
			may.add_round_timer(150, 'interdimensional_scale')
			may.add_round_timer(210, 'ethereal_scale')
			may.add_round_timer(300, 'hyperascendant_scale')
		end
		G.GAME.may_initialized_start_timers = true
	end
	G.GAME.may_timers = G.GAME.may_timers or {}
	local elapsed_timers = {}
	for k, v in pairs(G.GAME.may_timers) do
		v.rounds = v.rounds - 1
		if v.rounds <= 0 then
			may.timer_functions[v.func]()
			table.insert(elapsed_timers, k)
		end
	end
	for k, v in pairs(elapsed_timers) do
		table.remove(G.GAME.may_timers, v)
	end
	if G.GAME.round_resets.ante > 8 and not G.GAME.may_announced_endless then 
		may.a('Endless Mode reached! Endless-Exclusive content may now appear.', '20', 0.5, G.C.DARK_EDITION, 'may_ethereal_joker', 1, 1.5)
		G.GAME.may_announced_endless = true
		G.GAME.may_endless_mode = true
	end
end

-- don't ask
local vanf_cest = card_eval_status_text
function card_eval_status_text(card, eval_type, amt, percent, dir, extra)
    if extra and extra.message and type(extra.message) == 'table' then
		extra.message = extra.message[1]
	end
	vanf_cest(card, eval_type, amt, percent, dir, extra)
end


local function FALLBACK(x, y)
	if may.invalid_number(x) or to_big(x):isInfinite() or to_big(x):isNaN() then 
		return to_big(vanf_gba(math.floor(y)) * (1 + (y - math.floor(y)))):normalize()
	end
	return to_big(x):mul(1):normalize()
end

-- Custom Blind Scaling
-- if you're wondering why there's to many to_bigs, I AM SICK AND TIRED OF OMEGANUM INFINITY WHAT DO YOU MEAN ARITHMETIC ERROR WHAT DID I EVEN DO WRONG 
local vanf_gba = get_blind_amount
function get_blind_amount(ante)
	local big1 = to_big(1)
	local big3 = to_big(3)
	local big1_5 = to_big(1.5)
	local big10 = to_big(10)
	local big20 = to_big(20)
	local big30 = to_big(30)
	local big35 = to_big(35)
	local big50 = to_big(50)
	local big0_1 = to_big(0.1)
	local big0_2 = to_big(0.2)
	local big0_3 = to_big(0.3)
	local big0_35 = to_big(0.35)
	local big0_5 = to_big(0.5)
	-- Fix decimal ante
	local amount = to_big(vanf_gba(math.floor(ante)) * (big1 + (ante - math.floor(ante)))) 
	if (G.GAME.may_instability or 0) > 0 then
		amount = to_big(amount):arrow(1, to_big(big1 + (to_big(G.GAME.may_instability) * big0_1)))
	    amount = FALLBACK(amount, ante)
	end
	if G.GAME.may_instability_blind_increases and #G.GAME.may_instability_blind_increases > 0 then
		for k, v in ipairs(G.GAME.may_instability_blind_increases) do
		    amount = to_big(amount):arrow(v[1], to_big(v[2]))
        end
	    amount = FALLBACK(amount, ante)
	end
	if may.conf.scaling then
		ante = to_big(math.abs(ante or 1))
		local mythic = to_big(G.GAME.may_mythic_scaling or 0)
		local transcendent = to_big(G.GAME.may_transcendent_scaling or 0)
		local interdimensional = to_big(G.GAME.may_interdimensional_scaling or 0) 
		local ethereal = to_big(G.GAME.may_ethereal_scaling or 0)
		local surreal = to_big(G.GAME.may_surreal_scaling or 0)
		local hyperascendant = to_big(G.GAME.may_hyperascendant_scaling or 0)
		if mythic > to_big(0) then
			amount = to_big(amount):arrow(1, to_big(((mythic * ((big20 + (to_big(ante) * big0_1)) + big1)))))
		    amount = FALLBACK(amount, ante)
	    end
		if transcendent > to_big(0) then
			amount = to_big(amount):arrow(1, to_big((transcendent * (big30 + (to_big(ante) * big0_3)) + big1)))
		    amount = FALLBACK(amount, ante)
	    end
		if interdimensional > to_big(0) then
			amount = to_big(amount):arrow(2, to_big((interdimensional * ((big35 + (to_big(ante) * big0_35)) + big1))))
		    amount = FALLBACK(amount, ante)
	    end
		if ethereal > to_big(0) then 
			amount = to_big(amount):arrow(3, to_big((ethereal * ((big50 + (to_big(ante) * big0_5)) + big1))))
		    amount = FALLBACK(amount, ante)
	    end
		if surreal > to_big(0) then 
			amount = to_big(amount):arrow(4, to_big(surreal * (to_big(ante) * big0_1) + big1_5))
		    amount = FALLBACK(amount, ante)
	    end
		if hyperascendant > to_big(0) then
			amount = to_big(amount):arrow(to_big(math.floor(big3 + to_big(ante):logBase(big3) * (hyperascendant + big1))), to_big((hyperascendant * ((big50 + (to_big(ante) * big0_5)) + big1))))
		end
	end
	amount = FALLBACK(amount, ante)
	return to_big(amount or vanf_gba(math.floor(ante)) * (big1 + (ante - math.floor(ante)))):mul(big1):normalize()
end

local vanf_cuc = Card.use_consumeable
function Card:use_consumeable(area, copier)
	vanf_cuc(self)
	G.GAME.may_galileo_data = G.GAME.may_galileo_data or {}
	if self:gc().set == 'may_modifiercard' and self:gc().key ~= 'c_may_nostalgic_card' then
		G.GAME.last_modifier_card = self:gc().key
	end
	G.GAME.last_consumable = self:gc().key
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
		if self:gc().set == 'Tarot' then 
			G.GAME.last_tarot = self:gc().key
		elseif self:gc().set == 'Planet' and (self:gc().planet_rarity or 0) < 1 then 
			G.GAME.last_planet = self:gc().key
        elseif self:gc().set == 'Spectral' and not self:gc().hidden then 
			G.GAME.last_spectral = self:gc().key
		end
	return true end}))
	if self:gc().set == 'Planet' and (self:gc().planet_rarity or 0) < 1 then
		table.insert(G.GAME.may_galileo_data, self:gc().key)
		if #G.GAME.may_galileo_data > 5 then 
			table.remove(G.GAME.may_galileo_data, 1)
		end
	end
	if self:gc().pools and self:gc().pools.RingSystem then
		may.toggle_ring_display(true)
	end
end

local vanf_csc2 = Card.sell_card
function Card:sell_card()
	vanf_csc2(self)
	if self.ability.consumeable and not (self:gc().hidden or self:gc().no_grc or self:gc().no_doe) then
		G.GAME.may_last_consumable_sold = self:gc().key
	end
    if self.area == G.jokers then 
        G.GAME.may_jokers_sold = (G.GAME.may_jokers_sold or 0) + 1
    end
end

local vanf_csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    vanf_csa(self, center, initial, delay_sprites)
    if G and G.GAME.blind then 
        if G.GAME.may_pack_bonuses then 
            if self:gc().kind then 
                if G.GAME.may_pack_bonuses[self:gc().kind] then 
                    self.ability.extra = self.ability.extra + (G.GAME.may_pack_bonuses[self:gc().kind].cards or 0)
                    self.ability.choose = self.ability.choose + (G.GAME.may_pack_bonuses[self:gc().kind].choices or 0)
                end 
            end 
        end
    end
    if (self:gc().kind or '') == 'Standard' and #SMODS.find_card('v_may_card_tycoon') ~= 0 then
        if self:gc().key == 'p_standard_normal_1' or self:gc().key == 'p_standard_normal_2' or self:gc().key == 'p_standard_normal_3' or self:gc().key == 'p_standard_normal_4' then
            self:set_ability(G.P_CENTERS.p_may_b_premium1)
        elseif self:gc().key == 'p_standard_jumbo_1' or self:gc().key == 'p_standard_jumbo_2' then 
            self:set_ability(G.P_CENTERS.p_may_b_jumbo_premium1)
        elseif self:gc().key == 'p_standard_mega_1' or self:gc().key == 'p_standard_mega_2' then 
            self:set_ability(G.P_CENTERS.p_may_b_mega_premium1) 
        end 
    end 
end

local vanf_ed = ease_dollars
function ease_dollars(mod, instant)
	if to_big(mod) == to_big(0) then instant = true end
    vanf_ed(mod, to_big(mod or 0) == to_big(0) and true or instant)
end

-- Taken from Partner
-- Prevents Displays from getting too close to the screen edges
local Card_update_ref = Card.update
function Card:update(dt)
    Card_update_ref(self, dt)
    if self:gc().set == "may_display" and not self.states.drag.is then
        if self.T.x+self.T.w > G.ROOM.T.w then
            self.T.x = G.ROOM.T.w-self.T.w
        elseif self.T.x < 0 then
            self.T.x = 0
        end
        if self.T.y+self.T.h > G.ROOM.T.h then
            self.T.y = G.ROOM.T.h-self.T.h
        elseif self.T.y < 0 then
            self.T.y = 0
        end
    end
end

local vanf_er = end_round
function end_round()
	vanf_er()
	if G.GAME.blind_on_deck == 'Boss' then
		G.GAME.may_bosses_defeated = (G.GAME.may_bosses_defeated or 0) + 1
	end
end

-- Starting paramaters buff
-- Taken from Glue for Modpacks
local vanf_gigo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = vanf_gigo(self)
    ret.modifiers.extra_boosters = (ret.modifiers.extra_boosters or 0) + 1
    ret.shop.joker_max = ret.shop.joker_max + 2
    ret.starting_params.consumable_slots = (ret.starting_params.consumable_slots or 0) + 3
	return ret
end

local vanf_csd = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if SMODS.has_enhancement(self, 'm_stone') then
		G.GAME.may_stones_destroyed = (G.GAME.may_stones_destroyed or 0) + 1
	end
	if self:gc().indestructible and not self.ability.merging then
		card_eval_status_text(self, 'extra', nil, nil, nil, { message = {'Nope!'}, colour = G.C.DARK_EDITION, delay = 0.45, sound = 'cancel' })
		self.highlighted = false
		return
	end
	if self.ability.set ~= 'Voucher' then
		if (self.edition or {}).may_metallic and not self.ability.merging then
			if self.ability.consumeable then
				local success = 0
				for i=1, self:getQty() do
					if SMODS.pseudorandom_probability(s, "may_metallic", (G.GAME.probabilities.normal or 1), 2, "Metallic") then
						success = success + 1
					end
				end
				if success > 0 then
					card_eval_status_text(self, 'extra', nil, nil, nil, { message = {'Nope!'}, colour = G.C.DARK_EDITION, delay = 0.45, sound = 'cancel' })
					self.highlighted = false
					self.area:remove_card(self)
					G.consumeables:emplace(self)
					self:setQty(success)
					return
				else
					vanf_csd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
				end
			else 
				if SMODS.pseudorandom_probability(s, "may_metallic", (G.GAME.probabilities.normal or 1), 2, "Metallic") then
					card_eval_status_text(self, 'extra', nil, nil, nil, { message = {'Nope!'}, colour = G.C.DARK_EDITION, delay = 0.45, sound = 'cancel' })
					self.highlighted = false
					if (self.area == G.play or self.area == G.hand) then
						self.area:remove_card(self)
						G.deck:emplace(self)
					end
					return
				else
					vanf_csd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
				end
			end
		end
	end
	vanf_csd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
	G.E_MANAGER:add_event(Event({func = function()
		if G and G.GAME and G.vouchers then
		    G.GAME.used_vouchers = {}
		    for i, v in ipairs(G.vouchers.cards) do
			    G.GAME.used_vouchers[v.config.center_key] = true
			end
        end
	return true end}))
end

local vanf_ebc = ease_background_colour
function ease_background_colour(args)
	local yotta
	if G.pack_cards then 
		for k, v in pairs(G.pack_cards) do
			if type(v) == 'table' and v.gc and v:gc().set == 'yottacards' then
				yotta = true
				break
			end 
		end
	end 
	if yotta then
		args.new_colour = G.C.YELLOW
		args.special_colour = darken(G.C.YELLOW, 0.5)
		args.contrast = 2
	end
	vanf_ebc(args)
end

local vanf_gfec = G.FUNCS.end_consumeable
G.FUNCS.end_consumeable = function(e, delayfac)
	local prev_state = G.STATE
	vanf_gfec(e, delayfac)
	G.STATE = prev_state
	--[[G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2, func = function()
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1, func = function()
            G.TAROT_INTERRUPT = nil
			--G.STATE = prev_state
            G.CONTROLLER.locks.use = false
			if G.booster_pack and G.booster_pack.alignment then
                G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                G.booster_pack.alignment.offset.py = nil
			end
            if G.shop and G.shop.alignment then 
                G.shop.alignment.offset.y = G.shop.alignment.offset.py
                G.shop.alignment.offset.py = nil
				G.STATE = G.STATES.SHOP
            end
            if G.blind_select and G.blind_select.alignment then
                G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.py
                G.blind_select.alignment.offset.py = nil
				G.STATE = G.STATES.BLIND_SELECT
            end
            if G.round_eval and G.round_eval.alignment then
                G.round_eval.alignment.offset.y = G.ROOM.T.y + 15
                G.round_eval.alignment.offset.x = 0
            end
        return true end}))
    return true end}))]] 
end

local vanf_caath = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
	if card and card.ability.in_voucher_tab then
		card.area:unhighlight_all() 
		card.zoom = true		
	end
	vanf_caath(self, card, silent)
end

local vanf_catd = Card.add_to_deck
function Card:add_to_deck(from_debuff)
	vanf_catd(self, from_debuff)
	if self.gc and self:gc().set == 'may_display' then
	    if self.area == G.consumeables or self.area == G.jokers then
		    self:set_ability(may.random_consumable('display_failsafe', nil, nil, G.P_CENTER_POOLS.Consumeable, true), nil, true)
		end 
	end	
end