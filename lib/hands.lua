-- Poker Hand functions

function may.no_context_lvl_up(card, hand, instant, amount)
    SMODS.upgrade_poker_hands({
        hands = hand,
        func = function(base, hand, parameter)
            return base + G.GAME.hands[hand]['l_' .. parameter] * amount
        end,
        level_up = amount,
        from = card,
        instant = instant, 
		no_context = true,
    })
end

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
			may.hm(G.GAME.hands[hand].mult, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(G.GAME.hands[hand].chips, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_eq_level')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			may.hlv(G.GAME.hands[hand].level, true)
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
				may.hm('+', true)
			else
				may.hm('-', true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				return true end}))
			if to_big(amount) > to_big(0) then
				may.hc('+', true)
			else
				may.hc('-', true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
				play_sound('tarot1')
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			if to_big(amount) > to_big(0) then
				may.hlv('+'..amount, true)
			else
				may.hlv(-math.abs(amount), true)
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
				may.hm('+', true)
			else
				may.hm('-', true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			if to_big(amount) > to_big(0) then
				may.hc('+', true)
			else
				may.hc('-', true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('may_super_level')
				if arrow > 0 then 
					play_sound(may.get_operation_sound(arrow, 'chips'))
				end
				if card then card:juice_up(0.8, 0.5) end
				G.TAROT_INTERRUPT_PULSE = nil
			return true end}))
			may.hlv(may.generate_arrow_text(arrow)..amount, true)
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

-- deprecated
function may.hand_mod_lvl_multchips(hand, multchips, arrow, mod, silent)
	may.hand_lvl_multchips(nil, hand, silent, (multchips == 'chips' or multchips == 'multchips') and {arrow, mod} or nil, (multchips == 'mult' or multchips == 'multchips') and {arrow, mod} or nil)
	may.ch()
	may.refresh_score_operator()
end

