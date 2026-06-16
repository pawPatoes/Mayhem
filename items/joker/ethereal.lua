-- Ethereal Jokers

SMODS.Joker {
	key = 'acum_multiplexum',
	loc_txt = {
		name = {'Acum Multiplexum', "{C:inactive,s:0.5}Universal Collapse + ACVM VNIVERSVM{}"},
		text = {
			{
				"When {C:attention}Blind{} is {C:attention}selected{},",
				"turn {C:attention}all cards{} in deck into {C:attention}Aces{}",
				may.pager(),
				"Played {C:attention}Aces{} are retriggered {C:attention}#1# times{}",
				"and give {X:mult,C:white}^^^#2#{} Mult",
			},
			may.add_fusion_text('Kepler\'s Dream', 'Spadus', may.get_condition('spadus')),
		}
	},
	config = { extra = { repetitions = 8, eee_mult = 11 } },
	rarity = "may_ethereal",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 2 },
	cost = 111111,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.eee_mult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
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
					eee_mult = card.ability.extra.eee_mult,
					card = card,
				}
			end
		end
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({func = function()
                for _, card in ipairs(G.playing_cards) do
					assert(SMODS.change_base(card, nil, "Ace"))
				end
			return true end}))
			return {
				message = "ACVM",
				colour = G.C.DARK_EDITION,
			}
		end
		if context.forcetrigger then
			return {
				EEEmult_mod = card.ability.extra.eee_mult,
				message = '^^^'..card.ability.extra.eee_mult..' Mult',
				colour = G.C.MULT,
				card = card,
			}
		end
	end
}

SMODS.Joker {
	key = 'planet_ibiza',
	loc_txt = {
		name = {'Planet Ibiza', "{C:inactive,s:0.5}Aurora Rave + Wizard University{}"},
		text = {
			{
				"{C:attention}+#5#{} {C:dark_edition}Score Operator{} level when obtained",
				"if {C:dark_edition}Score Operator{} level is {C:attention}less than 2{}", 
				may.pager(),
				"Apply {C:attention}random{} {C:dark_edition}Editions{} to all {C:attention}played cards before scoring{}",
				may.pager(),
				"{C:attention}Held in hand cards{} with {C:dark_edition}Editions{} give {X:chips,C:white}#6##7#{} Chips",
				"where {C:attention}N{} is current {C:dark_edition}Score Operator{} level", 
				may.pager(),
				"{C:green}#1# in #2#{} chance to {C:attention}increase{} {C:dark_edition}Score Operator{} level",
				"by {C:attention}#3#{} after scoring",
				may.pager(),
				"{C:mult}Only works #8# time{}", 
				may.pager(),
				"{X:attention,C:white}^^^#4#{} Blind Size",
			},
            may.add_fusion_text('Diskus Distruktum', 'Rondo Discoteca', may.get_condition('rondo_discoteca')), 
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	config = { extra = { obtained = 1, odds = 15, mod = 1, blindmult = 200, h_chips = 10, active = 1 } },
	rarity = 'may_ethereal',
	atlas = 'joker2',
	blueprint_compat = false ,
	demicoloncompat = true,
	pos = { x = 4, y = 6 },
	soul_pos = { x = 5, y = 6 },
	cost = 1e7,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mod, card.ability.extra.blindmult, card.ability.extra.obtained, '{N}', card.ability.extra.h_chips, card.ability.extra.active} }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(3, card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
			if SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order and SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order < 2 then
				change_operator(card.ability.extra.obtained)
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(3, -card.ability.extra.blindmult)
			card:juice_up(0.3, 0.5)
		end
	end,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
			for k, v in ipairs(context.scoring_hand) do
				if not v.edition then
					v:set_edition(poll_edition('may_planet_ibiza', nil, true, true), false, false)
				end
			end
		end
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card.edition then
				local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
				if G.GAME.current_scoring_calculation_key == 'talisman_hyper' then
					op = G.GAME.hyper_operator
				end
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				else
					return {
						hyper_chips = {op, card.ability.extra.h_chips},
						card = context.other_card
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
		if context.after and context.cardarea == G.jokers and not context.blueprint then
			if pseudorandom('may_planet_ibiza') < G.GAME.probabilities.normal / card.ability.extra.odds then
				if card.ability.extra.active > 0 then
					card.ability.extra.active = card.ability.extra.active - 1
					change_operator(card.ability.extra.mod)
					return {
						message = 'Upgraded!',
						card = card
					}
				end
			end
		end
		if context.setting_blind then
			G.GAME.blind.chips = to_big(G.GAME.blind.chips):arrow(3, card.ability.extra.blindmult):normalize()
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
	end
}

SMODS.Joker {
	key = 'keplers_dream',
	loc_txt = {
		name = {'Kepler\'s Dream', "{C:inactive,s:0.5}Universal Collapse + Kepler{}"},
		text = {
			{
				"{C:attention}Gives{} the {C:planet}level{} of played Poker Hand",
				"as {X:mult,C:white}^^^Mult{}",
				"{C:inactive}Max of ^^^1e300{}",
			},
			may.add_fusion_text('Acum Multiplexum', 'Spadus', may.get_condition('spadus')),
			{
				"{C:inactive,E:1}Original concept by pyleup{}",
			},
		}
	},
	config = { extra = { EEEmult = 1 } },
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 },
	cost = 100000,
	rarity = 'may_ethereal',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.EEEmult}}
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				EEEmult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				message = '^^^'..number_format(to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)))..' Mult',
				colour = G.C.RED,
				card = context.other_card,				
			}
		end
		if context.forcetrigger then
			return {
				EEEmult_mod = to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)),
				message = '^^^'..number_format(to_big(math.min(1e300, G.GAME.hands[context.scoring_name].level)))..' Mult',
				colour = G.C.RED,
				card = context.other_card,
			}
		end
	end
}

