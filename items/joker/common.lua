-- Common Jokers
	
SMODS.Joker {
	key = 'hierarchy',
	loc_txt = {
		name = 'Hierarchy',
		text = {
			{
				"{C:attention}Gains{} {C:chips}+#1#{} Chips when a {C:attention}playing card{}",
				"with any {C:attention}Enhancement, Edition or Seal{} is {C:attention}scored{}",
				"{C:inactive}Currently {C:chips}+#2#{} {C:inactive}Chips{}"
			},
			may.add_fusion_text('Mana Orb', 'Wizard University', may.get_condition('wizard_university')) 
		}
	},
	config = { extra = { chips_gain = 5, chips = 0 } },
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 5, y = 0 },
	blueprint_compat = true,
	cost = 3,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card.config.center ~= G.P_CENTERS.c_base or context.other_card.edition or context.other_card.ability.seal then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
				return {
					colour = G.C.CHIPS,
					message_card = card,
					message = "Upgraded!"
				}
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				message_card = card,
				colour = G.C.CHIPS,
				message = '+'.. card.ability.extra.chips .. ' Chips',
			}
		end
		if context.forcetrigger then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			return {
				colour = G.C.CHIPS,
				message_card = card,
				message = "Upgraded!"
			}
		end
	end
}

SMODS.Joker {
	key = 'fading_joker',
	loc_txt = {
		name = 'Fading Joker',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
			"{C:mult}Self destructs{} after {C:attention}#2#{} rounds"
		}
	},
	config = { extra = { Xmult = 3, rounds = 3 } },
	rarity = 1,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.rounds} }
	end,
	atlas = 'joker1',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 2, y = 0 },
	cost = 4,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				card = card,
				colour = G.C.RED,
				message = 'X'.. card.ability.extra.Xmult .. ' Mult',
            }
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
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
				return {
					message = 'Faded!',
					card = card
				}
			end
			return {
				message = card.ability.extra.rounds.."/3",
				card = card
			}
		end
		-- we do a little trolling
		if context.forcetrigger then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds < 1 then
				G.E_MANAGER:add_event(Event({func = function()
					self = card
                    play_sound('tarot1')
					message = "Faded!"
					self:juice_up(0.3, 0.4)
					self.states.drag.is = true
					self.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false, func = function()
						G.jokers:remove_card(self)
						self:remove()
						self = nil
					return true end})) 
				return true end}))
				return {
					message = 'Faded!',
					card = card
				}
			end
			return {
				message = card.ability.extra.rounds.."/3",
				card = card
			}
		end
    end
}

SMODS.Joker {
	key = 'dead_pixel',
	loc_txt = {
		name = 'Dead Pixel',
		text = {
			"{C:mult}+#1#{} Mult",
			"{C:green}#2# in #3#{} chance for {X:mult,C:white}X#4#{} Mult"
		}
	},
	config = { extra = { mult = 25, odds = 4, Xmult = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.Xmult} }
	end,
	rarity = 1,
	atlas = 'joker1',
	blueprint_compat = true,
	pos = { x = 2, y = 7 },
	demicoloncompat = true,
	cost = 4,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if pseudorandom('may_dead_pixel') < 1 / card.ability.extra.odds then	
				return {
					Xmult_mod = card.ability.extra.Xmult,
					message = "X"..card.ability.extra.Xmult.." Mult",
					colour = G.C.MULT
				}
			else
				return {
					mult_mod = card.ability.extra.mult,
					message = "+"..card.ability.extra.mult.." Mult",
					colour = G.C.MULT
				}
			end
		end
		if context.forcetrigger then
			-- we do a little trolling part 2
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = "X"..card.ability.extra.Xmult.." Mult",
				colour = G.C.MULT
			}
		end
	end
}

SMODS.Joker {
	key = 'illusion',
	loc_txt = {
		name = 'Illusion',
		text = {
			{
                "{C:attention}Before scoring{}, {C:green}#1# in #2#{}", 
                "chance to gain the {C:may_ethereal}Level{} {C:mult}Mult{}", 
                "of played {C:purple}Poker Hand{} as {C:mult}+Mult{}", 
                "{C:inactive}Currently{} {C:mult}+#3#{} {C:inactive}Mult{}"
            }, 
            {
			    "{C:inactive,E:1}Art by _TeKKen_{}"
            }
		}
	},
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 0, y = 16 },
    config = { extra = { odds = 2, mult = 0, temp_scale = 0 } }, 
	blueprint_compat = true,
	cost = 5,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
        local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Illusion")
        return { vars = { normal, odds, card.ability.extra.mult } }
	end, 
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            if SMODS.pseudorandom_probability(card, "may_illusion", 1, card.ability.extra.odds, "Illusion") then 
                card.ability.extra.temp_scale = G.GAME.hands[context.scoring_name].l_mult
                SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "temp_scale",
                    scaling_message = {
                        message = 'Upgraded! (+'..card.ability.extra.temp_scale..')',
                        colour = G.C.MULT
                    }
				})
            end
        end
        if (context.joker_main or context.forcetrigger) and to_big(card.ability.extra.mult) > to_big(0) then 
            return {
                mult = card.ability.extra.mult, 
                card = card,
            }
        end
    end
}

