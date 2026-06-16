-- Misc

-- Unredeem vouchers 
-- stolen from Cryptid
function Card:unredeem(silent)
	if self.ability.set == "Voucher" then
		if not self then
			return
		end
		local card = copy_card(self)
		card.ability.extra = copy_table(self.ability.extra)
		if not silent then
		    local area
		    if G.STATE == G.STATES.HAND_PLAYED then
			    if not G.redeemed_vouchers_during_hand then
				    G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
			    end
			    area = G.redeemed_vouchers_during_hand
		    else
			    area = G.play
		    end
		    if card.facing == "back" then
			    card:flip()
		    end
		    card:start_materialize()
		    area:emplace(card)
		end
		card.cost = 0
		card.shop_voucher = false
		local current_round_voucher = G.GAME.current_round.voucher
		if not self.debuff then
		    self:unapply_to_run()
		end
		if not silent then
		    stop_use()
			card.no_ui = true
			self.no_ui = true
		    if not self.config.center.discovered then
			    discover_card(self.config.center)
		    end
		    self.states.hover.can = false			
			local top_dynatext = nil
			local bot_dynatext = nil
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
				top_dynatext = DynaText({
					string = localize({
						type = "name_text",
						set = self.config.center.set,
						key = self.config.center.key,
					}),
					colours = { G.C.RED },
					rotate = 1,
					shadow = true,
					bump = true,
					float = true,
					scale = 0.9,
					pop_in = 0.6 / G.SPEEDFACTOR,
					pop_in_rate = 1.5 * G.SPEEDFACTOR,
				})
				bot_dynatext = DynaText({
					string = "Unredeemed...",
					colours = { G.C.RED },
					rotate = 2,
					shadow = true,
					bump = true,
					float = true,
					scale = 0.9,
					pop_in = 1.4 / G.SPEEDFACTOR,
					pop_in_rate = 1.5 * G.SPEEDFACTOR,
					pitch_shift = 0.25,
				})
				self:juice_up(0.3, 0.5)
				play_sound("card1")
				play_sound("timpani")
				self.children.top_disp = UIBox({
				    definition = {n = G.UIT.ROOT, config = { align = "tm", r = 0.15, colour = G.C.CLEAR, padding = 0.15 }, nodes = {
						{n = G.UIT.O, config = { object = top_dynatext } },
					}},
					config = { align = "tm", offset = { x = 0, y = 0 }, parent = self },
				})
				self.children.bot_disp = UIBox({
				    definition = {n = G.UIT.ROOT, config = { align = "tm", r = 0.15, colour = G.C.CLEAR, padding = 0.15 }, nodes = {
						{ n = G.UIT.O, config = { object = bot_dynatext } },
					}},
				    config = { align = "bm", offset = { x = 0, y = 0 }, parent = self },
				})
			return true end}))
			delay(0.6)
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 2.6, func = function()
				top_dynatext:pop_out(4)
				bot_dynatext:pop_out(4)
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.5, func = function()
				self.children.top_disp:remove()
				self.children.top_disp = nil
				self.children.bot_disp:remove()
				self.children.bot_disp = nil
			return true end}))
	    end
		G.GAME.current_round.voucher = current_round_voucher
		if not silent then
		    G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, func = function()
				card:start_dissolve()
			    self:start_dissolve()
		    return true end}))
		end
		G.E_MANAGER:add_event(Event({func = function()
			if G and G.GAME and G.vouchers then
			    G.GAME.used_vouchers = {}
			    for i, v in ipairs(G.vouchers.cards) do
					if v ~= (card or {}) and v ~= (self or {}) then
						G.GAME.used_vouchers[v.config.center_key] = true
					end
				end
            end
		return true end})) 
	end
end

function Card:unapply_to_run(center)
	local center_table = {
		name = center and center.name or self and self.ability.name,
		extra = self and self.ability.extra or center and center.config.extra,
	}
	local obj = center or self.config.center
	if obj.unredeem and type(obj.unredeem) == "function" then
		obj:unredeem(self)
		return
	end

	if center_table.name == "Overstock" or center_table.name == "Overstock Plus" then
		G.E_MANAGER:add_event(Event({
			func = function()
				change_shop_size(-1)
				return true
			end,
		}))
	end
	if center_table.name == "Tarot Merchant" or center_table.name == "Tarot Tycoon" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.tarot_rate = G.GAME.tarot_rate / 2
				return true
			end,
		}))
	end
	if center_table.name == "Planet Merchant" or center_table.name == "Planet Tycoon" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.planet_rate = G.GAME.planet_rate / 2
				return true
			end,
		}))
	end
	if center_table.name == "Hone" or center_table.name == "Glow Up" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.edition_rate = G.GAME.edition_rate / 2
				return true
			end,
		}))
	end
	if center_table.name == "Magic Trick" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.playing_card_rate = 0
				return true
			end,
		}))
	end
	if center_table.name == "Crystal Ball" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
				return true
			end,
		}))
	end
	if center_table.name == "Clearance Sale" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.discount_percent = 0
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
	end
	if center_table.name == "Liquidation" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.discount_percent = 25
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then
						v:set_cost()
					end
				end
				return true
			end,
		}))
	end
	if center_table.name == "Reroll Surplus" or center_table.name == "Reroll Glut" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 2
				G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + 2)
				return true
			end,
		}))
	end
	if center_table.name == "Seed Money" then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.interest_cap = 25
				return true
			end,
		}))
	end
	if center_table.name == "Money Tree" then
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.GAME.used_vouchers.v_seed_money then
					G.GAME.interest_cap = 50
				else
					G.GAME.interest_cap = 25
				end
				return true
			end,
		}))
	end
	if center_table.name == "Grabber" or center_table.name == "Nacho Tong" then
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
		ease_hands_played(-1)
	end
	if center_table.name == "Paint Brush" or center_table.name == "Palette" then
		G.hand:change_size(-1)
	end
	if center_table.name == "Wasteful" or center_table.name == "Recyclomancy" then
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
		ease_discard(-1)
	end
	if center_table.name == "Antimatter" then
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					G.jokers.config.card_limit = G.jokers.config.card_limit - 1
				end
				return true
			end,
		}))
	end
	if center_table.name == "Hieroglyph" or center_table.name == "Petroglyph" then
		ease_ante(center_table.extra)
		G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
		G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1

		if center_table.name == "Hieroglyph" then
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
			ease_hands_played(1)
		end
		if center_table.name == "Petroglyph" then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
			ease_discard(1)
		end
	end
