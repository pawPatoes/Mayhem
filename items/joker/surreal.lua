-- Surreal Jokers

SMODS.Joker {
	key = 'ad_infinitum',
	loc_txt = {
		name = 'Ad Infinitum',
		text = {
			{
				"Retriggers {C:attention}first and last{} played", 
				"{C:attention}cards #1#{} times",
				"Additional {C:attention}#2#{} retrigger", 
				"{C:attention}per card{} in played hand",
				may.pager(), 
				"Playing cards give {X:mult,C:white}^^^^#3#{} Mult", 
				"when scored, where {C:attention}N{} is", 
				"the {C:attention}position{} of the card in hand",
				"{C:inactive}Unscoring cards count{}"
			},
			{
				"{C:inactive,E:1}Concept and original art by _TeKKen_{}",
			}
		}
	},
	config = { extra = { base_retrigger = 10, retrigger_bonus = 1 } },
	pos = { x = 1, y = 11 },
	soul_pos = { x = 3, y = 11, extra = { x = 2, y = 11 } },
	cost = 5000,
	rarity = 'may_surreal',
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	immutable = true,
    loc_vars = function(self, info_queue, card) 
        return {vars = { card.ability.extra.base_retrigger, card.ability.extra.retrigger_bonus, "(1 + (N / 25))" } }
    end,
    calculate = function(self, card, context)
		if context.repetition then
			if context.cardarea == G.play then
				if context.other_card and (context.other_card == (context.scoring_hand or {})[1]) or (context.other_card == (context.scoring_hand or {})[#context.scoring_hand]) then
					if table_hasvalue(G.play.cards, context.other_card) then
						return {
							message = 'Again!',
							repetitions = card.ability.extra.base_retrigger + (#G.play.cards * card.ability.extra.retrigger_bonus),
							card = context.other_card,
						}
					end
				end
			end
		end
		if context.other_card and context.cardarea == G.play then 
			local pos = 0
			for k, v in pairs(G.play.cards) do
				if v == context.other_card then 
					pos = k
				end 
			end 
			return {
				hyper_mult = {4, 1 + (pos / 50)},
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'universalis',
	loc_txt = {
		name = 'UNIVERSALIS',
		text = {
			"{C:attention}Retrigger adjacent Jokers{} once for {C:attention}every{}",
			"held {C:planet}Planet{} card",
			may.pager(), 
			"{C:attention}Jokers{} give {X:chips,C:white}^^^^#1#{} Chips", 
			"when {C:attention}retriggered{} during scoring",
			may.pager(),
			"{C:inactive}(Currently #2# retriggers, max of 30){}"
		}
	},
	pos = { x = 0, y = 15 },
	soul_pos = { x = 2, y = 15, extra = { x = 1, y = 15 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { HEXchip = 1.1, retrigger = 0 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.HEXchip, math.min(card.ability.extra.retrigger, 30) } }
    end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			local joker1
			local joker2
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i > 1 then
						joker1 = G.jokers.cards[i - 1]
					end
					if i < #G.jokers.cards then
						joker2 = G.jokers.cards[i + 1]
					end
				end
			end
			if context.other_card == joker1 or context.other_card == joker2 then
				return {
					repetitions = math.min(card.ability.extra.retrigger, 30),
					hyper_chips = (G.GAME.blind and to_big(G.GAME.blind.chips or 0) > to_big(0)) and {4, card.ability.extra.HEXchip} or nil,
					message = 'Again!',
					card = card,
				}
			end
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().set == 'Planet' then
					if Overflow then
						amount = amount + (v:getQty() or 1)
					else
						amount = amount + 1
					end
				end
			end
			card.ability.extra.retrigger = amount
		end
	end
}

SMODS.Joker {
	key = 'ourania_kleidaria',
	loc_txt = {
		name = 'Ourania Kleidaria', 
		text = {
            {
                "{X:mult,C:white}+^^^^#1#{} Mult per", 
                "owned {C:attention}Eternal{} {C:attention}Joker{}", 
                "{C:inactive}Does not count instelf, currently ^^^^#2# Mult{}"
            }, 
            {
                "{C:dark_edition,E:1,s:1.5}Special Ability{}", 
                "Applies {C:attention}Eternal{} to the {C:attention}Joker{} to the {C:attention}right{}", 
            }
		}
	},
	pos = { x = 0, y = 14 },
	soul_pos = { x = 1, y = 14, extra = { x = 2, y = 14 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { HEXmult = 0.1 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
        local amount = 0
        if G.GAME.blind then 
            for k, v in pairs(G.jokers.cards) do
                if v ~= card then 
                    if SMODS.is_eternal(v) then 
                        amount = amount + 1
                    end
                end
            end
        end
		return {vars = { card.ability.extra.HEXmult, 1 + (card.ability.extra.HEXmult * amount) } }
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            local amount = 0
			for k, v in pairs(G.jokers.cards) do
                if v ~= card then 
                    if SMODS.is_eternal(v) then 
                        amount = amount + 1
                    end 
                end
            end 
            if 1 + (card.ability.extra.EEmult * amount) > 1 then 
			    return {
				    hyper_mult = {4, 1 + (card.ability.extra.HEXmult * amount)},
				    card = card
			    }
            end
		end
	end
}

SMODS.Joker {
	key = 'decenium',
	loc_txt = {
		name = 'Decenium',
		text = {
			"{C:attention}+#1#{} Ante when a {C:attention}consumable{} is {C:attention}used{}", 
			may.pager(),
            "{C:money}Sell value{} of held {C:attention}consumables{} is {C:green}multiplied{}", 
            "by {C:attention}Ante{} at the {C:attention}end of round{}", 
			may.pager(),
            "Gives {X:attention,C:white}^^#2#{} of total {C:money}money{} as", 
            "{X:chips,C:white}^^^^Chips{} when {C:attention}playing cards{} score", 
			may.pager(),
            "{C:inactive}Currently ^^^^#4# Chips{}"
		}
	},
	pos = { x = 0, y = 12 },
	soul_pos = { x = 1, y = 12, extra = { x = 2, y = 12 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { ante = 1, tetrate = 0.03, } },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante, card.ability.extra.tetrate, card.ability.extra.mult, to_big(G.GAME.dollars or 0):arrow(2, card.ability.extra.tetrate) } }
    end,
    calculate = function(self, card, context)
	    if context.using_consumeable then 
            ease_ante(card.ability.extra.ante)
        end 
        if (context.end_of_round and context.cardarea == G.jokers) or context.forcetrigger then 
            for k, v in pairs(G.consumeables.cards) do
                v.sell_cost = v.sell_cost * G.GAME.round_resets.ante
                card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.MONEY, delay = 0.45})
            end 
        end 
        if context.individual and context.cardarea == G.play and to_big(G.GAME.dollars or 0):arrow(2, card.ability.extra.tetrate) > to_big(1) then 
            return {
                hyper_chips = {4, to_big(G.GAME.dollars or 0):arrow(2, card.ability.extra.tetrate)},
                card = card, 
            }
        end
	end
}

SMODS.Joker {
	key = 'octum',
	loc_txt = {
		name = 'Octum',
		text = {
			"Played {C:attention}8s{} give {X:chips,C:white}^^^^#1#{} Chips", 
			may.pager(),
            "{C:mult}Discarded{} {C:attention}8s{} gain this Joker's", 
            "{X:chips,C:white}^^^^Chips{} as {C:mult}+Mult{}", 
			may.pager(),
            "{C:attention}8s held in hand{} add {X:attention,C:white}X#2#{} their", 
            "{C:mult}+Mult{} to this Jokers {X:chips,C:white}^^^^Chips{}",
            "{C:attention}before scoring{}" 
        }
	},
	pos = { x = 3, y = 13 },
	soul_pos = { x = 4, y = 13, extra = { x = 5, y = 13 } },
	cost = 5000,
	immutable = true,
	rarity = 'may_surreal',
	config = { extra = { HEXchip = 1.08, mult = 0.1, temp_scale = 0} },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.HEXchip, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 8 then
				return {
					hyper_chips = {4, card.ability.extra.HEXchip},
					card = context.other_card,
				}
			end
		end
        if context.before and not context.blueprint then 
            for k, v in pairs(G.hand.cards) do
                if v:get_id() == 8 and v.ability.perma_mult then
                    card.ability.extra.temp_scale = v.ability.perma_mult * card.ability.extra.mult
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "HEXchip",
                        scalar_value = "temp_scale",
                        colour = G.C.CHIPS
                    })
                end 
            end
        end
        if context.discard then 
            if context.other_card:get_id() == 8 then 
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.HEXchip 
                card_eval_status_text(context.other_card, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus'})
            end 
        end 
	end
}

--[[SMODS.Joker {
	key = 'subdola',
	loc_txt = {
		name = {'Subdola', "{C:dark_edition,s:0.6}N Joker{}"},
		text = {
			{
				"When an {C:dark_edition}N Joker{} is {C:green}obtained{}, create a {C:dark_edition}Negative Sly Joker{}", 
				may.pager(),
                "{C:attention}Retrigger{} all {C:dark_edition}N Jokers{} once for every {C:attention}#1#{} {C:dark_edition}Sly Jokers{} owned", 
				may.pager(),
                "Create a random {C:dark_edition}Negative N Joker{} if", 
                "{C:attention}played hand{} is a {C:attention}Three of a Kind{} {C:attention}before scoring{}", 
				may.pager(),
                "{X:mult,C:white}+^^^^#2#{} Mult per owned {C:dark_edition}Sly Joker{} if {C:attention}played hand{} is {C:attention}Three of a Kind{}",
				may.pager(),
                "{C:inactive}Max 14 retriggers, rounded down{}", 
                "{C:inactive}Currently ^^^^#3# Mult and #4# retriggers{}", 
			},
			{
				"{C:inactive,E:1}Original concept by _TeKKen_{}",
			},
		}
	},
	pos = { x = 3, y = 14 },
	soul_pos = { x = 5, y = 14, extra = { x = 4, y = 14 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { sly_jokers = 3, HEXmult = 0.14 } },
	unlocked = true,
	discovered = true,
	n_joker = true,
	pools = { N = true },
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
        local amount = 0
        if G.jokers then
            for k, v in pairs(G.jokers.cards) do
                if v:gc().key == 'j_sly' then 
                    amount = amount + 1
                end 
            end
        end
        return {vars = { card.ability.extra.sly_jokers, card.ability.extra.HEXmult, 1 + (card.ability.extra.HEXmult * amount), math.min(14, math.floor(amount / card.ability.extra.sly_jokers)) } }
    end,
    calculate = function(self, card, context)
		if (context.card_added and context.cardarea == G.jokers and context.card and may.is_n(context.card)) or context.forcetrigger then 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                local card2 = create_card("Joker", G.jokers, false, nil, nil, nil, 'j_sly', "may_subdola")
			    card2:set_edition({negative = true}, true, true)
			    card2:add_to_deck()
			    G.jokers:emplace(card2)
			    card:juice_up(0.3, 0.5)
            return true end})) 
        end
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card and may.is_n(context.other_card) then 
            local amount = 0
            for k, v in pairs(G.jokers.cards) do
                if v:gc().key == 'j_sly' then 
                    amount = amount + 1
                end 
            end
            return {
				message = 'Again!',
				card = card,
				repetitions = math.min(14, math.floor(amount / card.ability.extra.sly_jokers))
			}
        end
        if context.before and next(context.poker_hands['Three of a Kind']) then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                local card2 = create_card("N", G.jokers, false, nil, nil, nil, nil, "may_subdola")
			    card2:set_edition({negative = true}, true, true)
			    card2:add_to_deck()
			    G.jokers:emplace(card2)
			    card:juice_up(0.3, 0.5)
            return true end})) 
		end 
        if context.joker_main and G.GAME.current_round.current_hand.handname == localize("Three of a Kind", 'poker_hands') then 
            local amount = 0
            for k, v in pairs(G.jokers.cards) do
                if v:gc().key == 'j_sly' then 
                    amount = amount + 1
                end 
            end
            if 1 + (card.ability.extra.HEXmult * amount) > 1 then 
                return {
                    hyper_mult = {4, 1 + (card.ability.extra.HEXmult * amount)}, 
                    card = card, 
                }
            end 
        end
	end
}]] 

