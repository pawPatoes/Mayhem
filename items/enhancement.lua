-- Enhancements

SMODS.Enhancement {
	key = 'jagged',
	loc_txt = {
		name = 'Jagged Card',
		text = {
			'{X:chips,C:white}X1.3{} Chips',
		}
	},
	pos = { x = 9, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .5,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_chips = 1.3
			}
		end
	end
}

SMODS.Enhancement {
	key = 'magma',
	loc_txt = {
		name = 'Magma Card',
		text = { 
            {
			    '{X:mult,C:white}X1.4{} Mult',
            }, 
            {
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 10, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .5,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = 1.4
			}
		end
	end
}

SMODS.Enhancement {
	key = 'grid',
	loc_txt = {
		name = 'Grid Card',
		text = {
			"{C:attention}Gains{} {C:mult}+3{} Mult when {C:attention}played{}",
			"{C:mult}Loses 1{} Mult when {C:mult}discarded{}",
			"{C:inactive}Currently {C:mult}+#1#{} {C:inactive}Mult{}"
		}
	},
	pos = { x = 11, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .4,
	config = { grid_mult = 0 },
	discovered = true,
	atlas = 'enhancement',
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.grid_mult or 0 } }
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.grid_mult = 0
	end,
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			if card.ability.grid_mult ~= 0 then
				card.ability.grid_mult = card.ability.grid_mult - 1
				return {
					message = 'Downgraded!',
					colour = G.C.RED,
					card = card,
				}
			end
		end
		if context.before and context.cardarea == G.play then
			card.ability.grid_mult = card.ability.grid_mult + 3
			return {
				message = 'Upgraded!',
				colour = G.C.RED,
				card = card,
			}
		end
		if context.cardarea == G.play and context.main_scoring then
			return {
				mult = card.ability.grid_mult
			}
		end
	end
}

SMODS.Enhancement {
	key = 'super_mult',
	loc_txt = {
		name = 'Super Mult Card',
		text = {
            {
				'{X:mult,C:white}^1.04{} Mult',
    		}, 
            {
        		'{C:inactive,E:1}Art by Superb Thing{}'
            }, 
		}
	},
	pos = { x = 1, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				e_mult = 1.04
			}
		end
	end
}

SMODS.Enhancement {
	key = 'overgrown',
	loc_txt = {
		name = 'Overgrown Card',
		text = {
			{
				"Apply a",
				"{C:attention}random{} {C:dark_edition}Edition{} to this card",
				"when it is {C:attention}discarded{}",
				"then {C:mult}remove this enhancement{}",
			},
			{
				"{C:inactive,E:1}Idea by _TeKKen_{}", 
				"{C:inactive,E:1}Art by Huycorn{}"
			},
		}
	},
	pos = { x = 2, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	atlas = 'enhancement',
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			card:set_edition(poll_edition('may_overgrown', nil, true, true), false, false)
			card:set_ability(G.P_CENTERS.c_base, true, nil)
		end
	end
}

SMODS.Enhancement {
	key = 'platinum',
	loc_txt = {
		name = 'Platinum Card',
		text = {
			"{X:money,C:white}X1.1${} at the", 
            "end of round",
            "if {C:attention}held in hand{}",
		}
	},
	pos = { x = 3, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = 0,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.hand and context.other_card == card then
			return {
				x_dollars = 1.1, 
                card = card 
			}
		end
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Enhancement {
	key = 'scorched',
	loc_txt = {
		name = 'Scorched Card',
		text = { 
            {
			    "{X:planet,C:white}X1.5{} Level of a {C:attention}random{}",
			    "{C:purple}Poker Hand{} when {C:mult}discarded{}",
            }, 
            {
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 4, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .05,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.discard and context.other_card == card then
			local hand = may.rndhand()
			may.th(hand)
			may.level_up_hand_hyper(card, hand, nil, 1.5)
			may.ch()
		end
	end
}

SMODS.Enhancement {
	key = 'crystal',
	loc_txt = {
		name = 'Crystal Card',
		text = {
            {
			    '{C:money}+#1#%{} of {C:money}total balance{} when scored {C:inactive}($#2#){}',
			    '{C:mult}Decreases{} by {C:attention}2{} when {C:attention}triggered{}',
			    '{C:attention}Increases{} by {C:attention}10{} if {C:attention}held in hand{} after scoring',
            },
            {
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 5, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .075,
	discovered = true,
    shatters = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.crystal_percent or 0, number_format((to_big(G.GAME.dollars) or to_big(0)):mul((card.ability.crystal_percent or 0) * 0.01)) } }
	end, 
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.crystal_percent = 5
	end,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			card.ability.crystal_percent = math.max(0, card.ability.crystal_percent - 2)
			return {
				message = 'Downgraded!',
				colour = G.C.MONEY,
				card = card, 
				x_dollars = 1 + (card.ability.crystal_percent * 0.01)
			}
		end
		if context.after and context.cardarea == G.hand then
			card.ability.crystal_percent = card.ability.crystal_percent + 10
			return {
				message = 'Upgraded!',
				colour = G.C.MONEY,
				card = card
			}
		end
	end
}

local vanf_dc = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	vanf_dc(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	SMODS.calculate_context({card_drawn = true, other_card = card, from = from, to = to})
end

SMODS.Enhancement {
	key = 'cardboard',
	loc_txt = {
		name = 'Cardboard Card',
		text = {
            {
			    "If {C:attention}held in hand{} after hand is played, {C:attention}give{} all {C:attention}other{}",
			    "{C:attention}Cardboard{} cards {C:attention}held in hand{}",
			    "{X:attention,C:white}X4{} Nominal Chips"
            }, 
            {
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 6, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = .3,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end, 
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.hand then
			for i=1, #G.hand.cards, 1 do
				if SMODS.has_enhancement(G.hand.cards[i], 'm_may_cardboard') and G.hand.cards[i] ~= card then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
						G.hand.cards[i].ability.nominal_multiplier = (G.hand.cards[i].ability.nominal_multiplier or 0) + 4
						G.hand.cards[i]:juice_up()
						play_sound('may_nominal_chips')
					return true end}))
				end
			end
		end
	end
}

SMODS.Enhancement {
	key = 'shadow',
	loc_txt = {
		name = 'Shadow Card',
		text = {
			{
			    "{C:attention}Before scoring{}, add {C:mult}+3{} Mult",
			    "to all cards {C:attention}held in hand{}",
			    "if played"
			}, 
			{
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 7, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = 0,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1) } }
	end, 
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.before then
			if #SMODS.find_card('j_may_corey') == 0 then 
				if card.area == G.play then
					for k, v in pairs(G.hand.cards) do
						v.ability.perma_mult = (v.ability.perma_mult or 0) + 3
						card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Upgraded!', colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
					end
				end 
			else
				if card.area == G.play or card.area == G.hand or card.area == G.deck then
					for k, v in pairs(G.hand.cards) do
						v.ability.perma_mult = (v.ability.perma_mult or 0) + 3
						card_eval_status_text(v, 'extra', nil, nil, nil, { message = 'Upgraded!', colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
					end
				end 
			end
		end
	end
}

SMODS.Enhancement {
	key = 'titanium',
	loc_txt = {
		name = 'Titanium Card',
		text = {
			'{X:money,C:white}X1.1${} but {X:attention,C:white}X3{} {C:attention}Blind Size{}',
			'when scored', 
            '{C:mult}Self destructs{} after scoring', 
            'if played'
		}
	},
	pos = { x = 8, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = 0,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
				G.GAME.blind.chips = G.GAME.blind.chips:mul(3)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
			return true end}))
			return {
				x_dollars = 1.1, 
                card = card,
			}
		end
        if context.after and context.cardarea == G.play then 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                card:start_dissolve()
                card = nil 
            return true end})) 
        end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Enhancement {
	key = 'geometric',
	loc_txt = {
		name = 'Geometric Card',
		text = {
            {
			    "Gives half the {C:attention}square-root{}", 
                "of played {C:purple}Poker Hand{} {C:planet}level{}", 
                "as {X:mult,C:white}XMult{}"
            }, 
            {
                '{C:inactive,E:1}Art by HuyCorn{}'
            }
		}
	},
	pos = { x = 0, y = 0 },
	unlocked = true,
	weight = 0.25,
	discovered = true,
	atlas = 'enhancement',
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = math.sqrt(G.GAME.hands[context.scoring_name].mult) * 0.5
			}
		end
	end
}

SMODS.Enhancement {
	key = 'fortune',
	loc_txt = {
		name = 'Fortune Card',
		text = {
			'{X:money,C:white}X0.02${} per held', 
            '{C:mult}non-{}{C:dark_edition}Negative{} {C:purple}Tarot Card{}', 
            '{C:inactive}Currently X#1#${}'
		}
	},
	pos = { x = 12, y = 0 },
	unlocked = true,
	replace_base_card = false,
	weight = 0,
	discovered = true,
	atlas = 'enhancement',
    loc_vars = function(self, info_queue, card)
        local amount = 0
        if G.consumeables then 
			for k, v in pairs(G.consumeables.cards) do
                if v:gc().set == 'Tarot' and ((not v.edition) or (v.edition and v.edition.key ~= 'e_negative')) then 
                    amount = amount + v:getQty()
                end
            end
        end
        return { vars = { 1 + (amount * 0.02) } }
    end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
            local amount = 0
			for k, v in pairs(G.consumeables.cards) do
                if v:gc().set == 'Tarot' and ((not v.edition) or (v.edition and v.edition.key ~= 'e_negative')) then 
                    amount = amount + v:getQty()
                end
            end
			return {
				x_dollars = 1 + (amount * 0.02), 
                card = card,
			}
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end 
}