end

-- Taken from Entropy 
function Card:is_playing_card()
    if not G.deck then return end
    if self.area == G.play and self.ability.consumeable then return end
    if (self.area == G.hand or self.area == G.play or self.area == G.discard) and (self.config.center.set == "Default" or self.config.center.set == "Enhanced") then return true end
    for i, v in pairs(G.playing_cards) do
        if v == self then return true end
    end
end

if #SMODS.find_mod('Cryptid') == 0 then

local cuc = Card.can_use_consumeable
function Card:can_use_consumeable(any_state, skip_check)
	if not self.ability.consumeable then
		return false
	end
	return cuc(self, any_state, skip_check)
end

end

function may.generate_arrow_text(arrow, threshold)
	arrow = type(arrow) ~= 'string' and to_number(to_big(arrow)) or arrow
	if arrow == 'eq' then
		return '='
	elseif arrow == 0 then
		return 'X'
	elseif arrow == -1 then
		return '+'
	elseif arrow == -2 then
		return '-'
	elseif arrow <= -3 then
		return '/'
	end
	local str = ""
	if arrow < (threshold or 5) then
		str = string.rep('^', arrow)
	else
		str = '{'..arrow..'}'
	end
	return str
end

function generate_fact_text(fact, threshold)
	local str = ""
	if fact < (threshold or 10) then
		for i=1, to_number(fact), 1 do
			str = str .. '!'
		end
	else
		str = '!('..fact..')'
	end
	return str
end

function generate_expofact_text(fact, threshold)
	local str = ""
	if fact < (threshold or 10) then
		for i=1, to_number(fact), 1 do
			str = str .. '^!'
		end
	else
		str = '^!('..fact..')'
	end
	return str
end

function may.get_joker_count(rarity)
	local num = 0
	if G.jokers then
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == rarity then
				num = num + 1
			end
		end
	end
	return num
end

may.score_operator_colors = {
	'may_col_interdimensional', 
	'may_col_ethereal',
	'may_col_surreal', 
	'may_col_instability', 
	'may_col_e_otherworldly', 
	'may_col_hyperascendant', 
	'may_col_big_operator',
	'may_col_huge_operator', 
}

-- Mass redeem Vouchers
-- based on jl.voucher from jenlib
-- can take in table of keys, or number of random vouchers
function may.massvoucher(keys, amount, nobundle)
	if keys and type(keys) == 'table' then
		for k, v in pairs(keys) do
			if not G.P_CENTERS[v] then return end
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local card = Card(area.T.x + area.T.w/2 - G.CARD_W/2, area.T.y + area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[v],{bypass_discovery_center = true, bypass_discovery_ui = true})
			card:start_materialize()
			area:emplace(card)
			card.cost=0
			card.shop_voucher=false
			card:redeem()
			G.E_MANAGER:add_event(Event({delay = 0,func = function() 
				card:start_dissolve()
			return true end}))
		end
	else
		for i=1, amount, 1 do
			local key = get_next_voucher_key(true)
            if nobundle then 
                local tries = 0
      		  while G.P_CENTERS[key].pools and G.P_CENTERS[key].pools.VoucherBundle do
                    key = get_next_voucher_key(true)
                    tries = tries + 1
                    if tries > 50 then 
                        key = pseudorandom_element(G.P_CENTER_POOLS.Voucher, pseudoseed('failsafe'))
                        break
                    end
                end
            end
			if not G.P_CENTERS[key] then return end
			local area
			if G.STATE == G.STATES.HAND_PLAYED then
				if not G.redeemed_vouchers_during_hand then
					G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
				end
				area = G.redeemed_vouchers_during_hand
			else
				area = G.play
			end
			local card = Card(area.T.x + area.T.w/2 - G.CARD_W/2, area.T.y + area.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[key],{bypass_discovery_center = true, bypass_discovery_ui = true})
			card:start_materialize()
			area:emplace(card)
			card.cost=0
			card.shop_voucher=false
			card:redeem()
			G.E_MANAGER:add_event(Event({delay = 0,func = function() 
				card:start_dissolve()
			return true end}))
		end
	end
end

