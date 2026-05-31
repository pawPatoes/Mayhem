-- Rare Jokers
	
SMODS.Joker {
	key = 'jonas',
	loc_txt = {
		name = 'Jonas',
		text = {
            {
			    "{X:mult,C:white}X#1#{} Mult"
            }, 
            {
                "{C:inactive,E:1}Improved art by _TeKKen_{}"
            }
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 4, y = 17 },
	blueprint_compat = true,
	config = { extra = { Xmult = 4, } },
	cost = 8,
    endless = true, 
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X'..card.ability.extra.Xmult..' Mult',
				colour = G.C.MULT,
				card = card
			}
		end
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Joker {
	key = 'aaaa',
	loc_txt = {
		name = 'AAAA',
		text = {
			{
				"Retrigger all",
				"played {C:attention}Aces #1#{} times",
			},
			may.add_fusion_text('Universal Collapse', 'Acum', may.get_condition('acum'))
		}
	},
	config = { extra = { repetitions = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions} }
	end,
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 5 },
	cost = 6,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then		
				return {
					message = 'AAAAgain!',
					repetitions = card.ability.extra.repetitions,
					card = card,
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card:juice_up(.5, .5)
					return true end }))	
				}
			end
		end
	end
} 

SMODS.Joker {
	key = 'voucher_joker',
	loc_txt = {
		name = 'Voucher Joker',
		text = {
            {
			    "{C:attention}+#1#{} {C:green}Voucher Slot{}",
            }, 
            {
			    "{C:inactive,E:1}Idea by _TeKKen_{}"
            },
		}
	},
	config = { extra = { slots = 1 } },
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 3, y = 15 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.change_voucher_limit(card.ability.extra.slots)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_voucher_limit(-card.ability.extra.slots)
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			SMODS.change_voucher_limit(card.ability.extra.slots)
			return {
				message = '+'..card.ability.extra.slots..' Voucher Slot',
				
			}
		end
	end
}

SMODS.Joker {
	key = 'lil_prince',
	loc_txt = {
		name = "Lil' Prince",
		text = {
            {
			    "{X:mult,C:white}^#1#{} Mult if played",
			    "hand is {C:attention}Royal Flush{}",
			    "{C:attention}otherwise{}, {C:mult}destroy{} all scoring {C:attention}cards{}",
            }, 
            {
			    "{C:inactive,E:1}Art by _TeKKen_{}"
            }
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 3, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	cost = 6,
	config = { extra = { Emult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands['may_Royal Flush']) then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT
			}
		end
		if context.destroying_card then
			if not next(context.poker_hands['may_Royal Flush']) then
				return {remove = not context.destroying_card.ability.eternal}
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'gemstone',
	loc_txt = {
    name = 'Gemstone',
    text = {
			"{C:attention}Glass Cards{} also give {X:chips,C:white}X#1#{} Chips",
			"but {C:attention}always break{}"
		}
	},
	config = { extra = { Xchips = 2.5 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 0 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.name == 'Glass Card' then
				return {
					xchips = card.ability.extra.Xchips,
					colour = G.C.CHIPS,
					card = context.other_card,	
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						card2 = context.other_card
						card:juice_up(.3, .5)
						card2:shatter()
						card2.will_shatter = true
					return true end }))
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'pea',
	loc_txt = {
        name = 'Pea',
        text = {
            {
			    "{C:attention}Held in hand{} {C:dark_edition}Steel{} cards",
			    "give {C:attention}played{} {C:purple}Poker Hand{} {X:mult,C:white}X#1#{} Mult",
			    "after scoring",
		    }, 
            {
			    "{C:inactive,E:1}Art & idea by _TeKKen_{}"
            }
	    },
    },
	config = { extra = { Xmult = 1.2 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 17 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.after then
			for k, v in pairs(G.hand.cards) do
				if v.ability.name == 'Steel Card' then
					may.th(G.GAME.current_round.current_hand.handname)
					G.GAME.hands[G.GAME.current_round.current_hand.handname or 'High Card'].mult = G.GAME.hands[G.GAME.current_round.current_hand.handname or 'High Card'].mult * card.ability.extra.Xmult
					delay(0.5)
					Q(function() card:juice_up(.2, .3) return true end)
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						play_sound('button')
					return true end}))
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
						play_sound('multhit2')
						card:juice_up(0.3, 0.5)
						v:juice_up(0.3, 0.5)
					return true end}))
					may.hcm(nil, 'X'..card.ability.extra.Xmult..'', true)
					may.ch()
					delay(0.5)
				end
			end
		end
	end
}

