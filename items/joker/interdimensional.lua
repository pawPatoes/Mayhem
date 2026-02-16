-- Interdimensional Jokers

SMODS.Joker {
	key = 'world_destroyer',
	loc_txt = {
		name = {'World Destroyer', "{C:inactive,s:0.5}Universal Collapse + Storm{}"},
		text = {
            {
			    "{X:chips,C:white}+^^#1#{} Chips per {C:attention}held{} {C:planet}Planet Card{}", 
				may.pager(),
                "At the {C:attention}end of round{}, {C:mult}destroys{} all", 
                "held {C:planet}Planet Cards{} and gains {X:chips,C:white}+^^#2#{} Chips", 
                "per {C:mult}destroyed{} {C:planet}Planet Card{}", 
				may.pager(),
				"{C:inactive}Currently {X:chips,C:white}^^#3#{} {C:inactive}Chips, will gain +^^#4#{}"
            }, 
            may.add_fusion_text('Zodiac', 'Astral Expunger', 'Used {C:attention}50{} {C:purple}Tarot Cards{} this run')
		}
	},
	config = { extra = { EEchip_gain = 0.5, EEchip = 1, temp_scale = 0 } },
	pos = { x = 4, y = 15 },
	soul_pos = { x = 5, y = 15 },
	cost = 100000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	immutable = true,
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
        return {vars = { card.ability.extra.EEchip, card.ability.extra.EEchip_gain, 1 + (card.ability.extra.EEchip * amount), card.ability.extra.EEchip_gain * amount }}
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then 
            local amount = 0
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end 
            end 
            if 1 + (amount * card.ability.extra.EEchip) > 1 then
			    return {
				    message = "^^"..(1 + (amount * card.ability.extra.EEchip)).." Chips",
				    colour = G.C.CHIPS,
				    EEchip_mod = 1 + (amount * card.ability.extra.EEchip),
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
            card.ability.extra.temp_scale = amount * card.ability.extra.EEchip_gain
            SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "EEchip",
				scalar_value = "temp_scale",
                colour = G.C.CHIPS
			})
		end
	end
}

