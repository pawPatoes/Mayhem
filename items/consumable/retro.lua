-- Retro cards 

AllowBulkUse('retrocards')

SMODS.Consumable {
	key = 'easter_egg',
	config = { extra = { jokers = 1 } },
	loc_txt = {
		name = 'EASTER_EGG',
		text = {
			"Create {C:attention}#1# random{} {X:mult,C:white}Rare{} {C:attention}Joker{}",
			"for {C:attention}every{} {C:money}Yotta Card{} you have {C:attention}used{} this run",
			"{C:inactive}Will create #2# Jokers, requires room{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 0 },
    display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and #G.jokers.cards < G.jokers.config.card_limit and card.ability.extra.jokers * may.ctu('yottacards') ~= 0
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.jokers, card.ability.extra.jokers * may.ctu('yottacards') } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.extra.jokers * may.ctu('yottacards'), G.jokers.config.card_limit - #G.jokers.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.jokers.config.card_limit > #G.jokers.cards then
					play_sound('timpani')
					local card2 = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'may_easter_egg')
					card2:add_to_deck()
					G.jokers:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for j = 1, number, 1 do
			for i = 1, math.min(card.ability.extra.jokers * may.ctu('yottacards'), G.jokers.config.card_limit - #G.jokers.cards) do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if G.jokers.config.card_limit > #G.jokers.cards then
						play_sound('timpani')
						local card2 = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'may_easter_egg')
						card2:add_to_deck()
						G.jokers:emplace(card2)
						card:juice_up(0.3, 0.5)
					end
				return true end}))
			end
		end
	end
}

SMODS.Consumable {
	key = '1_up',
	config = { extra = { dollars = 2 } },
	loc_txt = {
		name = '1-UP',
		text = {
			"{C:money}+$#1#{} for {C:attention}every{} {C:spectral}Spectral Card{}",
			"you have {C:attention}used{} this run",
			"{C:inactive}Will give $#2#{}"
		}
	},
	set = 'retrocards',
	pos = { x = 2, y = 0 },
    display_size = { w = 71, h = 71 },  
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * may.ctu('Spectral') } }
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars * may.ctu('Spectral'))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            play_sound('timpani')
        return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		ease_dollars(number * card.ability.extra.dollars * may.ctu('Spectral'))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            play_sound('timpani')
        return true end}))
	end
}