SMODS.Joker {
	key = 'notatos',
	loc_txt = {
		name = 'Notatos',
		text = {
            "{X:may_score,C:white}^^^^#1#{} Score", 
			may.pager(),
            "{C:green}Add{} {C:attention}base{} {C:mult}Mult{} of", 
            "{C:attention}played{} {C:purple}Poker Hand{}", 
            "to {C:attention}its{} {C:may_score}Score{} {C:attention}before scoring{}", 
			may.pager(),
            "{C:attention}After scoring{}, {C:green}gain{} {X:may_score,C:white}+^^#2#{} Score", 
            "if {C:attention}earned{} {C:may_score}Score{} is {C:mult}less{} than {C:attention}Blind Requirements{}", 
            "then {C:attention}apply{} {X:may_score,C:white}^^^^Score{} to {C:may_score}Score{} of", 
            "of {C:attention}played{} {C:purple}Poker Hand{}"
		}
	},
	pos = { x = 2, y = 3 },
    soul_pos = { x = 4, y = 3, extra = { x = 3, y = 3 } },
	cost = 5000,
	rarity = 'may_surreal',
	config = { extra = { HEXscore = 1, HEXscore_gain = 0.1 } },
	unlocked = true,
	discovered = true,
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'may_hand_score_tutorial', set = 'Other' }
        return {vars = { card.ability.extra.HEXscore, card.ability.extra.HEXscore_gain } }
    end,
    calculate = function(self, card, context)
        if context.before then 
            may.hand_mod_score(context.scoring_name, -1, G.GAME.hands[context.scoring_name].mult, false)
        end 
		if context.after then
            if not SMODS.last_hand_oneshot then 
                SMODS.scale_card(card, {
				    ref_table = card.ability.extra,
				    ref_value = "HEXscore",
					scalar_value = "HEXscore_gain",
                    scaling_message = {
                        message = 'Upgraded!',
                        colour = may.C.score
                    }
			    })
                may.hand_mod_score(context.scoring_name, 2, card.ability.extra.HEXscore, false)
            end
            return {
                hyper_score = {4, card.ability.extra.HEXscore},
                card = card,
            } 
		end
		if context.forcetrigger then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "HEXscore",
				scalar_value = "HEXscore_gain",
                scaling_message = {
                    message = 'Upgraded!',
                    colour = may.C.score
                }
		    })
		end
	end
}