SMODS.Joker {
	key = 'aurora_rave',
	loc_txt = {
		name = {'Aurora Rave', "{C:inactive,s:0.5}Party Time + Universal Collapse{}"},
		text = {
			{
				"{C:attention}+#5#{} {C:dark_edition}Score Operator{} level when obtained",
				"if {C:dark_edition}Score Operator{} is {C:attention}less than 1{}",
				may.pager(),
				"Before scoring, {C:green}#1# in #2#{}",
				"chance to {C:attention}increase{} {C:dark_edition}Score Operator{} level",
				"by {C:attention}#3#{}",
				may.pager(),
				"{C:mult}Only works once{}", 
				may.pager(),
				"{X:attention,C:white}^^#4#{} Blind Size",
			},
			may.add_fusion_text('Wizard University', 'Planet Ibiza', 'Have at least {C:attention}70{} {C:dark_edition}Enhanced{} playing cards'),
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	config = { extra = { obtained = 1, odds = 10, mod = 1, blindmult = 2, active = false } },
	rarity = 'may_interdimensional',
	atlas = 'joker2',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 6, y = 3 },
	soul_pos = { x = 6, y = 4 },
	cost = 100000,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult, card.ability.extra.obtained } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(2, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
			if SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order and SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order < 1 then 
				change_operator(card.ability.extra.obtained)
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(2, -card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and (not card.ability.extra.active) and (not context.blueprint) then
			if pseudorandom('may_aurora_rave') < G.GAME.probabilities.normal / card.ability.extra.odds then
				change_operator(card.ability.extra.mod)
                card.ability.extra.active = true 
				return {
					message = 'Upgraded!',
					card = card
				}
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
			G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(2, card.ability.extra.blindmult):normalize()
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
	end
}

SMODS.Joker {
	key = 'acum_universum',
	loc_txt = {
		name = {'Acum Universum', "{C:inactive,s:0.5}Universal Collapse + Acum{}"},
		text = {
			{
				"{C:attention}All{} scoring {C:attention}cards{} are {C:attention}turned into{} {C:attention}Aces{}",
				"before scoring", 
				may.pager(),
				"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
				"and give {X:mult,C:white}^^#2#{} Mult",
			},
			may.add_fusion_text('Universal Collapse', 'Acum Multiplexum', 'Have at least {C:attention}77 Aces{} in full deck'),
		}
	},
	config = { extra = { repetitions = 4, ee_mult = 11 } },
	immutable = true,
	rarity = "may_interdimensional",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
	cost = 5000,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.ee_mult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card:get_id() == 14 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = card,
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				return {
					ee_mult = card.ability.extra.ee_mult,
					card = card
				}
			end
		end
		if context.before and not context.blueprint then
			for _, card in ipairs(context.scoring_hand) do
				assert(SMODS.change_base(card, nil, "Ace"))
			end
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.forcetrigger then
			return {
				EEmult_mod = card.ability.extra.ee_mult,
				message = '^^'..card.ability.extra.ee_mult..' Mult',
				colour = G.C.MULT,
				card = context.other_card,
			}
		end
	end
}

SMODS.Joker {
	key = 'kepler',
	loc_txt = {
		name = {'Kepler', "{C:inactive,s:0.5}Cosmos + Universal Collapse{}"},
		text = {
			{
				"{C:attention}Gives{} the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^^Mult{}",
				"{C:inactive}Max of ^^1e300{}",
			},
			may.add_fusion_text('Universal Collapse', 'Kepler\'s Dream', '{C:planet}Level up{} a {C:purple}Poker Hand{} to {C:planet}level{} {C:attention}500{}'),
		}
	},
	config = { extra = { EEmult = 1 } },
	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 },
	cost = 10000,
	rarity = 'may_interdimensional',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				EEmult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				card = card,
				message = '^^'..number_format(to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)))..' Mult',
				colour = G.C.MULT,	
			}
		end
		if context.forcetrigger then
			return {
				EEmult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				card = card,
				message = '^^'..number_format(to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)))..' Mult',
				colour = G.C.MULT,	
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus_kollectum_maximus',
	loc_txt = {
		name = {'Diskus Kollectum Maximus', "{C:inactive,s:0.5}Diskus Kollectum + Collector's Edition{}"},
		text = {
			{
				"When {C:attention}Blind{} is {C:attention}selected{},",
				"create {C:attention}#1#{} {C:dark_edition}Negative{} copies of {C:purple}The Wheel of Fortune{}",
				may.pager(),
				"{C:attention}Increases{} by {C:attention}#2#{} per {C:attention}card{} in {C:attention}played hand{}",
				may.pager(),
				"{C:attention}Jokers{} with an {C:dark_edition}Edition{} give {X:purple,C:white}^^#3#{} Mult & Chips",
				"{X:purple,C:white}^^#4#{} Mult & Chips if {C:attention}this Joker{} has an {C:dark_edition}Edition{} instead",
			},
			may.add_fusion_text('Universal Collapse', 'Diskus Distruktum', '{C:attention}Holding{} at least {C:attention}1400{} copies of {C:purple}The Wheel of Fortune{}'),
		}
	},
	rarity = 'may_interdimensional',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	custom_soul_anim = 'diskus_spin',
	pos = { x = 4, y = 12 },
	soul_pos = { x = 5, y = 12 },
	cost = 100000,
	config = { extra = { blindcards = 40, cards_gain = 10, EEmultchips = 14, EEmultchips_alt = 80 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { card.ability.extra.blindcards, card.ability.extra.cards_gain, card.ability.extra.EEmultchips, card.ability.extra.EEmultchips_alt } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.blindcards = card.ability.extra.blindcards + (card.ability.extra.cards_gain * #G.play.cards)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
		if context.other_joker and context.other_joker.edition and context.other_joker ~= card then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
			return true end}))
			if card.edition then
				return {
					message = "^^"..card.ability.extra.EEmultchips_alt.." Mult & Chips",
					EEmult_mod = card.ability.extra.EEmultchips_alt,
					EEchip_mod = card.ability.extra.EEmultchips_alt,
					colour = G.C.PURPLE,
					card = context.other_joker,
					sound = 'may_eeboth'
				}
			else
				return {
					message = "^^"..card.ability.extra.EEmultchips.." Mult & Chips",
					EEmult_mod = card.ability.extra.EEmultchips,
					EEchip_mod = card.ability.extra.EEmultchips,
					colour = G.C.PURPLE,
					card = context.other_joker,
					sound = 'may_eeboth'
				}
			end
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:setQty(card.ability.extra.blindcards)
					wheel:add_to_deck()
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.blindcards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
						wheel:setQty(1)
					end
				end
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'rocco_pfilosofia',
	loc_txt = {
		name = {'Rocco Pfilosofia', "{C:inactive,s:0.5}Bismuth Joker + Cement Joker{}"},
		text = {
			{
				"{X:chips,C:white}^^#1#{} Chips",
				may.pager(),
                "When {C:attention}Blind{} is {C:attention}selected{},", 
				"create a {C:dark_edition}Negative{} copy of {C:spectral}Medusa{} and {C:planet}Deimos{}",
				may.pager(),
                "After scoring, {C:mult}destroy{} all", 
				"{C:dark_edition}Stone Cards{} {C:attention}held in hand{} and gain", 
				"{X:chips,C:white}+^^#2#{} Chips per destroyed card",
				may.pager(), 
				"Played {C:dark_edition}Stone Cards{} increase", 
				"{X:chips,C:white}^^Chips{} gain by {X:chips,C:white}+^^#3#{} before scoring",
				may.pager(),
				"{C:planet}Deimos{} {C:green}no longer{} {C:mult}destroys{} cards", 
				"and gives this Joker's {X:chips,C:white}^^Chips{}"
			},
            may.add_fusion_text('Universal Collapse', 'Infinity Stone', 'At least {C:attention}250{} {C:dark_edition}Stone Cards{} {C:mult}destroyed{}')
		}
	},
	rarity = "may_interdimensional",
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 0 },
	config = { extra = { EEchip = 1, EEchip_gain = 0.5, EEchip_gain2 = 0.1, } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_medusa
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_deimos
		return { vars = { card.ability.extra.EEchip, card.ability.extra.EEchip_gain, card.ability.extra.EEchip_gain2 } }
	end,
	cost = 100000,
	calculate = function(self, card, context)
		if context.setting_blind then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_may_medusa', 'may_rocco_pfilosofia')
			    card2:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card2)
			    card2:add_to_deck()
				local card3 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_deimos', 'may_rocco_pfilosofia')
			    card3:set_edition({negative = true}, false, false)
			    G.consumeables:emplace(card3)
			    card3:add_to_deck()
			return true end})) 
		end
        if context.after and not context.blueprint then 
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then 
                    SMODS.destroy_cards(v)
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "EEchip",
                        scalar_value = "EEchip_gain",
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
                        ref_value = "EEchip_gain",
                        scalar_value = "EEchip_gain2",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end
		end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.EEchip > 1 then
            return {
                ee_chips = card.ability.extra.EEchip, 
                card = card, 
            }
        end
		if context.using_consumeable and context.consumeable:gc().key == 'c_may_deimos' then 
            may.hand_mod_multchips(may.favhand(), 'chips', 2, card.ability.extra.EEchip, false, context.consumeable)
        end
	end
}