-- New function for modifying level Mult & Chips. mult and chips are tables: {ARROW, MOD}
function may.hand_lvl_multchips(card, hand, instant, chips, mult)
	if not G.GAME.hands[hand] then return end 
	mod = to_big(mod)
	local prev_chips = to_big(G.GAME.hands[hand].l_chips)
	local prev_mult = to_big(G.GAME.hands[hand].l_mult)
	G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult)
	G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips)
	if chips then
		G.GAME.hands[hand].l_chips = to_big(G.GAME.hands[hand].l_chips):arrow(chips[1] or -1, chips[2])
	end
	if mult then
		G.GAME.hands[hand].l_mult = to_big(G.GAME.hands[hand].l_mult):arrow(mult[1] or -1, mult[2])
	end
	if not instant then
		may.th(hand)
		delay(0.5)
		may.cosmetic_score_operator('Lv.', G.C.UI.TEXT_LIGHT, 'may_lvl_multchips')
		may.hcm(prev_chips, prev_mult, false)
		delay(0.7)
		if chips then 
			local op = may.generate_arrow_text(chips[1])
			local op_num = chips[1]
			if chips[1] == -1 and to_big(chips[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'chips'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(op..math.abs(chips[2]), true)
			delay(0.2)
			may.hc(to_big(G.GAME.hands[hand].l_chips), false)
		end
		if mult then 
			local op = may.generate_arrow_text(mult[1])
			local op_num = mult[1]
			if mult[1] == -1 and to_big(mult[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'mult'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hm(op..math.abs(mult[2]), true)
			delay(0.2)
			may.hm(to_big(G.GAME.hands[hand].l_mult), false)
		end
		delay(1.3)
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_mod_dollars(card, hand, silent, arrow, mod)
	if not G.GAME.hands[hand] then return end 
	mod = to_big(mod)
	G.GAME.hands[hand].dollars = to_big(G.GAME.hands[hand].dollars or 0)
	local prev = G.GAME.hands[hand].dollars
	if to_big(arrow) >= to_big(0) then
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
		G.GAME.may_override_monitor_colors = true
		may.cosmetic_score_operator('', {0, 0, 0, 0})
		G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
			ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
		return true end}))
		may.h(localize(hand, 'poker_hands'), prev, '---', G.GAME.hands[hand].level)
		local op = may.generate_arrow_text(arrow)
		local op_num = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then
			op = '-'
			op_num = -2
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.TAROT_INTERRUPT_PULSE = true
			play_sound(may.get_operation_sound(op_num, 'dollars'))
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		may.hc(op..math.abs(mod), true)
		delay(0.2)
		may.hc(G.GAME.hands[hand].dollars, false)
		delay(1.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.1)
			G.GAME.may_override_monitor_colors = nil
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_mod_dollars_all(card, silent, arrow, mod)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		v.dollars = to_big(v.dollars or 0)
	end
	if to_big(arrow) >= to_big(0) then
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
		G.GAME.may_override_monitor_colors = true
		may.cosmetic_score_operator('', {0, 0, 0, 0})
		G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
			ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
		return true end}))
		may.h('All Hands', '...', '---', G.GAME.hands[hand].level)
		local op = may.generate_arrow_text(arrow)
		local op_num = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then
			op = '-'
			op_num = -2
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.TAROT_INTERRUPT_PULSE = true
			play_sound(may.get_operation_sound(op_num, 'dollars'))
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		may.hc(op..math.abs(mod), true)
		delay(1.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.1)
			G.GAME.may_override_monitor_colors = nil
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_mod_score(card, hand, silent, arrow, mod)
	mod = to_big(mod)
	G.GAME.hands[hand].score = to_big(G.GAME.hands[hand].score or 0)
	local prev = G.GAME.hands[hand].score
	if to_big(arrow) >= to_big(0) then
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
		G.GAME.may_override_monitor_colors = true
		may.cosmetic_score_operator('', {0, 0, 0, 0})
		G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
			ease_colour(G.C.UI_MULT, copy_table(may.C.score), 0.1)
		return true end}))
		may.h(localize(hand, 'poker_hands'), '---', prev, G.GAME.hands[hand].level)
		local op = may.generate_arrow_text(arrow)
		local op_num = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then
			op = '-'
			op_num = -2
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.TAROT_INTERRUPT_PULSE = true
			play_sound(may.get_operation_sound(op_num, 'score'))
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		may.hm(op..math.abs(mod), true)
		delay(0.2)
		may.hm(G.GAME.hands[hand].score, false)
		delay(1.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			ease_colour(G.C.UI_MULT, G.C.RED, 0.1)
			G.GAME.may_override_monitor_colors = nil
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_mod_score_dollars_composite(card, hand, silent, score, dollars)
	G.GAME.hands[hand].score = to_big(G.GAME.hands[hand].score or 0)
	G.GAME.hands[hand].dollars = to_big(G.GAME.hands[hand].dollars or 0)
	local prev_score = G.GAME.hands[hand].score
	local prev_dollars = G.GAME.hands[hand].dollars
	if score then
		G.GAME.hands[hand].score = to_big(G.GAME.hands[hand].score):arrow(score[1] or -1, score[2])
	end
	if dollars then
		G.GAME.hands[hand].dollars = to_big(G.GAME.hands[hand].dollars):arrow(dollars[1] or -1, dollars[2])
	end
	if not silent then
		G.GAME.may_override_monitor_colors = true
		may.cosmetic_score_operator('', {0, 0, 0, 0})
		G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
			if score then
				ease_colour(G.C.UI_MULT, copy_table(may.C.score), 0.1)
			end
			if dollars then
				ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
			end
		return true end}))
		may.h(localize(hand, 'poker_hands'), prev_dollars, prev_score, number_format(G.GAME.hands[hand].level))
		if dollars then
			local op = may.generate_arrow_text(dollars[1])
			local op_num = dollars[1]
			if dollars[1] == -1 and to_big(dollars[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'dollars'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(op..math.abs(dollars[2]), true)
			delay(0.2)
			may.hc(G.GAME.hands[hand].dollars, false)
		end
		if score then
			local op = may.generate_arrow_text(score[1])
			local op_num = score[1]
			if score[1] == -1 and to_big(score[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'score'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hm(op..math.abs(score[2]), true)
			delay(0.2)
			may.hm(G.GAME.hands[hand].score, false)
		end
		delay(1.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			ease_colour(G.C.UI_MULT, G.C.RED, 0.1)
			ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.1)
			G.GAME.may_override_monitor_colors = nil
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

-- deprecated
function may.hand_mod_multchips(hand, multchips, arrow, mod, silent, card)
	may.hand_multchips(nil, hand, silent, (multchips == 'chips' or multchips == 'multchips') and {arrow, mod} or nil, (multchips == 'mult' or multchips == 'multchips') and {arrow, mod} or nil)
	may.ch()
end

function may.hand_multchips(card, hand, instant, chips, mult)
	local prev_mult = to_big(G.GAME.hands[hand].mult)
	local prev_chips = to_big(G.GAME.hands[hand].chips)
	if chips then
	    if chips[1] == 'eq' then
			G.GAME.hands[hand].chips = to_big(chips[2])
	    else
			G.GAME.hands[hand].chips = to_big(G.GAME.hands[hand].chips):arrow(chips[1], chips[2])
		end
	end
	if mult then
	    if mult[1] == 'eq' then
			G.GAME.hands[hand].mult = to_big(mult[2])
	    else
			G.GAME.hands[hand].mult = to_big(G.GAME.hands[hand].mult):arrow(mult[1], mult[2])
		end
	end
	if not instant then
		may.h(localize(hand, 'poker_hands'), prev_chips, prev_mult, G.GAME.hands[hand].level)
		delay(0.5)
		if chips then 
			local op = may.generate_arrow_text(chips[1])
			local op_num = chips[1]
			if chips[1] == -1 and to_big(chips[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'chips'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(op..math.abs(chips[2]), true)
			delay(0.2)
			may.hc(G.GAME.hands[hand].chips, false)
		end
		if mult then 
			local op = may.generate_arrow_text(mult[1])
			local op_num = mult[1]
			if mult[1] == -1 and to_big(mult[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			    G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'mult'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hm(op..math.abs(mult[2]), true)
			delay(0.2)
			may.hm(G.GAME.hands[hand].mult, false)
		end
		delay(1.3)
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_multchips_all(card, ignore, instant, chips, mult, hand_text)
	local targets = {}
	for k, v in pairs(G.GAME.hands) do
	    if (type(ignore) == 'string' and k ~= ignore) or (type(ignore) == 'table' and not table_hasvalue(ignore, k)) or (not ignore) then
		    table.insert(targets, k)
		end
	end
	for k, v in pairs(targets) do
	   may.hand_multchips(card, v, true, chips, mult)
	end
	if not instant then
		may.h(hand_text or (not ignore and 'All Hands' or 'Other Hands'), '...', '...', '...')
		delay(0.5)
		if chips then 
			local op = may.generate_arrow_text(chips[1])
			local op_num = chips[1]
			if chips[1] == -1 and to_big(chips[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'chips'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(op..math.abs(chips[2]), true)
		end
		if mult then 
			local op = may.generate_arrow_text(mult[1])
			local op_num = mult[1]
			if mult[1] == -1 and to_big(mult[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'mult'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hm(op..math.abs(mult[2]), true)
		end
		delay(1.3)
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

-- deprecated
function may.hand_mod_multchips_all(multchips, arrow, mod, silent, card, ignore)
	may.hand_multchips_all(card, ignore, silent, (multchips == 'chips' or multchips == 'multchips') and {arrow, mod} or nil, (multchips == 'mult' or multchips == 'multchips') and {arrow, mod} or nil)
	may.ch()
end

function may.hand_mod_score_all(card, arrow, mod, silent)
	mod = to_big(mod)
	for k, v in pairs(G.GAME.hands) do
		may.hand_mod_score(card, k, true, arrow, mod)
	end
	if not silent then
        G.GAME.may_override_monitor_colors = true
		may.cosmetic_score_operator('', {0, 0, 0, 0})
		G.E_MANAGER:add_event(Event({delay = 0.2, func = function()
			ease_colour(G.C.UI_MULT, copy_table(may.C.score), 0.1)
		return true end}))
		may.h('All Hands', '---', '...', G.GAME.hands[hand].level)
		local op = may.generate_arrow_text(arrow)
		local op_num = arrow
		if arrow == -1 and to_big(mod) < to_big(0) then
			op = '-'
			op_num = -2
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			G.TAROT_INTERRUPT_PULSE = true
			play_sound(may.get_operation_sound(op_num, 'score'))
			if card then card:juice_up(0.8, 0.5) end
		return true end}))
		may.hm(op..math.abs(mod), true)
		delay(1.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			ease_colour(G.C.UI_MULT, G.C.RED, 0.1)
			G.GAME.may_override_monitor_colors = nil
		return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
		return true end}))
	end
end

function may.hand_mod_lvl_multchips_all(multchips, arrow, mod)
	may.hand_lvl_multchips_all(nil, false, (multchips == 'chips' or multchips == 'multchips') and {arrow, mod} or nil, (multchips == 'mult' or multchips == 'multchips') and {arrow, mod} or nil)
end

function may.hand_lvl_multchips_all(card, immediate, chips, mult, ignore)
	for k, v in pairs(G.GAME.hands) do
		if k ~= (ignore or '') then
		    may.hand_lvl_multchips(card, k, true, chips, mult)
		end
	end
	if not immediate then
	    may.h(ignore and 'Other Hands' or 'All Hands', '...', '...', '...')
		delay(0.5)
		may.cosmetic_score_operator('Lv.', G.C.UI.TEXT_LIGHT, 'may_lvl_multchips')
		may.hcm(prev_chips, prev_mult, false)
		delay(0.7)
		if chips then 
			local op = may.generate_arrow_text(chips[1])
			local op_num = chips[1]
			if chips[1] == -1 and to_big(chips[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'chips'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hc(op..math.abs(chips[2]), true)
		end
		if mult then 
			local op = may.generate_arrow_text(mult[1])
			local op_num = mult[1]
			if mult[1] == -1 and to_big(mult[2]) < to_big(0) then
				op = '-'
				op_num = -2
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.TAROT_INTERRUPT_PULSE = true
				play_sound(may.get_operation_sound(op_num, 'mult'))
				if card then card:juice_up(0.8, 0.5) end
			return true end}))
			may.hm(op..math.abs(mult[2]), true)
		end
		delay(1.3)
		G.E_MANAGER:add_event(Event({func = function()
			G.TAROT_INTERRUPT_PULSE = nil
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