SMODS.Consumable {
	key = 'lootbox',
	config = { extra = { voucher_count = 12, voucher_gain = 1 } },
	loc_txt = {
		name = 'LOOTBOX',
		text = {
			"For {C:attention}every #1#{} {C:green}Vouchers{} redeemed,",
			"{C:attention}redeem #2# random{} {C:green}Voucher{}",
			"{C:inactive}Will redeem #3# Vouchers{}"
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 1 },
    display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and #(G.vouchers.cards or {}) >= card.ability.extra.voucher_count
	end,
	loc_vars = function(self, info_queue, card)
		if G.vouchers then
			return { vars = { card.ability.extra.voucher_count, card.ability.extra.voucher_gain, 
			math.floor(#(G.vouchers.cards or {}) / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain } }
		else
			return { vars = { card.ability.extra.voucher_count, card.ability.extra.voucher_gain, 0} }
		end
	end,
	use = function(self, card, area, copier)
		may.massvoucher(nil, to_number(math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain))
	end,
	bulk_use = function(self, card, area, copier, number)
		may.massvoucher(nil, to_number(math.floor(#G.vouchers.cards / card.ability.extra.voucher_count) * card.ability.extra.voucher_gain) * number)
	end
}

SMODS.Consumable {
	key = 'upgrade',
	config = { extra = { editioncards = 1, planetcards = 40, } },
	loc_txt = {
		name = 'UPGRADE',
		text = {
			"Create {C:attention}#1# random{} {C:dark_edition}Modifier Card{}",
			"for {C:attention}every #2#{} {C:planet}Planet Cards{}", 
			"you have {C:attention}used{} this run",
			"{C:inactive}Will create #3# Modifier Cards, requires room{}"
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 2 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('Planet') >= card.ability.extra.planetcards
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.editioncards, card.ability.extra.planetcards, math.floor(may.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(math.floor(may.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, 'may_upgrade')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.min(math.floor(may.ctu('Planet') / card.ability.extra.planetcards) * card.ability.extra.editioncards * number, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound('timpani')
					local card2 = create_card('editioncards', G.consumeables, nil, nil, nil, nil, nil, 'may_upgrade')
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					card:juice_up(0.3, 0.5)
				end
			return true end}))
		end
	end
}

--[[SMODS.Consumable {
	key = 'savescum',
	config = { extra = { copies = 1, consumables = 35, } },
	loc_txt = {
		name = 'SAVESCUM',
		text = {
			"Create {C:attention}#1#{} {C:dark_edition}Negative{} copy of",
            "the {C:attention}last consumable{} {C:money}sold{} this run", 
            "with {C:mult}$0{} {C:money}sell value{}", 
			"for {C:attention}every #2#{} {C:attention}consumables{} {C:attention}used{} this run",
			"{C:inactive}Will create #3# copies, sell cost is{}", 
            "{C:inactive}increased by Negative Edition, SAVESCUM excluded{}"
		}
	},
	set = 'retrocards',
	pos = { x = 3, y = 1 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and G.GAME.may_last_consumable_sold and (G.GAME.may_last_consumable_sold ~= 'c_may_savescum')
	end,
	loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.may_last_consumable_sold and G.P_CENTERS[G.GAME.may_last_consumable_sold] or nil
        local may_last_consumable_sold = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
        local colour = ((not fool_c) or G.GAME.may_last_consumable_sold == 'c_may_savescum') and G.C.RED or G.C.SECONDARY_SET.retrocards
        if fool_c and may_last_consumable_sold ~= 'c_may_savescum' then
            info_queue[#info_queue + 1] = fool_c
        end
        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. may_last_consumable_sold .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }
		return { vars = { card.ability.extra.copies, card.ability.extra.consumables, math.floor(may.ctu() / card.ability.extra.consumables) * card.ability.extra.copies }, main_end = main_end }
	end,
	use = function(self, card, area, copier)
	    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local card2 = create_card(G.P_CENTERS[G.GAME.may_last_consumable_sold].set, G.consumeables, nil, nil, nil, nil, G.GAME.may_last_consumable_sold, 'may_savescum')
			card2:add_to_deck()
			G.consumeables:emplace(card2)
            card2:set_edition('e_negative')
            card2.sell_cost = 0
            card2:setQty(math.floor(may.ctu() / card.ability.extra.consumables) * card.ability.extra.copies)
			card:juice_up(0.3, 0.5)
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			local card2 = create_card(G.P_CENTERS[G.GAME.may_last_consumable_sold].set, G.consumeables, nil, nil, nil, nil, G.GAME.may_last_consumable_sold, 'may_savescum')
			card2:add_to_deck()
			G.consumeables:emplace(card2)
            card2:set_edition('e_negative')
            card2.sell_cost = 0
            card2:setQty(math.floor(may.ctu() / card.ability.extra.consumables) * card.ability.extra.copies)
			card:juice_up(0.3, 0.5)
		return true end}))
	end
}]] 

SMODS.Consumable {
	key = 'gamble',
	config = { extra = { wheels = 4, chips = 42, odds = 4 } },
	loc_txt = {
		name = 'GAMBLE',
		text = {
            "{C:green}#1# in #2#{} chance to", 
            "give all {C:purple}Poker Hands{} {C:chips}+#3#{} Chips",
			"for {C:attention}every #4#{} copies of", 
            "{C:tarot}The Wheel of Fortune{} used this run,",
			"{C:inactive}Will give +#5# Chips{}"
		}
	},
	set = 'retrocards',
	pos = { x = 3, y = 0 },
    display_size = { w = 71, h = 71 }, 
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.cu('c_wheel_of_fortune') >= card.ability.extra.wheels
	end,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		local normal, odds = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "GAMBLE")
        return { vars = { normal, odds, card.ability.extra.chips, card.ability.extra.wheels, math.floor(may.cu('c_wheel_of_fortune') / card.ability.extra.wheels) * card.ability.extra.chips } }
	end,
	use = function(self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "may_gamble", G.GAME.probabilities.normal, card.ability.extra.odds, "GAMBLE") then 
            may.hand_mod_multchips_all('chips', -1, math.floor(may.cu('c_wheel_of_fortune') / card.ability.extra.wheels) * card.ability.extra.chips, false, card)
        else 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.retrocards,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                    silent = true
                })
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end}))
        end
	end,
	bulk_use = function(self, card, area, copier, number)
        local amount = 0
		for i=1, number do
            if SMODS.pseudorandom_probability(card, "may_gamble", G.GAME.probabilities.normal, card.ability.extra.odds, "GAMBLE") then 
                amount = amount + 1
            end 
        end 
        if amount > 0 then 
            may.hand_mod_multchips_all('chips', -1, math.floor(may.cu('c_wheel_of_fortune') / card.ability.extra.wheels) * card.ability.extra.chips * amount, false, card)
        else 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.retrocards,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                    silent = true
                })
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end}))
        end
	end
}

