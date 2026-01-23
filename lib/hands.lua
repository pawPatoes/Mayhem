-- Poker Hand functions

-- Gets the least played Poker Hand 
function lphand()
	if not G.GAME then return 0 else
		local chosen_hand = 'High Card'
		local lowest_amount = math.huge
		for _, v in ipairs(G.handlist) do
			if G.GAME.hands[v].played <= lowest_amount then
				chosen_hand = v
				lowest_amount = G.GAME.hands[v].played
			end
		end
		return chosen_hand
	end
end

-- Get level of most played Poker Hand 
function get_mphand_level()
	if not G.GAME then return 0 end
	return G.GAME.hands[may.favhand()].level 
end

function may.get_all_ph_mult(ignore)
	if G and G.GAME and G.GAME.blind then
		local mult = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= ignore and SMODS.is_poker_hand_visible(k) then
				mult = mult + G.GAME.hands[k].mult
			end
		end
		return to_big(mult)
	else
		return to_big(0)
	end
end

function may.get_all_ph_chips(ignore)
	if G and G.GAME and G.GAME.blind then
		local chips = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if G.GAME.hands[k] ~= ignore and SMODS.is_poker_hand_visible(k) then
				chips = chips + G.GAME.hands[k].chips
			end
		end
		return to_big(chips)
	else
		return to_big(0)
	end
end

function may.get_all_ph_level(ignore)
	if G and G.GAME and G.GAME.blind then
		local level = to_big(0)
		for k, v in pairs(G.GAME.hands) do
			if k ~= ignore and SMODS.is_poker_hand_visible(k) then
				level = level + G.GAME.hands[k].level
			end
		end
		return to_big(level)
	else
		return to_big(0)
	end
end

-- Get Poker Hand with lowest level
function may.lowhand()
	local chosen_hand = 'High Card'
	local lowest_level = 'n/a'
	for _, v in ipairs(G.handlist) do
		if type(lowest_level) == 'string' or G.GAME.hands[v].level <= lowest_level and SMODS.is_poker_hand_visible(v) then --(Talisman and to_big(lowest_level) or lowest_level) then
			chosen_hand = v
			lowest_level = G.GAME.hands[v].level
		end
	end
	return chosen_hand
end

-- Get lowest scoring Poker Hand 
function may.ls_hand()
	local hand = 'High Card'
	local lowest_score = 0
	for _, v in ipairs(G.handlist) do
		if lowest_score == 0 or to_big(G.GAME.hands[v].chips):mul(G.GAME.hands[v].mult) <= to_big(lowest_score) and SMODS.is_poker_hand_visible(v) then
			hand = v
			lowest_score = to_big(G.GAME.hands[v].chips):mul(G.GAME.hands[v].mult)
		end
	end
	return hand
end

-- Get highest Scoring Poker Hand 
function may.hs_hand()
	local hand = 'High Card'
	local lowest_score = 0
	for _, v in ipairs(G.handlist) do
		if lowest_score == 0 or to_big(G.GAME.hands[v].chips):mul(G.GAME.hands[v].mult) >= to_big(lowest_score) and SMODS.is_poker_hand_visible(v) then
			hand = v
			lowest_score = to_big(G.GAME.hands[v].chips):mul(G.GAME.hands[v].mult)
		end
	end
	return hand
end

-- Hyperoperational hand level
function may.level_up_hand_hyper(card, hand, instant, amount, arrow)
	local former_level = G.GAME.hands[hand].level
	arrow = arrow or 0
	amount = amount or 1
    amount = to_big(amount)
	if hand and G.GAME.hands[hand] then
        if not instant then 
            may.th(hand) 
        end
		level_up_hand(card, hand, true, to_big(G.GAME.hands[hand].level):arrow(arrow or 0, amount) - G.GAME.hands[hand].level)
		if not instant then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end }))
			update_hand_text({delay = 0}, {mult = number_format(G.GAME.hands[hand].mult), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				return true end }))
			update_hand_text({delay = 0}, {chips = number_format(G.GAME.hands[hand].chips), StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
				return true end }))
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=number_format(G.GAME.hands[hand].level)})
			delay(1.3)
		end
    end
end

