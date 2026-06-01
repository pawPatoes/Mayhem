-- Calculation keys
if SMODS and SMODS.calculate_individual_effect then
	local scie = SMODS.calculate_individual_effect
	function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local ret = scie(effect, scored_card, key, amount, from_edition)
		if ret then
			return ret
		end
		
		if (key == 'mdc_chip' or key == 'MDCchip_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips.current = mod_chips(chips.current:modocate(amount))
			update_hand_text({delay = 0}, {chips = chips.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Y"..amount.." Chips", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "Y"..number_format(amount).." Chips", colour = effect.colour or G.C.CHIPS, sound = effect.sound or 'may_mdc_chip'})
				end
			end
			return true
		end
		if (key == 'mdc_mult' or key == 'MDCmult_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult.current = mod_chips(mult.current:modocate(amount))
			update_hand_text({delay = 0}, {mult = mult.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Y"..amount.." Mult", colour =  G.C.EDITION, edition = true})
				else
                    card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "Y"..number_format(amount).." Mult", colour = effect.colour or G.C.MULT, sound = effect.sound or 'may_mdc_mult'})
				end
			end
			return true
		end
		
		--[[if (key == 'fact_chip' or key == 'FACTchip_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips.current = mod_chips(chips.current:fact(amount))
			update_hand_text({delay = 0}, {chips = chips.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Chips"..may.generate_fact_text(amount), colour =  G.C.EDITION, edition = true})
				elseif key ~= 'FACTchip_mod' then
					if effect.echip_message then
						card_eval_status_text_factchip(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.factchip_message)
					else
						card_eval_status_text_factchip(scored_card or effect.card or effect.focus, 'fact_chip', amount, percent)
					end
				end
			end
			return true
		end
		if (key == 'fact_mult' or key == 'FACTmult_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult.current = mod_mult(mult.current:fact(amount))
			update_hand_text({delay = 0}, {mult = mult.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Mult"..may.generate_fact_text(amount), colour =  G.C.EDITION, edition = true})
				elseif key ~= 'FACTmult_mod' then
					if effect.echip_message then
						card_eval_status_text_factmult(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.factmult_message)
					else
						card_eval_status_text_factmult(scored_card or effect.card or effect.focus, 'fact_mult', amount, percent)
					end
				end
			end
			return true
		end]]
		
		if (key == 'eq_chip' or key == 'EQchip_mod') then 
			if effect.card then juice_card(effect.card) end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips.current = to_big(amount)
			update_hand_text({delay = 0}, {chips = chips.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "="..amount.." Chips", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "="..number_format(amount).." Chips", colour = effect.colour or G.C.CHIPS, sound = effect.sound or 'may_eqchip'})
				end
			end
			return true
		end
		if (key == 'eq_mult' or key == 'EQmult_mod') then 
			if effect.card then juice_card(effect.card) end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult.current = to_big(amount)
			update_hand_text({delay = 0}, {mult = mult.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "="..amount.." Mult", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "="..number_format(amount).." Mult", colour = effect.colour or G.C.MULT, sound = effect.sound or 'may_eqmult'})
				end
			end
			return true
		end
		
		--[[if (key == 'expofact_chip' or key == 'EXPOFACTchip_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local chips = SMODS.Scoring_Parameters["chips"]
			chips.current = mod_chips(chips.current:expofact(amount))
			update_hand_text({delay = 0}, {chips = chips.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Chips"..may.generate_expofact_text(amount), colour =  G.C.EDITION, edition = true})
				elseif key ~= 'EXPOFACTchip_mod' then
					if effect.echip_message then
						card_eval_status_text_expofactchip(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.expofactchip_message)
					else
						card_eval_status_text_expofactchip(scored_card or effect.card or effect.focus, 'expofact_chip', amount, percent)
					end
				end
			end
			return true
		end
		if (key == 'expofact_mult' or key == 'EXPOFACTmult_mod') and amount ~= 1 then 
			if effect.card then juice_card(effect.card) end
			local mult = SMODS.Scoring_Parameters["mult"]
			mult.current = mod_mult(mult.current:expofact(amount))
			update_hand_text({delay = 0}, {mult = mult.current})
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "Mult"..may.generate_expofact_text(amount), colour =  G.C.EDITION, edition = true})
				elseif key ~= 'EXPOFACTmult_mod' then
					if effect.echip_message then
						card_eval_status_text_expofactmult(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.expofactmult_message)
					else
						card_eval_status_text_expofactmult(scored_card or effect.card or effect.focus, 'expofact_mult', amount, percent)
					end
				end
			end
			return true
		end]] 
		
		if key == 'eq_dollars' then 
			ease_dollars(to_big(0):sub(to_big(G.GAME.dollars)):add(to_big(amount)))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "="..amount.."$", colour =  G.C.MONEY, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "="..number_format(amount).."$", colour = effect.colour or G.C.MONEY, sound = effect.sound or 'may_eqdollars'})
				end
			end
			return true
		end
		if key == 'x_dollars' and amount ~= 1 then 
			may.hypermoney(0, amount, Talisman.config_file.disable_anims)
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "X"..amount.."$", colour =  G.C.MONEY, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "X"..number_format(amount).."$", colour = effect.colour or G.C.MONEY, sound = effect.sound or 'may_bigmoney'})
				end
			end
			return true
		end
		
		if (key == 'eq_score' or key == 'EQscore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.2, 0.2)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "="..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "="..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_eqscore'})					
				end
			end
			return true
		end
		if (key == 'add_score' or key == 'score_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):add(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.2, 0.2)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "+"..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "+"..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_addscore'})
				end
			end
			return true
		end
		if (key == 'x_score' or key == 'Xscore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):mul(amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "X"..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "X"..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_x_score'})
				end
			end
			return true
		end
		if (key == 'e_score' or key == 'Escore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(1, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4, 0.4)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "^"..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "^"..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_escore'})
				end
			end
			return true
		end
		if (key == 'ee_score' or key == 'EEscore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(2, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.5, 0.5)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "^^"..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "^^"..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_eescore'})
				end
			end
			return true
		end
		if (key == 'eee_score' or key == 'EEEscore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(3, amount)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.6, 0.6)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "^^^"..amount.." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or "^^^"..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or 'may_eeescore'})
				end
			end
			return true
		end
		if (key == 'hyper_score' or key == 'Hscore_mod') then 
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(amount[1], amount[2])
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up((amount[1] * 0.1) + 0.3, (amount[1] * 0.1) + 0.3)
			return true end}))
			if not effect.remove_default_message then
				if from_edition then
					card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = may.generate_arrow_text(amount[1])..amount[2].." Score", colour =  G.C.EDITION, edition = true})
				else
					card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = effect.message or may.generate_arrow_text(amount[1])..number_format(amount).." Score", colour = effect.colour or may.C.score, sound = effect.sound or may.get_operation_sound('score', amount[1])})
				end
			end
			return true
		end
	end
