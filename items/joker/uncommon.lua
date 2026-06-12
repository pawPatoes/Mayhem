-- Uncommon Jokers

SMODS.Joker {
	key = 'double_edged_sword',
	loc_txt = {
		name = 'Double-Edged Sword',
		text = {
			"{X:attention,C:white}X#1#{} Blind Size",
			"{C:money}+$#2#{} at the end of round"
		}
	},
	config = { extra = { size = 1.4, dollars = 8 } },
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 4, y = 4 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.size, card.ability.extra.dollars } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			may.change_blind_size(0, 1.3)
			card:juice_up(0.3, 0.5)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		may.change_blind_size(-3, 1.3)
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				dollars = card.abilityt.extra.dollars,
				card = card,
			}
		end
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				G.GAME.blind.chips = to_big(G.GAME.blind.chips):mul(card.ability.extra.size)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'thumb',
	loc_txt = {
		name = 'Thumb',
		text = {
            {
			    "{C:money}+$#1#{} for {C:attention}every played card{}",
			    "{C:attention}less{} than current {C:attention}Card Selection Limit{}",
			    "{C:inactive}Max of $#2#{}",
            }, 
            {
			    "{C:inactive,E:1}Art & idea by Goobert_Joke{}"
            }, 
		}
	},
	config = { extra = { dollars = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars*25} }
	end,
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 17 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger and not (G.hand.config.highlighted_limit == #G.play.cards) then
			return {
				dollars = math.min(100, (G.hand.config.highlighted_limit - #G.play.cards)) * card.ability.extra.dollars,
				message = '$'..math.min(100, (G.hand.config.highlighted_limit - #G.play.cards)) * card.ability.extra.dollars,
				card = card,
				colour = G.C.MONEY
			}
		end
	end
}

SMODS.Joker {
	key = 'paper_shredder',
	loc_txt = {
		name = 'Paper Shredder',
		text = {
			"{C:attention}After hand{} is played,",
			"{C:mult}destroy{} a {C:attention}random card{}",
			"{C:attention}held in hand{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 1, y = 3 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	immutable = true,
	calculate = function(self, card, context)
		if ((context.after and context.cardarea == G.jokers) or context.forcetrigger) and #G.hand.cards > 0 then
			card2 = pseudorandom_element(G.hand.cards, pseudoseed("paper_shredder_selection"))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('generic1')
				card:juice_up(0.3, 0.5)
				card2.highlighted = true
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				card:juice_up(0.3, 0.5)
				card2:start_dissolve(nil, true)
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'nebula',
	loc_txt = {
		name = 'Nebula',
		text = {
			{
				"{C:attention}Gives{} {X:green,C:white}X#1#{} the {C:planet}level{}",
				"of played Poker Hand as {C:mult}+Mult{}",
			},
			may.add_fusion_text('Universal Collapse', 'Cosmos', may.get_condition('cosmos'))
		}
	},
	config = { extra = { mul = 3 } },
	pos = { x = 0, y = 3 },
	cost = 5,
	rarity = 2,
	unlocked = true,
	demicoloncompat = true,
	discovered = true,
	blueprint_compat = true,
	atlas = 'joker1',
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.mul } }
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				colour = G.C.MULT,
				mult = G.GAME.hands[context.scoring_name].level * card.ability.extra.mul,
				card = card,			
			}
		end
	end
}

SMODS.Joker {
	key = 'mana_orb',
	loc_txt = {
		name = 'Mana Orb',
		text = {
			{
				"{C:green}#1# in #2#{} chance to",
				"apply {C:attention}random{} {C:dark_edition}Enhancements{} to",
				"all {C:attention}played cards before scoring{}", 
                "{C:inactive}Doesn't override existing Enhancements{}"
			},
			may.add_fusion_text('Hierarchy', 'Wizard University', may.get_condition('wizard_university')) 
		}
	},
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 3, y = 2 },
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	cost = 4,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and pseudorandom('may_mana_orb') < G.GAME.probabilities.normal / card.ability.extra.odds then
			local enhance = {}
			for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
				if v.key ~= 'm_stone' then
					table.insert(enhance, v)
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.name == 'c_base' then
					v:set_ability(pseudorandom_element(enhance, pseudoseed('may_mana_orb')), nil, true)
				end
			end
			return {
				card = card,
				message = "Enhancements!",
				sound = 'holo1', 
				colour = G.C.DARK_EDITION
			}
		end
		if context.forcetrigger then
			local enhance = {}
			for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
				if v.key ~= 'm_stone' then
					table.insert(enhance, v)
				end
			end
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability(pseudorandom_element(enhance, pseudoseed('may_mana_orb')), nil, true)
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
			return {
				card = card,
				message = "Enhancements!",
				colour = G.C.DARK_EDITION
			}
		end
	end
}

SMODS.Joker {
	key = 'kids_drawing',
	loc_txt = {
		name = "Kid's Drawing",
		text = {
			"When {C:attention}Blind{} is {C:attention}selected{},",
			"this Joker creates {C:attention}#1#{} random {C:attention}playing cards{}",
			"and shuffles them into your {C:attention}deck{}",
			"{C:inactive}(May have an Enhancement, Seal and/or Edition){}"
		}
	},
	config = { extra = { amount = 4 } },
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.amount } }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and context.cardarea == G.jokers) or (context.setting_blind and context.cardarea == G.jokers and context.blueprint) then
			local created_cards = {}
			for i=1, card.ability.extra.amount, 1 do
				local card = create_playing_card(nil, G.play, nil, i == 1, {G.C.IMPORTANT})
				table.insert(created_cards, card)
			end
			delay(0.5)
			may.randomise(created_cards)
			delay(0.5)
			for k, v in ipairs(created_cards) do
				G.E_MANAGER:add_event(Event({delay = 0.2, timer = 'REAL', func = function()
					play_sound('card1')
					v:add_to_deck()
					G.play:remove_card(v)
					G.deck:emplace(v)
				return true end}))
			end
		end
		if context.forcetrigger then
			local created_cards = {}
			for i=1, card.ability.extra.amount, 1 do
				local card = create_playing_card(nil, G.pack_cards, nil, i == 1, {G.C.IMPORTANT})
				table.insert(created_cards, card)
			end
			delay(0.5)
			may.randomise(created_cards)
			delay(0.5)
			for k, v in ipairs(created_cards) do
				G.E_MANAGER:add_event(Event({delay = 0.2, timer = 'REAL', func = function()
					play_sound('card1')
					v:add_to_deck()
					G.pack_cards:remove_card(v)
					G.deck:emplace(v)
				return true end}))
			end
		end
	end
}

