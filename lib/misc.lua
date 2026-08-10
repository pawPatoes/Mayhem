-- Misc

-- Taken from Entropy 
function Card:is_playing_card()
    if not G.deck then return end
    if self.area == G.play and self.ability.consumeable then return end
    if (self.area == G.hand or self.area == G.play or self.area == G.discard) and (self.config.center.set == "Default" or self.config.center.set == "Enhanced") then return true end
    for i, v in pairs(G.playing_cards) do
        if v == self then return true end
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
	'may_col_prismatic', 
	'may_col_demiurgic',
	'may_col_opalescent', 
	'may_col_instability', 
	'may_col_e_otherworldly', 
	'may_col_e_omega', 
	'may_col_big_operator',
	'may_col_huge_operator', 
}

-- Mass redeem Vouchers
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
      		  while G.P_CENTERS[key].attributes and table_hasvalue(G.P_CENTERS[key].attributes, 'voucher_bundle') do
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
	G.GAME.interest_amount = to_number(to_big(G.GAME.interest_amount or 0):arrow(arrow, mod))
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
	G.GAME.interest_cap = to_number(to_big(G.GAME.interest_cap or 0):arrow(arrow, mod))
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
		local text = may.generate_arrow_text(arrow)
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
	G.GAME.may_instability = to_number(to_big(G.GAME.may_instability or 0):arrow(arrow, mod))
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			attention_text({
				text = may.generate_arrow_text(arrow, 4)..(to_number(mod) or 0)..' Instability',
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
				local text = may.generate_arrow_text(arrow)..tostring(math.abs(amount))..localize('$')
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
						G.FUNCS.tsj_specific(dollar_UI, 0, arrow * 4, true)
					else
						G.FUNCS.tsj_specific(dollar_UI, 0, math.min(may.conf.Shakiness.pulselimit, arrow * 4), true)
					end
				end
			end
		return true end}))
	end
end