SMODS.Consumable {
	key = 'glitch',
	config = { extra = { retrocards = 7, cards = 1 } },
	loc_txt = {
		name = 'G{s:1.3}LIT{}CH{s:0.7}HH{}{s:1.3}CH{}',
		text = {
			"Create {C:attention}#1# random{} playing card",
            "with {C:dark_edition}ERROR Seal{} and shuffle it into your deck", 
			"for {C:attention}every #2#{} {C:retrocards}Retro Cards{}", 
			"you have {C:attention}used{} this run",
			"{C:inactive}Will create #3# cards{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 1 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and may.ctu('retrocards') >= card.ability.extra.retrocards
	end,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.may_error_seal
		return { vars = { card.ability.extra.cards, card.ability.extra.retrocards, math.floor(may.ctu('retrocards') / card.ability.extra.retrocards) * card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
        local created = {}
		for i = 1, math.floor(may.ctu('retrocards') / card.ability.extra.retrocards) * card.ability.extra.cards do
            local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.retrocards})
            table.insert(created, new)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('card1')
                card:juice_up(0.3, 0.5)
			return true end}))
		end
        for k, v in pairs(created) do
            v:set_seal('may_error_seal', false, false)
        end
        for k, v in pairs(created) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play:remove_card(v)
                v:add_to_deck()
                G.deck:emplace(v)
                play_sound('card1')
            return true end})) 
        end
	end,
	bulk_use = function(self, card, area, copier, number)
		local created = {}
		for i = 1, math.floor((may.ctu('retrocards') + number) / card.ability.extra.retrocards) * card.ability.extra.cards do
            local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.retrocards}) 
            table.insert(created, new)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('card1')
                card:juice_up(0.3, 0.5)
			return true end}))
		end
        for k, v in pairs(created) do
            v:set_seal('may_error_seal', false, false)
        end
        for k, v in pairs(created) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play:remove_card(v)
                v:add_to_deck()
                G.deck:emplace(v)
                play_sound('card1')
            return true end})) 
        end
	end
}

SMODS.Consumable {
	key = 'wrong_warp',
	config = { extra = { skips = 2, tags = 1, } },
	loc_txt = {
		name = 'WRONG_WARP',
		text = {
			"Create {C:attention}#1# random Tag{}",
			"for {C:attention}every #2#{} {C:attention}Blinds{}", 
			"you have {C:attention}skipped{} this run",
			"{C:inactive}Will create #3# Tags{}"
		}
	},
	set = 'retrocards',
	pos = { x = 1, y = 2 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and G.GAME.skips >= card.ability.extra.skips
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.tags, card.ability.extra.skips, math.floor(G.GAME.skips / card.ability.extra.skips) * card.ability.extra.tags } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.floor(G.GAME.skips / card.ability.extra.skips) * card.ability.extra.tags do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				may.random_tag()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		for i = 1, math.floor(G.GAME.skips / card.ability.extra.skips) * card.ability.extra.tags * number do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				may.random_tag()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'out_of_bounds',
	config = { extra = { sold = 20, slots = 1, } },
	loc_txt = {
		name = 'OUT_OF_BOUNDS',
		text = {
			"{C:green}+#1#{} {C:attention}Joker Slot{}",
			"for {C:attention}every #2#{} {C:attention}Jokers{}", 
			"you have {C:money}sold{} this run",
			"{C:inactive}Will give #3# Joker Slots{}"
		}
	},
	set = 'retrocards',
	pos = { x = 2, y = 1 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and (G.GAME.may_jokers_sold or 0) >= card.ability.extra.sold
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.slots, card.ability.extra.sold, math.floor((G.GAME.may_jokers_sold or 0) / card.ability.extra.sold) * card.ability.extra.slots } }
	end,
	use = function(self, card, area, copier)
		G.jokers:change_size(math.floor((G.GAME.may_jokers_sold or 0) / card.ability.extra.sold) * card.ability.extra.slots)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            card:juice_up(0.3, 0.5)
        return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.jokers:change_size(math.floor((G.GAME.may_jokers_sold or 0) / card.ability.extra.sold) * card.ability.extra.slots * number)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            card:juice_up(0.3, 0.5)
        return true end}))
	end
}

SMODS.Consumable {
	key = 'bossfight',
	config = { extra = { defeat = 5, tags = 1, } },
	loc_txt = {
		name = 'BOSSFIGHT',
		text = {
			"Gain {C:attention}#1# Ethereal Tag{}",
			"for every {C:attention}#2# Boss Blinds{}",
			"{C:green}defeated{} this run",
			"{C:inactive}Will give #3# Ethereal Tags{}"
		}
	},
	set = 'retrocards',
	pos = { x = 0, y = 0 },
    display_size = { w = 71, h = 71 },
	cost = 4,
	unlocked = true,
	discovered = true,
	atlas = 'retro',
	can_use = function(self, card)
		return may.canuse() and (G.GAME.may_bosses_defeated or 0) >= card.ability.extra.defeat
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
		return { vars = { card.ability.extra.tags, card.ability.extra.defeat, math.floor((G.GAME.may_bosses_defeated or 0) / card.ability.extra.defeat) * card.ability.extra.tags } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
			for i = 1, math.floor((G.GAME.may_bosses_defeated or 0) / card.ability.extra.defeat) * card.ability.extra.tags do 
				add_tag(Tag('tag_ethereal')) 
			end
		return true end}))
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
			for i = 1, math.floor((G.GAME.may_bosses_defeated or 0) / card.ability.extra.defeat) * card.ability.extra.tags * number do 
				add_tag(Tag('tag_ethereal')) 
			end
		return true end}))
	end
}