function may.ease_interest(arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.interest_amount = to_big(G.GAME.interest_amount or 0)
	if arrow >= 0 then
		G.GAME.interest_amount = G.GAME.interest_amount:arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.interest_amount = G.GAME.interest_amount:add(mod)
		elseif arrow == -2 then
			G.GAME.interest_amount = G.GAME.interest_amount:sub(mod)
		elseif arrow == -3 then
			G.GAME.interest_amount = G.GAME.interest_amount:div(mod)
		end
	end
	G.GAME.interest_amount = to_number(G.GAME.interest_amount)
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local op = may.generate_arrow_text(arrow)
			if arrow == -1 and to_big(mod) < to_big(mod) then
				op = '-'
			end
			attention_text({
				text = op..(number_format(math.abs(mod or 0)))..' Interest',
				scale = 0.85, 
				hold = 1,
				cover = handarea,
				cover_colour = G.C.MONEY,
				align = 'cm',
			})
			play_sound('coin4')
			play_sound('generic1')
		return true end}))
	end
end

function may.ease_interest_cap(arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.interest_cap = to_big(G.GAME.interest_cap or 0)
	if arrow >= 0 then
		G.GAME.interest_cap = G.GAME.interest_cap:arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.interest_cap = G.GAME.interest_cap:add(mod)
		elseif arrow == -2 then
			G.GAME.interest_cap = G.GAME.interest_cap:sub(mod)
		elseif arrow == -3 then
			G.GAME.interest_cap = G.GAME.interest_cap:div(mod)
		end
	end
	G.GAME.interest_cap = to_number(G.GAME.interest_cap)
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local op = may.generate_arrow_text(arrow)
			if arrow == -1 and to_big(mod) < to_big(mod) then
				op = '-'
			end
			attention_text({
				text = op..(number_format(math.abs(mod or 0)))..' Interest Cap',
				scale = 0.85, 
				hold = 1,
				cover = handarea,
				cover_colour = G.C.MONEY,
				align = 'cm',
			})
			play_sound('coin4')
			play_sound('generic1')
		return true end}))
	end
end

function may.change_blind_size(arrow, mod)
	local blind_chips = G.HUD:get_UIE_by_ID('chip_UI_count')
	if blind_chips then
		blind_chips:update()
	end
	G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
		local text = ''
		if arrow >= 1 then
			text = may.generate_arrow_text(arrow, 4)
		elseif arrow == 0  then
			text = 'X'
		elseif arrow == -1 then
			text = '+'
		elseif arrow == -2 then
			text = '-'
		elseif arrow <= -3 then
			text = '/'
		end
		local col = G.C.IMPORTANT
		attention_text({
			text = text..(to_number(mod) or 0),
			scale = 1, 
			hold = 1,
			cover = blind_chips,
			cover_colour = col,
			align = 'cm',
		})
		play_sound('highlight2', 0.715, 0.2)
		play_sound('generic1')
	return true end}))
end

function may.ease_instability(arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.may_instability = to_big(G.GAME.may_instability or 0)
	if arrow >= 0 then
		G.GAME.may_instability = G.GAME.may_instability:arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.may_instability = G.GAME.may_instability:add(mod)
		elseif arrow == -2 then
			G.GAME.may_instability = G.GAME.may_instability:sub(mod)
		elseif arrow == -3 then
			G.GAME.may_instability = G.GAME.may_instability:div(mod)
		end
	end
	G.GAME.may_instability = to_number(G.GAME.may_instability)
	G.GAME.may_instability_threshold = G.GAME.may_instability_threshold or 8
	G.GAME.may_instability_increase = G.GAME.may_instability_increase or 10
	local activated = 0
	while G.GAME.may_instability >= G.GAME.may_instability_threshold do
	    G.GAME.may_instability_threshold = G.GAME.may_instability_threshold * 2
		activated = activated + 1
		G.GAME.may_instability_blind_increases = G.GAME.may_instability_blind_increases or {}
		local N = 0
		if G.jokers then
		    for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_hyperascendant' then
					N = 35
					break
				elseif v:gc().rarity == 'may_surreal' then
					N = math.max(4, N)
				elseif v:gc().rarity == 'may_ethereal' then
					N = math.max(3, N)
				elseif v:gc().rarity == 'may_interdimensional' then
					N = math.max(2, N)
				elseif v:gc().rarity == 'may_transcendent' or v:gc().rarity == 'may_mythic' then
					N = math.max(1, N)
				end
			end
		end
		table.insert(G.GAME.may_instability_blind_increases, {N, G.GAME.may_instability_increase})
		G.GAME.may_instability_increase = math.min(1e300, to_big(G.GAME.may_instability_increase) ^ 3)
		may.change_blind_size(N, G.GAME.may_instability_increase)
	end
	if activated > 0 then
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
		    play_sound('may_instability_threshold')
		return true end}))
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text 
			if arrow >= 1 then
				text = may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = 'X'
			elseif arrow == -1 then
				text = '+'
			elseif arrow == -2 then
				text = '-'
			elseif arrow <= -3 then
				text = '/'
			end
			attention_text({
				text = text..(to_number(mod) or 0)..' Instability',
				scale = 0.8, 
				hold = 3,
				cover = handarea,
				cover_colour = SMODS.Gradients.may_col_instability,
				align = 'cm',
			})
			if ((arrow == -1 and to_big(mod) > to_big(0)) or (arrow >= 0 and to_big(mod) > to_big(1))) then
			    play_sound('may_instability_increase')
			else
				play_sound('may_demitrigger', 0.75)
				play_sound('may_forcetrigger', 0.5)
			end 
			play_sound('generic1')
			G.ROOM.jiggle = G.ROOM.jiggle + 2
		return true end}))
	end
end 