local randtext = {
	"A","B","C","D","E","F","G","H","I","J",
	"K","L","M","N","O","P","Q","R","S","T",
	"U","V","W","X","Y","Z"," ","a","b","c",
	"d","e","f","g","h","i","j","k","l","m",
	"n","o","p","q","r","s","t","u","v","w",
	"x","y","z","0","1","2","3","4","5","6",
	"7","8","9","+","-","?","!","$","%","[",
	"]","(",")"
}

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
		return operation == 'eq' and 'may_eq_level' or tab[math.min(operation + 2, #tab)]
	end
	if chipsmult == 'chips' then
		local tab = {
			'chips1', 
			'talisman_xchip', 
			'talisman_echip', 
			'talisman_eechip',
			'talisman_eeechip',
			'may_hexchip',
			'may_hepchip',
			'may_octchip',
			'may_ennchip',
			'may_decchip',
			'may_undchip',
			'may_doechip',
			'may_trechip',
		}
		return operation == 'eq' and 'may_eqchip' or tab[math.min(operation + 2, may.conf.custom_hyperoperations and #tab or 5)]
	elseif chipsmult == 'mult' then
		local tab = {
			'multhit1', 
			'multhit2', 
			'talisman_emult', 
			'talisman_eemult',
			'talisman_eeemult',
			'may_hexmult',
			'may_hepmult',
			'may_octmult',
			'may_ennmult',
			'may_decmult',
			'may_undmult',
			'may_doemult',
			'may_tremult',
		}
		return operation == 'eq' and 'may_eqchip' or tab[math.min(operation + 2, may.conf.custom_hyperoperations and #tab or 5)]
	elseif chipsmult == 'dollars' then
		local tab = {
			'coin3', 
			'may_bigmoney', 
		}
		return operation == 'eq' and 'may_eqdollar' or tab[math.min(operation + 2, #tab)]
	elseif chipsmult == 'score' then
		local tab = {
			'may_addscore', 
			'may_xscore', 
			'may_escore', 
			'may_eescore',
			'may_eeescore',
			'may_hexscore',
		}
		return operation == 'eq' and 'may_eqscore' or tab[math.min(operation + 2, may.conf.custom_hyperoperations and #tab or 5)]
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

-- Gets a random consumable, taken from Cryptid
function may.random_consumable(seed, excluded_flags, banned_card, pool, no_undiscovered)
	--[[ set up excluded flags - these are the kinds of consumables we DON'T want to have generating
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
	end]]
	local final_pool = pool or {}
	if #final_pool == 0 and not pool then 
		for k, v in pairs(G.P_CENTER_POOLS.Consumeables) do 
			if v.key ~= (banned_card or '') then 
				if not v.hidden and not v.no_doe and not v.no_grc then 
					if (v.discovered or not no_undiscovered) then 
						table.insert(final_pool, v)
					end
				end
			end
		end
	end
	if #final_pool > 0 then 
		return SMODS.poll_object({ pool = final_pool, guaranteed = true, seed = seed })
	else 
		return G.P_CENTERS['c_strength']
	end
end

-- Gets the Nominal Chips of a playing card
function Card:may_get_nominal_chips()
    return ((not SMODS.has_no_rank(self)) and self.base.nominal * (G.GAME.playing_card_multiplier or 1) * (self.ability.nominal_multiplier or 1)) or 0
end

-- Plays the composite gong sound, like when balancing with Plasma Deck
function may.gong()
    play_sound('gong', 0.94, 0.3)
    play_sound('gong', 0.94*1.5, 0.2)
    play_sound('tarot1', 1.5)
end

function may.op_from_rarity(key)
	local tab = {
		{'may_mythic', 1},
		{'may_ethereal', 1},
		{'may_prismatic', 2}, 
		{'may_demiurgic', 3},
	}
	for k, v in pairs(tab) do
		if v[1] == key then 
			return v[2]
		end
	end
	return 0
end

-- i love talisman
function may.get_score_operator()
	local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
	if (G.GAME.current_scoring_calculation_key or '') == 'talisman_hyper' then
		op = G.GAME.hyper_operator or 2
    end 
	return op
end

-- Returns Global Hyperoperator 
function may.global_op()
	if not G.jokers then 
		return 0 
	end
	local ret = 0
	for k, v in pairs(G.jokers.cards) do
		ret = math.max(ret, may.op_from_rarity(v:gc().rarity))
	end
	for k, v in pairs(G.jokers.cards) do
		if v:gc().global_op then 
			ret = math.max(ret, v:gc().global_op(v, v:gc()))
		end
	end
	for k, v in pairs(G.jokers.cards) do 
		if v.ability and type(v.ability.extra) == 'table' and v.ability.extra.arrow then
			ret = math.max(ret, v.ability.extra.arrow)
		end
	end
	ret = math.max(ret, may.get_score_operator())
	return ret
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

-- Taken from Finity
function may.recursive_table(table_return_table, index)
	local ret = table_return_table[index]
	if index <= #table_return_table then
		local function get_deepest(tbl)
			tbl = tbl or {}
			while tbl.extra do
				tbl = tbl.extra
			end
			return tbl
		end
		local prev = get_deepest(ret)
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

-- Custom ease_colour intended for Transcendence, does not add events unless smooth_ease is set to true, and has other optimizations
function may.ease_colour(col, target, smooth_ease)
	if smooth_ease and (may.transcendence or 0) < 13 then
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

function may.ease_blind_colour(inblind, blind_col, smooth_ease)
    if not inblind then return end
    blind_col = blind_col or get_blind_main_colour(inblind.config.blind.key or "")
    local dark_col = mix_colours(blind_col, G.C.BLACK, 0.4)

    may.ease_colour(G.C.DYN_UI.MAIN, blind_col, smooth_ease)
    may.ease_colour(G.C.DYN_UI.DARK, dark_col, smooth_ease)

    local boss_main, boss_dark
    if not inblind.boss and inblind.name then
        boss_main = darken(G.C.BLACK, 0.05)
        boss_dark = lighten(G.C.BLACK, 0.07)
    else
        boss_main = blind_col
        boss_dark = mix_colours(blind_col, G.C.BLACK, 0.2)
    end

    may.ease_colour(G.C.DYN_UI.BOSS_MAIN, boss_main, smooth_ease)
    may.ease_colour(G.C.DYN_UI.BOSS_DARK, boss_dark, smooth_ease)
end


-- why isn't this in smods, and if it is why haven't i heard of it yet
function may.has_card(key)
	return #SMODS.find_card(key) ~= 0
end

function may.get_highest_special_voucher_tier(key)
	local ret = 0
	for k, v in pairs(G.vouchers.cards) do
		if v:gc().special_tier and v:gc().special_tier[1] == key then 
			ret = math.max(ret, v:gc().special_tier[2])
		end
	end
	return ret
end

-- Spawns in applicable Special Vouchers
function may.handle_special_vouchers()
	for k, v in pairs(G.P_CENTERS) do 
		if v.special_voucher_behavior then 
			local spawn, sound, func, duplicates = v.special_voucher_behavior(v) 
			if spawn and (duplicates or not may.has_card(v.key)) then
				SMODS.add_voucher_to_shop(v.key)
				G.E_MANAGER:add_event(Event({func = function()
					if sound then 
						if type(sound) == 'string' then 
							play_sound(sound)
						else 
							play_sound(sound[1], sound[2], sound[3])
						end
					else 
						play_sound('may_positive')
					end
            	return true end}))
				if func then 
					func(v)
				end
			end
		end
	end
end

function may.stack_op(num, arrow, amt)
	if arrow == -1 then
		return num * amt
	elseif arrow == 0 then
		return num ^ amt
	elseif arrow == 1 then
		return (math.abs(amt) == 1 and num or num ^ amt)
	else
		for i = 1, math.min(to_number(amt), 1000) do
			num = to_big(num):arrow(arrow, num)
		end
		return num
	end
end

function may.rep_arrow(num1, arrow, num2, amt)
	if arrow == -1 then
		return num1 + num2 * amt
	elseif arrow == 0 then
		return to_big(num1):mul(to_big(num2):pow(to_big(amt))):normalize()
	elseif arrow == 1 then
		return num1 ^ (num2 ^ amt)
	else
		for i = 1, math.min(to_number(amt), 1000) do
			num1 = to_big(num1):arrow(arrow, num2)
		end
		return to_big(num1):normalize()
	end
end

function may.get_run_stage()
	if not G.GAME.blind then 
		return 'pre-endless'
	end
	for k, v in pairs(G.jokers.cards) do 
		if v:gc().rarity == 'may_transcendent' then
			return 'post-transcendent'
		end
	end
	return G.GAME.may_endless_mode and 'endless' or 'pre-endless'
end

CardArea.change_max_highlight = CardArea.change_max_highlight or function(self, mod, silent)
	self.config.highlighted_limit = self.config.highlighted_limit + (mod or 0)
	if self == G.hand then
		SMODS.change_play_limit(mod)
		SMODS.change_discard_limit(mod)
	end
end

-- I LOVE TALISMAN
function may.change_operator(amount)
	if G.GAME.current_scoring_calculation_key ~= 'talisman_hyper' and SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + amount > 2 then 
		G.GAME.current_scoring_calculation_key = 'talisman_hyper'
		change_operator(amount - 2)
	else 
		change_operator(amount)
	end
end

--[[ 
	The function which you see right in front of your very eyes is a product of spite and poor decisions on behalf of people I have not interacted with in my life. 
	You see, the purpose of this function is so simple and benign, yet incredibly useful at the same time. With that in mind, the fact that, at least in my opinion, an analogous function I not provided by the vanilla codebase is absolutely jarring.
	Checking whether or not a playing card is numbered is, to put it lightly, very useful and frequent. Aces, however, are usually not treated as number cards or face cards. As such, checking if the card is not a face card will not suffice. The check for Aces is mandatory. 
	I had shoved this discrepancy under a hypothetical rug for the longest time. I hid under the philosophy that nobody would really notice. That has been proven false, and I cannot easily pass it off as a personal choice since it is my duty to keep consistency with vanilla and other mods. 
	That, my friend, is the story of this here function. A function you may consider senseless, but which hides beneath its silly surface a tragic tale of poor decisions and laziness.
]]
function Card:may_is_number()
	return not self:is_face() and not SMODS.has_no_rank(self) and self:get_id() ~= 14
end

-- man
function Card:may_get_suit()
	if SMODS.has_no_suit(self) or SMODS.has_any_suit(self) then
		return
	end
	for k, v in pairs(SMODS.Suits) do
		if self:is_suit(k) then
			return k
		end
	end
	return
end

function may.varda_amount(card)
	local ret = 0
	local exp = 0
	if not SMODS.has_enhancement(card, 'c_base') then 
		exp = exp + 1
		ret = ret + math.max(0, math.max(0, math.ceil(1.4 - (G.P_CENTERS[card.config.center.key].weight or 1))) ^ 1.3) 
	end
	if card.edition then
		exp = exp + 1
		ret = math.ceil(ret * 1.1)
		ret = ret + math.max(0, math.ceil((math.max(0, (20 - (G.P_CENTERS[card.edition.key].weight or 15)) * 0.2)) ^ 1.1))
	end
	if card.seal then
		exp = exp + 1
		ret = ret == 0 and 1 or math.ceil(ret * 1.45)
	end
	return math.floor(math.floor(ret * 0.85) ^ (1 + exp * 0.085))
end

-- Gets sell value of a playing card
function Card:may_playing_sell_value()
	if not SMODS.is_playing_card(self) then 
		return 
	end 
	local ret = 1
	if not SMODS.has_enhancement(self, 'c_base') then 
		if G.P_CENTERS[self.config.center.key].sell_value then
			ret = ret + G.P_CENTERS[self.config.center.key].sell_value
		else 
			ret = ret + math.max(0, math.max(0, math.ceil(1.4 - (G.P_CENTERS[self.config.center.key].weight or 1))) ^ 1.3) 
		end
	end
	if self.edition then 
		ret = ret + (G.P_CENTERS[self.edition.key].extra_cost or 3)
	end
	if self.seal then 
		ret = ret + (G.P_SEALS[self.seal].sell_value or 4)
	end
	if self:may_get_suit() and SMODS.Suits[self:may_get_suit()].sell_value then 
		ret = ret + SMODS.Suits[self:may_get_suit()].sell_value
	end 
	if not SMODS.has_no_rank(self) and SMODS.Ranks[self.base.value].sell_value then 
		ret = ret + SMODS.Suits[self:get_id()].sell_value
	end
	if self.ability.playing_sell_value then 
		ret = ret + self.ability.playing_sell_value
	end 
	return may.round(ret)
end