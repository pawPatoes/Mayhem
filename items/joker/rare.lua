-- Rare Jokers
	
SMODS.Joker {
	key = 'jonas',
	loc_txt = {
		name = 'Jonas',
		text = {
            {
			    "{X:mult,C:white}X#1#{} Mult", 
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
	attributes = {
		'xmult'
	}, 
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
	key = 'lil_prince',
	loc_txt = {
		name = "Lil' Prince",
		text = {
            {
			    may.hyp(1, 'mult', '^#1#').." Mult if played",
			    "hand is {C:attention}Royal Flush{}",
			    "{C:attention}otherwise{} hand will {C:mult}not score{}",
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
	endless = true,
	cost = 6,
	config = { extra = { Emult = 1.5 } },
	attributes = {
		'emult', 
		'hand_type'
	}, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main and next(context.poker_hands['may_Royal Flush'])) or context.forcetrigger then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT
			}
		end
		if context.debuff_hand and context.scoring_name ~= 'may_Royal Flush' then
			return {
				debuff = true, 
				debuff_text = 'Lil\' Princed!', 
				debuff_source = card
			}
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Joker {
	key = 'canyon',
	loc_txt = {
		name = 'Canyon',
		text = {
			{
				"{X:chips,C:white}X#1#{} Chips", 
                "{C:green}Increases{} by {X:chips,C:white}+X#2#{} when a", 
				"{C:attention}number card{} is {C:mult}destroyed{}", 
				"{C:mult}Resets{} when {C:attention}Boss Blind{} is {C:green}defeated{}", 
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}", 
			},
		}
	},
	config = { extra = { x_chips = 1, x_chips_gain = 0.5 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 0, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 10,
	attributes = {
		'xchips', 
		'face', 
		'resets', 
	}, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips, card.ability.extra.x_chips_gain } }
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
            local num = 0
            for k, v in pairs(context.removed) do
                if not v:is_face() then 
					num = num + 1
				end
            end
            if num > 0 then
                SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_chips",
					scalar_value = "x_chips_gain",
					scaling_message = {
						colour = G.C.CHIPS
					}
				})
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                x_chips = card.ability.extra.x_chips,
				card = card
            }
        end
		if context.end_of_round and not context.blueprint and context.game_over == false and context.main_eval and context.beat_boss then
			card.ability.extra.x_chips = 1
			return {
				message = 'Reset!', 
				colour = G.C.CHIPS, 
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'tribulation',
	loc_txt = {
		name = 'Tribulation',
		text = {
			{
				"{C:attention}Jacks{} give {X:chips,C:white}X#1#{} Chips",
				"when scored", 
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}", 
			},
		}
	},
	config = { extra = { x_chips = 1.75 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 1, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 10,
	attributes = {
		'xchips', 
		'jack', 
	}, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play and context.other_card:get_id() == 11) or context.forcetrigger then
			return {
				x_chips = card.ability.extra.x_chips, 
				card = card 
			}
		end
	end
}

SMODS.Joker {
	key = 'yorker',
	loc_txt = {
		name = 'Yorker',
		text = {
			{
				"{C:mult}Discarded{} cards {C:green}gain{}", 
				"{X:chips,C:white}+X#1#{} Chips"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}", 
			},
		}
	},
	config = { extra = { x_chips = 0.02 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 2, y = 9 },
	blueprint_compat = true,
	demicoloncompat = false,
	cost = 10,
	attributes = {
		'xchips', 
		'jack', 
	}, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_chips } }
	end,
	calculate = function(self, card, context)
		if context.discard then
			context.other_card.ability.perma_x_chips = (context.other_card.ability.perma_x_chips or 0) + card.ability.extra.x_chips 
			return {
				message = 'Upgraded!', 
				colour = G.C.CHIPS, 
				message_card = context.other_card, 
				sound = 'may_permabonus'
			}
		end
	end
}

SMODS.Joker {
	key = 'chicken',
	loc_txt = {
		name = 'Chicken',
		text = {
			{
				"{C:green}+#1#{} {C:chips}hand{} and {C:mult}discard{}", 
				"against {C:mult}non-{}{C:attention}Boss Blinds{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}", 
			},
		}
	},
	config = { extra = { mod = 1 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 3, y = 9 },
	blueprint_compat = false,
	demicoloncompat = false,
	cost = 10,
	attributes = {
		'discard', 
		'hands', 
	}, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mod } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not G.GAME.blind.config.blind.boss then
			ease_hands_played(card.ability.extra.mod)
			ease_discard(card.ability.extra.mod)
			return {
                message = '+'..card.ability.extra.mod..' hand & discard', 
				colour = G.C.GREEN,
                card = card,
            }
		end
	end
}