--[[SMODS.Joker {
	key = 'nose',
	loc_txt = {
		name = {"Nose", "{C:dark_edition,s:0.6}N Joker"},
		text = {
            {
			    "If played hand is {C:attention}Three of a kind{},",
			    "all played {C:attention}cards{} gain {C:mult}+#1#{} Mult",
			    "Increases by {C:attention}#2#{} for every owned {C:dark_edition}Sly Joker{}",
			    "at the {C:attention}end of round{}",
            }, 
            {
			    "{C:inactive,E:1}Original idea & art by _TeKKen_{}"
            }, 
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 2, y = 10 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { mult = 3, mult_gain = 3} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and G.GAME.current_round.current_hand.handname == localize("Three of a Kind", 'poker_hands') then
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
			return {
				message = 'Upgraded!',
				card = context.other_card,
				colour = G.C.MULT
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					amount = amount + card.ability.extra.mult_gain
				end
			end
			if amount ~= 0 then
				card.ability.extra.mult = card.ability.extra.mult + amount
				return {
					message = 'Upgraded! (+'..amount..')',
					card = card,
					colour = G.C.MULT
				}
			end
		end
		if context.forcetrigger then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					amount = amount + card.ability.extra.mult_gain
				end
			end
			if amount ~= 0 then
				card.ability.extra.mult = card.ability.extra.mult + amount
				return {
					message = 'Upgraded! (+'..amount..')',
					card = card,
					colour = G.C.MULT
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'grafitti_n',
	loc_txt = {
		name = {"Grafitti N", "{C:dark_edition,s:0.6}N Joker"},
		text = {
            {
			    "If played hand is {C:attention}Three of a kind{},",
			    "{C:green}#1# in #2#{} chance to create a {C:dark_edition}Foil{} {C:attention}Sly Joker{}",
			    "{C:green}Always{} triggers if you own {C:attention}3{} or more {C:dark_edition}N{} jokers",
			    "{C:mult}Works once per round{}",
			    "{C:inactive}(Must have room){}",
			    "{C:inactive}#3#, #4#{}",
            }, 
            {
			    "{C:inactive,E:1}Original idea & art by _TeKKen_{}"
            }, 
		} 
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 3, y = 10 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 6,
	config = { extra = { odds = 6, cantrigger = true, guaranteed = false} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['e_foil']
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cantrigger and 'Active' or 'Inactive', card.ability.extra.guaranteed and 'guaranteed' or 'not guaranteed' } }
	end,
	calculate = function(self, card, context)
		if context.before and G.GAME.current_round.current_hand.handname == localize("Three of a Kind", 'poker_hands') and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and card.ability.extra.cantrigger then
			if card.ability.extra.guaranteed then
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({foil = true}, false, false)
				card.ability.extra.cantrigger = false
			else
				if pseudorandom('may_grafitti_n') < G.GAME.probabilities.normal / card.ability.extra.odds then
					local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
					G.jokers:emplace(card2)
					card2:add_to_deck()
					card2:set_edition({foil = true}, false, false)
					card.ability.extra.cantrigger = false
				end
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.cantrigger == false then
			card.ability.extra.cantrigger = true
			return {
				message = 'Activated!',
				card = card
			}
		end
		if context.forcetrigger then
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
			G.jokers:emplace(card2)
			card2:add_to_deck()
			card2:set_edition({foil = true}, false, false)
			card.ability.extra.cantrigger = false
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.n_joker and v ~= card then
					amount = amount + 1
					if amount >= 3 then
						card.ability.extra.guaranteed = true
					end
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'nnnn',
	loc_txt = {
		name = {"NNNN", "{C:dark_edition,s:0.6}N Joker"},
		text = {
			"{C:attention}Retrigger{} all {C:dark_edition}N{} {C:attention}Jokers{} for",
			"{C:attention}every Ace{} in {C:attention}scoring hand{}",
			"If played hand is {C:attention}Three of a Kind{}, set the rank of",
			"{C:attention}all scoring cards{} to {C:attention}Aces{}",
			"{C:inactive}(NNNN excluded){}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	demicoloncompat = true,
	pos = { x = 1, y = 16 },
	blueprint_compat = true,
	cost = 6,
	config = { extra = { odds = 6, cantrigger = true, guaranteed = false} },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.cantrigger and 'Active' or 'Inactive', card.ability.extra.guaranteed and 'guaranteed' or 'not guaranteed' } }
	end,
	calculate = function(self, card, context)
		local amount = 0
		if context.before then
			for k, v in pairs(context.scoring_hand) do
				if context.scoring_hand[k]:get_id() == 14 then
					amount = amount + 1
				end
			end
			if (not context.blueprint) and next(context.poker_hands['Three of a Kind']) then
				for _, card in ipairs(context.scoring_hand) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
				return {
					message = "Nace!",
					colour = G.C.DARK_EDITION,
				}
			end
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self and context.other_card ~= card and may.is_n(context.other_card) then
			if amount > 0 then
				return {
					repetitions = amount,
					message = 'Again!',
					card = card
				}
			end
		end
		if context.forcetrigger then
			for _, card in ipairs(context.scoring_hand) do
					assert(SMODS.change_base(card, nil, "Ace"))
			end
			return {
				message = "Nace!",
				colour = G.C.DARK_EDITION,
			}
		end
	end
}

SMODS.Joker {
	key = 'burning_n',
	loc_txt = {
		name = {'Burning N', "{C:dark_edition,s:0.6}N Joker"},
		text = {
			"{C:green}#1# in #2#{} chance to",
			"apply {C:attention}Scorched{} to",
			"all {C:attention}played cards{} if played",
			"Poker Hand is {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 4, y = 8 },
	pools = { N = true },
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_may_scorched']
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	cost = 7,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and G.GAME.current_round.current_hand.handname == localize("Three of a Kind", 'poker_hands') then
			if pseudorandom('may_burning_n') < G.GAME.probabilities.normal / card.ability.extra.odds then
				for k, v in ipairs(context.scoring_hand) do
					v:set_ability('m_may_scorched', nil, true)
				end
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('holo1')
				return true end}))
				return {
					card = card,
					message = "Scorched!",
					colour = G.C.DARK_EDITION
				}
			end
		end
		if context.forcetrigger then
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability("m_may_scorched", nil, true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
			return {
				card = card,
				message = "Scorched!",
				colour = G.C.DARK_EDITION
			}
		end
	end
}]] 

SMODS.Joker {
	key = 'collectors_edition',
	loc_txt = {
		name = 'Collector\'s Edition',
		text = {
			{
				"{X:mult,C:white}^#1#{} Mult if",
				"{C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			},
			may.add_fusion_text('Diskus Kollectum', 'Diskus Kollectum Maximus', may.get_condition('diskus_kollectum_maximus'))
		}
	},
	config = { extra = { Emult = 1.15 } },
	rarity = 3,
	demicoloncompat = true,
	immutable = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 3, y = 5 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main and card.edition then
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				colour = G.C.MULT,
				Emult_mod = card.ability.extra.Emult,
				card = card
			}
		end
		if context.forcetrigger then
			return {
				message = "^"..card.ability.extra.Emult.." Mult",
				colour = G.C.MULT,
				Emult_mod = card.ability.extra.Emult,
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'collectionist',
	loc_txt = {
		name = 'Collectionist',
		text = {
			{
				"{C:attention}Jokers{} with an {C:dark_edition}Edition{}",
				"give {X:chips,C:white}X#1#{} Chips",
			},
			may.add_fusion_text('Diskus', 'Diskus Kollectum', may.get_condition('diskus_kollectum')), 
            {
                "{C:inactive,E:1}Improved art by _TeKKen_{}"
            }
		}
	},
	rarity = 3,
	atlas = 'joker1',
	pos = { x = 4, y = 9 },
	cost = 6,
	config = { extra = { Xchips = 2 } },
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips} }
	end,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.edition and card ~= context.other_joker then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(0.5, 0.5)
			return true end}))
			return {
				message = "X"..card.ability.extra.Xchips.." Chips",
				Xchip_mod = card.ability.extra.Xchips,
				colour = G.C.CHIPS
			}
		end
		if context.forcetrigger then
			return {
				message = "X"..card.ability.extra.Xchips.." Chips",
				Xchip_mod = card.ability.extra.Xchips,
				colour = G.C.CHIPS
			}
		end
	end
}

