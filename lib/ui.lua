-- UI
-- See modtabs.lua for Mayhem's config pages

-- Custom text and color stuff with Score Operator
-- Inspired by POLTERWORX, no code use however
function may.cosmetic_score_operator(text, color, sound, no_juice, ignore_identical)
	-- man
	local op = G.HUD:get_UIE_by_ID('hand_text_area').children[1].children[2].UIBox:get_UIE_by_ID('hand_operator_container').children[1] 
	G.GAME.may_last_cosmetic_score_op = G.GAME.may_last_cosmetic_score_op or {}
	if ((G.GAME.may_last_cosmetic_score_op.text or '') ~= (text or 'a') and (G.GAME.may_last_cosmetic_score_op.color or {}) ~= (color or {1})) or ignore_identical then
	    G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
		    G.GAME.may_cosmetic_op = true
		    if text then
			    op.config.text = text
			    op.config.scale = 0.9 - (math.max(string.len(text) - 4, 0) * 0.05)
		    end
		    if color then 
			    op.config.colour = color
		    end
		    if sound then
			    if type(sound) == 'string' then 
				    if sound ~= 'SILENT' then
						play_sound(sound)
				    end
			    elseif type(sound) == 'table' then 
				    play_sound(sound[1], sound[2], sound[3])
			    elseif type(sound) == 'function' then 
				    sound(text, color, no_juice)
			    end 
		    else
			    play_sound('button', 1.1, 0.75)
		    end
		    if not no_juice then
			    op:juice_up(0.8, 0.5)
		    end
		    G.HUD:get_UIE_by_ID('hand_text_area').UIBox:recalculate()
        return true end}))
	end
	G.GAME.may_last_cosmetic_score_op = {
		text = text,
		color = color,
	}
end

function may.refresh_score_operator(delay, immediate)
	if immediate then
	    G.GAME.may_cosmetic_op = nil
		G.FUNCS.SMODS_scoring_calculation_function(G.HUD:get_UIE_by_ID('hand_text_area'))
		G.HUD:get_UIE_by_ID('hand_operator_container').UIBox:recalculate()
        SMODS.refresh_score_UI_list()
	else
		local f_delay = 0.3
	    if delay then 
			f_delay = type(delay) == 'number' and delay or (tonumber(delay) * G.SETTINGS.GAMESPEED)
		end
		G.E_MANAGER:add_event(Event({delay = f_delay, trigger = 'immediate', func = function()
			if G.GAME.may_cosmetic_op then
			    play_sound('button', 1.1, 0.75)
			    G.HUD:get_UIE_by_ID('hand_text_area').children[1].children[2].UIBox:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(0.8, 0.5)
			    G.GAME.may_cosmetic_op = nil
			    G.FUNCS.SMODS_scoring_calculation_function(G.HUD:get_UIE_by_ID('hand_text_area'))
                G.HUD:get_UIE_by_ID('hand_operator_container').UIBox:recalculate()
                SMODS.refresh_score_UI_list()
			end
		return true end}))
	end
end

-- Hacky fix so color resets properly
for k, v in pairs(SMODS.Scoring_Calculations) do
	if not v.colour then 
		SMODS.Scoring_Calculation:take_ownership(k, {
			colour = G.C.MULT
		}, true)
	end
end

-- Allow Vouchers and Booster Packs in Consumable Slots
-- Code mostly from Entropy
G.FUNCS.can_open_pack = function(e)
    local card = e.config.ref_table
    if not may.canuse() then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.MULT
        e.config.button = 'open_pack'
    end
end