SMODS.Joker {
	key = 'diskus_distruktum',
	loc_txt = {
		name = {'Diskus Distruktum', "{C:inactive,s:0.5}Universal Collapse + Diskus Kollectum Maximus{}"},
		text = {
            {
			    "When {C:attention}Blind{} is {C:attention}selected{}, create {C:attention}#1#{} {C:dark_edition}Negative{} copies of {C:purple}The Wheel of Fortune{}",
				may.pager(),
			    "{C:attention}Increases{} by {C:attention}#2#{} when {C:purple}The Wheel of Fortune{} is used",
				may.pager(),
			    "{X:mult,C:white}+^^^#3#{} Mult per {C:attention}Joker{} with an {C:dark_edition}Edition{}",
			    "{C:attention}Increases{} by {C:attention}#4#{} at the {C:attention}end of round{} if {C:attention}this Joker{} has an {C:dark_edition}Edition{}",
				may.pager(), 
				"{C:inactive}Currently ^^^#5# Mult{}"
            }, 
            may.add_fusion_text('Planet Ibiza', 'Rondo Discoteca', may.get_condition('rondo_discoteca'))
		}
	},
	config = { extra = { blindcards = 140, scale = 14, EEEmult = 14, EEEmult_gain = 14 } },
	pos = { x = 4, y = 11 },
	soul_pos = { x = 5, y = 11 },
	cost = 1414141,
	rarity = 'may_ethereal',
	immutable = true,
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	custom_soul_anim = 'diskus_spin_fast',
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local num = 1
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.key then
					num = num + card.ability.extra.EEEmult
				end
			end
		end
        return {vars = {card.ability.extra.blindcards, card.ability.extra.scale, card.ability.extra.EEEmult, card.ability.extra.EEEmult_gain, num}}
    end,
    calculate = function(self, card, context)
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
		if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' and not context.blueprint then
			card.ability.extra.blindamount = card.ability.extra.blindamount + card.ability.extra.scale
			return {
				message = 'Upgraded!',
				card = card
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if card.edition then
				card.ability.extra.EEEmult = card.ability.extra.EEEmult + card.ability.extra.EEEmult_gain
				return {
					message = 'Upgraded!',
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if context.joker_main or context.forcetrigger then
			local num = 1
			for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.key then
					num = num + card.ability.extra.EEEmult
				end
			end 
			if num > 1 then
			    return {
				    eee_mult = num,
				    card = card 
			    }
			end
		end
	end
}

SMODS.Joker {
	key = 'astral_expunger',
	loc_txt = {
		name = {'Astral Expunger', "{C:inactive,s:0.5}World Destroyer + Zodiac{}"},
		text = {
            {
			    "{X:chips,C:white}+^^^#1#{} Chips per {C:attention}held{} {C:planet}Planet Card{}", 
				may.pager(),
                "At the {C:attention}end of round{}, {C:mult}destroys{} all", 
                "held {C:planet}Planet Cards{} and gains {X:chips,C:white}+^^^#2#{} Chips", 
                "per {C:mult}destroyed{} {C:planet}Planet Card{}", 
				may.pager(),
                "When a {C:tarot}Tarot Card{} is {C:attention}used{}", 
                "apply {C:attention}1 + current pentation{} amount", 
                "to {C:planet}level{} of {C:attention}most played{} {C:purple}Poker Hand{}", 
				may.pager(),
			    "{C:inactive}#3#, currently {X:chips,C:white}^^^#4#{} {C:inactive}Chips, will gain +^^^#5#{}",
            }, 
			may.add_fusion_text('Infinity Stone', 'Zodium Calamitas', may.get_condition('zodium_calamitas')),
			{
				"{C:inactive,E:1}Art by XZ0204{}"
			}
		}
	},
	config = { extra = { EEEchip_gain = 0.5, EEEchip = 1, temp_scale = 0 } },
	pos = { x = 7, y = 2 }, 
	soul_pos = { x = 8, y = 2 }, 
	cost = 1e7,
	rarity = 'may_ethereal',
	unlocked = true,
	discovered = true,
	immutable = true,
	atlas = 'joker2',
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
        return {vars = { card.ability.extra.EEEchip, card.ability.extra.EEEchip_gain, may.favhand(), 1 + (card.ability.extra.EEEchip * amount), card.ability.extra.EEEchip_gain * amount }}
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then 
            local amount = 0
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                end 
            end 
            if 1 + (amount * card.ability.extra.EEEchip) > 1 then
			    return {
				    message = "^^^"..(1 + (amount * card.ability.extra.EEEchip)).." Chips",
				    colour = G.C.CHIPS,
				    EEEchip_mod = 1 + (amount * card.ability.extra.EEEchip),
				    card = card,			
			    }
            end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint  then
            local amount = 0
			for k, v in pairs(G.consumeables.cards) do 
                if v:gc().set == 'Planet' then 
                    amount = amount + v:getQty()
                    G.E_MANAGER:add_event(Event({ func = function()
                        v:start_dissolve()
                    return true end}))
                end 
            end 
            card.ability.extra.temp_scale = amount * card.ability.extra.EEEchip_gain
            SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "EEEchip",
				scalar_value = "temp_scale",
                colour = G.C.CHIPS
			})
		end
        if context.using_consumeable and context.consumeable and context.consumeable:gc().set == 'Tarot' then 
			may.th(may.favhand())
            may.level_up_hand_hyper(card, may.favhand(), false, 1 +card.ability.extra.EEEchip, 3)
			may.ch()
        end
	end
}

