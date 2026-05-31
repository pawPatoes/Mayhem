SMODS.Joker {
	key = 'spadus',
	loc_txt = {
		name = {'{C:dark_edition,s:1.2}Spadus{}', "{C:inactive,s:0.5}ACVM MVLTIPLEXVM + Kepler's Dream{}"},
		text = {
			"Played {C:attention}Aces{} give {X:purple,C:white}#1##2##3#X{} Mult & Chips",
			"and are retriggered {C:attention}#4# times{}",
			may.pager(),
			"{C:attention}Hyperoperand{} is {C:attention}equal{} to played {C:purple}Poker Hand{} {C:planet}level{}",
			may.pager(),
			"{C:attention}Arrows increase{} by {C:attention}#5#{} when a {C:planet}planet card{} is {C:attention}used{} during a {C:attention}blind{}",
			may.pager(),
			"When {C:attention}Blind{} is {C:attention}selected{}, turn {C:attention}all{} cards in deck into {C:attention}Aces{}",
			may.pager(),
			"{C:inactive}Arrows round up{}"
		}
	},
	config = { extra = { arrow = 4, repetitions = 11, arrow_gain = 1 } },
	rarity = "may_hyperascendant",
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 11e111,
    set_card_type_badge = may.hyperascendant_badge,
	loc_vars = function(self, info_queue, card)
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.repetitions, card.ability.extra.arrow_gain, card.ability.extra.reset }}
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
					hyper_mult = {math.ceil(card.ability.extra.arrow), G.GAME.hands[context.scoring_name].level},
					hyper_chips = {math.ceil(card.ability.extra.arrow), G.GAME.hands[context.scoring_name].level},
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
		if context.using_consumeable and not context.blueprint then 
			if context.consumeable:gc().set == 'Planet' and (#G.hand.cards ~= 0 and not G.pack_cards) then
				card.ability.extra.arrow = card.ability.extra.arrow + (card.ability.extra.arrow_gain * context.consumeable:getEvalQty())
				return {
					message = 'Upgraded!',
					colour = G.C.DARK_EDITION,
					card = card,
					sound = 'may_hyperoperator',
				}
			end
		end
		if context.forcetrigger then
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
	end
}

