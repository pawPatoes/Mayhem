-- Transcendent Jokers

SMODS.Joker {
	key = 'little_prince',
	loc_txt = {
		name = {'Little Prince', "{C:inactive,s:0.5}Universal Collapse + Royale{}"},
		text = {
			"This Joker {C:attention}gains{} {X:mult,C:white}^#1#{} Mult{}", 
			"if played Poker Hand is {C:attention}Royal Flush{}",
			"{C:inactive}Curerntly{} {X:mult,C:white}^#2#{} {C:inactive}Mult{}",
		}
	},
	config = { extra = { Emult = 1, Emult_gain = 25 } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	no_tree = true,
	pos = { x = 2, y = 2 },
	soul_pos = { x = 1, y = 2 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_gain, card.ability.extra.Emult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.Emult > 1 then
			return {
				Emult_mod = card.ability.extra.Emult,
				card = card,
				message = '^'..card.ability.extra.Emult..' Mult',
				colour = G.C.MULT,			
			}
		end
		if context.before and next(context.poker_hands['may_Royal Flush']) and not context.blueprint then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.MULT,
			}
		end
	end
}

SMODS.Joker {
	key = 'party_time',
	loc_txt = {
		name = {'Party Time', "{C:inactive,s:0.5}Daredevil + Universal Collapse{}"},
		text = {
			{
				"After hand is played, {C:green}#1# in #2#{}",
				"chance to {C:attention}increase{} {C:dark_edition}Score Operator{} level",
				"by {C:attention}#3#{}",
				may.pager(),
				"{C:mult}Only works once{}", 
				may.pager(),
				"{X:attention,C:white}X#4#{} Blind Size",
			},
			may.add_fusion_text('Universal Collapse', 'Aurora Rave', may.get_condition('aurora_rave')),
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	config = { extra = { odds = 15, mod = 1, blindmult = 200, active = false } },
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 3, y = 3 },
	soul_pos = { x = 2, y = 3 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult } }
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
		if context.after and context.cardarea == G.jokers and not context.blueprint then
			if pseudorandom('may_party_time') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
            if not card.ability.extra.active then
			    change_operator(card.ability.extra.mod) 
                card.ability.extra.active = true
			    return {
				    message = 'Upgraded!',
				    card = card
			    }
            end
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.GAME.blind.chips = to_big(G.GAME.blind.chips):mul(card.ability.extra.blindmult)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			return true end}))
		end
	end
}

--[[SMODS.Joker {
	key = 'ultimate_hurley',
	loc_txt = {
		name = {'Ultimate Hurley', "{C:inactive,s:0.5}Hurley + Universal Collapse{}"},
		text = {
			{
				"Scoring {C:attention}10s{} give {X:money,C:white}X#1#${}",
			},
			{
				"{C:inactive,E:1}Concept and art by therealten95{}",
			},
		}
	},
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 8 },
	soul_pos = { x = 1, y = 8 },
	cost = 1000,
	config = { extra = { xmoney = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmoney } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 10 then	
				return {
					message = 'X'..card.ability.extra.xmoney..'$',
					colour = G.C.MONEY,
					card = context.other_card,
					x_dollars = card.ability.extra.xmoney
				}
			end
		end
		if context.forcetrigger then
			return {
				message = 'X'..card.ability.extra.xmoney..'$',
				colour = G.C.MONEY,
				card = card,
				x_dollars = card.ability.extra.xmoney
			}
		end
	end
}]] 