SMODS.Joker {
	key = 'sexangulae_quattor',
	loc_txt = {
		name = 'Sexangulae Quattor',
		text = {
			{
			    "Played {C:attention}4s{} are {C:attention}retriggered #1#{} times",
			    "and give {X:chips,C:white}^^^^#2#{} Chips",
				may.pager(),
			    "Played cards that are {C:mult}not{} {C:attention}4s{} get",
			    "{C:mult}destroyed{} and give {X:attention,C:white}^^^^#3#{} Blind Size before scoring",
			}, 
			{
				"{C:inactive,E:1}Art inspired by woomyarras.io{}"
			}
		}
	},
	pos = { x = 5, y = 16 },
	soul_pos = { x = 1, y = 17, extra = { x = 0, y = 17 } },
	cost = 4444,
	rarity = 'may_surreal',
	config = { extra = { repetitions = 4, HEXchip = 44, HEXblind_size = 444,} },
	unlocked = true,
	discovered = true,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.repetitions, card.ability.extra.HEXchip, card.ability.extra.HEXblind_size, } }
    end,
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card:get_id() == 4 then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card,
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 4 then
				return {
					hyper_chips = {4, card.ability.extra.HEXchip},
					card = context.other_card
				}
			end
		end
		if context.before then
			G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				for k, v in pairs(G.play.cards) do
					if v:get_id() ~= 4 then
						G.GAME.blind.chips = G.GAME.blind.chips:arrow(4, card.ability.extra.HEXblind_size)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.hand_text_area.blind_chips:juice_up()
						play_sound('may_blind_size')
						v:start_dissolve()
					end
				end
			return true end}))
		end
		if context.forcetrigger then
			return {
				hyper_chips = {4, card.ability.extra.HEXchip},
				card = card
			}
		end
	end
}