SMODS.Joker {
	key = 'percolator',
	loc_txt = {
		name = 'Percolator',
		text = {
			{
				"When {C:attention}entering shop{}, {C:green}#1# in #2#{} chance", 
				"to apply {C:dark_edition}Negative{} to a random held {C:attention}Consumable{}", 
				"{C:mult}without{} an {C:dark_edition}Edition{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}", 
			},
		}
	},
	config = { extra = { odds = 2 } },
	rarity = 3,
	atlas = 'joker2',
	pos = { x = 4, y = 9 },
	blueprint_compat = false,
	demicoloncompat = false,
	cost = 10,
	attributes = {
		'editions', 
		'chance', 
	}, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Percolator")
		return { vars = { normal, odds } }
	end,
	calculate = function(self, card, context)
		if context.starting_shop then
			if SMODS.pseudorandom_probability(card, "may_percolator", 1, card.ability.extra.odds, "Percolator") then  
				G.E_MANAGER:add_event(Event({func = function() 
					local total, checked, center = 0, 0, nil
					for i = 1, #G.consumeables.cards do
						if not (G.consumeables.cards[i]:gc().hidden or G.consumeables.cards[i]:gc().no_doe or G.consumeables.cards[i]:gc().no_perkeo) then
							total = total + (G.consumeables.cards[i]:getQty())
						end
					end
					local poll = pseudorandom(pseudoseed('percolator')) * total
					for i = 1, #G.consumeables.cards do
						checked = checked + (G.consumeables.cards[i]:getQty())
						if checked >= poll then
							center = G.consumeables.cards[i]
							break
						end
					end
					if center then
						center:set_edition('e_negative')
						card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Negative!'}, colour = G.C.DARK_EDITION, delay = 0.45})
					end
				return true end}))
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
				may.pager(45),
				"{C:inactive,E:1,s:0.7}LONG LIVE LEGUMES{}"
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
	attributes = {
		'xmult'
	}, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
		if context.after then
			local found
			for k, v in pairs(G.hand.cards) do
				if SMODS.has_enhancement(v, 'm_steel') then 
					found = true 
					break
				end
			end
			if found then 
				may.th(context.scoring_name)
				for k, v in pairs(G.hand.cards) do
					if SMODS.has_enhancement(v, 'm_steel') then
						may.hand_multchips(v, context.scoring_name, false, nil, {0, card.ability.extra.Xmult})
					end
				end
				may.ch()
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
				may.hyp(1, 'mult', '^#1#').." Mult if",
				"{C:attention}this Joker{} has an {C:dark_edition}Edition{}",
			},
			may.add_fusion_text('Diskus Kollectum', 'Diskus Dominus', may.get_condition('diskus_dominus'))
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
	attributes = {
		'emult', 
		'editions'
	}, 
	calculate = function(self, card, context)
		if (context.joker_main and card.edition) or context.forcetrigger then
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
				"Other {C:attention}Jokers{} with an {C:dark_edition}Edition{}",
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
	attributes = {
		'xchips', 
		'editions'
	},
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
	config = { extra = { cards = 5 } },
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 5, y = 9 },
	cost = 6,
	attributes = {
		'wheel', 
		'generation', 
		'editions'
	}, 
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
                wheel.no_variants = true 
				wheel:setQty(math.ceil(card.ability.extra.cards))
				wheel:add_to_deck()
                wheel:set_edition('e_negative')
				G.consumeables:emplace(wheel)
				wheel.sell_cost = 0
				wheel:set_cost()
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
				"Gives {X:chips,C:white}+X#1#{} Chips per", 
				"{C:attention}held{} {C:planet}Planet Card{} during scoring", 
				may.pager(65),
                "At the {C:attention}end of round{}, {C:mult}destroys{} all", 
                "held {C:planet}Planet Cards{} and increases {X:chips,C:white}XChips{} by {X:chips,C:white}+X#2#{}", 
				may.pager(65),
				"{C:inactive}Currently {X:chips,C:white}X#3#{} {C:inactive}Chips{}"
			},
			may.add_fusion_text('Omniversal Catalyst', 'Intergalactic Tempest', may.get_condition('intergalactic_tempest')),
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
	attributes = {
		'xchips', 
		'destroy_card', 
		'planet'
	}, 
	loc_vars = function(self, info_queue, card)
		may.fuse_tip(info_queue, 'world_destroyer', { may.ctu('Planet') })
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