SMODS.Joker {
	key = 'acum',
	loc_txt = {
		name = {'Acum', "{C:inactive,s:0.5}Universal Collapse + AAAA{}"},
		text = {
			{
				"{C:attention}After hand{} is played, create a {C:dark_edition}Negative{}",
				"copy of {C:spectral}Grim{}",
				may.pager(),
				"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
				"and give {X:mult,C:white}^#2#{} Mult",
			},
			may.add_fusion_text('Universal Collapse', 'Acum Universum', may.get_condition('acum_universum')),
		}
	},
	config = { extra = { repetitions = 4, e_mult = 11 } },
	rarity = "may_transcendent",
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	atlas = 'joker1',
	pos = { x = 5, y = 5 },
	soul_pos = { x = 0, y = 6 },
	cost = 1000,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_grim
		return { vars = { card.ability.extra.repetitions, card.ability.extra.e_mult } }
	end,
	calculate = function(self, card, context)
		if (context.cardarea == G.play and context.repetition) or (context.blueprint and context.cardarea == G.play and context.repetition) and not context.repetition_only then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			end
		end
		if context.after or (context.blueprint and context.after) then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				card:juice_up(0.3, 0.5)
				local grim = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_grim', nil)
				grim.no_forced_edition = true
				grim.no_forced_edition = nil
				grim:setQty(1)
				grim:set_edition({negative = true}, true)
				grim:set_cost()
				grim:add_to_deck()
				G.consumeables:emplace(grim)
			return true end}))
		end
		if (context.individual and context.cardarea == G.play) or (context.individual and context.cardarea == G.play and context.blueprint) then
			if context.other_card:get_id() == 14 then	
				return {
					e_mult = card.ability.extra.e_mult,
					card = context.other_card,
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				card:juice_up(1,1)
				local grim = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_grim', nil)
				grim.no_forced_edition = true
				grim.no_forced_edition = nil
				grim:setQty(1)
				grim:set_edition({negative = true}, true)
				grim:set_cost()
				grim:add_to_deck()
				G.consumeables:emplace(grim)
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'storm',
	loc_txt = {
		name = {'Storm', "{C:inactive,s:0.5}Universal Collapse + Destroyer{}"},
		text = {
			{
				"{X:chips,C:white}+^#1#{} Chips per {C:attention}held{} {C:planet}Planet Card{}", 
				may.pager(),
                "At the {C:attention}end of round{}, {C:mult}destroys{} all", 
                "held {C:planet}Planet Cards{} and gains {X:chips,C:white}+^#2#{} Chips", 
                "per {C:mult}destroyed{} {C:planet}Planet Card{}", 
				may.pager(),
				"{C:inactive}Currently {X:chips,C:white}^#3#{} {C:inactive}Chips, will gain +^#4#{}"
			},
			may.add_fusion_text('Universal Collapse', 'World Destroyer', may.get_condition('world_destroyer')),
		}
	},
	config = { extra = { Echip_gain = 0.5, Echip = 1, temp_scale = 0} },
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4 },
	cost = 1000,
	rarity = 'may_transcendent',
	unlocked = true,
	immutable = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        local amount = 0
        if G.consumeables then
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end
            end
        end
        return {vars = { card.ability.extra.Echip, card.ability.extra.Echip_gain, 1 + (card.ability.extra.Echip * amount), card.ability.extra.Echip_gain * amount }}
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then 
            local amount = 0
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end 
            end 
            if 1 + (amount * card.ability.extra.Echip) > 1 then
			    return {
				    message = "^"..(1 + (amount * card.ability.extra.Echip)).." Chips",
				    colour = G.C.CHIPS,
				    Echip_mod = 1 + (amount * card.ability.extra.Echip),
				    card = card,			
			    }
            end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            local amount = 0
			for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                    G.E_MANAGER:add_event(Event({ func = function()
                        v:start_dissolve()
                    return true end}))
                end 
            end 
            card.ability.extra.temp_scale = amount * card.ability.extra.Echip_gain
            SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Echip",
				scalar_value = "temp_scale",
                colour = G.C.CHIPS
			})
		end
	end
}