--[[SMODS.Joker {
	key = 'navigation',
	loc_txt = {
		name = {"Navigation", "{C:dark_edition,s:0.6}N Joker{}"},
		text = {
			"When Blind is {C:attention}skipped{}",
			"this Joker creates {C:attention}3{} {C:dark_edition}Negative Sly Jokers{}",
			"and {C:mult}self destructs{}",
			"{C:mult}Self destructs{} in {C:attention}#1# rounds{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	n_joker = true,
	pools = { N = true },
	pos = { x = 2, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
    immutable = true, 
	cost = 6,
	config = { extra = { rounds = 3 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
		if context.skip_blind and context.cardarea == G.jokers then
			for i=1, 3, 1 do
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({negative = true}, false, false)
			end
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
					return true end})) 
			return true end}))
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds < 1 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
                    play_sound('tarot1')
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
			end
			return {
				message = card.ability.extra.rounds.." rounds left",
				card = card
			}
		end
		if context.forcetrigger then
			for i=1, 3, 1 do
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_n')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				card2:set_edition({negative = true}, false, false)
			end
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
					return true end})) 
			return true end}))
		end
	end
}]] 

SMODS.Joker {
	key = 'wheel_of_eternity',
	loc_txt = {
		name = 'Wheel of Eternity',
		text = {
			{
				"{C:green}#1# in #2#{} chance to create", 
                "a {C:attention}copy{} of {C:tarot}The Wheel of Fortune{}", 
                "when {C:tarot}The Wheel of Fortune{} is {C:attention}used{}",
                "{C:inactive}(Does not require room){}"
			},
			may.add_fusion_text('man', 'Diskus', may.get_condition('diskus')),
			{
				"{C:inactive,E:1}Idea by _TeKKen_{}",
			},
		}
	},
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 5 },
	cost = 8,
	config = { extra = { odds = 2, } },
	loc_vars = function(self, info_queue, card)
        local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Wheel of Eternity")
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = { normal, odds } }
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable and context.consumeable:gc().key == 'c_wheel_of_fortune' then
            if SMODS.pseudorandom_probability(card, "may_wheel_of_eternity", 1, card.ability.extra.odds, "Wheel of Eternity") then 
                G.E_MANAGER:add_event(Event({ func = function()
				    card:juice_up(0.5, 0.5)
				    local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				    G.consumeables:emplace(wheel)
				    wheel:add_to_deck()
                    play_sound('timpani')
			    return true end}))
            end 
        end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({ func = function()
				card:juice_up(0.5, 0.5)
				local wheel = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', nil)
				G.consumeables:emplace(wheel)
				wheel:add_to_deck()
                play_sound('timpani')
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'zodiac',
	loc_txt = {
		name = 'Zodiac',
		text = {
            {
			    "{C:green}#1# in #2#{} chance to", 
                "{C:planet}level up{} {C:attention}most played{}", 
                "{C:purple}Poker Hand{} by {C:attention}#3#{}", 
                "when a {C:tarot}Tarot Card{} is {C:attention}used{}", 
                "{C:inactive}#4#{}", 
				"{C:inactive}Level-ups are silent{}"
            },
            may.add_fusion_text('World Destroyer', 'Astral Expunger', may.get_condition('astral_expunger')), 
			{
				"{C:inactive,E:1}Art by s_n_i_p_e_r.{}"
			} 
		}
	},
	config = { extra = { odds = 3, level = 1 } },
	loc_vars = function(self, info_queue, card)
        local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Zodiac")
		return { vars = { normal, odds, card.ability.extra.level, may.favhand() } }
	end,
	rarity = 2,
	atlas = 'joker2',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 6, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if (context.using_consumeable and context.consumeable:gc().set == 'Tarot' and SMODS.pseudorandom_probability(card, "may_zodiac", 1, card.ability.extra.odds, "Zodiac")) or context.forcetrigger then 
            may.th(may.favhand())
            level_up_hand(card, may.favhand(), true, card.ability.extra.level)
            may.ch()
        end
	end
}

SMODS.Joker {
	key = 'cement_joker',
	loc_txt = {
		name = 'Cement Joker',
		text = {
			{
			    "{C:planet}Deimos{} {C:green}no longer{}", 
                "{C:mult}destroys{} cards when used", 
				may.pager(),
                "{C:green}#1# in #2#{} chance to create", 
                "a {C:attention}copy{} of {C:planet}Deimos{}", 
                "when {C:attention}Blind{} is {C:attention}selected{}",
				may.pager(),
                "{C:inactive}(Requires room){}"
			},
			may.add_fusion_text('Bismuth Joker', 'Rocco Pfilosofia', may.get_condition('rocco_pfilosofia')),
			{
				"{C:inactive,E:1}Art by s_n_i_p_e_r.{}"
			}
		}
	},
	config = { extra = { odds = 3 } },
	rarity = 2,
	atlas = 'joker2',
	pos = { x = 5, y = 4 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_may_deimos
        local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Cement Joker")
		return { vars = { normal, odds } }
	end,
	calculate = function(self, card, context)
		if (context.setting_blind and SMODS.pseudorandom_probability(card, "may_cement_joker", 1, card.ability.extra.odds, "Cement Joker")) or context.forcetrigger then
            if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    play_sound('timpani')
				    local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, 'c_may_deimos', 'may_cement_joker')
				    card2:add_to_deck()
				    G.consumeables:emplace(card2)
				    card2:juice_up(0.3, 0.5)
			    return true end}))
                return {
                    message = "+Deimos", 
                    colour = G.C.SECONDARY_SET.Planet,
                    card = card,
                }
            end
		end
	end
}