-- Money hyperoperations
function may.hypermoney(arrow, amount, silent)
	if G and G.GAME then
		G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
			G.GAME.dollars = to_big(G.GAME.dollars):arrow(arrow, amount)
			if not Talisman.config_file.disable_anims then
				G.ROOM.jiggle = G.ROOM.jiggle + (arrow/5)
				local dollar_UI = G.HUD:get_UIE_by_ID('dollar_text_UI')
				local text = ''
				if arrow == 0 then
					text = 'X'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 1 then
					text = '^'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 2 then
					text = '^^'..tostring(math.abs(amount))..localize('$')
				elseif arrow == 3 then
					text = '^^^'..tostring(math.abs(amount))..localize('$')
				elseif arrow > 3 then
					text = '{'..arrow..'}'..tostring(math.abs(amount))..localize('$')
				end
				dollar_UI.config.object:update()
				G.HUD:recalculate()
				attention_text({
					text = text,
					scale = 0.8, 
					hold = 0.7,
					cover = dollar_UI.parent,
					cover_colour = G.C.MONEY,
					align = 'cm',
				})
				if not silent then
					play_sound('may_bigmoney')
					if arrow == 1 then
						play_sound('may_e_antimatter')
					elseif arrow > 1 then
                        play_sound(may.get_operation_sound(arrow, 'mult'))
					end
				end
				if arrow > 0 then
					if may.conf.Shakiness.unlimitquiver then
						G.FUNCS.tsj_specific(dollar_UI, 0, arrow*4, true)
					else
						G.FUNCS.tsj_specific(dollar_UI, 0, math.min(may.conf.Shakiness.pulselimit, arrow*4), true)
					end
				end
			end
		return true end}))
	end
end

local randtext = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"," ","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","-","?","!","$","%","[","]","(",")",}

function may.obfuscatedtext(length)
	local str = ""
	for i = 1, length do
		str = str .. randtext[math.random(#randtext)]
	end
	return str
end

function may.get_operation_sound(operation, chipsmult)
	operation = type(operation) ~= 'string' and to_number(to_big(operation)) or operation
	if chipsmult == 'level' then
		local tab = {
			'tarot1', 
			'may_x_level', 
			'may_e_level', 
			'may_ee_level', 
			'may_eee_level', 
			'may_hex_level'
		}
		return operation == 'eq' and 'may_eq_level' or tab[operation + 2]
	end
	if may.conf.CustomHyperoperations then
		if chipsmult == 'chips' then
			if operation == 'eq' then
				return 'may_eqchip'
			elseif operation == -1 then
				return 'chips1'
			elseif operation == 0 then
				return 'talisman_xchip'
			elseif operation == 1 then
				return 'talisman_echip'
			elseif operation == 2 then
				return 'talisman_eechip'
			elseif operation == 3 then
				return 'talisman_eeechip'
			elseif operation == 4 then
				return 'may_hexchip'
			elseif operation == 5 then
				return 'may_hepchip'
			elseif operation == 6 then
				return 'may_octchip'
			elseif operation == 7 then
				return 'may_ennchip'
			elseif operation == 8 then
				return 'may_decchip'
			elseif operation == 9 then
				return 'may_undchip'
			elseif operation == 10 then
				return 'may_doechip'
			elseif operation >= 11 then
				return 'may_trechip'
			end
		elseif chipsmult == 'mult' then
			if operation == 'eq' then
				return 'may_eqmult'
			elseif operation == -1 then
				return 'multhit1'
			elseif operation == 0 then
				return 'multhit2'
			elseif operation == 1 then
				return 'talisman_emult'
			elseif operation == 2 then
				return 'talisman_eemult'
			elseif operation == 3 then
				return 'talisman_eeemult'
			elseif operation == 4 then
				return 'may_hexmult'
			elseif operation == 5 then
				return 'may_hepmult'
			elseif operation == 6 then
				return 'may_octmult'
			elseif operation == 7 then
				return 'may_ennmult'
			elseif operation == 8 then
				return 'may_decmult'
			elseif operation == 9 then
				return 'may_undmult'
			elseif operation == 10 then
				return 'may_doemult'
			elseif operation >= 11 then
				return 'may_tremult'
			end
		elseif chipsmult == 'dollars' then
			if operation == 'eq' then
				return 'may_eqdollars'
			elseif operation == -1 then
				return 'coin3'
			elseif operation >= 0 then
				return 'may_bigmoney'
			end
		elseif chipsmult == 'score' then
			if operation == 'eq' then
				return 'may_eqscore'
			elseif operation == -1 then
				return 'may_addscore'
			elseif operation == 0 then
				return 'may_xscore'
			elseif operation == 1 then
				return 'may_escore'
			elseif operation == 2 then
				return 'may_eescore'
			elseif operation == 3 then
				return 'may_eeescore'
			elseif operation == 4 then
				return 'may_hexscore'
			end
		end
	else
		if chipsmult == 'chips' then
			if operation == -1 then
				return 'chips1'
			elseif operation == 0 then
				return 'talisman_xchip'
			elseif operation == 1 then
				return 'talisman_echip'
			elseif operation == 2 then
				return 'talisman_eechip'
			elseif operation >= 3 then
				return 'talisman_eeechip'
			end
		elseif chipsmult == 'mult' then
			if operation == -1 then
				return 'multhit1'
			elseif operation == 0 then
				return 'multhit2'
			elseif operation == 1 then
				return 'talisman_emult'
			elseif operation == 2 then
				return 'talisman_eemult'
			elseif operation >= 3 then
				return 'talisman_eeemult'
			end
		elseif chipsmult == 'dollars' then
			if operation == -1 then
				return 'coin3'
			elseif operation == 0 then
				return 'may_bigmoney'
			end
		elseif chipsmult == 'score' then
			if operation == -1 then
				return 'may_addscore'
			elseif operation == 0 then
				return 'may_xscore'
			elseif operation == 1 then
				return 'may_escore'
			elseif operation == 2 then
				return 'may_eescore'
			elseif operation == 3 then
				return 'may_eeescore'
			elseif operation == 4 then
				return 'may_hexscore'
			end
		end
	end
end

-- Gets the Tag corresponding to an Edition. Returns default if none is found. Key must have e_ prefix
function may.get_edition_tag(key, default) 
    for k, v in pairs(G.P_TAGS) do
        if v.config.edition and 'e_'..v.config.edition == key then
            return v.key
        end
    end
    return default
end

-- Checks if a consumable is the default consumable of its set
function Card:may_is_default()
    if self:gc() and self:gc().set then
        return SMODS.ConsumableTypes[self:gc().set].default == self:gc().key
    end
    return false
end

-- Checks if a key is the default consumable of any set or the specified set
function may.is_default(key, set)
    if set then 
        return SMODS.ConsumableTypes[set].default == key 
    else
        for k, v in pairs(SMODS.ConsumableTypes) do
            if v.default == key then
                return true
            end
        end
    end
    return false
end

-- Shorthand for the random Enhancement Tarots
function may.random_enhancement(key, seed)
    for k, v in ipairs(G.hand.cards) do
        local percent = 0.85 + (k-0.999)/(#G.hand.cards-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			v:flip()
			play_sound('card1', percent)
		return true end}))
	end
    local selected = pseudorandom_element(G.hand.cards, pseudoseed(seed))
	for k, v in pairs(G.hand.cards) do
        if v ~= selected then 
            local percent = 0.85 + (k-0.999)/(#G.hand.cards-0.998)*0.3
		    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			    v:flip()
			    play_sound('card1', percent)
		    return true end}))
        end
	end
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
		selected.highlighted = true
		play_sound('card1')
	return true end}))
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function() 
		selected.highlighted = false
		selected:flip()
		selected:set_ability(G.P_CENTERS[key], true, nil)
		play_sound('tarot2')
		selected:juice_up(0.3, 0.3)
	return true end}))