SMODS.Joker {
	key = 'cosmos',
	loc_txt = {
		name = {'Cosmos', "{C:inactive,s:0.5}Universal Collapse + Nebula{}"},
		text = {
			{
				"{C:attention}Gives{} the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^Mult{}",
				"{C:inactive}Max of ^1e300{}",
			},
			may.add_fusion_text('Universal Collapse', 'Kepler', may.get_condition('kepler')),
		}
	},
	config = { extra = { Emult = 1 } },
	pos = { x = 5, y = 6 },
	soul_pos = { x = 0, y = 7 },
	cost = 1000,
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Emult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				Emult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				card = card,
				message = '^'..number_format(math.min(1e300, G.GAME.hands[context.scoring_name].level))..' Mult',
				colour = G.C.MULT,
			}
		end
		if context.forcetrigger then
			return {
				Emult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				card = card,
				message = '^'..number_format(math.min(1e300, G.GAME.hands[context.scoring_name].level))..' Mult',
				colour = G.C.MULT,
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus_kollectum',
	loc_txt = {
		name = {'Diskus Kollectum', "{C:inactive,s:0.5}Diskus + Collectionist{}"},
		text = {
			{
				"When {C:attention}Blind{} is {C:attention}selected{},",
				"create {C:attention}#1#{} {C:dark_edition}Negative{} copies of {C:purple}The Wheel of Fortune{}",
				may.pager(),
				"{C:attention}Increases{} by {C:attention}#2#{} when {C:attention}hand{} is {C:attention}played{}",
				may.pager(),
				"{X:mult,C:white}+^#3#{} Mult per {C:attention}Joker{} with an {C:dark_edition}Edition{}",
				may.pager(), 
				"{C:inactive}Currently ^#4# Mult{}"
			},
			may.add_fusion_text('Collector\'s Edition', 'Diskus Kollectum Maximus', may.get_condition('diskus_kollectum_maximus')),
		}
	},
	rarity = 'may_transcendent',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	custom_soul_anim = 'diskus_spin',
	pos = { x = 3, y = 12 },
	soul_pos = { x = 0, y = 13 },
	cost = 1000,
	config = { extra = { blindcards = 20, cards_gain = 5, Emult = 14, } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local num = 1
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.key then
					num = num + card.ability.extra.Emult
				end
			end
		end
		return { vars = { card.ability.extra.blindcards, card.ability.extra.cards_gain, card.ability.extra.Emult, num } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.blindcards = card.ability.extra.blindcards + card.ability.extra.cards_gain
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				wheel:setQty(card.ability.extra.blindcards)
				wheel:add_to_deck()
			    wheel:set_edition({negative = true}, false, false)
				G.consumeables:emplace(wheel)
			return true end}))
		end
        if context.joker_main or context.forcetrigger then
			local num = 1
			for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.key then
					num = num + card.ability.extra.Emult
				end
			end 
			if num > 1 then
			    return {
				    e_mult = num,
				    card = card 
			    }
			end
		end
	end
}

SMODS.Joker {
	key = 'bismuth_joker',
	loc_txt = {
		name = {'Bismuth Joker', "{C:inactive,s:0.5}Bedrock Joker + Stone Joker{}"},
		text = {
			{
				"{X:chips,C:white}^#1#{} Chips",
				may.pager(),
                "When {C:attention}Blind{} is {C:attention}selected{},", 
				"create a {C:dark_edition}Negative{} copy of {C:spectral}Medusa{}",
				may.pager(),
                "After scoring, {C:mult}destroy{} all", 
				"{C:dark_edition}Stone Cards{} {C:attention}held in hand{} and gain", 
				"{X:chips,C:white}+^#2#{} Chips per destroyed card",
				may.pager(), 
				"Played {C:dark_edition}Stone Cards{} increase", 
				"{X:chips,C:white}^Chips{} gain by {X:chips,C:white}+^#3#{} before scoring",
			},
            may.add_fusion_text('Cement Joker', 'Rocco Pfilosofia', may.get_condition('rocco_pfilosofia')) 
		}
	},
	rarity = "may_transcendent",
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 0 },
	config = { extra = { Echip = 1, Echip_gain = 0.5, Echip_gain2 = 0.1, } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_medusa
		return { vars = { card.ability.extra.Echip, card.ability.extra.Echip_gain, card.ability.extra.Echip_gain2 } }
	end,
	cost = 1000,
	calculate = function(self, card, context)
		if context.setting_blind then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_may_medusa', 'may_bismuth_joker')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
			return true end})) 
		end
        if context.after and not context.blueprint then 
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then 
                    SMODS.destroy_cards(v)
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "Echip",
                        scalar_value = "Echip_gain",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end 
        end
		if context.before and not context.blueprint then
			for k, v in pairs(G.play.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "Echip_gain",
                        scalar_value = "Echip_gain2",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end
		end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.Echip > 1 then
            return {
                e_chips = card.ability.extra.Echip, 
                card = card, 
            }
        end
	end
}