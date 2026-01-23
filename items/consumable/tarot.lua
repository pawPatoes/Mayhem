-- Tarot cards

SMODS.Consumable {
	key = 'shaman',
	set = 'Tarot',
	loc_txt = {
		name = "The Shaman",
		text = {
			{
				"Select a {C:dark_edition}modified{} {C:attention}playing card{}",
				"{C:mult}Destroy it{} and create {C:attention}#1# random{}",
				"{C:spectral}Spectral Cards{}",
				"{C:inactive}(requires room){}"
			},
			{
				"{C:inactive,E:1}Original idea by _TeKKen_{}"
			}
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 3, 
	unlocked = true,
    config = { extra = { cards = 2 } }, 
	can_use = function(self, card)
        local other
		for k, v in pairs(G.hand.highlighted) do 
			if v ~= card then 
				other = v
			end 
		end
		if other then
			return may.canuse() and #G.hand.highlighted <= (1 + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0) and (other.config.center ~= G.P_CENTERS.c_base or other.seal or other.edition) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		end
		return false
	end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() 
			play_sound('card3')
		return true end}))
		SMODS.destroy_cards(G.hand.highlighted)
        for i=1, card.ability.extra.cards do
		    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    play_sound('timpani')
                    local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_shaman')
                    card2:add_to_deck()
                    G.consumeables:emplace(card2)
                    card:juice_up(0.3, 0.5)
                end
		    return true end}))
        end
	end
}

SMODS.Consumable {
	key = 'darkness',
	set = 'Tarot',
	loc_txt = {
		name = "The Darkness",
		text = {
            {
			    "{C:mult}Remove{} the {C:dark_edition}Enhancements{} of all",
			    "cards {C:attention}held in hand{}",
			    "{C:money}+#1# Interest{} {C:attention}per{} affected {C:attention}card{}",
			    "{C:inactive}Currently +#2#{}"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		}
	},
	pos = { x = 5, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'tarot',
	cost = 3,
	unlocked = true,
	config = { extra = { interest = 0.045 } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		local count = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do
				if v.config.center.key ~= 'c_base' then
					count = count + 1
				end
			end
		end
		return { vars = { tostring(card.ability.extra.interest), card.ability.extra.interest * count } }
	end,
	can_use = function(self, card)
		for k, v in pairs(G.hand.cards) do
			if v.config.center.key ~= 'c_base' then
				return true
			end
		end
		return false
	end,
	discovered = true,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do
			if v.config.center.key ~= 'c_base' then
				table.insert(targets, v)
			end
		end
		if #targets > 0 then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end }))
			for i=1, #targets do
				local percent = 1.15 - (i-0.999)/(#targets-0.998)*0.3
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() targets[i]:flip();play_sound('card1', percent);targets[i]:juice_up(0.3, 0.3);return true end }))
			end
			delay(0.2)
			for i=1, #targets do
				local percent = 0.85 + (i-0.999)/(#targets-0.998)*0.3
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() targets[i]:flip();targets[i]:set_ability(G.P_CENTERS.c_base, true, nil);play_sound('tarot2', percent);targets[i]:juice_up(0.3, 0.3);return true end }))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() may.ease_interest(-1, card.ability.extra.interest * #targets);return true end }))
	end
}