--[[SMODS.Joker {
	key = 'royale',
	loc_txt = {
		name = 'Royale',
		text = {
			{
				"This Joker {C:attention}gains{} {X:mult,C:white}+X#1#{} Mult",
				"if played Poker Hand is {C:attention}Royal Flush{}",
				"{C:inactive}Currently {X:mult,C:white}X#2#{} {C:inactive}Mult{}",
			},
			may.add_fusion_text('Omniversal Catalyst', 'Little Prince', may.get_condition('little_prince'))
		}
	},
	config = { extra = { Xmult_gain = 2, Xmult = 1 } },
	pos = { x = 4, y = 3 },
	cost = 5,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	no_tree = true,
	atlas = 'joker1',
	attributes = {
		'xmult', 
		'scaling', 
		'hand_type'
	}, 
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
}]]

SMODS.Joker {
	key = 'bad_handwriting',
	loc_txt = {
		name = 'Bad Handwriting',
		text = {
            "Before scoring, all {C:attention}held copies{} of", 
            "the {C:planet}Planet Card{} corresponding to {C:attention}played{} {C:purple}Poker Hand{}",
            "level up{} {C:attention}all{} other {C:purple}Poker Hands{} by {C:attention}#1#{}", 
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
	attributes = {
		'planet'
	}, 
	loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
		if context.before or context.forcetrigger then
			for k, v in pairs(G.consumeables.cards) do 
                if v:gc().key == may.planethand(context.scoring_name) then 
                    may.level_up_all_hands(card, context.scoring_name, false, card.ability.extra.levels)
                end 
            end
			may.ch()
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
				"played {C:hearts}Hearts{} have a {C:green}#1# in #2#{} chance",
				"to give "..may.hyp(1, 'mult', '^#3#').." Mult when scored",
			},
			{
				"{C:inactive,E:1}Art & idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 3, Emult = 1.2 } },
	pos = { x = 0, y = 11 },
	cost = 6,
	rarity = 3,
	immutable = true,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	endless = true,
	atlas = 'joker1',
	attributes = {
		'sauce', 
		'food',
		'chance',
		'hearts', 
		'emult', 
	}, 
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Ketchup")
        return {vars = { normal, odds, card.ability.extra.Emult }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if #G.play.cards <= 3 then
				if context.other_card:is_suit('Hearts') then	
					if SMODS.pseudorandom_probability(card, "may_ketchup", 1, card.ability.extra.odds, "Ketchup") then
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
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Joker {
	key = 'mustard',
	loc_txt = {
		name = 'Mustard',
		text = {
			{
				"If {C:attention}Joker Slots{} are {C:attention}fully occupied{},",
				"played {C:diamonds}Diamonds{} have a {C:green}#1# in #2#{} chance",
				"to give {C:money}+#3#{} Interest Cap before scoring",
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 4, interest_cap = 5 } },
	pos = { x = 5, y = 10 },
	cost = 6,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	attributes = {
		'sauce', 
		'food', 
		'diamonds',
		'chance', 
		'economy'
	}, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Ketchup")
        return {vars = { normal, odds, card.ability.extra.interest_cap } }
    end,
    calculate = function(self, card, context)
		if context.after and context.cardarea == G.jokers then
			if #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit then
				for k, v in pairs(G.play.cards) do
					if v:is_suit('Diamonds') then
						if SMODS.pseudorandom_probability(card, "may_mustard", 1, card.ability.extra.odds, "Mustard") then
							may.ease_interest_cap(-1, card.ability.extra.interest_cap)
							card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.interest_cap..' Interest Cap'}, colour = G.C.MONEY, delay = 0.45})
						end
					end
				end
			end
		end
		if context.forcetrigger then
			may.ease_interest_cap(-1, card.ability.extra.interest_cap)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.interest_cap..' Interest Cap'}, colour = G.C.MONEY, delay = 0.45})
		end
	end
}

