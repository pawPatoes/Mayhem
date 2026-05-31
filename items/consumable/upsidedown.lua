-- Upside Down Consumables

AllowBulkUse('upside_down_planets')

-- Upside Down Tarots

SMODS.Consumable {
	key = 'fool_upsd',
	set = 'upside_down_tarots',
	name = 'ThT FooF',
	loc_txt = {
		name = 'ThT FooF',
		text = {
			{
				"{C:mult}Destroy{} all owned {C:attention}copies{} of most",
				"{C:attention}recently used{} {C:tarot}Tarot Card{}",
				"{C:money}+$#1#{} {C:attention}per{} destroyed {C:attention}card{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 9, y = 5 },
	config = { extra = { dollars = 10 } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().key == G.GAME.last_tarot then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().key == G.GAME.last_tarot then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
					v:start_dissolve()
					v = nil
					card:juice_up()
					play_sound('timpani')
				return true end}))
                ease_dollars(card.ability.extra.dollars) 
			end
		end
	end,
}

SMODS.Consumable {
	key = 'magician_upsd',
	set = 'upside_down_tarots',
	name = 'ThT MagiigaM',
	loc_txt = {
		name = 'ThT MagiigaM',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Lucky{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {C:money}+$#1#{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 8, y = 5 },
	config = { extra = { dollars = 3, target_enhancement = 'm_lucky' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_p_dollars = (targets[i].ability.perma_p_dollars or 0) + card.ability.extra.dollars
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'high_priestess_upsd',
	set = 'upside_down_tarots',
	name = 'ThT HiiH PrieseirP',
	loc_txt = {
		name = 'ThT HiiH PrieseirP',
		text = {
			{
				"{C:mult}Destroy{} all {C:dark_edition}CCDs{} held", 
                "in hand", 
                "Create {C:attention}#1#{} {C:dark_edition}Negative{} Consumable", 
                "of the {C:attention}same type{} for each", 
                "{C:mult}destroyed{} card"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 7, y = 5 },
	atlas = 'upside_down',
    config = { extra = { cards = 1 } }, 
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_ccd_tutorial", set = "Other" }
        info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
            if v.ability.consumeable then 
                return may.canuse()
            end
        end 
        return false
	end,
	use = function(self, card, area, copier)
		local consumables = {}
        local targets = {}
        for k, v in pairs(G.hand.cards) do
            if v.ability.consumeable then 
                table.insert(targets, v)
                table.insert(consumables, G.P_CENTERS[v2].set)
            end
        end
        for k, v in pairs(targets) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                v:start_dissolve()
                play_sound('card3')
            return true end})) 
        end 
        for k, v in pairs(consumables) do
            for i=1, card.ability.extra.cards do 
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                    local card2 = create_card(v, G.consumeables, nil, nil, nil, nil, nil, 'may_high_priestess_upsd')
				    card2:set_edition({negative = true}, true)
				    card2:add_to_deck()
				    G.consumeables:emplace(card2)
                return true end})) 
            end
        end
	end,
}

SMODS.Consumable {
	key = 'empress_upsd',
	set = 'upside_down_tarots',
	name = 'ThT EmprpmE',
	loc_txt = {
		name = 'ThT EmprpmE',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Mult{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {X:chips,C:white}+X#1#{} Chips"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 6, y = 5 },
	config = { extra = { bonus = 0.3, target_enhancement = 'm_mult' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_x_chips = (targets[i].ability.perma_x_chips or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'emperor_upsd',
	set = 'upside_down_tarots',
	name = 'ThT EmpepmE',
	loc_txt = {
		name = 'ThT EmpepmE',
		text = {
			{
				"{C:mult}Destroy{} all owned {C:tarot}Tarot Cards{}",
				"and create {C:attention}random{} {C:dark_edition}Negative{} {C:planet}Planet{}",
				"{C:dark_edition}CCDs{} {C:attention}in their place{}",
				"which are shuffled into your deck",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 5, y = 5 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_ccd_tutorial", set = "Other" }
		return { vars = {} }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Tarot' then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local count = 0
		for k, v in pairs(G.consumeables.cards) do
			if v:gc().set == 'Tarot' then
				count = count + v:getQty()
				G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
					v:juice_up()
					v:start_dissolve()
					v = nil
					card:juice_up()
					play_sound('timpani')
				return true end}))
			end
		end
		for i=1, count, 1 do
			local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
			G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
				new:juice_up()
				play_sound('card1')
				play_sound('tarot1')
				new:set_edition({negative=true}, true)
			return true end}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for k, v in pairs(G.play.cards) do
			local percent = 1.15 - (k - 0.999) / (#G.play.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(G.play.cards) do
			v:set_ability(may.random_consumable('may_emperor_upsd', nil, nil, G.P_CENTER_POOLS.Planet, true), nil, true)
		end
		for k, v in pairs(G.play.cards) do
			local percent = 0.85 + (k - 0.999) / (#G.play.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function() 
				v:flip()
				play_sound('card1', percent)
				v:juice_up(0.3, 0.3)
			return true end}))
		end
		for k, v in pairs(G.play.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
				v:add_to_deck()
				G.play:remove_card(v)
				G.deck:emplace(v)
				play_sound('card1')
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'heirophant_upsd',
	set = 'upside_down_tarots',
	name = 'ThT HierooreiH',
	loc_txt = {
		name = 'ThT HierooreiH',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Bonus{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {X:mult,C:white}+X#1#{} Mult"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 4, y = 5 },
	config = { extra = { bonus = 0.3, target_enhancement = 'm_bonus' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_x_mult = (targets[i].ability.perma_x_mult or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'lovers_upsd',
	set = 'upside_down_tarots',
	name = 'ThT LovvoL',
	loc_txt = {
		name = 'ThT LovvoL',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Wild{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {X:mult,C:white}+X#1#{} {C:attention}held in hand{} Mult"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 3, y = 5 },
	config = { extra = { bonus = 0.6, target_enhancement = 'm_wild' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_h_x_mult = (targets[i].ability.perma_h_x_mult or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'chariot_upsd',
	set = 'upside_down_tarots',
	name = 'ThT CharahC',
	loc_txt = {
		name = 'ThT CharahC',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Steel{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {C:mult}+#1#{} Mult"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 2, y = 5 },
	config = { extra = { bonus = 10, target_enhancement = 'm_steel' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_mult = (targets[i].ability.perma_mult or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'justice_upsd',
	set = 'upside_down_tarots',
	name = 'JustsuJ',
	loc_txt = {
		name = 'JustsuJ',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Glass{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {C:chips}+#1#{} Chips"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 1, y = 5 },
	config = { extra = { bonus = 65, target_enhancement = 'm_glass' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_mult = (targets[i].ability.perma_mult or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'hermit_upsd',
	set = 'upside_down_tarots',
	name = 'ThT HerreH',
	loc_txt = {
		name = 'ThT HerreH',
		text = {
			{
				"{X:money,C:white}X#1#${}",
				"{C:money}+#2# Interest{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 0, y = 5 },
	config = { extra = { x_dollars = 0.5, interest = 2 } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		return { vars = { card.ability.extra.x_dollars, card.ability.extra.interest } }
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card, area, copier)
		may.hypermoney(0, 0.5, false)
		may.ease_interest(-1, card.ability.extra.interest)
	end,
}

SMODS.Consumable {
	key = 'wheel_of_fortune_upsd',
	set = 'upside_down_tarots',
	name = 'ThT WhehW OO FortroF',
	loc_txt = {
		name = 'ThT WhehW OO FortroF',
		text = {
			{
				"{C:mult}Remove{} the {C:dark_edition}Edition{} of a",
				"{C:attention}random Joker{}",
				"{C:money}+#1# Interest Cap{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 9, y = 4 },
	config = { extra = { interest_cap = 20 } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		return { vars = { card.ability.extra.interest_cap } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do
			if v.edition then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.jokers.cards) do
			if v.edition then
				table.insert(targets, v)
			end
		end
		local joker = pseudorandom_element(targets, pseudoseed('may_wheel_of_fortune_upsd'))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('timpani')
			joker:juice_up(0.3, 0.5)
			joker:set_edition(nil)
		return true end}))
		may.ease_interest_cap(-1, card.ability.extra.interest_cap)
	end,
}

SMODS.Consumable {
	key = 'strength_upsd',
	set = 'upside_down_tarots',
	name = 'StrertS',
	loc_txt = {
		name = 'StrertS',
		text = {
			{
				"{C:attention}Randomize ranks{} of all {C:attention}selected cards{}",
				"{C:attention}Most played{} {C:purple}Poker Hand{} gains {C:mult}+#1#{} Mult",
				"{C:attention}per{} selected {C:attention}card{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 8, y = 4 },
	config = { extra = { bonus = 10 } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted ~= 0
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #G.hand.highlighted, 1 do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				G.hand.highlighted[i]:flip()
				play_sound('card1', percent)
				G.hand.highlighted[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #G.hand.highlighted, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				local suit_prefix = string.sub(G.hand.highlighted[i].base.suit, 1, 1)..'_'
				local rank_suffix = math.random(2, 14)
				if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
					elseif rank_suffix == 10 then rank_suffix = 'T'
					elseif rank_suffix == 11 then rank_suffix = 'J'
					elseif rank_suffix == 12 then rank_suffix = 'Q'
					elseif rank_suffix == 13 then rank_suffix = 'K'
					elseif rank_suffix == 14 then rank_suffix = 'A'
				end
				G.hand.highlighted[i]:set_base(G.P_CARDS[suit_prefix..rank_suffix])
			return true end}))
		end
		for i=1, #G.hand.highlighted, 1 do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				G.hand.highlighted[i]:flip()
				play_sound('card1', percent)
				G.hand.highlighted[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		may.hand_mod_multchips(may.favhand(), 'mult', -1, #G.hand.highlighted * card.ability.extra.bonus, false, card)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end,
}

SMODS.Consumable {
	key = 'hanged_man_upsd',
	set = 'upside_down_tarots',
	name = 'HannaH MaM',
	loc_txt = {
		name = 'HannaH MaM',
		text = {
			{
				"{C:atterntion}Duplicate{} all {C:attention}selected playing cards{}",
				"{C:attention}#1# Ante per{} selected {C:attention}card{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 7, y = 4 },
	config = { extra = { ante = -0.04 } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ante } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted ~= 0
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.highlighted) do
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local _card = copy_card(v, nil, nil, G.playing_card)
			_card:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, _card)
			G.hand:emplace(_card)
			_card:start_materialize(nil, _first_dissolve)
			_first_dissolve = true
			play_sound('card1')
		end
		playing_card_joker_effects(new_cards)
		ease_ante(#G.hand.highlighted * card.ability.extra.ante)
	end,
}

SMODS.Consumable {
	key = 'death_upsd',
	set = 'upside_down_tarots',
	name = 'DeaeD',
	loc_txt = {
		name = 'DeaeD',
		text = {
			{
				"{C:attention}Randomize{} all {C:attention}suit and rank matching{} instances of a",
				"{C:attention}selected playing{} card from full deck",
				"{C:money}+$#1#{}",
				"{C:inactive}Selected card must not be rankless or suitless{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 6, y = 4 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { dollars = 10 } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted == 1 and not (G.hand.highlighted[1]:norank() or G.hand.highlighted[1]:nosuit())
	end,
	use = function(self, card, area, copier)
		local target = G.hand.highlighted[1]
		for k, v in pairs(G.playing_cards) do
			if v:get_id() == target:get_id() and v:is_suit(target.base.suit) then
				may.randomise({v}, not table_hasvalue(G.hand.cards, v))
			end
		end
		ease_dollars(card.ability.extra.dollars)
	end,
}

SMODS.Consumable {
	key = 'temperance_upsd',
	set = 'upside_down_tarots',
	name = 'TempepmeT',
	loc_txt = {
		name = 'TempepmeT',
		text = {
			{
				"Set the {C:money}sell value{} of",
				"a {C:attention}selected Joker{} to {C:mult}0{}",
				"Add {C:mult}lost{} {C:money}sell value{} to {C:attention}all other Jokers{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 5, y = 4 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse() and #G.jokers.highlighted == 1 and #G.jokers.cards > 1
	end,
	use = function(self, card, area, copier)
		local target = G.jokers.highlighted[1]
		local value = target.sell_cost
		target.sell_cost = 0
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot2')
			target:juice_up(0.3, 0.5)
		return true end}))
		for k, v in pairs(G.jokers.cards) do
			if v ~= target then
				v.ability.extra_value = (v.ability.extra_value or 0) + value
				v:set_cost()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					play_sound('timpani')
					v:juice_up(0.3, 0.5)
				return true end}))
			end
		end
	end,
}

SMODS.Consumable {
	key = 'devil_upsd',
	set = 'upside_down_tarots',
	name = 'DeveD',
	loc_txt = {
		name = 'DeveD',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Gold{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {X:chips,C:white}+X0.3{} {C:attention}held in hand{} Chips"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 4, y = 4 },
	config = { extra = { bonus = 5, target_enhancement = 'm_gold' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_h_x_chips = (targets[i].ability.perma_h_x_chips or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'tower_upsd',
	set = 'upside_down_tarots',
	name = 'TowoT',
	loc_txt = {
		name = 'TowoT',
		text = {
			{
				"{C:mult}Remove{} {C:attention}Stone{} {C:dark_edition}Enhancement{} from",
				"{C:attention}all cards held in hand{}",
				"{C:attention}Affected{} cards gain {C:money}+#1#{} {C:attention}held in hand{} dollars"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 3, y = 4 },
	config = { extra = { bonus = 5, target_enhancement = 'm_stone' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if SMODS.has_enhancement(v, card.ability.extra.target_enhancement) then
				table.insert(targets, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 - (i - 0.999) / (#targets - 0.998) * 0.3
			targets[i]:set_ability(G.P_CENTERS.c_base, nil, true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() 
				play_sound('may_permabonus', percent)
				targets[i]:juice_up(0.3, 0.3)
				targets[i].ability.perma_h_dollars = (targets[i].ability.perma_h_dollars or 0) + card.ability.extra.bonus
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'star_upsd',
	set = 'upside_down_tarots',
	name = 'SttS',
	loc_txt = {
		name = 'SttS',
		text = {
			{
				"{C:attention}Randomize{} the {C:attention}suit{} of all",
				"{C:attention}Diamond{} cards {C:attention}held in hand{}",
				"Convert all {C:attention}other cards{} held in hand into {C:attention}Clubs{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 2, y = 4 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { target_suit = 'Diamonds', conv_suit = 'Clubs' } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				return may.canuse()
			end
		end
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local other = {}
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				table.insert(targets, v)
			else
				table.insert(other, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:change_suit(pseudorandom_element(G.P_CARDS, pseudoseed('may_star_upsd'))['suit'])
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 1.15 - (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 0.85 + (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			other[i]:change_suit(card.ability.extra.conv_suit)
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'moon_upsd',
	set = 'upside_down_tarots',
	name = 'MooM',
	loc_txt = {
		name = 'MooM',
		text = {
			{
				"{C:attention}Randomize{} the {C:attention}suit{} of all",
				"{C:attention}Club{} cards {C:attention}held in hand{}",
				"Convert all {C:attention}other cards{} held in hand into {C:attention}Hearts{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 1, y = 4 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { target_suit = 'Clubs', conv_suit = 'Hearts' } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				return may.canuse()
			end
		end
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local other = {}
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				table.insert(targets, v)
			else
				table.insert(other, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:change_suit(pseudorandom_element(G.P_CARDS, pseudoseed('may_star_upsd'))['suit'])
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 1.15 - (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 0.85 + (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			other[i]:change_suit(card.ability.extra.conv_suit)
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'sun_upsd',
	set = 'upside_down_tarots',
	name = 'SuS',
	loc_txt = {
		name = 'SuS',
		text = {
			{
				"{C:attention}Randomize{} the {C:attention}suit{} of all",
				"{C:attention}Heart{} cards {C:attention}held in hand{}",
				"Convert all {C:attention}other cards{} held in hand into {C:attention}Spades{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 0, y = 4 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { target_suit = 'Hearts', conv_suit = 'Spades' } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				return may.canuse()
			end
		end
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local other = {}
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				table.insert(targets, v)
			else
				table.insert(other, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:change_suit(pseudorandom_element(G.P_CARDS, pseudoseed('may_star_upsd'))['suit'])
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 1.15 - (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 0.85 + (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			other[i]:change_suit(card.ability.extra.conv_suit)
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

SMODS.Consumable {
	key = 'judgement_upsd',
	set = 'upside_down_tarots',
	name = 'JudgegduJ',
	loc_txt = {
		name = 'JudgegduJ',
		text = {
			{
				"{C:mult}Destroy{} a {C:attention}random non-fusion Joker{}",
				"Create {C:attention}#1# random{} {C:dark_edition}Negative{} {C:tarot}Tarot Cards{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 9, y = 3 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { tarots = 4 } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.tarots } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do
			if not v:may_is_fusion() then
				return may.canuse()
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.jokers.cards) do
			if not v:may_is_fusion() then
				table.insert(targets, v)
			end
		end
		local target = pseudorandom_element(targets, pseudoseed('may_judgement_upsd'))
		target:start_dissolve()
		target = nil
		for i=1, card.ability.extra.tarots, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('timpani', 0.5)
				local card2 = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'may_judgement_upsd')
				card2:set_edition({negative = true}, true)
				card2:add_to_deck()
				G.consumeables:emplace(card2)
				card:juice_up(0.3, 0.5)
			return true end}))
		end
	end,
}


SMODS.Consumable {
	key = 'world_upsd',
	set = 'upside_down_tarots',
	name = 'WoroW',
	loc_txt = {
		name = 'WoroW',
		text = {
			{
				"{C:attention}Randomize{} the {C:attention}suit{} of all",
				"{C:attention}Spade{} cards {C:attention}held in hand{}",
				"Convert all {C:attention}other cards{} held in hand into {C:attention}Diamonds{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 8, y = 3 },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	config = { extra = { target_suit = 'Spades', conv_suit = 'Diamonds' } },
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				return may.canuse()
			end
		end
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local other = {}
		for k, v in pairs(G.hand.cards) do
			if v:is_suit(card.ability.extra.target_suit) then
				table.insert(targets, v)
			else
				table.insert(other, v)
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end}))
		for i=1, #targets, 1 do
			local percent = 1.15 - (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #targets, 1 do
			local percent = 0.85 + (i - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
				targets[i]:change_suit(pseudorandom_element(G.P_CARDS, pseudoseed('may_star_upsd'))['suit'])
				targets[i]:flip()
				play_sound('card1', percent)
				targets[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 1.15 - (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
		for i=1, #other, 1 do
			local percent = 0.85 + (i - 0.999) / (#other - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			other[i]:change_suit(card.ability.extra.conv_suit)
				other[i]:flip()
				play_sound('card1', percent)
				other[i]:juice_up(0.3, 0.3)
			return true end}))
		end
	end,
}

-- Upside Down Planets

-- original planet key, name, hand1, hand2, x, y
may.upside_down_planets = {
	{'mercury', 'MercreM', 'Pair', 'Two Pair', 9, 2},
	{'venus', 'VeneV', 'Three of a Kind', 'Straight', 8, 2},
	{'earth', 'EaraE', 'Full House', 'Four of a Kind', 7, 2},
	{'mars', 'MaaM', 'Four of a Kind', 'Straight Flush', 6, 2},
	{'jupiter', 'JupipuJ', 'Flush', 'Full House', 5, 2},
	{'saturn', 'SattaS', 'Straight', 'Flush', 4, 2},
	{'uranus', 'UraarU', 'Two Pair', 'Three of a Kind', 3, 2},
	{'pluto', 'PlulP', 'High Card', 'Pair', 1, 2},
	{'planet_x', 'PlaalP X', 'Five of a Kind', 'Flush House', 0, 3},
	{'ceres', 'CereC', 'Flush House', 'Flush Five', 1, 3},
	{'eris', 'ErrE', 'Flush Five', 'High Card', 6, 3},
}

for k, v in pairs(may.upside_down_planets) do
	SMODS.Consumable {
		key = v[1]..'_upsd',
		set = 'upside_down_planets',
		name = v[2],
		loc_txt = {
			name = v[2],
			text = {
				{
					"{C:mult}Level down{} {C:purple}#1#{}",
					"{C:planet}Level up{} {C:purple}#2#{} by {C:attention}3{}",
				},
				{
					"{C:inactive,E:1}Art by _TeKKen_{}"
				},
			}
		},
		pos = { x = v[5], y = v[6] },
		config = { extra = { hand1 = v[3], hand2 = v[4] } },
		atlas = 'upside_down',
		cost = 10,
		unlocked = true,
		discovered = true,
    no_grc = true, 
		loc_vars = function(self, info_queue, card)
			return { vars = { v[3], v[4] } }
		end,
		can_use = function(self, card)
			return may.canuse() and to_big(G.GAME.hands[card.ability.extra.hand1].level) > to_big(1)
		end,
		use = function(self, card, area, copier)
			may.th(card.ability.extra.hand1)
			if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
				level_up_hand(card, card.ability.extra.hand1, nil, -1)
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					play_sound('tarot2')
				return true end}))
			end
			delay(1.3)
			may.th(card.ability.extra.hand2)
			level_up_hand(card, card.ability.extra.hand2, nil, 3)
			delay(1.3)
			may.ch()
		end,
		in_pool = function(self, args)
			return SMODS.is_poker_hand_visible(v[3]) and SMODS.is_poker_hand_visible(v[4])
		end
	}
end

SMODS.Consumable {
	key = 'neptune_upsd',
	set = 'upside_down_planets',
	name = 'NeptpeN',
	loc_txt = {
		name = "NeptpeN",
		text = {
			{
				"{C:mult}Level down{} {C:purple}Straight Flush{}",
				"{C:planet}Level up{} {C:purple}Royal Flush{} by {C:attention}3{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 2, y = 2 },
	config = { extra = { hand1 = 'Straight Flush', hand2 = 'may_Royal Flush' } },
	atlas = 'upside_down',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse() and to_big(G.GAME.hands[card.ability.extra.hand1].level) > to_big(1)
	end,
	use = function(self, card, area, copier)
		may.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		may.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 3)
		delay(1.3)
		may.ch()
	end,
	in_pool = function(self, args)
		return SMODS.is_poker_hand_visible('Straight Flush') and SMODS.is_poker_hand_visible('may_Royal Flush')
	end
}

SMODS.Consumable {
	key = 'proxima_centauri_upsd',
	set = 'upside_down_planets',
	name = 'ProxorP CentneC',
	loc_txt = {
		name = "ProxorP CentneC",
		text = {
			{
				"{C:mult}Level down{} {C:purple}Royal Flush{}",
				"{C:planet}Level up{} {C:purple}Five of a Kind{} by {C:attention}3{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 0, y = 2 },
	config = { extra = { hand1 = 'may_Royal Flush', hand2 = 'Five of a Kind' } },
	atlas = 'placeholder',
	cost = 10,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card, area, copier)
		may.th(card.ability.extra.hand1)
		if to_number(G.GAME.hands[card.ability.extra.hand1].level) > 1 then
			level_up_hand(card, card.ability.extra.hand1, nil, -1)
		else
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot2')
			return true end}))
		end
		delay(1.3)
		may.th(card.ability.extra.hand2)
		level_up_hand(card, card.ability.extra.hand2, nil, 3)
		delay(1.3)
		may.ch()
	end,
	in_pool = function(self, args)
		return G.GAME.hands['Five of a Kind'].visible, { allow_duplicates = false }
	end,
	in_pool = function(self, args)
		return SMODS.is_poker_hand_visible('Straight Flush') and SMODS.is_poker_hand_visible('may_Royal Flush')
	end
}

-- Upside Down Spectrals

SMODS.Consumable {
	key = 'familiar_upsd',
	set = 'upside_down_spectrals',
	name = 'FamiimaF',
	loc_txt = {
		name = "FamiimaF",
		text = {
			{
				"{C:mult}Destroys{} all {C:attention}face cards{} held in {C:attention}hand{}",
				"{C:attention}+1 Hand Size{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 9, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
		    for _, card in ipairs(G.hand.cards) do
			    if card:is_face() then
				    card:start_dissolve(nil, false)
				    table.insert(targets, card)
			    end
		    end
		    SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
		    G.hand:change_size(1) 
            play_sound('may_event')
        return true end})) 
	end
}


SMODS.Consumable {
	key = 'grim_upsd',
	set = 'upside_down_spectrals',
	name = 'GrrG',
	loc_txt = {
		name = "GrrG",
		text = {
			{
				"{C:mult}Destroys{} all {C:attention}Aces{} in {C:attention}full deck{}",
				"{C:attention}-1 Ante{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 8, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
		    for _, card in ipairs(G.playing_cards) do
			    if card:get_id() == 14 then
				    card:start_dissolve(nil, true)
				    table.insert(targets, card)
			    end
		    end
		    ease_ante(-1)
		    SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
            play_sound('may_event')
        return true end}))
	end
}


SMODS.Consumable {
	key = 'incantation_upsd',
	set = 'upside_down_spectrals',
	name = 'IncantnacnI',
	loc_txt = {
		name = "IncantnacnI",
		text = {
			{
				"{C:mult}Destroys{} all {C:attention}numbered cards{} held in {C:attention}hand{}",
				"{C:attention}+2 Consumable Slots{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 7, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse()
	end,
	use = function(self, card, area, copier)
		local targets = {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
		    for _, card in ipairs(G.hand.cards) do
			    if not card:is_face() then
				    card:start_dissolve(nil, false)
				    table.insert(targets, card)
			    end
		    end
		    G.consumeables:change_size(2)
		    SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
            play_sound('may_event')
        return true end}))
	end
}

SMODS.Consumable {
	key = 'talisman_upsd',
	set = 'upside_down_spectrals',
	name = 'TalilaT',
	loc_txt = {
		name = "TalilaT",
		text = {
			{
				"{C:mult}Removes{} {C:attention}Gold Seal{} from", 
				"all cards in {C:attention}full deck{}",
				"Gives all {C:attention}cards{} held in hand", 
				"random {C:dark_edition}Enhancements{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 6, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		for k, v in pairs(G.playing_cards) do 
			if v.seal and v.seal == 'Gold' then 
				return may.canuse() and #G.hand.cards > 0
			end 
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals['Gold']
	end,
	use = function(self, card, area, copier)
		local enhance = {}
		for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
			if v.key ~= 'm_stone' then
				table.insert(enhance, v)
			end
		end
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Gold' then
			    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    card:set_seal(nil, true, false)
					if card.area == G.play or card.area == G.hand then
						card:juice_up(0.3, 0.5)
						play_sound('tarot1')
					end
				return true end}))
			end
		end
		for k, v in ipairs(G.hand.cards) do
			local percent = 1.15 - (k - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:flip()
				v:juice_up(0.3, 0.5)
				play_sound('card1', percent)
				delay(0.5)
			return true end}))
		end
		for k, v in ipairs(G.hand.cards) do
			local percent = 0.85 + (k - 0.999) / (#targets - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v:set_ability(pseudorandom_element(enhance, pseudoseed('may_talisman_upsd')), false, false) 
				v:flip()
				play_sound('tarot1', percent)
				delay(0.5)
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'aura_upsd',
	set = 'upside_down_spectrals',
	name = 'AuuA',
	loc_txt = {
		name = "AuuA",
		text = {
			{
				"{C:attention}Select{} a {C:attention}playing card{} with an {C:dark_edition}Edition{}",
				"{C:mult}Remove it's{} {C:dark_edition}Edition{} and {C:planet}level up{}",
				"{C:attention}3 random{} {C:purple}Poker Hands{} by {C:attention}10{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 5, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		if other then
			return may.canuse() and #G.hand.highlighted <= (1 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0) and other.edition
		end
		return false
	end,
	use = function(self, card, area, copier)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			other:juice_up(0.3, 0.5)
			other:set_edition(nil, true, true)
		return true end}))
		for i=1, 3, 1 do
			local hand = may.rndhand()
			may.th(hand)
			level_up_hand(card, hand, nil, 10)
			may.ch()
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() 
			G.hand:unhighlight_all() 
		return true end}))
	end
}

SMODS.Consumable {
	key = 'wraith_upsd',
	set = 'upside_down_spectrals',
	name = 'WraarW',
	loc_txt = {
		name = "WraarW",
		text = {
			{
				"{C:mult}Destroy{} {C:attention}all{} {X:rare,C:white}Rare{} {C:attention}Jokers{}",
				"{C:chips}+2 Hands{} and {C:mult}Discards{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 4, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card) 
		if G.jokers then 
			for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 3 then
				    return may.canuse()
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == 3 then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v:start_dissolve(nil, false)
					v:juice_up(0.3, 0.5)
                    play_sound('card3')
                return true end}))
			end
		end
		ease_hands_played(2)
		ease_discard(2)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
	end
}

SMODS.Consumable {
	key = 'sigil_upsd',
	set = 'upside_down_spectrals',
	name = 'SigiS',
	loc_txt = {
		name = "SigiS",
		text = {
			{
				"{C:attention}Select{} a {C:attention}playing card{}",
				"{C:mult}Destroys{} all {C:attention}cards{} in {C:attention}full deck{} with {C:attention}that card's suit{}",
				"{X:money,C:white}X2${}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 3, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse() and G.hand and #G.hand.highlighted == (1 + (card.area == G.hand and 1 or 0))
	end,
	use = function(self, card, area, copier)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		local targets = {}
		local suit = other.base.suit
		for k, v in pairs(G.playing_cards) do
			if v.base.suit == suit then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v:start_dissolve(nil, false)
                return true end})) 
				table.insert(targets, card)
			end
		end
		may.hypermoney(0, 2)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            play_sound('may_event')
        return true end}))
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}

SMODS.Consumable {
	key = 'ouija_upsd',
	set = 'upside_down_spectrals',
	name = 'OuiuO',
	loc_txt = {
		name = "OuiuO",
		text = {
			{
				"{C:attention}Select{} a {C:attention}playing card{}",
				"{C:mult}Destroys{} all {C:attention}cards{} in {C:attention}full deck{} with {C:attention}that card's rank{}",
				"{C:attention}Redeem{} a {C:attention}random{} {C:green}Voucher{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 2, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse() and G.hand and #G.hand.highlighted == (1 + (card.area == G.hand and 1 or 0))
	end,
	use = function(self, card, area, copier)
		local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		local targets = {}
		local rank = other:get_id()
		for k, v in pairs(G.playing_cards) do
			if v:get_id() == rank then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v:start_dissolve(nil, false)
                return true end}))
				table.insert(targets, v)
			end
		end
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            play_sound('may_event')
        return true end}))
		G.E_MANAGER:add_event(Event({func = function()
			may.voucher()
		return true end}))
	end
}

SMODS.Consumable {
	key = 'ectoplasm_upsd',
	set = 'upside_down_spectrals',
	name = 'EctopotcE',
	loc_txt = {
		name = "EctopotcE",
		text = {
			{
				"{C:mult}Removes{} {C:dark_edition}Negative{} from {C:attention}all{} {C:attention}Jokers{}",
				"Creates {C:attention}10{} {C:attention}random{} {C:dark_edition}Negative{} {C:dark_edition}Modifier Cards{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 1, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
	end, 
	can_use = function(self, card)
		if G.jokers then 
		    for k, v in pairs(G.jokers.cards) do
				if v.edition and v.edition.key == 'e_negative' then
				    return may.canuse()
				end 
			end
	    end
	end,
	use = function(self, card, area, copier)
		local jokers_found = {}
		for k, v in pairs(G.jokers.cards) do
			if v.edition and v.edition.type == 'negative' then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v.edition = nil
                    play_sound('tarot1')
                    v:juice_up(0.3, 0.5)
                return true end})) 
			end
		end
		for i=1, 10, 1 do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local edition = create_card("may_modifiercard", G.consumables, nil, nil, nil, nil, nil, "may_ectoplasm_upsd")
				edition:add_to_deck()
				G.consumeables:emplace(edition)
				edition:set_edition({negative = true}, true)
				play_sound('timpani')
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'immolate_upsd',
	set = 'upside_down_spectrals',
	name = 'ImmoommI',
	loc_txt = {
		name = "ImmoommI",
		text = {
			{
				"{C:attention}Duplicates{} up to {C:attention}5 selected cards{}",
				"{X:mult,C:white}+X0.5{} Mult to {C:attention}most played{}", 
				"{C:planet}Poker Hand{} per {C:attention}selected card{}",
				"{C:inactive}Will upgrade #1#{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 0, y = 1 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse() and G.hand and #G.hand.highlighted <= (5 + (card.area == G.hand and 1 or 0))
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { may.favhand() } }
	end,
	use = function(self, card, area, copier)
		for k, v in pairs(G.hand.highlighted) do
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local _card = copy_card(v, nil, nil, G.playing_card)
			_card:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, _card)
			G.hand:emplace(_card)
			_card:start_materialize(nil, _first_dissolve)
			_first_dissolve = true
		end
		playing_card_joker_effects(new_cards)
		may.hand_mod_multchips(may.favhand(), 'mult', 0, #G.hand.highlighted*0.5)
	end
}

SMODS.Consumable {
	key = 'ankh_upsd',
	set = 'upside_down_spectrals',
	name = 'AnnA',
	loc_txt = {
		name = "AnnA",
		text = {
			{
				"{C:mult}Destroys{} all {C:attention}duplicate Jokers{}",
				"{C:attention}Creates{} a {C:attention}random{} {X:legendary,C:white}Legendary{} {C:attention}Joker{}",
				"{C:inactive}Does not require room{}"
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 9, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		local joker_keys = {}
		if G.jokers then
			for k, v in pairs(G.jokers.cards) do
				if not table_hasvalue(joker_keys, v:gc().key) then
					table.insert(joker_keys, v:gc().key)
				else
				    return may.canuse()
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local joker_keys = {}
		local duplicates = {}
		for k, v in pairs(G.jokers.cards) do
			if not table_hasvalue(joker_keys, v:gc().key) then
				table.insert(joker_keys, v:gc().key)
			else
				table.insert(duplicates, v)
			end
		end
		for k, v in pairs(duplicates) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
			    v:start_dissolve(nil, false)
                play_sound('card3')
            return true end})) 
		end
		delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
		    local card2 = create_card("Joker", G.consumables, true, 4, nil, nil, nil, "may_ankh_upsd")
		    card2:add_to_deck()
		    G.jokers:emplace(card2)
            play_sound('timpani')
        return true end})) 
	end
}

SMODS.Consumable {
	key = 'deja_vu_upsd',
	set = 'upside_down_spectrals',
	name = 'DeeD VV',
	loc_txt = {
		name = "DeeD VV",
		text = {
			{
				"{C:mult}Removes{} {C:attention}Red Seal{} from", 
				"all cards in {C:attention}full deck{}",
				"Gives all {C:attention}Jokers random{} {C:dark_edition}Editions{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 8, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		local joker_available
		local seal
		for k, v in pairs(G.jokers.cards) do 
			if not v.edition then 
				joker_available = true 
				break
			end 
		end
		for k, v in pairs(G.playing_cards) do 
			if v.seal and v.seal == 'Red' then 
				seal = true 
				break 
			end 
		end
		return may.canuse() and joker_available and seal
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals['Red']
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Red' then
			    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    card:set_seal(nil, true, false)
					if card.area == G.play or card.area == G.hand then
						card:juice_up(0.3, 0.5)
						play_sound('tarot1')
					end
				return true end}))
			end
		end
		for i = 1, #G.jokers.cards do
			local joker = G.jokers.cards[i]
			G.E_MANAGER:add_event(Event({trigger = "after",delay = 0.15,func = function()
				if not joker.edition then
					joker:set_edition(poll_edition('may_deja_vu_upsd', nil, true, true))
				end
			return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'hex_upsd',
	set = 'upside_down_spectrals',
	name = 'HeH',
	loc_txt = {
		name = "HeH",
		text = {
			{
				"{C:mult}Removes{} {C:dark_edition}Polychrome{} from all Jokers",
				"{C:money}+1 Interest{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 7, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
	end,
	can_use = function(self, card)
		for k, v in pairs(G.jokers.cards) do 
			if v.edition and v.edition.key == 'e_polychrome' then
				return may.canuse()
			end 
		end 
	    return false
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.jokers.cards) do
			if card.edition and card.edition.type == 'polychrome' then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    card:set_edition(nil, true, false)
                    play_sound('tarot1')
                    card:juice_up()
                return true end}))
			end
		end
		delay(0.5)
		may.ease_interest(1)
	end
}

SMODS.Consumable {
	key = 'trance_upsd',
	set = 'upside_down_spectrals',
	name = 'TraarT',
	loc_txt = {
		name = "TraarT",
		text = {
			{
				"{C:mult}Removes{} {C:attention}Blue Seal{} from",
				"all cards in {C:attention}full deck{}",
				"Applies {C:dark_edition}Negative{} to a {C:attention}random Joker{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 6, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card) 
		local joker_available
		local seal
		for k, v in pairs(G.jokers.cards) do 
			if not v.edition then 
				joker_available = true 
				break
			end 
		end
		for k, v in pairs(G.playing_cards) do 
			if v.seal and v.seal == 'Blue' then 
				seal = true 
				break 
			end 
		end
		return may.canuse() and seal and joker_available
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals['Blue']
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Blue' then
			    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    card:set_seal(nil, true, false)
					if card.area == G.play or card.area == G.hand then
						card:juice_up(0.3, 0.5)
						play_sound('tarot1')
					end
				return true end}))
			end
		end
		local targets = {}
		for k, v in pairs(G.jokers.cards) do
			if not v.edition then
				table.insert(targets, v)
			end
		end
		local joker = pseudorandom_element(targets, pseudoseed('may_trance_upsd'))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
		    joker:set_edition({negative = true})
        return true end}))
	end
}

SMODS.Consumable {
	key = 'medium_upsd',
	set = 'upside_down_spectrals',
	name = 'MeddeM',
	loc_txt = {
		name = "MeddeM",
		text = {
			{
				"{C:mult}Removes{} {C:attention}Purple Seal{} from all cards in {C:attention}deck{}",
				"{X:money,C:white}X1.2${}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 5, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		for k, v in pairs(G.playing_cards) do 
			if v.seal and v.seal == 'Purple' then 
				return may.canuse()
			end 
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals['Purple']
	end,
	use = function(self, card, area, copier)
		for _, card in ipairs(G.playing_cards) do
			if card.seal and card.seal == 'Purple' then
			    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    card:set_seal(nil, true, false)
					if card.area == G.play or card.area == G.hand then
						card:juice_up(0.3, 0.5)
						play_sound('tarot1')
					end
				return true end}))
			end
		end
		may.hypermoney(0, 1.2, false)
	end
}

SMODS.Consumable {
	key = 'cryptid_upsd',
	set = 'upside_down_spectrals',
	name = 'CrypyrC',
	loc_txt = {
		name = "CrypyrC",
		text = {
			{
				"{C:mult}Destroys{} all {C:attention}duplicates{}",
				"of a {C:attention}random playing card{}",
				"{C:money}+5 Interest Cap{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 4, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	can_use = function(self, card)
		return may.canuse()
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local selected_card = pseudorandom_element(G.playing_cards, pseudoseed('may_cryptid_upsd'))
		for k, v in pairs(G.playing_cards) do
			if v:get_id() == selected_card:get_id() and v.base.suit == selected_card.base.suit then
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				    v:start_dissolve(nil, false)
					play_sound('card3')
				return true end})) 
				table.insert(targets, card)
			end
		end
		delay(0.5)
		may.ease_interest_cap(5)
		SMODS.calculate_context({ remove_playing_cards = true, removed = targets })
	end
}

SMODS.Consumable {
	key = 'soul_upsd',
	set = 'upside_down_spectrals',
	name = 'SooS',
	loc_txt = {
		name = "SooS",
		text = {
			{
				"{C:mult}Destroys{} all {X:legendary,C:white}Legendary{} {C:attention}Jokers{}",
				"{C:attention}Creates{} {C:attention}random{} {C:dark_edition}Negative{} {X:may_epic,C:white}Epic{} {C:attention}Jokers{}",
				"for {C:attention}every destroyed Joker{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 7, y = 3 },
	soul_pos = { x = 3, y = 0 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
    no_grc = true, 
	custom_soul_anim = function(self, layer)
		local scale_mod = 0.05 - 0.05 * math.sin(1.8 * G.TIMERS.REAL) - 0.07 * math.sin(0.5 * (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) * ( 1 + (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 1.5
        local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) - 0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 + (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 1.7

        self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
        self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end,
	can_use = function(self, card)
		return may.canuse()
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in pairs(G.jokers.cards) do
			if v:gc().rarity == 4 then
                amount = amount + 1 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    v:start_dissolve(nil, false)
                    play_sound('card3')
                return true end}))
			end
		end
		delay(0.5)
		for i=1, amount, 1 do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local card2 = create_card("Joker", G.jokers, nil, may.epic_key, nil, nil, nil, "may_soul_upsd")
				card2:add_to_deck()
				G.jokers:emplace(card2)
                card2:set_edition('e_negative')
                play_sound('timpani')
            return true end}))
		end
	end
}

SMODS.Consumable {
	key = 'black_hole_upsd',
	set = 'upside_down_spectrals',
	name = 'BlalB HooH',
	loc_txt = {
		name = "BlalB HooH",
		text = {
			{
				"{C:mult}Levels down{} {C:attention}all Poker Hands{} by 1",
				"Creates a copy of {C:dark_edition}Universal Collapse{}",
				"{C:inactive}Requires room{}",
			},
			{
				"{C:inactive,E:1}Art by _TeKKen_{}"
			},
		}
	},
	pos = { x = 0, y = 2 },
	atlas = 'upside_down',
	cost = 50,
	unlocked = true,
	discovered = true,
	endless = true, 
    no_grc = true, 
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_may_universal_collapse
        return {}
    end, 
	can_use = function(self, card)
		return may.canuse() and #G.jokers.cards < G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		may.level_up_all_hands(card, false, -1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
			G.jokers:emplace(card2)
			play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
			card2:add_to_deck()
		return true end}))
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}