--[[SMODS.Joker {
	key = 'sly_n',
	loc_txt = {
		name = {"Sly N", "{C:dark_edition,s:0.6}N Joker"},
		text = {
            {
			    "All {C:dark_edition}N{} Jokers give {C:chips}+#1#{} Chips",
			    "if played {C:attention}hand{} is {C:attention}Three of a Kind{}",
			    "{C:attention}Additional{} {C:chips}+#2#{} Chips for {C:attention}every{} {C:dark_edition}Sly Joker{}",
			    "{C:chips}+#3#{} {C:inactive}in total{}",
            }, 
            {
			    "{C:inactive,E:1}Art & idea by _TeKKen_{}"
            }
		}
	},
	rarity = 1,
	atlas = 'joker1',
	n_joker = true,
	pos = { x = 0, y = 9 },
	blueprint_compat = true,
	demicoloncompat = true,
	pools = { N = true },
	cost = 4,
	config = { extra = { base_chips = 20, bonus_chips = 20, total_chips = 0} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['j_sly']
		return { vars = { card.ability.extra.base_chips, card.ability.extra.bonus_chips, card.ability.extra.total_chips } }
	end,
	calculate = function(self, card, context)
		if context.other_joker then
			if may.is_n(context.other_joker) then
				if G.GAME.current_round.current_hand.handname == localize("Three of a Kind", 'poker_hands') then
					return {
						chips = card.ability.extra.total_chips,
						card = card,
						message = "+"..card.ability.extra.total_chips,
						colour = G.C.CHIPS
					}
				end
			end
		end
		if context.forcetrigger then
			return {
				chips = card.ability.extra.total_chips,
				card = card,
				message = "+"..card.ability.extra.total_chips,
				colour = G.C.CHIPS
			}
		end
	end,
	update = function(self, card, dt)
		if G.GAME.blind then
			local sly_jokers = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_sly' then
					sly_jokers = sly_jokers + 1
				end
			end
			card.ability.extra.total_chips = (sly_jokers * card.ability.extra.bonus_chips) + card.ability.extra.base_chips
		end
	end
}

SMODS.Joker {
	key = 'noble_gas',
	loc_txt = {
		name = {'Noble Gas', '{C:dark_edition,s:0.7}N Joker{}'},
		text = {
            {
                "When {C:attention}Blind{} is {C:attention}selected{},", 
                "create a {C:dark_edition}Sly Joker{} if the", 
                "{C:attention}number{} of owned {C:dark_edition}Sly Jokers{}", 
                "is {C:attention}uneven or 0{}",
                "{C:inactive}(#1#, requires room){}"
            }, 
			{
			    "{C:inactive,E:1}Original art by _TeKKen_{}", 
				"{C:inactive,E:1}Improved art by @daunas123{}", 
            }
		}
	},
	rarity = 1,
	atlas = 'joker1',
	pos = { x = 4, y = 10 },
	blueprint_compat = false,
	n_joker = true,
	pools = { N = true },
	cost = 4,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
        local amount = 0
        if G.jokers then 
            for k, v in pairs(G.jokers.cards) do
                if v:gc().key == 'j_sly' then 
                    amount = amount + 1
                end
            end
        end
		return { vars = { (amount % 2 ~= 0 or amount == 0) and 'Active!' or 'Inactive' } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.cardarea == G.jokers then 
            local amount = 0
            for k, v in pairs(G.jokers.cards) do
                if v:gc().key == 'j_sly' then 
                    amount = amount + 1
                end
            end
            if amount % 2 ~= 0 or amount == 0 then 
                G.E_MANAGER:add_event(Event({func = function()
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
						local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sly', 'may_noble_gas')
						G.jokers:emplace(card2)
						card2:add_to_deck()
					end
				return true end})) 
            end
        end
	end
}]] 