--[[if may.conf.content.WIP then

SMODS.Joker {
	key = 'overflow',
	loc_txt = {
		name = 'Overflow',
		text = {
			"{X:chips,C:white}#1##2##3##4#{} Chips",
			"When {C:attention}blind{} is {C:attention}selected{}, gain {C:chips}current hands{}",
			"as {C:dark_edition}hyperoperator level{}"
		}
	},
	config = { extra = { arrow = 1, Hchips = 3, } },
	pos = { x = 0, y = 0 },
	cost = 5000,
	rarity = 'may_hyperascendant',
	misc_badge = may_wip_badge,
	unlocked = true,
	immutable = true,
	discovered = true,
	atlas = 'placeholder',
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_immutable", set = "Other" }
        return {vars = { '{', card.ability.extra.arrow, '}', card.ability.extra.Hchips, }}
    end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.arrow = card.ability.extra.arrow + G.GAME.current_round.hands_left
			if may.conf.Safe then
				card.ability.extra.arrow = math.min(10000, card.ability.extra.arrow)
			end
			return {
				message = 'Upgraded!',
				colour = G.C.DARK_EDITION,
				card = card,
				sound = 'may_hyperoperator',
			}
		end
		if context.joker_main then
			return {
				hyper_chips = {math.ceil(card.ability.extra.arrow), card.ability.extra.Hchips},
				message = may.generate_arrow_text(card.ability.extra.arrow, 5)..' Chips',
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end
}

end]]

SMODS.Joker {
	key = 'rondo_discoteca',
	loc_txt = {
		name = {'{C:dark_edition,s:1.2}Rondo Discoteca{}', "{C:inactive,s:0.5}Diskus Distruktum + Planet Ibiza{}"},
		text = {
			{
			    "{C:attention}+#1#{} {C:dark_edition}Score Operator{} level when {C:attention}obtained{}", 
			    may.pager(),
			    "When {C:attention}Blind{} is {C:attention}selected{}, create {C:attention}#2#{} {C:dark_edition}Negative{} copies of {C:tarot}The Wheel of Fortune{}", 
			    may.pager(),
			    "Using {C:tarot}The Wheel of Fortune{} applies random {C:dark_edition}Editions{} to all cards {C:attention}held in hand{}", 
			    may.pager(),
			    "Cards {C:attention}held in hand{} with {C:dark_edition}Editions{} give {X:chips,C:white}#3#{} Chips, where {C:attention}N{} is {C:dark_edition}Score Operator{} level", 
			    "and {C:attention}X{} is the number of held copies of {C:tarot}The Wheel of Fortune{}", 
				may.pager(),
			    "{C:attention}Jokers{} with an {C:dark_edition}Edition{} have a {C:mult}fixed{} {C:green}#4# in #5#{} chance to {C:green}increase{} {C:dark_edition}Score Operator{} level", 
			    "by {C:attention}#6#{} after scoring and give {X:chips,C:white}#3#{} Chips",
			    may.pager(),
				"{C:inactive}#3# is currently #8#, hyperoperator will decrease by #9#{}",
			},
			{
				"{C:inactive,E:1}Art by Pakins{}"
			}
		}
	},
	config = { extra = { obtained = 2, odds = 3, wheels = 560, mod = 1, decrease = -0.25 } },
	rarity = "may_hyperascendant",
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	custom_soul_anim = 'diskus_spin_fast',
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
	cost = 1e100,
    set_card_type_badge = may.hyperascendant_badge,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
        local amount = 0
        local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
		if (G.GAME.current_scoring_calculation_key or '') == 'talisman_hyper' then
			op = G.GAME.hyper_operator or 2
		end
        if G.consumeables then 
            for k, v in pairs(G.consumeables.cards) do
                if v:gc().key == 'c_wheel_of_fortune' then 
                    amount = amount + v:getQty()
                end 
            end
        end
        local normal, odds = SMODS.get_probability_vars(card, 1, 3, "Rondo Discoteca")
        return { vars = { card.ability.extra.obtained, card.ability.extra.wheels, "{N + 1}X", normal, odds, card.ability.extra.mod, math.abs(card.ability.extra.decrease), "{"..(op + 1).."}"..amount, math.ceil(math.abs(card.ability.extra.decrease) * #(G.jokers or { cards = { } }).cards) } }
    end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card:juice_up(0.3, 0.5)
			if SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + card.ability.extra.obtained > 2 and G.GAME.current_scoring_calculation_key ~= 'talisman_hyper' then 
                G.GAME.current_scoring_calculation_key = 'talisman_hyper'
                change_operator(card.ability.extra.obtained-2)
            else 
                change_operator(card.ability.extra.obtained)
            end
		end
	end,
	calculate = function(self, card, context)
        if context.setting_blind then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(1, 1)
				local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				G.consumeables:emplace(wheel)
				wheel:setQty(card.ability.extra.wheels)
				wheel:add_to_deck()
				wheel:set_edition({negative = true}, false, false)
            return true end}))
        end 
        if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' then 
            if #G.hand.cards > 0 then 
                for k, v in pairs(G.hand.cards) do 
                    if not v.edition then
                        v:set_edition(poll_edition('may_planet_ibiza', nil, true, true), false, false)
                    end
                end
            end
        end 
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.edition then
                local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
				if G.GAME.current_scoring_calculation_key == 'talisman_hyper' then
					op = G.GAME.hyper_operator
				end
                local amount = 0
                for k, v in pairs(G.consumeables.cards) do 
                    if v:gc().key == 'c_wheel_of_fortune' then
                        amount = amount + v:getQty()
                    end 
                end
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				else
                    if amount > 0 then
					    return {
                            hyper_chips = {math.max(op + 1, -2), amount},
						    card = card
					    }
                    end
			    end
            end
        end
        if context.other_joker and context.other_joker.edition then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(2, 2)
			return true end}))
            local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
			if G.GAME.current_scoring_calculation_key == 'talisman_hyper' then
				op = G.GAME.hyper_operator
			end
            local amount = 0
            for k, v in pairs(G.consumeables.cards) do 
                if v:gc().key == 'c_wheel_of_fortune' then
                    amount = amount + v:getQty()
                end 
            end
            if amount > 0 then
			    return {
				    hyper_chips = {math.max(op + 1, -2), amount},
				    card = card
			    }
            end
		end
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			for k, v in pairs(G.jokers.cards) do 
                if v.edition and SMODS.pseudorandom_probability(card, "may_rondo_discoteca", 1, 3, "Rondo Discoteca") then 
                    G.E_MANAGER:add_event(Event({func = function()
                        change_operator(card.ability.extra.mod)
                    return true end}))
                    card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.GREEN, delay = 0.45})
                end
            end
		end
	end
}