SMODS.Joker {
	key = 'man',
	loc_txt = {
		name = "man",
		text = {
			{
				"When {C:attenton}Blind{} is {C:attention}selected{},",
				"this Joker creates {C:attention}#1#{} {C:dark_edition}Negative{}", 
                "copies of {C:tarot}The Wheel of Fortune{}",
                "with {C:mult}0{} {C:money}sell value{}"
			},
			may.add_fusion_text('Wheel of Eternity', 'Diskus', may.get_condition('diskus')),
			{
				"{C:inactive,E:1}Art & idea by _TeKKeN_{}"
			},
		}
	},
	config = { extra = { cards = 7 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 9 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind or context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				G.consumeables:emplace(wheel)
                wheel:setQty(math.ceil(card.ability.extra.cards))
				wheel:add_to_deck()
                wheel.sell_cost = 0
                wheel:set_edition('e_negative')
                play_sound('timpani')
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'destroyer',
	loc_txt = {
		name = 'Destroyer',
		text = {
			{
				"{X:chips,C:white}+X#1#{} Chips per {C:attention}held{} {C:planet}Planet Card{}", 
                "At the {C:attention}end of round{}, {C:mult}destroys{} all", 
                "held {C:planet}Planet Cards{} and gains {X:chips,C:white}+X#2#{} Chips", 
				"{C:inactive}Currently {X:chips,C:white}X#3#{} {C:inactive}Chips{}"
			},
			may.add_fusion_text('Universal Collapse', 'Storm', may.get_condition('storm')),
		}
	},
	config = { extra = { Xchips_gain = .05, Xchips = 0.05 } },
	pos = { x = 3, y = 7 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        local amount = 0
        if G.consumeables then
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end
            end
        end
        return {vars = {card.ability.extra.Xchips, card.ability.extra.Xchips_gain, 1 + (amount * card.ability.extra.Xchips)}}
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then 
            local amount = 0
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end 
            end 
            if amount * card.ability.extra.Xchips > 1 then
			    return {
				    message = "X"..(amount * card.ability.extra.Xchips).." Chips",
				    colour = G.C.CHIPS,
				    Xchip_mod = 1 + (amount * card.ability.extra.Xchips),
				    card = card,			
			    }
            end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    G.E_MANAGER:add_event(Event({ func = function()
                        v:start_dissolve()
                    return true end}))
                end 
            end 
            SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xchips",
				scalar_value = "Xchips_gain",
                colour = G.C.CHIPS
			})
		end
	end
}

SMODS.Joker {
	key = 'royale',
	loc_txt = {
		name = 'Royale',
		text = {
			{
				"This Joker {C:attention}gains{} {X:mult,C:white}X#1#{} Mult",
				"if played Poker Hand is {C:attention}Royal Flush{}",
				"{C:inactive}Currently {X:mult,C:white}X#2#{} {C:inactive}Mult{}",
			},
			may.add_fusion_text('Universal Collapse', 'Little Prince', may.get_condition('little_prince'))
		}
	},
	config = { extra = { Xmult_gain = 2, Xmult = 1 } },
	pos = { x = 4, y = 3 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	no_tree = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				message = "X"..card.ability.extra.Xmult.." Mult",
				colour = G.C.MULT,
				Xmult_mod = card.ability.extra.Xmult,
				card = card,	
			}
		end
		if context.before and next(context.poker_hands['may_Royal Flush']) and not context.blueprint then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

SMODS.Joker {
	key = 'bad_handwriting',
	loc_txt = {
		name = 'Bad Handwriting',
		text = {
            "Before scoring, all {C:attention}held copies{} of", 
            "the {C:planet}Planet Card{} corresponding to {C:attention}played{} {C:purple}Poker Hand{}",
            "level up{} {C:attention}all{} other {C:purple}Poker Hands{}", 
            "by {C:attention}#1#{}", 
            "{C:inactive,E:1,s:0.7}\"Felush Euie\"???{}"
		}
	},
	config = { extra = { levels = 1 } },
	pos = { x = 2, y = 17 },
	cost = 8,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
		if context.before or context.forcetrigger then
			for k, v in pairs(G.consumeables.cards) do 
                if v:gc().key == may.planethand(context.scoring_name) then 
                    for k, v in pairs(G.GAME.hands) do 
                        if k ~= context.scoring_name then
                            level_up_hand(card, k, true, card.ability.extra.levels) 
                        end 
                    end 
                    may.h('Other Hands', '...', '...', '')
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                    return true end}))
                    may.hm('+', true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                    return true end}))
                    may.hc('+', true)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                    return true end}))
                    may.hlv('+'..card.ability.extra.levels, true)
                    delay(1.3)
                    may.ch()
                end 
            end
		end
	end
}