SMODS.Joker {
	key = 'granite_joker',
	loc_txt = {
		name = 'Granite Joker',
		text = {
            {
                "When a {C:dark_edition}Stone Card{} is", 
                "{C:mult}destroyed{}, all {C:attention}other{}", 
                "{C:dark_edition}Stone Cards{} in full deck", 
                "gain {X:chips,C:white}+X#1#{} Chips"
            }, 
            may.add_fusion_text('Marble Joker', 'Bedrock Joker', may.get_condition('bedrock_joker')),
			{
				"{C:inactive,E:1}Art by s_n_i_p_e_r.{}"
			},
		}
	},
	config = { extra = { x_chips = 0.2 } },
	rarity = 2,
	atlas = 'joker2',
	pos = { x = 4, y = 5 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.x_chips } }
	end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.cardarea == G.jokers then 
            local amount = 0
            for k, v in pairs(context.removed) do 
                if SMODS.has_enhancement(v, 'm_stone') then
                    amount = amount + 1
                end 
            end 
            if amount > 0 then 
                for k, v in pairs(G.playing_cards) do
                    if SMODS.has_enhancement(v, 'm_stone') and not table_hasvalue(context.removed, v) then 
                        v.ability.perma_x_chips = (v.ability.perma_x_chips or 0) + (card.ability.extra.x_chips * amount)
                        if v.area ~= G.discard and v.area ~= G.deck then
                            card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus'})
                        end 
                    end 
                end 
                return {
                    message = '+X'..(card.ability.extra.x_chips * amount)..' Chips', 
                    colour = G.C.CHIPS, 
                    card = card, 
                }
            end
        end
	end
}