SMODS.Consumable {
	key = 'blade',
	set = 'Tarot',
	loc_txt = {
		name = "The Blade",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected card in {C:attention}hand{}",
				"into a {C:attention}Jagged{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 3, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_jagged" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'spirit',
	set = 'Tarot',
	loc_txt = {
		name = "The Spirit",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected card in {C:attention}hand{}",
				"into a {C:attention}Fortune{} card"
			},
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_fortune" },
	unlocked = true,
    endless = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Consumable {
	key = 'volcano',
	set = 'Tarot',
	loc_txt = {
		name = "The Volcano",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected card in {C:attention}hand{}",
				"into a {C:attention}Magma{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 2, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_magma" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'spreadsheet',
	set = 'Tarot',
	loc_txt = {
		name = "The Spreadsheet",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
				"into {C:attention}Grid{} cards"
			},
			{
				"{C:inactive,E:1}Improved art by Violet{}"
			}
		}
	},
	pos = { x = 2, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 2, mod_conv = "m_may_grid" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'paragon',
	set = 'Tarot',
	loc_txt = {
		name = "The Paragon",
		text = {
			{
				"Enhances #1# {C:attention}random{} card", 
                "held in {C:attention}hand{}",
				"into a {C:attention}Super Mult{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 5, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
    config = { extra = { cards = 1, target = 'm_may_super_mult'} }, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
        return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.random_enhancement(card.ability.extra.target, 'may_paragon')
	end
}

SMODS.Consumable {
	key = 'vines',
	set = 'Tarot',
	loc_txt = {
		name = "The Vines",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
				"into {C:attention}Overgrown{} cards"
			},
			{
				"{C:inactive,E:1}Improved art by Violet{}"
			}
		}
	},
	pos = { x = 1, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 2, mod_conv = "m_may_overgrown" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'pickaxe',
	set = 'Tarot',
	loc_txt = {
		name = "The Pickaxe",
		text = {
			{
				"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
				"into a {C:attention}Platinum{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 1, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
    endless = true,
	config = { extra = { cards = 1, target = 'm_may_platinum'} }, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
        return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.random_enhancement(card.ability.extra.target, 'may_pickaxe')
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Consumable {
	key = 'torch',
	set = 'Tarot',
	loc_txt = {
		name = "The Torch",
		text = {
			{
				"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
				"into a {C:attention}Scorched{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 0, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	config = { extra = { cards = 1, target = 'm_may_scorched'} }, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
        return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.random_enhancement(card.ability.extra.target, 'may_torch')
	end
}

SMODS.Consumable {
	key = 'gem',
	set = 'Tarot',
	loc_txt = {
		name = "The Gem",
		text = {
			{
				"Enhances #1# selected card in {C:attention}hand{}",
				"into a {C:attention}Crystal{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 4, y = 0 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_crystal" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'box',
	set = 'Tarot',
	loc_txt = {
		name = "The Box",
		text = {
			{
				"Enhances up to {C:attention}#1#{} selected cards in {C:attention}hand{}",
				"into {C:attention}Cardboard{} cards"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 3, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 2, mod_conv = "m_may_cardboard" },
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true
}

SMODS.Consumable {
	key = 'void',
	set = 'Tarot',
	loc_txt = {
		name = "The Void",
		text = {
			{
				"Enhances a {C:attention}random{} card held in {C:attention}hand{}",
				"into a {C:attention}Shadow{} card"
			},
			{
				"{C:inactive,E:1}Improved art by Violet{}"
			}
		}
	},
	pos = { x = 4, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	unlocked = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	config = { extra = { cards = 1, target = 'm_may_shadow'} }, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
        return { vars = { card.ability.extra.cards } }
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.random_enhancement(card.ability.extra.target, 'may_void')
	end
}

SMODS.Consumable {
	key = 'mecha',
	set = 'Tarot',
	loc_txt = {
		name = "The Mecha",
		text = {
			{
				"Enhances #1# selected card in {C:attention}hand{}",
				"into a {C:attention}Titanium{} card"
			},
			{
				"{C:inactive,E:1}Improved art by T3rragon{}"
			}
		}
	},
	pos = { x = 0, y = 1 },
	display_size = { w = 65, h = 95 },
	atlas = 'may_tarot',
	cost = 3,
	config = { max_highlighted = 1, mod_conv = "m_may_titanium" },
	unlocked = true,
    endless = true,
	can_use = function(self, card)
		return may.canuse() and #G.hand.highlighted <= (card.ability.max_highlighted + (card.area == G.hand and 1 or 0)) and #G.hand.highlighted > (card.area == G.hand and 1 or 0)
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
		return { vars = { card.ability.max_highilghted or self.config.max_highlighted } }
	end,
	discovered = true, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

SMODS.Consumable {
	key = 'axiom',
	set = 'Tarot',
	loc_txt = {
		name = "The Axiom",
		text = {
			{
				"Enhances #1# {C:attention}random{} card", 
                "held in {C:attention}hand{}",
				"into a {C:attention}Geometric{} card"
			},
		}
	},
	pos = { x = 1, y = 2 },
	atlas = 'placeholder',
	cost = 3,
	unlocked = true,
    config = { extra = { cards = 1, target = 'm_may_geometric'} }, 
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
        return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		return may.canuse() and #G.hand.cards ~= 0
	end,
	discovered = true,
	use = function(self, card, area, copier)
		may.random_enhancement(card.ability.extra.target, 'may_axiom')
	end
}