SMODS.Joker {
	key = 'infinity_stone',
	loc_txt = {
		name = {'Infinity Stone', "{C:inactive,s:0.5}Rocco Pfilosofia + Universal Collapse{}"},
		text = {
			{
				"{X:chips,C:white}^^^#1#{} Chips",
				may.pager(),
                "When {C:attention}Blind{} is {C:attention}selected{},", 
				"create a {C:dark_edition}Negative{} copy of {C:spectral}Medusa{} and {C:planet}Deimos{}",
				may.pager(),
                "After scoring, {C:mult}destroy{} all", 
				"{C:dark_edition}Stone Cards{} {C:attention}held in hand{} and gain", 
				"{X:chips,C:white}+^^^#2#{} Chips per destroyed card",
				may.pager(), 
				"Played {C:dark_edition}Stone Cards{} increase", 
				"{X:chips,C:white}^^^Chips{} gain by {X:chips,C:white}+^^^#3#{} before scoring",
				may.pager(),
				"{C:planet}Deimos{} {C:green}no longer{} {C:mult}destroys{} cards", 
				"and gives this Joker's {X:chips,C:white}^^^Chips{}"
			},
            may.add_fusion_text('Astral Expunger', 'Zodium Calamitas', may.get_condition('zodium_calamitas'))
		}
	},
	rarity = "may_ethereal",
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 0 },
	config = { extra = { EEEchip = 1, EEEchip_gain = 1, EEEchip_gain2 = 0.5, } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_medusa
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_deimos
		return { vars = { card.ability.extra.EEEchip, card.ability.extra.EEEchip_gain, card.ability.extra.EEEchip_gain2 } }
	end,
	cost = 1e7,
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
                        ref_value = "EEEchip",
                        scalar_value = "EEEchip_gain",
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
                        ref_value = "EEEchip_gain",
                        scalar_value = "EEEchip_gain2",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end
		end
        if (context.joker_main or context.forcetrigger) and card.ability.extra.EEEchip > 1 then
            return {
                eee_chips = card.ability.extra.EEEchip, 
                card = card, 
            }
        end
		if context.using_consumeable and context.consumeable:gc().key == 'c_may_deimos' then 
            may.hand_mod_multchips(may.favhand(), 'chips', 3, card.ability.extra.EEEchip, false, context.consumeable)
        end
	end
}