end

-- Gets the number of times a consumable was used
function may.cu(key)
    if G.GAME.consumeable_usage then
        if G.GAME.consumeable_usage[key] then
            return G.GAME.consumeable_usage[key].count
        end
    end
    return 0
end

-- Check G.GAME as well as joker info for banned keys, taken from Cryptid 
function may.no(center, m, key, no_no)
	if no_no then
		return center[m] or (G.GAME and G.GAME[m] and G.GAME[m][key]) or false
	end
	return may.no(center, "no_" .. m, key, true)
end

-- Gets a random consumable, taken from Cryptid
function may.random_consumable(seed, excluded_flags, banned_card, pool, no_undiscovered)
	-- set up excluded flags - these are the kinds of consumables we DON'T want to have generating
	excluded_flags = excluded_flags or { "hidden", "no_doe", "no_grc" }
	local selection = "n/a"
	local passes = 0
	local tries = 500
	while true do
		tries = tries - 1
		passes = 0
		local key = pseudorandom_element(pool or G.P_CENTER_POOLS.Consumeables, pseudoseed(seed or "grc")).key
		selection = G.P_CENTERS[key]
		if selection.discovered or not no_undiscovered then
			for k, v in pairs(excluded_flags) do
				if not may.no(selection, v, key, true) then
					if not banned_card or (banned_card and banned_card ~= key) then
						passes = passes + 1
					end
				end
			end
		end
		if passes >= #excluded_flags or tries <= 0 then
			if tries <= 0 and no_undiscovered then
				return G.P_CENTERS["c_strength"]
			else
				return selection
			end
		end
	end
end

-- Gets the Nominal Chips of a playing card
function Card:may_get_nominal_chips()
    return (not SMODS.has_no_rank(self)) and self.base.nominal * (G.GAME.playing_card_multiplier or 1) * (self.ability.nominal_multiplier or 1)
end

-- Plays the composite gong sound, like when balancing with Plasma Deck
function may.gong()
    play_sound('gong', 0.94, 0.3)
    play_sound('gong', 0.94*1.5, 0.2)
    play_sound('tarot1', 1.5)
end

-- Creates a random Tag, set boss to true if Boss Tag can be generated
function may.random_tag(boss)
    local tag_key
    if not boss then
	    repeat
            tag_key = get_next_tag_key("may_bag_of_fortune")
	    until tag_key ~= "tag_boss"
    end
	local tag = Tag(tag_key)
	if #SMODS.find_mod('Cryptid') ~= 0 then
		tag.ability.shiny = Cryptid.is_shiny()
	end
	if tag.name == "Orbital Tag" then
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then
				_poker_hands[#_poker_hands + 1] = k
			end
		end
		tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("may_bag_of_fortune"))
	end
	add_tag(tag)
end