SMODS.Joker {
	key = 'zodium_calamitas',
	loc_txt = {
		name = {'{C:dark_edition,s:1.2}Zodium Calamitas{}', "{C:inactive,s:0.5}Infinity Stone + Astral Expunger{}"},
		text = {
			{
				"{X:chips,C:white}#1##2#{} Chips, additional {X:chips,C:white}+#1##2#{} per held {C:planet}Planet Card{}",
				may.pager(),
                "When {C:attention}Blind{} is {C:attention}selected{},", 
				"create a {C:dark_edition}Negative{} copy of {C:spectral}Medusa{} and {C:planet}Deimos{}",
				may.pager(),
                "After scoring, {C:mult}destroy{} all", 
				"{C:dark_edition}Stone Cards{} {C:attention}held in hand{} and gain", 
				"{X:chips,C:white}+H#3#{} Chips per destroyed card",
				may.pager(), 
				"Played {C:dark_edition}Stone Cards{} increase", 
				"{X:chips,C:white}HChips{} gain by {X:chips,C:white}+H#4#{} before scoring",
				may.pager(),
				"{C:planet}Deimos{} {C:green}no longer{} {C:mult}destroys{} cards", 
				"and gives this Joker's {X:chips,C:white}HChips{}",
				may.pager(),
				"{C:attention}+#6#{} {C:dark_edition}hyperoperator{} every {C:attention}#7#{}", 
				"{C:tarot}Tarot Cards{} used, {C:mult}max{} {C:attention}+#8#{} per round", 
				may.pager(), 
				"{C:inactive}Currently #9# Chips{}"
			},
		}
	},
	rarity = "may_hyperascendant",
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 0, y = 0 },
	config = { extra = { hyperoperator = 4, hyper_chips = 1, hyper_chips_gain = 1, hyper_chips_gain2 = 0.5, hyperop_decrease = -0.25, hyperop_increase = 1, tarots = 3, max = 5, increased = 0, used = 0 } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_medusa
		info_queue[#info_queue + 1] = G.P_CENTERS.c_may_deimos
		local amount = 0
		if G.GAME.blind then
		    for k, v in pairs(G.consumeables.cards) do
			    if v:gc().set == 'Planet' then 
				    amount = amount + v:getQty()
			    end
		    end
		end
		return { vars = { 
			'{'..card.ability.extra.hyperoperator..'}',
			card.ability.extra.hyper_chips,
			card.ability.extra.hyper_chips_gain,
			card.ability.extra.hyper_chips_gain2, 
			tostring(-math.abs(card.ability.extra.hyperop_decrease)),
			card.ability.extra.hyperop_increase,
			card.ability.extra.tarots, 
			card.ability.extra.max, 
			'{'..card.ability.extra.hyperoperator..'}'..(card.ability.extra.hyper_chips * (amount + 1)),
		} }
	end,
	cost = 1e100,
    set_card_type_badge = may.hyperascendant_badge,
	calculate = function(self, card, context)
		if context.setting_blind then 
			card.ability.extra.increased = 0
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
                        ref_value = "hyper_chips",
                        scalar_value = "hyper_chips_gain",
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
                        ref_value = "hyper_chips_gain",
                        scalar_value = "hyper_chips_gain2",
						scaling_message = {
                            colour = G.C.CHIPS, 
							message = localize('k_upgrade_ex')
						}
                    })
                end 
            end
		end
        if context.joker_main or context.forcetrigger then
			local amount = 0
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().set == 'Planet' then 
					amount = amount + v:getQty()
				end
			end
			if card.ability.extra.hyper_chips * (amount + 1) > 1 then
				return {
					hyper_chips = {card.ability.extra.hyperoperator, card.ability.extra.hyper_chips * (amount + 1)}, 
					card = card, 
				}
			end
        end
		if context.using_consumeable then 
			if context.consumeable:gc().key == 'c_may_deimos' then
                may.hand_mod_multchips(may.favhand(), 'chips', card.ability.extra.hyperoperator, card.ability.extra.hyper_chips, false, context.consumeable)
			end
			if context.consumeable:gc().set == 'Tarot' then
				if card.ability.extra.increased <= card.ability.extra.max then
				    card.ability.extra.used = card.ability.extra.used + context.consumeable:getEvalQty()
				    if card.ability.extra.used >= card.ability.extra.tarots then 
					    card.ability.extra.used = card.ability.extra.used - card.ability.extra.tarots
					    card.ability.extra.increased = card.ability.extra.increased + 1
					    SMODS.scale_card(card, {
						    ref_table = card.ability.extra,
							ref_value = "hyperoperator",
						    scalar_value = "hyperop_increase",
                            scaling_message = {
                                colour = G.C.DARK_EDITION, 
							    message = localize('k_upgrade_ex'), 
							    sound = 'may_hyperoperator'
						    }
					    })
				    end
				end
			end
        end
	end
}