end

-- Good riddance.
--[[function card_eval_status_text_hyper_mult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'mult')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Mult'
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_hyper_chips(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'chips')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Chips'
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqmult'
	amt = amt
	text = 'Mult='..amt
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqchip'
	amt = amt
	text = 'Chips='..amt
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqscore'
	amt = amt
	text = 'Score='..amt
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eqdollars(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eqdollars'
	amt = amt
	text = '$='..amt
	colour = G.C.MONEY
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_addscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_addscore'
	amt = amt
	text = '+'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_xscore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_xscore'
	amt = amt
	text = 'X'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_escore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_escore'
	amt = amt
	text = '^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.8
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eescore'
	amt = amt
	text = '^^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.9
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_eeescore(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_eeescore'
	amt = amt
	text = '^^^'..amt..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(30, math.log(amt, 500))
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_hyper_score(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = may.get_operation_sound(amt[1], 'score')
	amt = amt
	text = (amt[1] > 5 and ('{' .. tostring(amt[1]) .. '}') or string.rep('^', amt[1])) .. tostring(amt[2])..' Score'
	colour = may.C.score
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	amt = amt[2]
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 + math.min(40, math.log(amt, 500))
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_mdcmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_mdcmult'
	amt = amt
	text = 'Y'..amt..' Mult'
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_factchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_mdcchip'
	amt = amt
	text = 'Y'..amt..' Chips'
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_apemult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_apemult'
	amt = amt
	text = "{Mult, "..amt.."}"
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_apechip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_apechip'
	amt = amt
	text = "{Chips, "..amt.."}"
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_factmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_factmult'
	amt = amt
	text = 'Mult'..generate_fact_text(amt, 20)
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_factchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_factchip'
	amt = amt
	text = 'Chips'..generate_fact_text(amt, 20)
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_expofactmult(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_expofactmult'
	amt = amt
	text = 'Mult'..generate_expofact_text(amt, 20)
	colour = G.C.MULT
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_expofactchip(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_expofactchip'
	amt = amt
	text = 'Chips'..generate_expofact_text(amt, 20)
	colour = G.C.CHIPS
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end

function card_eval_status_text_xdollars(card, eval_type, amt, percent, dir, extra)
	percent = percent or (0.9 + 0.2*math.random())
	if dir == 'down' then 
		percent = 1-percent
	end
    if extra and extra.focus then card = extra.focus end
	local text = ''
	local sound = nil
	local volume = 1
	local card_aligned = 'bm'
	local y_off = 0.15*G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05*card.T.h
	elseif card.area == G.hand then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.area == G.play then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	elseif card.jimbo  then
		y_off = -0.05*G.CARD_H
		card_aligned = 'tm'
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
	local extrafunc = nil
	sound = 'may_bigmoney'
	amt = amt
	text = "X"..amt..'$'
	colour = G.C.MONEY
	config.type = 'fade'
	config.scale = 0.7
	delay = delay*1.25
	if not Talisman.config_file.disable_anims then
		if to_big(amt) > to_big(1) or to_big(amt) < to_big(1) then
			if extra and extra.instant then
				if extrafunc then extrafunc() end
				attention_text({
					text = text,
					scale = config.scale or 1, 
					hold = delay - 0.2,
					backdrop_colour = colour,
					align = card_aligned,
					major = card,
					offset = {x = 0, y = y_off}
				})
				play_sound(sound, 0.8+percent*0.2, volume)
				if not extra or not extra.no_juice then
					card:juice_up(0.6, 0.1)
					G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
				end
			else
				G.E_MANAGER:add_event(Event({ trigger = 'before',delay = delay,func = function()
					if extrafunc then extrafunc() end
						attention_text({
							text = text,
							scale = config.scale or 1, 
							hold = delay - 0.2,
							backdrop_colour = colour,
							align = card_aligned,
							major = card,
							offset = {x = 0, y = y_off}
						})
						play_sound(sound, 0.8+percent*0.2, volume)
						if not extra or not extra.no_juice then
							card:juice_up(0.6, 0.1)
							G.ROOM.jiggle = G.ROOM.jiggle + 0.7 
						end
						return true
						end
				}))
			end
		end
	end
	if extra and extra.playing_cards_created then 
		playing_card_joker_effects(extra.playing_cards_created)
	end
end]] 