G.FUNCS.open_pack = function(e)
    local card = e.config.ref_table
    --[[G.GAME.DefineBoosterState = G.STATE
    delay(0.1)
    local area = card.area
    if card.ability.booster_pos then G.GAME.current_round.used_packs[card.ability.booster_pos] = 'USED' end
	--G.hand:remove()
    if not card.from_tag then 
      G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
    end
    if card.RPerkeoPack then
        G.RPerkeoPack = true
    end
    if G.shop and not G.shop.alignment.offset.py then
        G.shop.alignment.offset.py = G.shop.alignment.offset.y
        G.shop.alignment.offset.y = G.ROOM.T.y + 29
    end
    if G.blind_select and not G.blind_select.alignment.offset.py then
        G.blind_select.alignment.offset.py = G.blind_select.alignment.offset.y
        G.blind_select.alignment.offset.y = G.ROOM.T.y + 39
    end
    if G.round_eval and not G.round_eval.alignment.offset.py then
        G.round_eval.alignment.offset.py = G.round_eval.alignment.offset.y
        G.round_eval.alignment.offset.y = G.ROOM.T.y + 29
    end
    e.config.ref_table.cost = 0
    e.config.ref_table:open()]] 
	if #G.hand.cards > 0 then
		for k, v in ipairs(G.hand.cards) do
		    draw_card(G.hand, G.discard, 1, 'up', true, v, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				play_sound('card1')
			return true end}))
		end
	end
	card.from_tag = true
	card.cost = 0
	if card.area then
		card.area:remove_card(card)
        draw_card(card.area, G.play, 1, 'up', true, card, nil, true) 
	end
	G.E_MANAGER:add_event(Event({delay = 0.4, trigger = 'after', func = function()
		G.CONTROLLER.locks.use = nil
		if card.ability.name:find('Arcana') then 
            G.STATE = G.STATES.TAROT_PACK
        elseif card.ability.name:find('Celestial') then
            G.STATE = G.STATES.PLANET_PACK
        elseif card.ability.name:find('Spectral') then
            G.STATE = G.STATES.SPECTRAL_PACK
        elseif card.ability.name:find('Standard') then
            G.STATE = G.STATES.STANDARD_PACK
        elseif card.ability.name:find('Buffoon') then
            G.STATE = G.STATES.BUFFOON_PACK
		else
			G.STATE = G.STATES.SMODS_BOOSTER_OPENED
        end
		card:remove()
	return true end}))
	G.FUNCS.use_card({ config = { ref_table = card } }) 
	-- cryptid.
    if card.ability.cry_multiuse and to_big(card.ability.cry_multiuse) > to_big(1) then
        local card = card
        card.ability.cry_multiuse = card.ability.cry_multiuse - 1
        card.ability.extra_value = -1 * math.max(1, math.floor(card.cost/2))
        card:set_cost()
        delay(0.4)
        card:juice_up()
        play_sound('generic1')
        attention_text({
            text = format_ui_value(card.ability.cry_multiuse),
            scale = 1.1,
            hold = 0.6,
            major = card,
            backdrop_colour = G.C.SET[card.config.center.set],
            align = 'bm',
            offset = {x = 0, y = 0.2}
        })
        local c2 = copy_card(card)
        c2:add_to_deck()
        area:emplace(c2)
    end
end

G.FUNCS.can_redeem_voucher = function(e)
    local card = e.config.ref_table
    if not may.canuse() then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.MULT
        e.config.button = 'redeem_voucher'
    end
end

G.FUNCS.redeem_voucher = function(e)
    local card = e.config.ref_table
	if card.config.center.set == 'Voucher' then
		may.redeem_specific(card)
	end
end

G.FUNCS.may_can_sell_voucher = function(e)
    local card = e.config.ref_table
    if not may.canuse() then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'may_sell_voucher'
    end
end

G.FUNCS.may_sell_voucher = function(e)
    local orig_card = e.config.ref_table
	local key = orig_card:gc().key
	local card
	for k, v in pairs(G.vouchers.cards) do
	    if v:gc() == orig_card:gc() then
		    card = v
			break
		end
	end 
	if card then
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
            play_sound('coin2')
            orig_card:juice_up(0.3, 0.4)
        return true end}))
        delay(0.2)
	    local value = card.sell_cost
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
            card:unapply_to_run()
			card:start_dissolve({G.C.GOLD})
			orig_card:start_dissolve({G.C.GOLD})
		    G.vouchers:remove_card(card)
		    G.GAME.used_vouchers[key] = nil
	    return true end})) 
	    G.E_MANAGER:add_event(Event({func = function()
		    if G and G.GAME and G.vouchers then
				G.GAME.used_vouchers = {}
				for i, v in ipairs(G.vouchers.cards) do
				    if v ~= (card or {}) then
					    G.GAME.used_vouchers[v.config.center_key] = true
				    end
			    end
                G.E_MANAGER:add_event(Event({func = function()		
					G.GAME.used_vouchers[key] = nil
			    return true end}))
            end
		    card = nil
	    return true end}))
	    ease_dollars(value)
	else
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
            play_sound('may_error')
            orig_card:juice_up(0.3, 0.4)
        return true end}))
	end