function Card:may_explode(dissolve_colours, explode_time_fac, no_sound)
    local explode_time = 1.3*(explode_time_fac or 1)*(math.sqrt(G.SETTINGS.GAMESPEED))
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.WHITE}

    local start_time = G.TIMERS.TOTAL
    local percent = 0
	if not no_sound then
        play_sound('explosion_buildup1')
	end
    self.juice = {
        scale = 0,
        r = 0,
        handled_elsewhere = true,
        start_time = start_time, 
        end_time = start_time + explode_time
    }

    local childParts1 = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*explode_time,
        scale = 0.2,
        speed = 2,
        lifespan = 0.2*explode_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    local childParts2 = nil

    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                if self.juice then 
                    percent = (G.TIMERS.TOTAL - start_time)/explode_time
                    self.juice.r = 0.05*(math.sin(5*G.TIMERS.TOTAL) + math.cos(0.33 + 41.15332*G.TIMERS.TOTAL) + math.cos(67.12*G.TIMERS.TOTAL))*percent
                    self.juice.scale = percent*0.15
                end
                if G.TIMERS.TOTAL - start_time > 1.5*explode_time then return true end
            end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 0.3,
        delay =  0.9*explode_time,
        func = (function(t) return t end)
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.9*explode_time,
        func = (function()
            childParts2 = Particles(0, 0, 0,0, {
                timer_type = 'TOTAL',
                pulse_max = 30,
                timer = 0.003,
                scale = 0.6,
                speed = 15,
                lifespan = 0.5,
                attach = self,
                colours = self.dissolve_colours,
            })
            childParts2:set_role({r_bond = 'Weak'})
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blockable = false,
                ref_table = self,
                ref_value = 'dissolve',
                ease_to = 1,
                delay =  0.1*explode_time,
                func = (function(t) return t end)
            }))
            self:juice_up()
            G.VIBRATION = G.VIBRATION + 1
			if not no_sound then 
                play_sound('explosion_release1')
			end
            childParts1:fade(0.3*explode_time) return true end)
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.4*explode_time,
        func = (function()
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blockable = false, 
                blocking = false,
                ref_value = 'scale',
                ref_table = childParts2,
                ease_to = 0,
                delay = 0.1*explode_time
            }))
            return true end)
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.5*explode_time,
        func = (function() self:remove() return true end)
    }))
end

-- taken from Finity
function may.recursive_table(table_return_table, index)
	local ret = table_return_table[index]
	if index <= #table_return_table then
		local function getDeepest(tbl)
			tbl = tbl or {}
			while tbl.extra do
				tbl = tbl.extra
			end
			return tbl
		end
		local prev = getDeepest(ret)
		prev.extra = may.recursive_table(table_return_table, index + 1)
	end
	return ret
end

-- Returns random Voucher keys that are NOT Voucher Bundles or Miscellaneous Vouchers
-- max_tries is deprecated and does nothing
function may.get_next_voucher_key(max_tries)
	local pool = {}
	for k, v in pairs(get_current_pool('Voucher')) do 
		if not v.pools then 
			table.insert(pool, v)
		else 
			if not v.pools.VoucherBundle and not v.pools.MiscVoucher then
				table.insert(pool, v)
			end
		end
	end
    return pseudorandom_element(pool, pseudoseed('may_next_voucher')).key
end

-- Gets the Modifier Card corresponding to a given modifier
function may.get_modifier_card(key)
	for k, v in pairs(G.P_CENTERS) do
		if v.config and v.config.extra and type(v.config.extra) == 'table' and v.config.extra.target == key and v.set == 'may_modifiercard' then 
			return v.key
		end
	end
	return nil
end

-- Immediately redeems a specified Voucher object
function may.redeem_specific(card)
	delay(0.1)
    if card.area then
		card.area:remove_card(card)
        draw_card(card.area, G.play, 1, 'up', true, card, nil, true) 
	end
    G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
	stop_use()
	local prev_state = G.STATE
	card.no_ui = true
	if card.children.use_button then card.children.use_button:remove() end
	card.children.use_button = nil
    card.cost = 0
    local area = card.area
	
	G.TAROT_INTERRUPT = G.STATE
    G.STATE = (G.STATE == G.STATES.TAROT_PACK and G.STATES.TAROT_PACK) or
        (G.STATE == G.STATES.PLANET_PACK and G.STATES.PLANET_PACK) or
        (G.STATE == G.STATES.SPECTRAL_PACK and G.STATES.SPECTRAL_PACK) or
        (G.STATE == G.STATES.STANDARD_PACK and G.STATES.STANDARD_PACK) or
        (G.STATE == G.STATES.BUFFOON_PACK and G.STATES.BUFFOON_PACK) or
        G.STATES.PLAY_TAROT
    G.CONTROLLER.locks.use = true
    if G.booster_pack and not G.booster_pack.alignment.offset.py and (card.ability.consumeable or not (G.GAME.pack_choices and G.GAME.pack_choices > 1)) then
        G.booster_pack.alignment.offset.py = G.booster_pack.alignment.offset.y
        G.booster_pack.alignment.offset.y = G.ROOM.T.y + 29
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
	
    card:redeem()
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
        card:start_dissolve()
        card:remove()
	return true end}))
	-- cryptid.
    if card.ability.cry_multiuse and to_big(card.ability.cry_multiuse) > to_big(1) then
        local card2 = card
        card2.ability.cry_multiuse = card2.ability.cry_multiuse - 1
        card2.ability.extra_value = -1 * math.max(1, math.floor(card2.cost/2))
        card2:set_cost()
        delay(0.4)
        card2:juice_up()
        play_sound('generic1')
        attention_text({
            text = format_ui_value(card2.ability.cry_multiuse),
            scale = 1.1,
            hold = 0.6,
            major = card,
            backdrop_colour = G.C.SET[card2.config.center.set],
            align = 'bm',
            offset = {x = 0, y = 0.2}
        })
        local c2 = copy_card(card)
        c2:add_to_deck()
        area:emplace(c2)
    end
	
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2, func = function()
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1, func = function()
            G.TAROT_INTERRUPT = nil
			G.STATE = prev_state
            G.CONTROLLER.locks.use = false
			if G.booster_pack then
                G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                G.booster_pack.alignment.offset.py = nil
			end
            if G.shop then 
                G.shop.alignment.offset.y = G.shop.alignment.offset.py
                G.shop.alignment.offset.py = nil
            end
            if G.blind_select then
                G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.py
                G.blind_select.alignment.offset.py = nil
            end
            if G.round_eval then
                G.round_eval.alignment.offset.y = G.round_eval.alignment.offset.py
                G.round_eval.alignment.offset.py = nil
            end
            if area and area.cards[1] then 
                G.E_MANAGER:add_event(Event({func = function()
                    G.E_MANAGER:add_event(Event({func = function()
                        G.CONTROLLER.interrupt.focus = nil
                        if G.shop then 
                            G.CONTROLLER:snap_to({node = G.shop:get_UIE_by_ID('next_round_button')})
                        elseif area then
                            G.CONTROLLER:recall_cardarea_focus(area)
                        end
                    return true end}))
                return true end}))
            end
        return true end}))
    return true end}))