-- Equals level basically, used in stuff like Mangas
function may.set_hand_level(card, hand, instant, mod)
	if hand and G.GAME.hands[hand] then
		local previous = { mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, level = G.GAME.hands[hand].level }
		level_up_hand(card, hand, true, to_big(mod) - to_big(G.GAME.hands[hand].level))
		--SMODS.upgrade_poker_hands({ hands = hand, level_up = to_big(mod) - to_big(G.GAME.hands[hand].level), instant = instant, from = card })
		if not instant then
			may.h(localize(hand, 'poker_hands'), previous.chips, previous.mult, previous.level)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
			return true end}))
			may.hm(G.GAME.hands[hand].mult)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(G.GAME.hands[hand].chips)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			may.hlv(G.GAME.hands[hand].level)
			delay(1.3)
			may.ch()
		end
	end
end

function may.level_up_all_hands(card, instant, amount, ignore)
	if to_big(amount) ~= to_big(0) then
		for k, v in pairs(G.GAME.hands) do
			if ignore then
				if k ~= ignore then 
					level_up_hand(card, k, true, amount)
				end
			else
				level_up_hand(card, k, true, amount)
			end
		end
		if not instant then
			local hand_name = 'All Hands'
			if ignore then
				if type(ignore) == 'string' then
					hand_name = 'Other Hands'
				else
					hand_name = 'Hands'
				end
			end
			may.h(hand_name, '...', '...', '...')
			delay(0.5)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end}))
			if to_big(amount) > to_big(0) then
				may.hm('+')
			else
				may.hm('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				return true end}))
			if to_big(amount) > to_big(0) then
				may.hc('+')
			else
				may.hc('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			if to_big(amount) > to_big(0) then
				may.hlv('+'..number_format(amount))
			else
				may.hlv(number_format(-math.abs(amount)))
			end
			delay(1.3)
			may.ch()
		end
	end
end

function may.level_up_all_hands_hyper(card, instant, amount, arrow, ignore)
	arrow = arrow or 0
	if to_big(amount) ~= to_big(0) then
		for k, v in pairs(G.GAME.hands) do
			if ignore then
				if v ~= G.GAME.hands[ignore] then 
					may.level_up_hand_hyper(card, k, true, amount, arrow)
				end
			else
				may.level_up_hand_hyper(card, k, true, amount, arrow)
			end
		end
		if not instant then
			local hand_name = 'All Hands'
			if ignore then
				if type(ignore) == 'string' then
					hand_name = 'Other Hands'
				else
					hand_name = 'Hands'
				end
			end
			may.h(hand_name, '...', '...', '...')
			delay(0.5)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = true
				return true end}))
			if to_big(amount) > to_big(0) then
				may.hm('+')
			else
				may.hm('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				return true end}))
			if to_big(amount) > to_big(0) then
				may.hc('+')
			else
				may.hc('-')
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			may.hlv(may.generate_arrow_text(arrow)..amount)
			delay(1.3)
			may.ch()
		end
	end
end

function may.set_all_hand_levels(card, instant, mod, ignore)
	for k, v in pairs(G.GAME.hands) do
		if ignore then
			if v ~= G.GAME.hands[ignore] then 
				may.set_hand_level(card, k, true, mod)
			end
		else
			may.set_hand_level(card, k, true, mod)
		end
	end
	if not instant then
		local hand_name = 'All Hands'
		if ignore then
			if type(ignore) == 'string' then
				hand_name = 'Other Hands'
			else
				hand_name = 'Hands'
			end
		end
		may.h(hand_name, '...', '...', '...')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
			G.TAROT_INTERRUPT_PULSE = true
		return true end}))
		may.hm('=', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		may.hc('=', true)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
			play_sound('may_eq_level')
			if card then card:juice_up(0.8, 0.5) end
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
		may.hlv(mod, true)
		delay(1.3)
		may.ch()
	end
end

function may.hand_mod_lvl_multchips(hand, multchips, arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult)
	G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips)
	if arrow >= 0 then
		if multchips == 'mult' then
			G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:arrow(arrow, mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:arrow(arrow, mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:arrow(arrow, mod)
			G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:arrow(arrow, mod)
		end
	else
		if arrow == -1 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:add(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:add(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:add(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:add(mod)
			end
		elseif arrow == -2 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:sub(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:sub(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:sub(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:sub(mod)
			end
		elseif arrow == -3 then
			if multchips == 'mult' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:div(mod)
			elseif multchips == 'chips' then
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:div(mod)
			elseif multchips == 'multchips' then
				G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult:div(mod)
				G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips:div(mod)
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = localize(hand, 'poker_hands')..' '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			local col 
			if multchips == 'mult' then
				col = G.C.MULT
			elseif	multchips == 'chips' then
				col = G.C.CHIPS
			elseif	multchips == 'multchips' then
				col = G.C.PURPLE
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('may_lvl_multchips')
			play_sound('generic1')
		return true end}))
	end
end

function may.hand_mod_dollars(hand, arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.hands[hand].dollars = to_big(G.GAME.hands[hand].dollars or 0)
	if arrow >= 0 then
		G.GAME.hands[hand].dollars = G.GAME.hands[hand].dollars:arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.hands[hand].dollars = G.GAME.hands[hand].dollars:add(mod)
		elseif arrow == -2 then
			G.GAME.hands[hand].dollars = G.GAME.hands[hand].dollars:sub(mod)
		elseif arrow == -3 then
			G.GAME.hands[hand].dollars = G.GAME.hands[hand].dollars:div(mod)
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = localize(hand, 'poker_hands')..' '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = G.C.MONEY,
				align = 'cm',
			})
			play_sound('coin6')
			play_sound('generic1')
		return true end}))
	end
end

function may.hand_mod_dollars_all(arrow, mod, silent)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		v.dollars = to_big(v.dollars or 0)
	end
	if arrow >= 0 then
		for k, v in pairs(G.GAME.hands) do
			v.dollars = v.dollars:arrow(arrow, mod)
		end
	else
		if arrow == -1 then
			for k, v in pairs(G.GAME.hands) do
				v.dollars = v.dollars:add(mod)
			end
		elseif arrow == -2 then
			for k, v in pairs(G.GAME.hands) do
				v.dollars = v.dollars:sub(mod)
			end
		elseif arrow == -3 then
			for k, v in pairs(G.GAME.hands) do
				v.dollars = v.dollars:div(mod)
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = 'All Hands '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = G.C.MONEY,
				align = 'cm',
			})
			play_sound('coin6')
			play_sound('generic1')
		return true end}))
	end