end

-- Creates the pagers that split up really long joker descriptions
function may.pager(length)
	return may.conf.pagers and '{C:inactive,s:0.8}'..string.rep('-', length or 60)..'{}' or ''
end

-- Returns appropriate hyperoperational Mult/Chips formatting for anything above X
function may.hyp(arrow, multchips)
	if may.conf.simple_hyper then
		if multchips == 'mult' then
			return '{X:mult,C:white}'
		elseif multchips == 'chips' then
			return '{X:chips,C:white}'
		elseif multchips == 'multchips' then
			return '{X:purple,C:white}'
		elseif multchips == 'score' then
			return '{X:may_score,C:white}'
		end
	else
		if multchips == 'mult' then
			if arrow == 1 then
				return '{X:mult,C:black}'
			elseif arrow == 2 then
				return '{X:black,C:mult}'
			elseif arrow == 3 then
				return '{X:may_interdimensional,C:mult}'
			else
				return '{X:may_surreal,C:mult}'
			end
		elseif multchips == 'chips' then
			if arrow == 1 then
				return '{X:chips,C:black}'
			elseif arrow == 2 then
				return '{X:black,C:chips}'
			elseif arrow == 3 then
				return '{X:may_interdimensional,C:chips}'
			else
				return '{X:may_surreal,C:chips}'
			end
		elseif multchips == 'multchips' then
			if arrow == 1 then
				return '{X:purple,C:black}'
			elseif arrow == 2 then
				return '{X:black,C:purple}'
			elseif arrow == 3 then
				return '{X:may_interdimensional,C:purple}'
			else
				return '{X:may_surreal,C:purple}'
			end
		elseif multchips == 'score' then
			if arrow == 1 then
				return '{X:may_score,C:black}'
			elseif arrow == 2 then
				return '{X:black,C:may_score}'
			elseif arrow == 3 then
				return '{X:may_interdimensional,C:may_score}'
			else
				return '{X:may_surreal,C:may_score}'
			end
		end
	end
end

-- Score shakiness 
-- slightly modified code from POLTERWORX

function DynaText:pulse(amt, shake)
	self.config.pulse = {
		speed = 40,
		width = 2.5,
		start = G.TIMERS.REAL, 
		amount = (amt or 0.2) * may.conf.Shakiness.pulsemult,
		silent = false,
		shake_screen = shake
	}
end

function DynaText:set_quiver(amt)
    self.config.quiver = {
        speed = 0.5,
        amount = (amt or 0.7) * may.conf.Shakiness.quivermult,
        silent = false
    }
end

function G.FUNCS.tsj_specific(e, quiver, pulse, juice, shake_screen)
	if e and e.config and e.config.object and next(e.config.object) then
		if may.conf.Shakiness.unlimitquiver then
			e.config.object:set_quiver(quiver)
		else
			e.config.object:set_quiver(math.min(may.conf.Shakiness.quiverlimit, quiver))
		end
		if may.conf.Shakiness.unlimitpulse then
			e.config.object:pulse(pulse, shake_screen)
		else
			e.config.object:pulse(math.min(may.conf.Shakiness.pulselimit, pulse), shake_screen)
		end
		e.config.object:update_text()
		e.config.object:align_letters()
		e:update_object()
		if juice then
			e.config.object:juice_up()
		end
	end
end