end

-- Fix naneinf flames
-- Taken from Entropy
--[[G.FUNCS.flame_handler = function(e)
	if (type(SMODS.get_scoring_parameter('chips', true)) == 'number' or type(SMODS.get_scoring_parameter('chips', true)) == 'table') and (type(SMODS.get_scoring_parameter('mult', true)) == 'number' or type(SMODS.get_scoring_parameter('mult', true)) == 'table') then
		G.ARGS.score_intensity.true_score = to_big(G.GAME.current_scoring_calculation:func(SMODS.get_scoring_parameter('chips', true), SMODS.get_scoring_parameter('mult', true), true))
	else
		G.ARGS.score_intensity.true_score = to_big(0)
	end
    G.C.UI_CHIPLICK = G.C.UI_CHIPLICK or {1, 1, 1, 1}
    G.C.UI_MULTLICK = G.C.UI_MULTLICK or {1, 1, 1, 1}
    for i=1, 3 do
        G.C.UI_CHIPLICK[i] = math.min(math.max(((((may.transcendence or 0) > 0 and (not G.GAME.may_override_monitor_colors) and may.get_transcendence_color(may.transcendence) or G.C.BLUE)[i]*0.5+G.C[(may.transcendence or 0) > 4 and 'BLACK' or 'YELLOW'][i]*0.5) + 0.1)^2, 0.1), 1)
        G.C.UI_MULTLICK[i] = math.min(math.max(((((may.transcendence or 0) > 0 and (not G.GAME.may_override_monitor_colors) and may.get_transcendence_color(may.transcendence) or G.C.RED)[i]*0.5+G.C[(may.transcendence or 0) > 4 and 'BLACK' or 'YELLOW'][i]*0.5) + 0.1)^2, 0.1), 1)
    end

    G.ARGS.flame_handler = G.ARGS.flame_handler or {
        chips = {
            id = 'flame_chips', 
            arg_tab = 'chip_flames',
            colour = (may.transcendence or 0) > 0 and (not G.GAME.may_override_monitor_colors) and may.get_transcendence_color(may.transcendence) or G.C.BLUE,
            accent = G.C.UI_CHIPLICK
        },
        mult = {
            id = 'flame_mult', 
            arg_tab = 'mult_flames',
            colour = (may.transcendence or 0) > 0 and (not G.GAME.may_override_monitor_colors) and may.get_transcendence_color(may.transcendence) or G.C.RED,
            accent = G.C.UI_MULTLICK
        }
    }
    for k, v in pairs(G.ARGS.flame_handler) do
        if e.config.id == v.id then 
        if not e.config.object:is(Sprite) or e.config.object.ID ~= v.ID then 
            e.config.object:remove()
            e.config.object = Sprite(0, 0, 2.5, 2.5, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
            v.ID = e.config.object.ID
            G.ARGS[v.arg_tab] = {
                intensity = 0,
                real_intensity = 0,
                intensity_vel = 0,
                colour_1 = v.colour,
                colour_2 = v.accent,
                timer = G.TIMERS.REAL
            }      
            e.config.object:set_alignment({
                major = e.parent,
                type = 'bmi',
                offset = {x=0,y=0},
                xy_bond = 'Weak'
            })
            e.config.object:define_draw_steps({{
				shader = 'flame',
				send = {
					{name = 'time', ref_table = G.ARGS[v.arg_tab], ref_value = 'timer'},
					{name = 'amount', ref_table = G.ARGS[v.arg_tab], ref_value = 'real_intensity'},
					{name = 'image_details', ref_table = e.config.object, ref_value = 'image_dims'},
					{name = 'texture_details', ref_table = e.config.object.RETS, ref_value = 'get_pos_pixel'},
					{name = 'colour_1', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_1'},
					{name = 'colour_2', ref_table =  G.ARGS[v.arg_tab], ref_value = 'colour_2'},
					{name = 'id', val =  e.config.object.ID},
				}
			}})
            e.config.object:get_pos_pixel()
        end
        local _F = G.ARGS[v.arg_tab]
        local exptime = math.exp(-0.4*G.real_dt)
        if to_big(G.ARGS.score_intensity.true_score) >= to_big(G.ARGS.score_intensity.required_score) and to_big(G.ARGS.score_intensity.required_score) > to_big(0) then
            _F.intensity = ((G.pack_cards and not G.pack_cards.REMOVED) or (G.TAROT_INTERRUPT)) and 0 or math.max(0., math.log(G.ARGS.score_intensity.true_score+1, 5)-2)
            if type(_F.intensity) == "table" then
                if _F.intensity > to_big(120) then
                    _F.intensity = 120
                else
                    _F.intensity = _F.intensity:to_number()
                end
            elseif _F.intensity > 120 then
                _F.intensity = 120
            end
        else
            _F.intensity = 0
        end
        _F.timer = _F.timer + G.real_dt*(1 + _F.intensity*0.2)
        if _F.intensity_vel < 0 then _F.intensity_vel = _F.intensity_vel*(1 - 10*G.real_dt) end
        _F.intensity_vel = (1-exptime)*(_F.intensity - _F.real_intensity)*G.real_dt*25 + exptime*_F.intensity_vel
        _F.real_intensity = math.max(0, _F.real_intensity + _F.intensity_vel)
        
        _F.real_intensity = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.real_intensity + G.cry_flame_override['intensity'])/2) or _F.real_intensity
        if to_big(_F.real_intensity) > to_big(120) then
            _F.real_intensity = 120
        end
        _F.change = (_F.change or 0)*(1 - 4.*G.real_dt) + ( 4.*G.real_dt)*(_F.real_intensity < _F.intensity - 0.0 and 1 or 0)*_F.real_intensity
        _F.change = (G.cry_flame_override and G.cry_flame_override['duration'] > 0) and ((_F.change + G.cry_flame_override['intensity'])/2) or _F.change
        end
    end
end]]

