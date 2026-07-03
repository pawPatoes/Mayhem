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