end

function may.hand_mod_score(hand, arrow, mod, silent)
	mod = to_big(mod)
	G.GAME.hands[hand].score = to_big(G.GAME.hands[hand].score or 0)
	if arrow >= 0 then
		G.GAME.hands[hand].score = G.GAME.hands[hand].score:arrow(arrow, mod)
	else
		if arrow == -1 then
			G.GAME.hands[hand].score = G.GAME.hands[hand].score:add(mod)
		elseif arrow == -2 then
			G.GAME.hands[hand].score = G.GAME.hands[hand].score:sub(mod)
		elseif arrow == -3 then
			G.GAME.hands[hand].score = G.GAME.hands[hand].score:div(mod)
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = localize(hand, 'poker_hands')..' '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = may.C.score,
				align = 'cm',
			})
			play_sound('may_addscore')
			play_sound('generic1')
		return true end}))
	end
end

function may.hand_mod_multchips(hand, multchips, arrow, mod, silent, card)
	local previous_mult = to_big(G.GAME.hands[hand].mult)
	local previous_chips = to_big(G.GAME.hands[hand].chips)
	if arrow == 'eq' then
		if multchips == 'mult' then
			G.GAME.hands[hand].mult = to_big(mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].chips = to_big(mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].mult = to_big(mod)
			G.GAME.hands[hand].chips = to_big(mod)
		end
	elseif arrow >= 0 then
		if multchips == 'mult' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):arrow(arrow, mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):arrow(arrow, mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):arrow(arrow, mod)
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):arrow(arrow, mod)
		end
	elseif arrow == -1 then
		if multchips == 'mult' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):add(mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):add(mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):add(mod)
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):add(mod)
		end
	elseif arrow == -2 then
		if multchips == 'mult' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):sub(mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):sub(mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):sub(mod)
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):sub(mod)
		end
	elseif arrow == -3 then
		if multchips == 'mult' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):div(mod)
		elseif multchips == 'chips' then
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):div(mod)
		elseif multchips == 'multchips' then
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):div(mod)
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):siv(mod)
		end
	end
	G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):abs():normalize()
	G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):abs():normalize()
	if to_big(G.GAME.hands[hand].mult):isNaN() or to_big(G.GAME.hands[hand].mult):lt(1) then
		G.GAME.hands[hand].mult = previous_mult
	end
	if to_big(G.GAME.hands[hand].chips):isNaN() or to_big(G.GAME.hands[hand].chips):lt(1) then
		G.GAME.hands[hand].chips = previous_chips
	end
	if not silent then
		local display_arrow = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then display_arrow = -2 end
		if arrow == -2 and to_big(mod) < to_big(0) then display_arrow = -1 end
		delay(0.5)
		Q(function() if card then card:juice_up(.2, .3) end return true end)
		may.h(localize(hand, 'poker_hands'), previous_chips, previous_mult, G.GAME.hands[hand].level)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		if multchips == 'chips' or multchips == 'multchips' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound(may.get_operation_sound(arrow, 'chips'))
                if card then 
					card:juice_up(0.3, 0.5)
                end
				if type(arrow) == 'number' and arrow > 2 then
					G.ROOM.jiggle = G.ROOM.jiggle + math.min(30, math.log10(arrow) + math.log(mod, 1000))
				end
			return true end}))
			may.hc(may.generate_arrow_text(display_arrow)..number_format(math.abs(mod)), true)
		end
		if multchips == 'mult' or multchips == 'multchips' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound(may.get_operation_sound(arrow, 'mult'))
				if card then 
					card:juice_up(0.3, 0.5)
                end
				if type(arrow) == 'number' and arrow > 2 then
					G.ROOM.jiggle = G.ROOM.jiggle + math.min(30, math.log10(arrow) + math.log(mod, 1000))
				end
			return true end}))
			may.hm(may.generate_arrow_text(display_arrow)..number_format(math.abs(mod)), true)
		end
		may.th(hand)
		delay(0.5)
		may.ch()
		delay(0.5)
	end