-- Automated Fusion notice generator
function may.add_fusion_text(joker1, joker2, condition)
	condition = condition or 'ERROR'
	if may.conf.short_fusion then
		return {
			"{C:dark_edition}FUSION:{} {C:attention}"..joker1.."{} {C:chips}>>{} {C:attention}"..joker2.."{}",
			"{C:may_surreal,s:1.1,u:may_surreal}CONDITION{}",
			condition
		}
	else
	    return {
		    "This Joker can {C:dark_edition}fuse{} with", 
			"{C:attention}"..joker1.."{} to create {C:attention}"..joker2.."{}", 
		    may.pager(math.max(string.len(condition), string.len("This Joker can {C:dark_edition}fuse{} with")) * 0.6), 
		    '{C:may_surreal,s:1.2,u:may_surreal}Fusion Condition{}', 
		    condition
	    }
	end
end

-- Reserving functionality 
-- Mostly taken from Entropy 
G.FUNCS.may_can_reserve = function(e)
	local card = e.config.ref_table
	if (#G.consumeables.cards < G.consumeables.config.card_limit) or (card.edition and card.edition.key == 'e_negative') then
		e.config.colour = G.C.GREEN
		e.config.button = "may_reserve"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.may_reserve = function(e)
	local card = e.config.ref_table
	G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
		local area = card.area
		card.area:remove_card(card)
		card:add_to_deck()
		if card.children.price then
			card.children.price:remove()
		end
		card.children.price = nil
		if card.children.buy_button then
			card.children.buy_button:remove()
		end
		card.children.buy_button = nil
		G.consumeables:emplace(card)
		if area == G.pack_cards then
		    G.GAME.pack_choices = G.GAME.pack_choices - 1
		    if G.GAME.pack_choices <= 0 then
			    G.FUNCS.end_consumeable(nil, delay_fac)
		    end
		end
		play_sound('generic1') 
	return true end}))
end 