-- Overriding because i have no idea how a lovely patch could do what this does (cards drawn inside celetsial packs, code injected in a very specific spot)
function Game:update_celestial_pack(dt)
    if self.buttons then self.buttons:remove(); self.buttons = nil end
    if self.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end

    if not G.STATE_COMPLETE then
        G.STATE_COMPLETE = true
        G.CONTROLLER.interrupt.focus = true
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                ease_background_colour_blind(G.STATES.PLANET_PACK)
                G.booster_pack_stars = Particles(1, 1, 0,0, {
                    timer = 0.07,
                    scale = 0.1,
                    initialize = true,
                    lifespan = 15,
                    speed = 0.1,
                    padding = -4,
                    attach = G.ROOM_ATTACH,
                    colours = {G.C.WHITE, HEX('a7d6e0'), HEX('fddca0')},
                    fill = true
                })
                G.booster_pack_meteors = Particles(1, 1, 0,0, {
                    timer = 2,
                    scale = 0.05,
                    lifespan = 1.5,
                    speed = 4,
                    attach = G.ROOM_ATTACH,
                    colours = {G.C.WHITE},
                    fill = true
                })
                G.booster_pack = UIBox{
                    definition = create_UIBox_celestial_pack(), 
                    config = {
                        align="tmi",
                        offset = {x=0,y=G.ROOM.T.y + 9},
                        major = G.hand,
                        bond = 'Weak'
                    }
                }
                G.booster_pack.alignment.offset.y = -2.2
                G.ROOM.jiggle = G.ROOM.jiggle + 3 
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.FUNCS.draw_from_deck_to_hand()

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            func = function()
                                G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                return true
                            end}))
                        return true
                    end
                }))
                return true
            end
        }))  
    end
end

-- Custom ease_colour intended for Transcendence, does not add events unless smooth_ease is set to true, and has other optimizations
function may.ease_colour(col, target, smooth_ease)
	if smooth_ease and may.transcendence < 13 then
		local function EASE(ref_table, ref_value, mod)
			G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blockable = true,
                blocking = false,
                ref_table = ref_table,
                ref_value = ref_value,
                ease_to = ref_table[ref_value] + mod,
                timer = 'REAL',
				delay = 0.25, 
                func = (function(t) return t end)
            }), 'other')
		end
		EASE(col, 1, target[1] - col[1])
        EASE(col, 2, target[2] - col[2])
    	EASE(col, 3, target[3] - col[3])
	else
	    col[1] = target[1]
		col[2] = target[2]
		col[3] = target[3]
	end
end

-- why isn't this in smods, and if it is why haven't i heard of it yet
function may.has_card(key)
	return #SMODS.find_card(key) ~= 0
end

-- Spawns in applicable Special Vouchers
function may.handle_special_vouchers(round)
	round = round or G.GAME.round
	if G.GAME.may_endless_mode then
		if round % 9 == 0 then
			if not may.has_card('v_may_astronomy_1') then
				SMODS.add_voucher_to_shop('v_may_astronomy_1')
				G.E_MANAGER:add_event(Event({func = function()
					play_sound('may_positive')
				return true end}))
			elseif not may.has_card('v_may_astronomy_2') then
				SMODS.add_voucher_to_shop('v_may_astronomy_2')
				G.E_MANAGER:add_event(Event({func = function()
				    play_sound('may_positive')
				return true end}))
			elseif not may.has_card('v_may_astronomy_3') then
				SMODS.add_voucher_to_shop('v_may_astronomy_3')
				G.E_MANAGER:add_event(Event({func = function()
				    play_sound('may_positive')
				return true end}))
			end
		end
		if round % 15 == 0 then
			if not may.has_card('v_may_reconfigure') then
			    SMODS.add_voucher_to_shop('v_may_reconfigure')
			    G.E_MANAGER:add_event(Event({func = function()
					play_sound('may_positive')
			    return true end}))
			end
		end
	elseif to_big(G.GAME.round_resets.ante) >= to_big(9) then
		if not may.has_card('v_may_endless_mode') then
			SMODS.add_voucher_to_shop('v_may_endless_mode')
		    G.E_MANAGER:add_event(Event({func = function()
				play_sound('may_positive')
            return true end}))
		end
	end
end