SMODS.Joker {
	key = 'free_sample',
	loc_txt = {
		name = 'Free Sample',
		text = {
			"When {C:attention}Boss Blind{} is defeated,",
			"redeem a {C:green}random{} {C:green}Voucher{}",
			"{C:mult}Self destructs{}"
		}
	},
	rarity = 2,
	atlas = 'joker1',
	pos = { x = 3, y = 0 },
	blueprint_compat = false,
	demicoloncompat = true,
	cost = 4,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not (context.individual and context.cardarea == G.play) and G.GAME.blind.boss and not card.gone then
			delay(0.5)
			may.voucher()
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
				return true end})) 
			return true end}))
		end
		if context.forcetrigger then
			delay(0.5)
			may.voucher()
			G.E_MANAGER:add_event(Event({func = function()
				self = card
				play_sound('tarot1')
				self:juice_up(0.3, 0.4)
				self.states.drag.is = true
				self.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
					G.jokers:remove_card(self)
					self:remove()
					self = nil
				return true end})) 
			return true end}))
		end
	end
}

SMODS.Joker {
	key = 'gemstone',
	loc_txt = {
    	name = 'Gemstone',
    	text = {
			"{C:attention}Glass Cards{} give {X:chips,C:white}X#1#{} Chips",
			"when scored"
		}
	},
	config = { extra = { Xchips = 1.35 } },
	rarity = 2,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 4, y = 0 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xchips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_glass') then
				return {
					xchips = card.ability.extra.Xchips,
					colour = G.C.CHIPS,
					message_card = context.other_card,
				}
			end
		end
	end
}