SMODS.Joker {
	key = 'ketchup',
	loc_txt = {
		name = 'Ketchup',
		text = {
			{
				"If played hand has {C:attention}3 or less{} cards,",
				"played {C:attention}Hearts{} have a {C:green}#1# in #2#{} chance",
				"to give {X:mult,C:white}^#3#{} Mult",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 3, Emult = 1.1 } },
	pos = { x = 0, y = 11 },
	cost = 6,
	rarity = 3,
	immutable = true,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Emult }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if #G.play.cards <= 3 then
				if context.other_card:is_suit('Hearts') then	
					if pseudorandom('may_ketchapp') < G.GAME.probabilities.normal / card.ability.extra.odds then
						return {
							e_mult = card.ability.extra.Emult,
							card = context.other_card,
							message = '^'..card.ability.extra.Emult..' Mult',
							colour = G.C.RED
						}
					end
				end
			end
		end
		if context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = context.other_card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.RED
			}
		end
	end
}

SMODS.Joker {
	key = 'mustard',
	loc_txt = {
		name = 'Mustard',
		text = {
			{
				"If {C:attention}Joker Slots{} are {C:attention}fully occupied{},",
				"played {C:attention}Diamonds{} have a {C:green}#1# in #2#{} chance",
				"to give {C:money}$#3#{}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 4, dollars = 7 } },
	pos = { x = 5, y = 10 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.dollars }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit then
				if context.other_card:is_suit('Diamonds') then
					if pseudorandom('may_mustard') < G.GAME.probabilities.normal / card.ability.extra.odds then
						return {
							dollars = card.ability.extra.dollars,
							card = context.other_card,
						}
					end
				end
			end
		end
		if context.forcetrigger then
			return {
				dollars = card.ability.extra.dollars,
				card = context.other_card,
			}
		end
	end
}

SMODS.Joker {
	key = 'soy_sauce',
	loc_txt = {
		name = 'Soy Sauce',
		text = {
			{
				"Played {C:attention}Spades{} have a {C:green}#1# in #2#{} chance",
				"to give {C:attention}+#3# Hand Size{} for this round",
				"if you currently have {C:attention}more{} {C:mult}Mult{} {C:attention}than{} {C:chips}Chips{}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 5, handsize = 1 } },
	pos = { x = 2, y = 8 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.handsize }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if to_big(chips) < to_big(mult) then
				if context.other_card:is_suit('Spades') then
					if pseudorandom('may_soy_sauce') < G.GAME.probabilities.normal / card.ability.extra.odds then
						G.hand:change_size(card.ability.extra.handsize)
						G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.handsize
						return {
							message = '+'..card.ability.extra.handsize..' Hand Size'
						}
					end
				end
			end
		end
		if context.forcetrigger then
			G.hand:change_size(card.ability.extra.handsize)
			G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.handsize
			return {
				message = '+'..card.ability.extra.handsize..' Hand Size'
			}
		end
	end
}

SMODS.Joker {
	key = 'pesto',
	loc_txt = {
		name = 'Pesto',
		text = {
			{
				"Played {C:attention}Clubs{} have a {C:green}#1# in #2#{} chance",
				"to give {C:attention}+#3# Card Selection Limit{}",
				"if {C:attention}Hand Size{} is {C:attention}bigger{} than {X:attention,C:white}X#4#{} {C:attention}Card Selection Limit{}",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 6, selectionlimit = 1, multiplier = 0.5 } },
	pos = { x = 5, y = 8 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	loc_vars = function(self, info_queue, card)
        return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.selectionlimit, card.ability.extra.multiplier }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if G.hand.config.card_limit > G.hand.config.highlighted_limit * card.ability.extra.multiplier then
				if context.other_card:is_suit('Clubs') then
					if pseudorandom('may_pesto') < G.GAME.probabilities.normal / card.ability.extra.odds then
						G.hand:change_max_highlight(card.ability.extra.selectionlimit)
						return {
							message = '+'..card.ability.extra.selectionlimit..' Card Selection Limit'
						}
					end
				end
			end
		end
		if context.forcetrigger then
			G.hand:change_max_highlight(card.ability.extra.selectionlimit)
			return {
				message = '+'..card.ability.extra.selectionlimit..' Card Selection Limit'
			}
		end
	end
}

--[[SMODS.Joker {
	key = 'hurley',
	loc_txt = {
		name = 'Hurley',
		text = {
			{
				"Scoring {C:attention}10s{} have a",
				"{C:green}#2# in #3#{} chance to give {C:money}$#1#{}",
			},
			may.add_fusion_text('Universal Collapse', 'Ultimate Hurley', may.get_condition('ultimate_hurley')),
			{
				"{C:inactive,E:1}Concept by therealten95{}"
			},
		}
	},
	config = { extra = { dollars = 10, odds = 5 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 7 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then
				if pseudorandom('may_hurley') < G.GAME.probabilities.normal / card.ability.extra.odds then	
					return {
						card = context.other_card,
						dollars = card.ability.extra.dollars,
					}
				end
			end
		end
		if context.forcetrigger then
			return {
				card = context.other_card,
				dollars = card.ability.extra.dollars,
			}
		end
	end
}]] 

SMODS.Joker {
	key = 'bag_of_fortune',
	loc_txt = {
		name = 'Bag of Fortune',
		text = {
            {
			    "When {C:attention}hand{} is {C:attention}played{},",
			    "create a {C:attention}random Tag{}"
            }, 
            {
                "{C:inactive}Art by mags{}"
            }
		}
	},
	rarity = 3,
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 1, y = 4 },
	cost = 6,
	calculate = function(self, card, context)
		if context.joker_main then
			local tag_key
			repeat
				tag_key = get_next_tag_key("may_bag_of_fortune")
			until tag_key ~= "tag_boss"
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
		if context.force_trigger then
			local tag_key
			repeat
				tag_key = get_next_tag_key("may_bag_of_fortune")
			until tag_key ~= "tag_boss"
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
	end
}

SMODS.Joker {
	key = 'ah_yes_the_store',
	loc_txt = {
		name = 'Ah yes, the store!',
		text = {
			{
				"{C:attention}+#1# card slots{} in shop",
                "{C:mult}-$#2#{} when rerolling"
			},
			{
				"{C:inactive,E:1}Art by therealten95{}", 
				"{C:inactive,E:1}Idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { slots = 3, p_dollars = -4 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 4, y = 4 },
	blueprint_compat = false,
	demicoloncompat = false,
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots, math.abs(card.ability.extra.p_dollars) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound('may_ah_yes_the_store')
			change_shop_size(card.ability.extra.slots)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			change_shop_size(-card.ability.extra.slots)
		end
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and context.cardarea == G.jokers then
			return {
                p_dollars = -math.abs(card.ability.extra.p_dollars), 
                card = card,
            }
		end
	end
}

SMODS.Joker {
	key = 'guacamole',
	loc_txt = {
		name = {'Guacamole', "{C:dark_edition,s:0.7}Content creator insert:{} {C:may_ethereal,u:may_ethereal,s:0.7}Exattox{}"}, 
		text = {
            {
                "{C:dark_edition,E:1,s:1.5}Special Ability{}", 
                "Create a copy of {X:legendary,C:white}QUAC-N7{}", 
				"{X:money,C:white}X#1#${}, and {C:mult}self destructs{}", 
				"{C:inactive}Requires room{}",
				"{C:inactive,E:1,s:0.7}I hope we're not gonna overscore too much...{}"
            }, 
			{
				"{C:inactive,E:1}Art by therealten95{}"
			}
		}
	},
	pos = { x = 5, y = 5 },
	cost = 10,
	rarity = 3,
	config = { extra = { x_dollars = 0.2 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_may_quac_n7
		return {vars = { card.ability.extra.x_dollars } }
    end,
    calculate = function(self, card, context)
		if context.forcetrigger then 
			SMODS.add_card({ key = 'c_may_quac_n7' })
			may.hypermoney(0, card.ability.extra.x_dollars or 0.2)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('tarot1')
				play_sound('holo1')
				card:juice_up(0.3, 0.5)
				card:start_dissolve()
				card = nil 
			return true end}))
		end
	end
}