end

function may.hand_mod_multchips_all(multchips, arrow, mod, silent, card, ignore)
	for k, v in pairs(G.GAME.hands) do
        if k ~= (ignore or '') then
		    local previous_mult = v.mult
		    local previous_chips = v.chips
		    if arrow == 'eq' then
			    if multchips == 'mult' then
				    v.mult = to_big(mod)
			    elseif multchips == 'chips' then
				    v.chips = to_big(mod)
			    elseif multchips == 'multchips' then
				    v.mult = to_big(mod)
				    v.chips = to_big(mod)
			    end
		    elseif arrow >= 0 then
			    if multchips == 'mult' then
				    v.mult = to_big(v.mult):arrow(arrow, mod)
			    elseif multchips == 'chips' then
				    v.chips = to_big(v.chips):arrow(arrow, mod)
			    elseif multchips == 'multchips' then
				    v.mult = to_big(v.mult):arrow(arrow, mod)
				    v.chips = to_big(v.chips):arrow(arrow, mod)
			    end
		    elseif arrow == -1 then
			    if multchips == 'mult' then
				    v.mult = to_big(v.mult):add(mod)
			    elseif multchips == 'chips' then
				    v.chips = to_big(v.chips):add(mod)
			    elseif multchips == 'multchips' then
				    v.mult = to_big(v.mult):add(mod)
				    v.chips = to_big(v.chips):add(mod)
			    end
		    elseif arrow == -2 then
			    if multchips == 'mult' then
				    v.mult = to_big(v.mult):sub(mod)
			    elseif multchips == 'chips' then
				    v.chips = to_big(v.chips):sub(mod)
			    elseif multchips == 'multchips' then
				    v.mult = to_big(v.mult):sub(mod)
				    v.chips = to_big(v.chips):sub(mod)
			    end
		    elseif arrow == -3 then
			    if multchips == 'mult' then
				    v.mult = to_big(v.mult):div(mod)
			    elseif multchips == 'chips' then
				    v.chips = to_big(v.chips):div(mod)
			    elseif multchips == 'multchips' then
				    v.mult = to_big(v.mult):div(mod)
				    v.chips = to_big(v.chips):div(mod)
			    end
		    end
		    if to_big(v.mult):isNaN() or to_big(v.mult):lt(1) then
			    v.mult = previous_mult
		    end
		    if to_big(v.chips):isNaN() or to_big(v.chips):lt(1) then
			    v.chips = previous_chips
		    end
	    end
    end
	if not silent then
		local display_arrow = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then display_arrow = -2 end
		if arrow == -2 and to_big(mod) < to_big(0) then display_arrow = -1 end
		delay(0.5)
		Q(function() card:juice_up(.2, .3) return true end)
		may.h('All Hands', '...', '...', '...')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('button')
		return true end}))
		if multchips == 'chips' or multchips == 'multchips' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound(may.get_operation_sound(arrow, 'chips'))
				card:juice_up(0.3, 0.5)
				if type(arrow) == 'number' and arrow > 2 then
					G.ROOM.jiggle = G.ROOM.jiggle + math.min(30, math.log10(arrow) + math.log(mod, 1000))
				end
			return true end}))
			may.hc(may.generate_arrow_text(display_arrow)..number_format(math.abs(mod)), true)
		end
		if multchips == 'mult' or multchips == 'multchips' then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound(may.get_operation_sound(arrow, 'mult'))
				card:juice_up(0.3, 0.5)
				if type(arrow) == 'number' and arrow > 2 then
					G.ROOM.jiggle = G.ROOM.jiggle + math.min(30, math.log10(arrow) + math.log(mod, 1000))
				end
			return true end}))
			may.hm(may.generate_arrow_text(display_arrow)..number_format(math.abs(mod)), true)
		end
		may.ch()
		delay(0.5)
	end