SMODS.Joker {
	key = 'soy_sauce',
	loc_txt = {
		name = 'Soy Sauce',
		text = {
			{
				"Played {C:spades}Spades{} have a {C:green}#1# in #2#{} chance",
				"to create a random {C:dark_edition}Modifier Card{} when scored",
				"if you currently have {C:attention}more{} {C:mult}Mult{} {C:attention}than{} {C:chips}Chips{}",
				"{C:inactive}Doesn't require room{}"
			},
			{
				"{C:inactive,E:1}Art & original idea by _TeKKen_{}"
			},
		}
	},
	config = { extra = { odds = 3 } },
	pos = { x = 2, y = 8 },
	cost = 5,
	rarity = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'joker1',
	attributes = {
		'sauce',
		'food', 
		'spades', 
		'chance', 
		'modifier_card'
	}, 
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Soy Sauce")
        return {vars = { normal, odds } }
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if to_big(chips) < to_big(mult) then
				if context.other_card:is_suit('Spades') then
					if SMODS.pseudorandom_probability(card, "may_soy_sauce", 1, card.ability.extra.odds, "Soy Sauce") then
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
							local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, nil)
							G.consumeables:emplace(card2)
							card2:add_to_deck()
						return true end}))
						return {
							message = '+Modifier Card',
							colour = G.C.DARK_EDITION, 
							card = card
						}
					end
				end
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, nil)
				G.consumeables:emplace(card2)
				card2:add_to_deck()
			return true end}))
			return {
				message = '+Modifier Card',
				colour = G.C.DARK_EDITION, 
				card = card
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
				"Played {C:clubs}Clubs{} have a {C:green}#1# in #2#{} chance",
				"to give {C:purple}+#3#{} Card Selection Limit when scored",
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
	attributes = {
		'sauce', 
		'food',
		'clubs', 
		'chance', 
	}, 
	loc_vars = function(self, info_queue, card)
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Pesto")
        return {vars = { normal, odds, card.ability.extra.selectionlimit, card.ability.extra.multiplier }}
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if G.hand.config.card_limit > G.hand.config.highlighted_limit * card.ability.extra.multiplier then
				if context.other_card:is_suit('Clubs') then
					if SMODS.pseudorandom_probability(card, "may_pesto", 1, card.ability.extra.odds, "Pesto") then
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
			may.add_fusion_text('Omniversal Catalyst', 'Ultimate Hurley', may.get_condition('ultimate_hurley')),
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
		if context.joker_main or context.force_trigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
				may.random_tag()
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'ah_yes_the_store',
	loc_txt = {
		name = 'Ah yes, the store!',
		text = {
			{
				"{C:attention}+#1#{} card slots in shop",
                "{C:mult}-$#2#{} when rerolling",
				may.pager(50),
				"{C:inactive,E:1,s:0.7}When I go to the store, I like to buy cheese! :D{}"
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
	attributes = {
		'economy', 
		'danny_h', 
		'passive', 
	}, 
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
		name = 'Guacamole',
		text = {
            {
                "{C:dark_edition,E:2}Ability{} - {C:planet,E:1}Intergalactic Snack{}", 
				"{C:attention,E:2}No Energy requirement{}", 
				may.pager(),
                "Create {C:attention}#1#{} {C:dark_edition}Negative{} copies of {C:planet}QUAC-N7{}", 
				"and {C:mult}self destruct{}", 
				may.pager(),
				"{C:inactive,E:1,s:0.7}I hope we're not gonna overscore too much...{}"
            }, 
			{
				"{C:inactive,E:1}Art by therealten95{}"
			}
		}
	},
	pos = { x = 5, y = 5 },
	cost = 6,
	rarity = 3,
	config = { extra = { copies = 4 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	endless = true,
	misc_badge = {
		colour = SMODS.Gradients.may_col_instability,
		text_colour = G.C.WHITE,
		text = {
			'Content Creator',
			'Exattox'
		}
	},
	attributes = {
		'on_sell', 
		'generation', 
		'planet', 
		'food', 
	}, 
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_may_quac_n7
		return {vars = { card.ability.extra.copies } }
    end,
	can_use_ability = function(self, card)
		return G.consumeables 
	end, 
	ability = function(self, card)
		local card2 = SMODS.add_card({ key = 'c_may_quac_n7' })
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
			play_sound('tarot1')
			play_sound('holo1')
			card2:set_edition('e_negative')
			card2:setQty(card.ability.extra.copies)
			card:juice_up(0.3, 0.5)
			card:start_dissolve()
			card = nil 
		return true end}))
	end,
    calculate = function(self, card, context)
		if context.forcetrigger then 
			local card2 = SMODS.create_card({ key = 'c_may_quac_n7' })
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('tarot1')
				play_sound('holo1')
				card2:set_edition('negative')
				card2:setQty(card.ability.extra.copies)
				card:juice_up(0.3, 0.5)
				card:start_dissolve()
				card = nil 
			return true end}))
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
				"{C:attention}Retrigger{} all",
				"played {C:attention}Aces #1#{} times",
			},
			may.add_fusion_text('Omniversal Catalyst', 'Acum', may.get_condition('acum'))
		}
	},
	config = { extra = { repetitions = 3 } },
	loc_vars = function(self, info_queue, card)
		if G.GAME and G.GAME.blind then
			local count = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 14 then
					count = count + 1
				end
			end
			may.fuse_tip(info_queue, 'acum', { count })
		end
		return { vars = { card.ability.extra.repetitions } }
	end,
	rarity = 3,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 5 },
	cost = 11, 
	attributes = {
		'ace', 
		'retrigger'
	}, 
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then		
				return {
					message = 'AAAAgain!',
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'anniversary_cake',
	loc_txt = {
		name = 'Anniversary Cake',
		text = {
			{
                "At the {C:attention}end of round{}, if a {B:1,C:white}#1#{} {C:attention}Joker{} is owned,", 
				"this Joker {C:green}creates{} another random {B:1,C:white}#1#{} {C:attention}Joker{}", 
				"and {C:green}upgrades{} the listed {C:attention}rarities{},", 
				"{C:mult}otherwise{} it will {C:mult}self destruct{}", 
				may.pager(), 
                "When this Joker {C:green}creates{} a {X:legendary,C:white}Legendary{} {C:attention}Joker{},", 
				"it {C:mult}self destructs{} and creates", 
				"{C:attention}#2#{} random {C:dark_edition}Negative{} {C:attention}consumables{}", 
				may.pager(), 
                "{C:inactive}Does not require room, excludes self{}", 
                "{C:inactive}Common -> Uncommon -> Rare -> Epic -> Legendary{}", 
			},
			{
				"{C:inactive,E:1}Art by 2Much{}"
			}
		}
	},
	config = { extra = { consumables = 10, rarity = 1 } },
	pos = { x = 1, y = 7 },
	cost = 12,
	rarity = 3,
	atlas = 'joker2',
	blueprint_compat = false,
	demicoloncompat = false,
	attributes = {
		'food', 
		'generation', 
	}, 
    loc_vars = function(self, info_queue, card)
		local rarities = {'Common', 'Uncommon', 'Rare', 'Epic', 'Legendary'}
		local colors = {'Common', 'Uncommon', 'Rare', may.epic_key, 'Legendary'}
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { rarities[card.ability.extra.rarity], card.ability.extra.consumables, colours = { G.C.RARITY[colors[card.ability.extra.rarity]] } } }
    end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			G.E_MANAGER:add_event(Event({func = function()
				play_sound('may_cake_spawn')
			return true end})) 
		end
	end, 
    calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval then
			local rarities = {1, 2, 3, may.epic_key, 4}
			local found
			for k, v in pairs(G.jokers.cards) do 
				if v ~= card and v:gc().rarity == rarities[card.ability.extra.rarity] then
					found = true 
					break
				end
			end
			if found then
				local rarity_amounts = { 0.01, 0.8, 1, may.epic_key, nope }
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					local card2 = create_card('Joker', G.jokers, card.ability.extra.rarity == 5, rarity_amounts[card.ability.extra.rarity], nil, true, nil, 'anniversary_cake')
					G.jokers:emplace(card2)
					card2:add_to_deck()
					card2:juice_up(0.5, 0.3)
					if card.ability.extra.rarity == 5 then 
						play_sound('may_bundle')
						for i = 1, card.ability.extra.consumables do
							local card3 = create_card('Consumable', G.consumeables, nil, nil, nil, true, may.random_consumable('may_anniversary_cake', nil, nil, G.P_CENTER_POOLS.Consumeable, true).key, 'anniversary_cake')
							card3:set_edition({negative = true}, false, false)
							G.consumeables:emplace(card3)
							card3:add_to_deck()
						end
						card:start_dissolve()
					end
					card.ability.extra.rarity = card.ability.extra.rarity + 1
					G.ROOM.jiggle = G.ROOM.jiggle + 1
				return true end}))
				if context.rarity ~= 5 then
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Happy Birthday!", colour = may.C.score, delay = 0.45, sound = 'may_cake_activate'})
				end
			else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('may_cake_destroy')
					card:start_dissolve()
					G.ROOM.jiggle = G.ROOM.jiggle + 1
				return true end}))			
			end
		end
	end
}