SMODS.Joker {
	key = 'fortuno',
	loc_txt = {
		name = "Fortuno",
		text = {
			"When {C:attenton}Blind{} is {C:attention}selected{},",
			"this Joker creates {C:attention}#1#{} {C:dark_edition}Negative{}", 
			"copies of {C:purple}The Wheel of Fortune{}",
			"for {C:attention}every Joker{} with an {C:dark_edition}Edition{}",
			may.pager(),
			"This Joker {C:attention}gains{} {X:purple,C:white}+^^^^#2#{} Mult & Chips", 
			"when using {C:purple}The Wheel of Fortune{}",
			may.pager(),
			"{C:inactive}Currently{} {X:purple,C:white}^^^^#3#{} {C:inactive}Mult & Chips, will create #4# cards{}",
		}
	},
	config = { extra = { cards = 5, HEXmultchips_gain = 0.06, HEXmultchips = 1, total_cards = 0 } },
	rarity = 'may_surreal',
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	pos = { x = 2, y = 16 },
	soul_pos = { x = 4, y = 16, extra = { x = 3, y = 16 } },
	cost = 5000,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.cards, card.ability.extra.HEXmultchips_gain, card.ability.extra.HEXmultchips, card.ability.extra.total_cards } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and card.ability.extra.total_cards ~= 0 then
			G.E_MANAGER:add_event(Event({func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:add_to_deck()
					wheel:setQty(card.ability.extra.total_cards)
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.total_cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
		if context.joker_main and card.ability.extra.EEmultchips ~= 1 then
			return {
				message = "^^^^"..card.ability.extra.HEXmultchips.." Mult & Chips",
				colour = G.C.PURPLE,
				hyper_chips = {4, card.ability.extra.HEXmultchips},
				hyper_mult = {4, card.ability.extra.HEXmultchips},
				sound = 'may_hexboth',
			}
		end
		if context.using_consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' and not context.blueprint then
			card.ability.extra.HEXmultchips = card.ability.extra.HEXmultchips + card.ability.extra.HEXmultchips_gain
			return {
				message = 'Upgraded!',
				card = card,
				colour = G.C.PURPLE,
			}
		end
		if context.forcetrigger and card.ability.extra.total_cards ~= 0 then
			G.E_MANAGER:add_event(Event({func = function()
				card:juice_up(0.5, 0.5)
				if Overflow then
					local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
					G.consumeables:emplace(wheel)
					wheel:add_to_deck()
					wheel:setQty(card.ability.extra.total_cards)
					wheel:set_edition({negative = true}, false, false)
				else
					for i=1, card.ability.extra.total_cards, 1 do
						local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
						G.consumeables:emplace(wheel)
						wheel:add_to_deck()
						wheel:set_edition({negative = true}, false, false)
					end
				end
			return true end}))
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local amount = 0
			for k, v in pairs(G.jokers.cards) do
				if v.edition then
					amount = amount + card.ability.extra.cards
				end
			end
			card.ability.extra.total_cards = amount
		else
			card.ability.extra.total_cards = 0
		end
	end
}