end

function may.hand_mod_score_all(arrow, mod, silent)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		v.score = to_big(v.score or 0)
	end
	if arrow >= 0 then
		for k, v in pairs(G.GAME.hands) do
			v.score = v.score:arrow(arrow, mod)
		end
	else
		if arrow == -1 then
			for k, v in pairs(G.GAME.hands) do
				v.score = v.score:add(mod)
			end
		elseif arrow == -2 then
			for k, v in pairs(G.GAME.hands) do
				v.score = v.score:sub(mod)
			end
		elseif arrow == -3 then
			for k, v in pairs(G.GAME.hands) do
				v.score = v.score:div(mod)
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		delay(0.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = 'All Hands '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = may.C.score,
				align = 'cm',
			})
			play_sound('may_addscore')
			play_sound('generic1')
		return true end}))
	end
end

function may.hand_mod_lvl_multchips_all(multchips, arrow, mod)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		v.l_mult = to_big(v.l_mult)
		v.l_chips = to_big(v.l_chips)
	end
	if arrow >= 0 then
		if multchips == 'mult' then
			for k, v in pairs(G.GAME.hands) do
				v.l_mult = v.l_mult:arrow(arrow, mod)
			end
		elseif multchips == 'chips' then
			for k, v in pairs(G.GAME.hands) do
				v.l_chips = v.l_chips:arrow(arrow, mod)
			end
		elseif multchips == 'multchips' then
			for k, v in pairs(G.GAME.hands) do
				v.l_mult = v.l_mult:arrow(arrow, mod)
				v.l_chips = v.l_chips:arrow(arrow, mod)
			end
		end
	else
		if arrow == -1 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:add(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:add(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:add(mod)
					v.l_chips = v.l_chips:add(mod)
				end
			end
		elseif arrow == -2 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:sub(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:sub(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:sub(mod)
					v.l_chips = v.l_chips:sub(mod)
				end
			end
		elseif arrow == -3 then
			if multchips == 'mult' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:div(mod)
				end
			elseif multchips == 'chips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_chips = v.l_chips:div(mod)
				end
			elseif multchips == 'multchips' then
				for k, v in pairs(G.GAME.hands) do
					v.l_mult = v.l_mult:div(mod)
					v.l_chips = v.l_chips:div(mod)
				end
			end
		end
	end
	if not silent then
		local handarea = G.HUD:get_UIE_by_ID('hand_text_area')
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			local text = 'All Hands '
			if arrow >= 1 then
				text = text..may.generate_arrow_text(arrow, 4)
			elseif arrow == 0  then
				text = text..'X'
			elseif arrow == -1 then
				text = text..'+'
			elseif arrow == -2 then
				text = text..'-'
			elseif arrow <= -3 then
				text = text..'/'
			end
			local col 
			if multchips == 'mult' then
				col = G.C.MULT
			elseif	multchips == 'chips' then
				col = G.C.CHIPS
			elseif	multchips == 'multchips' then
				col = G.C.PURPLE
			end
			attention_text({
				text = text..(to_number(mod) or 0),
				scale = 1, 
				hold = 1,
				cover = handarea,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('may_lvl_multchips')
			play_sound('generic1')
		return true end}))
	end
end

-- Gets the Jovian Moon corresponding to a specific Poker Hand
function may.jovianhand(hand)
	local key
	for k, v in pairs(G.P_CENTER_POOLS.Planet) do
		if v.config.jovian_hand == hand then
			key = v.key
			break
		end
	end
	return key or 'c_may_thebe'
end

-- Gets the Saturnian Moon corresponding to a specific Poker Hand
function may.saturnianhand(hand)
	local key
	for k, v in pairs(G.P_CENTER_POOLS.Planet) do
		if v.config.saturnian_hand == hand then
			key = v.key
			break
		end
	end
	return key or 'c_may_janus'
end 