local vanf_uasb = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local ui = vanf_uasb(card)
	-- Reserving functionality mostly taken from Entropy
	if card.area == G.pack_cards and G.pack_cards and card.config.center.reserve then
		return {n = G.UIT.ROOT, config = { padding = -0.07, colour = G.C.CLEAR }, nodes = {
				{n = G.UIT.R, config = {ref_table = card, r = 0.08, padding = 0.13, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.5 * card.T.w - 0.15, minh = 0.15 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "use_card", func = card:is_playing_card() and "can_reserve_card_to_deck" or "may_can_reserve", handy_insta_action = 'use'}, nodes = {
					{n = G.UIT.T, config = {text = 'RESERVE', colour = G.C.UI.TEXT_LIGHT, scale = 0.65, shadow = true}},
				}},
				{n = G.UIT.R, config = {ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.5 * card.T.w - 0.15, minh = 0.1 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "you matter :blush:", func = "can_use_consumeable", handy_insta_action = 'use'}, nodes = {
					{n = G.UIT.T, config = {text = localize("b_use"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}},
				}},
				{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
				{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
				{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
				{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
			},
		}
	end
	if card.area ~= G.pack_cards and card.config.center.may_permanent or card.config.center.indestructible then
		return {n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {
			{n=G.UIT.C, config={align = "cr"}, nodes={
			}}
		}}
	end
	-- Sell redeemed vouchers
	if card.ability.in_voucher_tab and may.has_card('v_may_reconfigure') and (card.gc and not card:gc().may_unsellable_voucher) then
		return {n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {
            {n = G.UIT.R, config = {ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.5 * card.T.w - 0.15, minh = 0.1 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "may_sell_voucher", func = "may_can_sell_voucher", handy_insta_action = 'use'}, nodes = {
				{n = G.UIT.T, config = {text = localize("b_sell"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}},
			}},
			{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
			{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
		}}
	end
	-- Joker abilities
	if card.area == G.jokers and card.config.center.key == 'j_may_ourania_kleidaria' then
        return {n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {
            {n=G.UIT.R, config={align = 'cl'}, nodes={
			    {n=G.UIT.C, config={align = "cl"}, nodes={
				    {n=G.UIT.C, config={ref_table = card, align = "cr", padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
					    {n=G.UIT.B, config = {w=0.1,h=0.6}},
						{n=G.UIT.C, config={align = "tm"}, nodes={
							{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
								{n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
							}},
							{n=G.UIT.R, config={align = "cm"}, nodes={
							    {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
							    {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                            }},
					    }}
				    }},
                }}, 
            }}, 
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                {n=G.UIT.C, config={align = "cl"}, nodes={
                    {n=G.UIT.C, config={ref_table = card, align = "cl", padding = 0.2, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'may_ourania_kleidaria_ability', func = 'may_can_use_ourania_kleidaria_ability', handy_insta_action = 'ability'}, nodes={
                        {n=G.UIT.B, config = {w=0.1,h=0.6}},
                        {n=G.UIT.C, config={align = "cm"}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                                {n=G.UIT.T, config={text = 'ABILITY',colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                            }}
                        }},
                    }}, 
                }}, 
            }}
		}}
	end
	if card.area == G.jokers and card.config.center.key == 'j_may_guacamole' then
        return {n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {
            {n=G.UIT.R, config={align = 'cl'}, nodes={
			    {n=G.UIT.C, config={align = "cl"}, nodes={
				    {n=G.UIT.C, config={ref_table = card, align = "cr", padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
					    {n=G.UIT.B, config = {w=0.1,h=0.6}},
						{n=G.UIT.C, config={align = "tm"}, nodes={
							{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
								{n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
							}},
							{n=G.UIT.R, config={align = "cm"}, nodes={
							    {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
							    {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                            }},
					    }}
				    }},
                }}, 
            }}, 
            {n=G.UIT.R, config={align = 'cl'}, nodes={
                {n=G.UIT.C, config={align = "cl"}, nodes={
                    {n=G.UIT.C, config={ref_table = card, align = "cl", padding = 0.2, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'may_guacamole_ability', func = 'may_can_use_guacamole_ability', handy_insta_action = 'ability'}, nodes={
                        {n=G.UIT.B, config = {w=0.1,h=0.6}},
                        {n=G.UIT.C, config={align = "cm"}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                                {n=G.UIT.T, config={text = 'ABILITY',colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                            }}
                        }},
                    }}, 
                }}, 
            }}
		}}
	end
	-- Booster Packs and Vouchers in Consumable Slots
	if card:gc().set == "Voucher" and card.area == G.consumeables then
		return {n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    {n=G.UIT.C, config={align = "cr"}, nodes={
                        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.2, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
                            {n=G.UIT.B, config = {w=0.1,h=0.6}},
                            {n=G.UIT.C, config={align = "tm"}, nodes={
                                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                                    {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                                }},
                                {n=G.UIT.R, config={align = "cm"}, nodes={
                                    {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                                    {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                                }}
                            }}
                        }},
                    }}
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    {n=G.UIT.C, config={align = "cr"}, nodes={ 
                        {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.2, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'redeem_voucher', func = 'can_redeem_voucher', handy_insta_action = 'use'}, nodes={
                            {n=G.UIT.B, config = {w=0.1,h=0.6}},
                            {n=G.UIT.T, config={text = localize('b_redeem'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                        }}
                    }}
                }},
            }},
        }}
    end
	if card:gc().set == "Booster" and card.area == G.consumeables then
		return {n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    {n=G.UIT.C, config={align = "cr"}, nodes={
                        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
                            {n=G.UIT.B, config = {w=0.1,h=0.6}},
                            {n=G.UIT.C, config={align = "tm"}, nodes={
                                {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                                    {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                                }},
                                {n=G.UIT.R, config={align = "cm"}, nodes={
                                    {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                                    {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                                }}
                            }}
                        }},
                    }}
                }},
                {n=G.UIT.R, config={align = 'cl'}, nodes={
                    {n=G.UIT.C, config={align = "cr"}, nodes={ 
                        {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'open_pack', func = 'can_open_pack', handy_insta_action = 'use'}, nodes={
                            {n=G.UIT.B, config = {w=0.1,h=0.6}},
                            {n=G.UIT.T, config={text = localize('b_open'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                        }}
                    }}
                }},
            }},
        }}
    end
	return ui
end

-- Overhaul vouchers tab in run info so it can handle many vouchers + Selling vouchers
-- taken from Betmma Better Vouchers This Run UI
--if #SMODS.find_mod('BetterVouchersThisRunUI') == 0 then
	local PAIRS_PER_ROW = 5
    local ROWS_PER_PAGE = 2
    
	function G.UIDEF.used_vouchers()
		G.SETTINGS.paused = false
        local silent = false
        local keys_used = {}
        local vouchers_used = {}
        local area_count = 0
        local voucher_areas = {}
        local voucher_pairs = {}
        local voucher_rows = {}
        G.your_collection={}
        for k, v in ipairs(G.P_CENTER_POOLS.Voucher) do
            local key = 1 + math.floor((k-0.1)/2)
            keys_used[key] = keys_used[key] or {}
            if G.GAME.used_vouchers[v.key] then 
                keys_used[key][#keys_used[key]+1] = v
                table.insert(vouchers_used, v)
                silent=true
            end
        end
        local keys_used2={}
        for k, v in ipairs(keys_used) do 
            if next(v) then
                area_count = area_count + 1
                table.insert(keys_used2,v)
            end
        end
        keys_used=keys_used2

        for k, v in ipairs(keys_used) do 
            if k>PAIRS_PER_ROW*ROWS_PER_PAGE then break end
            if next(v) then
                if #voucher_areas and #voucher_areas % PAIRS_PER_ROW==0 then 
                    table.insert(voucher_rows, 
                        {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_pairs}
                    )
                    voucher_pairs = {}
                end
                voucher_areas[#voucher_areas + 1] = CardArea(
                    G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
                    (#v == 1 and 1 or 1.33)*G.CARD_W,
                    (area_count >=10 and 1 or 1.3)*G.CARD_H, 
                    {card_limit = 2, type = 'voucher', highlight_limit = 2})
                G.your_collection[#G.your_collection+1]=voucher_areas[#voucher_areas]
                for kk, vv in ipairs(v) do 
                    local center = G.P_CENTERS[vv.key]
                    local card = Card(voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w/2, voucher_areas[#voucher_areas].T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
                    card.ability.order = vv.order
					card.ability.in_voucher_tab = true
                    card:start_materialize(nil, silent)
					card.area = voucher_areas[#voucher_areas]
                    silent = true
                    voucher_areas[#voucher_areas]:emplace(card)
                end
            table.insert(voucher_pairs, 
                {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
                    {n=G.UIT.O, config={object = voucher_areas[#voucher_areas]}}
                }}
            )
            end
        end
        table.insert(voucher_rows, 
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_pairs}
        )
        local deck_tables = {}

        local voucher_options = {}
        for i = 1, math.ceil(area_count/(PAIRS_PER_ROW*ROWS_PER_PAGE)) do
            table.insert(voucher_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(area_count/(PAIRS_PER_ROW*ROWS_PER_PAGE))))
        end
        if not silent then
            local t ={n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {localize('ph_no_vouchers')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
            }}
            return t
        end
        INIT_COLLECTION_CARD_ALERTS()
        t={n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {localize('ph_vouchers_redeemed')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
            }},
            {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
            }},
            {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
              {n=G.UIT.R, config={align = "cm"}, nodes=voucher_rows},
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
                create_option_cycle({options = voucher_options, w = 4.5, cycle_shoulders = true, opt_callback = 'used_voucher_page', focus_args = {snap_to = true, nav = 'wide'}, current_option = 1, colour = G.C.RED, no_pips = true})
            }}
          }}
        return t
    end
	
    G.FUNCS.used_voucher_page = function(args)
        if not args or not args.cycle_config then return end
        local keys_used = {}
        local vouchers_used = {}
        local area_count = 0
        local voucher_areas = {}
        local voucher_pairs = {}
        local voucher_rows = {}
        for k, v in ipairs(G.P_CENTER_POOLS["Voucher"]) do
            local key = 1 + math.floor((k-0.1)/2)
            keys_used[key] = keys_used[key] or {}
            if G.GAME.used_vouchers[v.key] then 
                keys_used[key][#keys_used[key]+1] = v
                table.insert(vouchers_used,v)
                silent=true
            end
        end
        local keys_used2={}
        for k, v in ipairs(keys_used) do 
            if next(v) then
                area_count = area_count + 1
                table.insert(keys_used2,v)
            end
        end
        keys_used=keys_used2
        for j = 1, #G.your_collection do
            for i = #G.your_collection[j].cards,1, -1 do
                local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
                c:remove()
                c = nil
            end
        end
        for i = 1, #G.your_collection do
            v=keys_used[PAIRS_PER_ROW*ROWS_PER_PAGE*(args.cycle_config.current_option - 1)+i]
            if not v then break end
            for j = 1, #v do
                local center = v[j]
                if not center then break end
                local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
                card:start_materialize(nil, i>1 or j>1)
				card.area = voucher_areas[#voucher_areas]
				card.ability.in_voucher_tab = true
                G.your_collection[i]:emplace(card)
            end
        end
        INIT_COLLECTION_CARD_ALERTS()
    end
--end

-- Invulnerable Blinds 
-- Taken from POLTERWORX
local vanf_reb = G.FUNCS.reroll_boss

G.FUNCS.reroll_boss = function(e)
	local blind = G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss]
	if blind.ultra or blind.tainted then
		play_sound('cancel', 0.8, 1)
		play_sound('may_error')
		G.blind_select_opts.boss:juice_up()
		G.ROOM.jiggle = G.ROOM.jiggle + 0.2
	else
		return vanf_reb(e)
	end
end

local vanf_bd = Blind.disable
function Blind:disable()
	local blind = self.config.blind
	if blind then
		if blind.ultra or blind.tainted then
			play_sound('cancel', 0.8, 1)
			play_sound('may_error')
			SMODS.juice_up_blind()
			G.ROOM.jiggle = G.ROOM.jiggle + 0.2
			return true
		end
	end
	return vanf_bd(self)
end

-- support for hidden operators + cosmetic changes
function change_operator(amount)
	G.GAME.may_no_op_update = true
	local order = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + amount
	if not order then return end
	if G.GAME.current_scoring_calculation_key == "talisman_hyper" then
		G.GAME.hyper_operator = (G.GAME.hyper_operator or 2) + amount
		order = G.GAME.hyper_operator
	end
	local next = "add"
	local keys = {}
	for i, v in pairs(SMODS.Scoring_Calculations) do
		if v.order then
			keys[#keys+1] = i
		end
	end
	table.sort(keys, function(a, b) return SMODS.Scoring_Calculations[a].order < SMODS.Scoring_Calculations[b].order end)
	for i, v in pairs(keys) do
		if SMODS.Scoring_Calculations[v].order <= order and not SMODS.Scoring_Calculations[v].hidden then
			next = v
		end
	end
	if next then
		SMODS.set_scoring_calculation(next)
	end
	if amount > 0 then
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_increase_operator')
		return true end}))
	else
		G.E_MANAGER:add_event(Event({func = function()
			play_sound('may_decrease_operator')
		return true end}))
	end
    G.E_MANAGER:add_event(Event({func = function() 
	    G.E_MANAGER:add_event(Event({func = function()
			G.GAME.may_no_op_update = nil 
		return true end})) 
	return true end}))
end

local vanf_sssc = SMODS.set_scoring_calculation
function SMODS.set_scoring_calculation(key)
	vanf_sssc(key)
	G.E_MANAGER:add_event(Event({func = function()
		if not G.GAME.may_no_op_update then  
			play_sound('button', 1.1)
			play_sound('may_demitrigger', 1, 0.85)
		end
		-- man
	    G.HUD:get_UIE_by_ID('hand_text_area').children[1].children[2].UIBox:get_UIE_by_ID('hand_operator_container').children[1]:juice_up(0.8, 0.5)
    return true end}))
end

-- Prevent updating when doing cosmetic score operator
local vanf_gfsscf = G.FUNCS.SMODS_scoring_calculation_function
G.FUNCS.SMODS_scoring_calculation_function = function(e)
	if not G.GAME.may_cosmetic_op then
		vanf_gfsscf(e)
	end
end