-- Epic jokers

SMODS.Joker {
	key = 'poker',
	loc_txt = {
		name = 'POKER',
		text = {
			{
				"{C:green}Scoring{} {C:attention}cards{} give {X:attention,C:white}X#1#{} Blind Size {C:attention}before scoring{}",
				may.pager(),
                "Played {C:hearts}Hearts{} give {C:mult}+#2#{} Mult", 
                "Played {C:diamonds}Diamonds{} give {C:money}+$#3#{}", 
                "Played {C:clubs}Clubs{} give {X:chips,C:white}X#4#{} Chips", 
                "Played {C:spades}Spades{} give {C:chips}+#5#{} Chips", 
				may.pager(),
                "{X:mult,C:white}^#6#{} Mult if played hand contains {C:attention}all suits{} above", 
				may.pager(),
                "{C:planet}Level up{} a {C:green}random{} {C:purple}Poker Hand{} by {C:attention}#7#{}", 
                "when a {C:attention}consumable{} is {C:attention}used{}", 
                "{C:green}Additional{} {C:planet}+#8#{} levels if used consumable", 
                "is a {C:planet}Planet Card{}", 
				may.pager(), 
				"{C:inactive}Hand level-ups are silent{}"
			},
			{
				"{C:inactive,E:1}Music and idea from Rolling Sky by Cheetah Mobile{}"
			},
		}
	},
	config = { extra = { x_blind_size = 0.95, mult = 25, p_dollars = 3, x_chips = 1.75, hand_chips = 100, e_mult = 1.2, levels = 0.5, add_levels = 0.25 } },
	pos = { x = 0, y = 0 },
	cost = 18,
	rarity = may.epic_key,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'placeholder',
	loc_vars = function(self, info_queue, card)
        return {vars = {  card.ability.extra.x_blind_size, card.ability.extra.mult, card.ability.extra.p_dollars, card.ability.extra.x_chips, card.ability.extra.hand_chips, card.ability.extra.e_mult, card.ability.extra.levels, card.ability.extra.add_levels }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if context.other_card:is_suit('Diamonds') then
				return {
					p_dollars = card.ability.extra.p_dollars,
					card = card,
				}
			elseif context.other_card:is_suit('Hearts') then 
                return {
                    mult = card.ability.extra.mult, 
                    card = card
                }
            elseif context.other_card:is_suit('Spades') then 
                return {
                    chips = card.ability.extra.hand_chips, 
                    card = card
                }
            elseif context.other_card:is_suit('Clubs') then 
                return {
                    x_chips = card.ability.extra.x_chips, 
                    card = card
                }
            end
		end
        if context.before and context.cardarea == G.jokers then 
            if scoring_hand then 
                for k, v in pairs(scoring_hand) do
                    G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.x_blind_size
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        play_sound('may_blind_size')
                        v:juice_up(0.3, 0.5)
                        card:juice_up(0.3, 0.5)
                    return true end})) 
                end 
            end
        end
        if context.joker_main then 
            local found = { heart = false, spade = false, diamond = false, club = false }
            local found_all = false
            for k, v in pairs(G.play.cards) do
                if v:is_suit('Hearts') then 
                    found.heart = true
                elseif v:is_suit('Spades') then
                    found.spade = true 
                elseif v:is_suit('Diamonds') then 
                    found.diamond = true
                elseif v:is_suit('Clubs') then
                    found.club = true 
                end
            end
            if found.heart and found.spade and found.diamond and found.club then 
                return {
                    e_mult = card.ability.extra.e_mult,
                    card = card
                }
            end
        end
        if context.using_consumeable then 
            level_up_hand(card, may.rndhand(), true, card.ability.extra.levels + (context.consumeable:gc().set == 'Planet' and card.ability.extra.add_levels or 0))
        end
		if context.forcetrigger then
			return {
                e_mult = card.ability.extra.e_mult,
                card = card
            }
		end
	end
}

