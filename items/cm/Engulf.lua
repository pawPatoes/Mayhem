-- Engulf cross-mod

Engulf.EditionFuncs.e_foil = nil
Engulf.EditionFuncs.e_holo = nil
Engulf.EditionFuncs.e_polychrome = nil

Engulf.EditionFuncs.e_may_hypnotic = function(card, hand, instant, amount, edition) 
	may.hand_mod_multchips(hand, 'mult', 'eq', G.GAME.hands[hand].chips ^ 1.5, instant, card)
end

Engulf.EditionFuncs.e_may_twilight = function(card, hand, instant, amount, edition) 
	may.hand_mod_multchips(hand, 'mult', -1, (G.GAME.may_twilight_amount or 5), instant, card)
	may.hand_mod_multchips(hand, 'chips', -1, (G.GAME.may_twilight_amount or 5), instant, card)
	G.GAME.may_twilight_amount = ((G.GAME.may_twilight_amount or 5) * 1.2) ^ 1.075
end

Engulf.EditionFuncs.e_may_alloy = function(card, hand, instant, amount, edition)
	local steel = 0
	local gold = 0
	for k, v in ipairs(G.playing_cards) do
		if SMODS.has_enhancement(v, 'm_steel') then
			steel = steel + 1
		elseif SMODS.has_enhancement(v, 'm_gold') then
			gold = gold + 1
		end
	end
	may.hand_mod_multchips(hand, 'mult', 0, (1 + (edition.x_mult * steel)) ^ amount, instant, card)
	may.hand_mod_dollars(hand, 0, (1 + (edition.x_dollars * gold)) ^ amount, instant)
end

Engulf.EditionFuncs.e_may_inverted = function(card, hand, instant, amount, edition)
	may.ease_interest(-1, 0.01 * amount)
end

Engulf.EditionFuncs.e_may_neon = function(card, hand, instant, amount, edition)
    local amount = 0
	for k, v in ipairs(G.jokers.cards) do
		if v.edition then
			amount = amount + 1
		end
    end
	for k, v in ipairs(G.consumeables.cards) do
		if v.edition then
			amount = amount + 1
	 end
	end
	for k, v in ipairs(G.playing_cards) do
		if v.edition then
			amount = amount + 1
		end
	end
	may.hand_mod_dollars(hand, -1, amount, instant)
end

Engulf.EditionFuncs.e_may_laminated = function(card, hand, instant, amount, edition)
	local found = 0
	for k, v in pairs(G.consumeables.cards) do
		if v.edition and v.edition.key == 'e_may_laminated' then
			found = found + v:getQty()
		end
	end
	if found > 0 then
	    may.hand_mod_multchips(hand, 'chips', -1, edition.chips * amount * found, instant, card)
	    may.hand_mod_multchips(hand, 'mult', -1, edition.mult * amount * found, instant, card)
	end
end

Engulf.EditionFuncs.e_may_cosmic = function(card, hand, instant, amount, edition)
    if card:gc().set and card:gc().set == 'Planet' then
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
		    local new = create_card('Planet', G.consumeables, nil, nil, nil, nil, may.planethand(hand), 'may_cosmic_engulf')
            new:add_to_deck()
            G.consumeables:emplace(new)
			new:juice_up(0.3, 0.5)
		    new:setQty(amount)
            new:set_edition('e_negative')
        return true end}))
    end
end

-- Custom operations and hyperoperation sounds
function Engulf.EditionHand(card, hand, edition, amount, instant)
    if card.ability.consumeable then
	    if Engulf.EditionFuncs[edition.key] then Engulf.EditionFuncs[edition.key](card, hand, instant, Engulf.config.stackeffects and amount or 1, edition) else
			
			if edition.chips then
				may.hand_mod_multchips(hand, 'chips', -1, edition.chips * (Engulf.config.stackeffects and amount or 1), instant, card)
			end
			if edition.mult then
				may.hand_mod_multchips(hand, 'mult', -1, edition.mult * (Engulf.config.stackeffects and amount or 1), instant, card)
			end
			
			if edition.x_chips then
				may.hand_mod_multchips(hand, 'chips', 0, edition.x_chips ^ (Engulf.config.stackeffects and amount or 1), instant, card)
			end
			if edition.x_mult then
				may.hand_mod_multchips(hand, 'mult', 0, edition.x_mult ^ (Engulf.config.stackeffects and amount or 1), instant, card)
			end
			
			if edition.e_chips then
				may.hand_mod_multchips(hand, 'chips', 1, to_big(edition.e_chips):arrow(2, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			if edition.e_mult then
				may.hand_mod_multchips(hand, 'mult', 1, to_big(edition.e_mult):arrow(2, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			
			if edition.ee_chips then
				may.hand_mod_multchips(hand, 'chips', 2, to_big(edition.ee_chips):arrow(3, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			if edition.ee_mult then
				may.hand_mod_multchips(hand, 'mult', 2, to_big(edition.ee_mult):arrow(3, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			
			if edition.eee_chips then
				may.hand_mod_multchips(hand, 'chips', 3, to_big(edition.eee_chips):arrow(4, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			if edition.eee_mult then
				may.hand_mod_multchips(hand, 'mult', 3, to_big(edition.eee_mult):arrow(4, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			
			if edition.hyper_chips then
				may.hand_mod_multchips(hand, 'chips', edition.hyper_chips[1], to_big(edition.hyper_chips[2]):arrow(edition.hyper_chips[1] + 1, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
			if edition.hyper_mult then
				may.hand_mod_multchips(hand, 'mult', edition.hyper_mult[1], to_big(edition.hyper_mult[2]):arrow(edition.hyper_mult[1] + 1, (Engulf.config.stackeffects and amount or 1)), instant, card)
			end
		    
		    if edition.p_dollars or edition.dollars or edition.h_dollars then may.hand_mod_dollars(hand, -1, edition.p_dollars or edition.dollars or edition.h_dollars, instant or false) end
		    
		    if edition.x_dollars then may.hand_mod_dollars(hand, 0, edition.x_dollars, instant or false) end
		    
		    if edition.score then may.hand_mod_score(hand, -1, edition.score*(Engulf.config.stackeffects and amount or 1), instant or false) end
		    if edition.x_score then may.hand_mod_score(hand, 0, edition.x_score^(Engulf.config.stackeffects and amount or 1), instant or false) end
		    if edition.e_score then may.hand_mod_score(hand, 1, to_big(edition.e_score):arrow(2, (Engulf.config.stackeffects and amount or 1)), instant or false) end
		    if edition.ee_score then may.hand_mod_score(hand, 2, to_big(edition.ee_score):arrow(3, (Engulf.config.stackeffects and amount or 1)), instant or false) end
		    if edition.eee_score then may.hand_mod_score(hand, 3, to_big(edition.eee_score):arrow(4, (Engulf.config.stackeffects and amount or 1)), instant or false) end
		    if edition.hyper_score then may.hand_mod_score(hand, edition.hyper_score[1], to_big(edition.hyper_score[2]:arrow(edition.hyper_score[1] + 1, (Engulf.config.stackeffects and amount or 1)), instant or false)) end
	    end
    end
end

local vanf_luh = level_up_hand
function level_up_hand(card, hand, instant, amount)
    if card and card.edition and (card.edition.retriggers or card.edition.repetitions) then
        if card.edition.retriggers then
            amount = (amount or 1) * (card.edition.retriggers + 1)
        else
            amount = (amount or 1) * (card.edition.repetitions + 1)
        end
    end
    vanf_luh(card, hand, instant, amount)
end