SMODS.Joker {
	key = 'daredevil',
	loc_txt = {
		name = 'Daredevil',
		text = {
			{
				"If Blind was {C:attention}beaten{} on your {C:attention}last{} hand,",
				"{C:green}#1# in #2#{} chance to increase {C:dark_edition}Score Operator{}",
				"level by {C:attention}#3#{}",
				"{C:mult}Only works once{}", 
				"{X:attention,C:white}X#4#{} Blind Size",
			},
			may.add_fusion_text('Universal Collapse', 'Party Time', may.get_condition('party_time'))
		}
	},
	config = { extra = { odds = 20, mod = 1, blindmult = 4, active = false } },
	pos = { x = 1, y = 7 },
	cost = 14,
	rarity = may.epic_key,
	unlocked = true,
    endless = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult }}
    end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(0, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(-3, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
    calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and (G.GAME.current_round.hands_left == 0 or #SMODS.find_card('j_cry_panopticon') ~= 0) and not context.blueprint then
			if pseudorandom('may_daredevil') < G.GAME.probabilities.normal / card.ability.extra.odds then
				if not card.ability.extra.active then
					card.ability.extra.active = true
					change_operator(card.ability.extra.mod)
					return {
						message = 'Upgraded!',
						card = card
					}
				end
			end
		end
		if context.forcetrigger then
			change_operator(card.ability.extra.mod)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Joker {
	key = 'cacophonous',
	loc_txt = {
		name = 'Cacophonous',
		text = {
			"{X:mult,C:white}X#1#{} Mult for {C:attention}every owned Joker{}",
			"{C:attention}Increases by {X:mult,C:white}#2#{} when a {C:attention}Joker is bought{}",
			"{C:inactive}{X:mult,C:white}X#3#{} {C:inactive}Mult in total{}"
		}
	},
	config = { extra = { Xmult = 0.2, Xmult_gain = 0.05,  } },
	rarity = may.epic_key,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 6 },
	cost = 12,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, G.jokers and ((#(G.jokers.cards or {})*card.ability.extra.Xmult) + 1) or 0 } }
	end,
	calculate = function(self, card, context) 
		if context.joker_main and (card.ability.extra.Xmult*#G.jokers.cards) + 1 > 1 then
			return {
				Xmult_mod = ((card.ability.extra.Xmult*#G.jokers.cards)+1),
				message = "X"..((card.ability.extra.Xmult*#G.jokers.cards)+1).." Mult",
				card = card,
				colour = G.C.RED,		
			}
		end
		if context.buying_card and context.card.ability.set == 'Joker' then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = "Upgraded!",
				card = card,
				colour = G.C.RED,		
			}
		end
		if context.forcetrigger then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = "Upgraded!",
				card = card,
				colour = G.C.RED,		
			}
		end
	end
}

--[[SMODS.Joker {
	key = 'n',
	loc_txt = {
		name = {"N", "{C:dark_edition,s:0.6}N Joker"},
		text = {
            {
			    "If played hand is {C:attention}Three of a kind{},",
			    "create a {C:dark_edition}Polychrome{} {C:attention}Sly Joker{}",
			    "{C:inactive}(Does not require room){}",
            }, 
            {
			    "{C:inactive,E:1}Original idea & art by _TeKKen_{}"
            }, 
		}
	},
	rarity = may.epic_key,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 1, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 14,
	config = { extra = { chips = 50 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_polychrome']
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Three of a Kind']) then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({polychrome = true}, false, false)
		end
		if context.forcetrigger then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({polychrome = true}, false, false)
			end
		end
	end
}

SMODS.Joker {
	key = 'n_lowercase',
	loc_txt = {
		name = {'n', "{C:dark_edition,s:0.6}N Joker"},
		text = {
            {
			    "{C:attention}Gains{} {X:chips,C:white}^#1#{} Chips when {C:dark_edition}Sly Joker{} is {C:attention}sold{}",
			    "{C:inactive}Currently {X:chips,C:white}^#2#{}{C:inactive} Chips{}",
            }, 
            {
                "{C:inactive,E:1}Original idea & art by _TeKKen_{}"
            }
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { tostring(card.ability.extra.Echip_gain), card.ability.extra.Echip, } }
	end,
	config = { extra = { Echip_gain = 0.014, Echip = 1 } },
	rarity = may.epic_key,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pools = { N = true },
	pos = { x = 3, y = 8 },
	cost = 14,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Echip > 1 then
			return {
				Echip_mod = card.ability.extra.Echip,
				message = '^'.. card.ability.extra.Echip .. ' Chips',
				colour = G.C.CHIPS,
				card = card,				
			}
		end
		if context.selling_card and context.card.ability.set == "Joker" and context.card:gc().key == 'j_sly' and not context.blueprint then
			card.ability.extra.Echip = card.ability.extra.Echip + card.ability.extra.Echip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
		if context.forcetrigger then
			card.ability.extra.Echip = card.ability.extra.Echip + card.ability.extra.Echip_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
			}
		end
	end
}]]

SMODS.Joker {
	key = '3d_joker',
	loc_txt = {
		name = '3D Joker',
		text = {
			"Played {C:attention}3s{} give {X:mult,C:white}^#1#{} Mult",
		}
	},
	config = { extra = { Emult = 1.13 } },
	rarity = may.epic_key,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 4, y = 7 },
	cost = 12,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 3 then
				return {
					e_mult = card.ability.extra.Emult,
					colour = G.C.RED,
					card = context.other_card,	
				}
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				colour = G.C.RED,
				card = context.other_card,	
			}
		end
	end
}