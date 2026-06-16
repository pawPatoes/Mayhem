-- Modifier Cards

AllowBulkUse('may_modifiercard')

-- Enhancement Cards 

SMODS.Consumable {
	key = 'bonus_card',
	config = { extra = { chips = 35, target = 'm_bonus' } },
	loc_txt = {
		name = 'Bonus Card',
		text = {
			{
				"Each {C:dark_edition}Bonus Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:chips}+#1#{} Chips to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {C:chips}+#2#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 2, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.chips, card.ability.extra.chips * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.chips}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, nil, false, {-1, card.ability.extra.chips})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.chips*number)}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, nil, false, {-1, card.ability.extra.chips * number})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'mult_card',
	config = { extra = { mult = 20, target = 'm_mult' } },
	loc_txt = {
		name = 'Mult Card',
		text = {
			{
				"Each {C:dark_edition}Mult Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}+#1#{} Mult to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 4, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.mult, card.ability.extra.mult * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.mult}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.mult})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.mult*number)}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.mult * number})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'wild_card',
	config = { extra = { min_mult = 5, max_mult = 25, min_chips = 5, max_chips = 25, target = 'm_wild' } },
	loc_txt = {
		name = 'Wild Card',
		text = {
			{
				"Each {C:dark_edition}Wild Card{}", 
				"{C:attention}held in hand{} gives", 
				"random amounts of {C:mult}+Mult{} and {C:chips}+Chips{}", 
				"{C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Min. #1#, max #2# Mult{}", 
				"{C:inactive}Min. #3#, max #4# Chips{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 5, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.min_mult, card.ability.extra.max_mult, card.ability.extra.min_chips, card.ability.extra.max_chips } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local mult = pseudorandom('may_wild_card', card.ability.extra.min_mult, card.ability.extra.max_mult)
			local chips = pseudorandom('may_wild_card', card.ability.extra.min_chips, card.ability.extra.max_chips)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..chips}, colour = G.C.CHIPS, delay = 0.45}) 
			may.hand_multchips_all(v, nil, false, {-1, chips})
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..mult}, colour = G.C.MULT, delay = 0.45}) 
			may.hand_multchips_all(v, nil, false, nil, {-1, mult})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local mult = 0
			local chips = 0
			for i=1, number do
				mult = mult + pseudorandom('may_wild_card', card.ability.extra.min_mult, card.ability.extra.max_mult)
				chips = chips + pseudorandom('may_wild_card', card.ability.extra.min_chips, card.ability.extra.max_chips)
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..chips}, colour = G.C.CHIPS, delay = 0.45}) 
			may.hand_multchips_all(v, nil, false, {-1, chips})
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..mult}, colour = G.C.MULT, delay = 0.45}) 
			may.hand_multchips_all(v, nil, false, nil, {-1, mult})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'glass_card',
	config = { extra = { x_mult1 = 2, x_mult2 = 0.25, odds = 4, target = 'm_glass' } },
	loc_txt = {
		name = 'Glass Card',
		text = {
			{
				"Each {C:dark_edition}Glass Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}X#1#{} Mult with a", 
				"{C:green}#2# in #3#{} chance to give",
				"{X:mult,C:white}X#4#{} Mult {C:mult}instead{}", 
				"to {C:attention}all{} {C:purple}Poker Hands{}", 
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 4, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Glass Card")
		return { vars = { card.ability.extra.x_mult1, normal, odds, card.ability.extra.x_mult2 } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			if SMODS.pseudorandom_probability(card, "may_glass_card", 1, card.ability.extra.odds, "Glass Card") then 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult2}, colour = G.C.MULT, delay = 0.45, sound = 'may_error'})
				may.hand_multchips_all(v, nil, false, nil, {0, card.ability.extra.x_mult2})
			else
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult1}, colour = G.C.MULT, delay = 0.45})
				may.hand_multchips_all(v, nil, false, nil, {0, card.ability.extra.x_mult1})
			end
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local successes = 0
			local fails = 0
			for i=1, number do 
				if SMODS.pseudorandom_probability(card, "may_glass_card", 1, card.ability.extra.odds, "Glass Card") then 
					successes = successes + 1
				else 
					fails = fails + 1
				end 
			end
			local total = (card.ability.extra.x_mult1 ^ fails) * (card.ability.extra.x_mult2 ^ successes)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..total}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {0, total})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'steel_card',
	config = { extra = { x_mult = 1.5, target = 'm_steel' } },
	loc_txt = {
		name = 'Steel Card',
		text = {
			{
				"Each {C:dark_edition}Steel Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}X#1#{} {C:may_ethereal}Level{} Mult to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:mult,C:white}X#2#{} {C:may_ethereal}Level{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 4, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_level_multchips_tutorial", set = "Other" }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult}, colour = G.C.MULT, delay = 0.45})
			may.hand_lvl_multchips_all(v, false, nil, {0, card.ability.extra.x_mult})
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult ^ number}, colour = G.C.MULT, delay = 0.45})
			may.hand_lvl_multchips_all(v, false, nil, {0, card.ability.extra.x_mult ^ number})
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'stone_card',
	config = { extra = { chips = 100, target = 'm_stone' } },
	loc_txt = {
		name = 'Stone Card',
		text = {
			{
				"Each {C:dark_edition}Stone Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:chips}+#1#{} Chips to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:mult}except{} {C:attention}most played{} {C:purple}Poker Hand{}",
				"{C:inactive}Currently{} {C:chips}+#2#{} {C:inactive}Chips, will ignore #3#{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 3, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.chips, card.ability.extra.chips * amount, may.favhand() } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.chips}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, may.favhand(), false, {-1, card.ability.extra.chips})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.chips*number)}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, may.favhand(), false, {-1, card.ability.extra.chips * number})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'gold_card',
	config = { extra = { dollars = 0.25, target = 'm_gold' } },
	loc_txt = {
		name = 'Gold Card',
		text = {
			{
				"Each {C:dark_edition}Gold Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:money}+#1#{} Dollars to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {C:money}+#2#{} {C:inactive}Dollars{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 5, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.dollars}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, -1, card.ability.extra.dollars)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.dollars*number)}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, -1, card.ability.extra.dollars*number)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'lucky_card',
	config = { extra = { mult = 40, p_dollars = 3, odds1 = 4, odds2 = 20, target = 'm_lucky' } },
	loc_txt = {
		name = 'Lucky Card',
		text = {
			{
				"Each {C:dark_edition}Lucky Card{}", 
				"{C:attention}held in hand{} has a", 
				"{C:green}#1# in #2#{} chance to give {C:mult}+#3#{} Mult", 
				"and a {C:green}#4# in #5#{} chance to give {C:money}+#6#{} Dollars", 
				"to {C:attention}all{} {C:purple}Poker Hands{}", 
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 3, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		local normal1, odds1 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds1, "Lucky Card")
		local normal2, odds2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, "Lucky Card")
		return { vars = { normal1, odds1, card.ability.extra.mult, normal2, odds2, card.ability.extra.p_dollars } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local hit = false 
			if SMODS.pseudorandom_probability(card, "may_lucky_card", 1, card.ability.extra.odds1, "Lucky Card") then 
				hit = true 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.mult}, colour = G.C.MULT, delay = 0.45})
				may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.mult})
			end
			if SMODS.pseudorandom_probability(card, "may_lucky_card", 1, card.ability.extra.odds2, "Lucky Card") then 
				hit = true 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.p_dollars}, colour = G.C.MONEY, delay = 0.45})
				may.hand_mod_dollars_all(v, false, -1, card.ability.extra.p_dollars)
			end
			if not hit then 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Nope!'}, colour = G.C.MULT, delay = 0.45})
			end
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do
			local hit = false 
			local mult = 0
			local dollars = 0
			for i=1, number do 
				if SMODS.pseudorandom_probability(card, "may_lucky_card", 1, card.ability.extra.odds1, "Lucky Card") then 
					hit = true 
					mult = mult + card.ability.extra.mult
				end
				if SMODS.pseudorandom_probability(card, "may_lucky_card", 1, card.ability.extra.odds2, "Lucky Card") then 
					hit = true 
					dollars = dollars + card.ability.extra.p_dollars
				end
			end
			if not hit then 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Nope!'}, colour = G.C.MULT, delay = 0.45})
			else 
				if mult > 0 then 
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..mult}, colour = G.C.MULT, delay = 0.45})
					may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.mult})
				end 
				if dollars > 0 then
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..dollars}, colour = G.C.MONEY, delay = 0.45})
					may.hand_mod_dollars_all(v, false, -1, dollars)
				end
			end 
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end
}

SMODS.Consumable {
	key = 'magma_card',
	config = { extra = { x_mult = 1.75, target = 'm_may_magma' } },
	loc_txt = {
		name = 'Magma Card',
		text = {
			{
				"Each {C:dark_edition}Magma Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}X#1#{} Mult to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:mult,C:white}X#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {0, card.ability.extra.x_mult})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult ^ number}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {0, card.ability.extra.x_mult})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'jagged_card',
	config = { extra = { bonus = 1.75, target = 'm_may_jagged' } },
	loc_txt = {
		name = 'Jagged Card',
		text = {
			{
				"Each {C:dark_edition}Jagged Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:chips,C:white}X#1#{} Chips to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:chips,C:white}X#2#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, card.ability.extra.bonus ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, nil, false, {0, card.ability.extra.bonus})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus ^ number}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(v, nil, false, {0, card.ability.extra.bonus ^ number}) 
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'super_mult_card',
	config = { extra = { bonus = 1.1, target = 'm_may_super_mult' } },
	loc_txt = {
		name = 'Super Mult Card',
		text = {
			{
				"Each {C:dark_edition}Super Mult Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}^#1#{} Mult to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:mult,C:white}^#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, to_big(card.ability.extra.bonus):arrow(2, amount) } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'^'..card.ability.extra.bonus}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {1, card.ability.extra.bonus})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local factor = math.abs(number) == 1 and card.ability.extra.bonus or to_big(card.ability.extra.bonus) ^ math.abs(number)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'^'..factor }, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {1, factor})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'grid_card',
	config = { extra = { bonus = 3, target = 'm_may_grid' } },
	loc_txt = {
		name = 'Grid Card',
		text = {
			{
				"Each {C:dark_edition}Grid Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:green,C:white}X#1#{} its {C:mult}+Mult{} to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + (v.ability.grid_mult or 0)
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, card.ability.extra.bonus * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus * (v.ability.grid_mult or 0)}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.bonus * (v.ability.grid_mult or 0)})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus * (v.ability.grid_mult or 0) * number}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.bonus * (v.ability.grid_mult or 0) * number})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'crystal_card',
	config = { extra = { dollars = 0.75, target = 'm_may_crystal' } },
	loc_txt = {
		name = 'Crystal Card',
		text = {
			{
				"Each {C:dark_edition}Crystal Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:money}+#1#{} Dollars to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:mult}except{} {C:attention}most played{} {C:purple}Poker Hand", 
				"{C:inactive}Currently{} {C:money}+#2#{} {C:inactive}Dollars, #3#{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.dollars, amount * card.ability.extra.dollars, may.favhand() } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.dollars..' Dollars'}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, -1, card.ability.extra.dollars, may.favhand())
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.dollars..' Dollars'}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, -1, card.ability.extra.dollars * number, may.favhand())
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'shadow_card',
	config = { extra = { bonus = 2, target = 'm_may_shadow' } },
	loc_txt = {
		name = 'Shadow Card',
		text = {
			{
				"Each {C:dark_edition}Shadow Card{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}+#1#{} Mult to {C:attention}all{} {C:purple}Poker Hands{}", 
				"per card {C:attention}held in hand{}",
				"{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, card.ability.extra.bonus * amount * #(G.hand or {cards = {}}).cards } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus * #G.hand.cards}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.bonus * #G.hand.cards})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus * #G.hand.cards * number}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(v, nil, false, nil, {-1, card.ability.extra.bonus * #G.hand.cards})
		end
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'geometric_card',
	config = { extra = { target = 'm_may_geometric' } },
	loc_txt = {
		name = 'Geometric Card',
		text = {
			{
				"Each {C:dark_edition}Geometric Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}XMult{} to each {C:purple}Poker Hand{}",
				"equal to {C:attention}half{} of the",
				"{C:attention}square-root{} of its {C:planet}level{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X(1+(sqrt(level) * 0.5))'}, colour = G.C.MULT, delay = 0.45})
			for k, v in pairs(G.GAME.hands) do
				v.mult = to_big(v.mult) * (1 + (math.sqrt(to_big(v.level)) * 0.5))
			end
			Q(function() v:juice_up(.2, .3) return true end)
			may.h('All Hands', '...', '...', '...')
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('multhit2')
				v:juice_up(1, 1)
			return true end}))
			may.hm('X...', true)
			may.ch()
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X(1+(sqrt(level) * 0.5)) (X'..number..')'}, colour = G.C.MULT, delay = 0.45})
			for k, v in pairs(G.GAME.hands) do
				v.mult = to_big(v.mult) * ((1 + (math.sqrt(to_big(v.level)) * 0.5)) ^ number)
			end
			Q(function() v:juice_up(.2, .3) return true end)
			may.h('All Hands', '...', '...', '...')
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('multhit2')
				v:juice_up(1, 1)
			return true end}))
			may.hm('X...', true)
			may.ch()
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'platinum_card',
	config = { extra = { bonus = 1.1, target = 'm_may_platinum' } },
	loc_txt = {
		name = 'Platinum Card',
		text = {
			{
				"Each {C:dark_edition}Platinum Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:money,C:white}X#1#{} Dollars to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:money,C:white}X#2#{} {C:inactive}Dollars{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	endless = true, 
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" } 
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, card.ability.extra.bonus ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, 0, card.ability.extra.bonus, false)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus ^ number}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, 0, card.ability.extra.bonus ^ number, false)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return G.GAME.may_endless_mode, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'fortune_card',
	config = { extra = { bonus = 0.1, target = 'm_may_fortune' } },
	loc_txt = {
		name = 'Fortune Card',
		text = {
			{
				"Each {C:dark_edition}Fortune Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:money,C:white}+X#1#{} Dollars to {C:attention}all{} {C:purple}Poker Hands{}", 
				"per held {C:tarot}Tarot Card{}",
				"{C:inactive}Currently{} {X:money,C:white}X#2#{} {C:inactive}Dollars{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	endless = true, 
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					for k2, v2 in pairs(G.consumeables.cards) do
						if v2:gc().set == 'Tarot' then
							return may.canuse()
						end
					end
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" } 
		local amount = 0
		local tarots = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		if G.consumeables then
			for k, v in pairs(G.consumeables.cards) do 
				if v:gc().set == 'Tarot' then
					tarots = tarots + 1
				end
			end
		end
		return { vars = { card.ability.extra.bonus, (1 + (card.ability.extra.bonus * tarots)) ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		local tarots = 0
		for k, v in pairs(G.consumeables.cards) do 
			if v:gc().set == 'Tarot' then
				tarots = tarots + 1
			end
		end
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..1 + (card.ability.extra.bonus * tarots)}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, 0, 1 + (card.ability.extra.bonus * tarots), false)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		local tarots = 0
		for k, v in pairs(G.consumeables.cards) do 
			if v:gc().set == 'Tarot' then
				tarots = tarots + 1
			end
		end
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..(1 + (card.ability.extra.bonus * tarots)) ^ number}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(v, false, 0, (1 + (card.ability.extra.bonus * tarots)) ^ number, false)
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return G.GAME.may_endless_mode, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

--[[SMODS.Consumable {
	key = 'titanium_card',
	config = { extra = { bonus1 = 2.5, bonus2 = 0.8, target = 'm_may_titanium' } },
	loc_txt = {
		name = 'Titanium Card',
		text = {
			{
				"Each {C:dark_edition}Titanium Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:money,C:white}X#1#{} Dollars and {X:planet,C:white}X#2#{} level", 
				"to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:money,C:white}X#3#{} {C:inactive}Dollars and{} {X:planet,C:white}X#4#{} {C:inactive}Level{} "
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	endless = true, 
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_hand_dollars_tutorial", set = "Other" }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus2, card.ability.extra.bonus1 ^ amount, card.ability.extra.bonus2 ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus1}, colour = G.C.MONEY, delay = 0.45})
			may.level_up_all_hands_hyper(card, false, card.ability.extra.bonus2, 0)
			may.hand_mod_dollars_all(v, false, 0, card.ability.extra.bonus1, false) 
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.bonus1 ^ number}, colour = G.C.MONEY, delay = 0.45})
			may.level_up_all_hands_hyper(card, false, card.ability.extra.bonus2 ^ number, 0)
			may.hand_mod_dollars_all(v, false, 0, card.ability.extra.bonus1 ^ number, false) 
		end
		may.refresh_score_operator()
		may.ch()
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	in_pool = function(self, args)
		return G.GAME.may_endless_mode, { allow_duplicates = false }
	end
}]] 

SMODS.Consumable {
	key = 'scorched_card',
	config = { extra = { bonus = 1.2, target = 'm_may_scorched' } },
	loc_txt = {
		name = 'Scorched Card',
		text = {
			{
				"Each {C:dark_edition}Scorched Card{}", 
				"{C:attention}held in hand{} gives", 
				"{X:planet,C:white}X#1#{} level", 
				"to {C:attention}all{} {C:purple}Poker Hands{}", 
				"{C:inactive}Currently{} {X:planet,C:white}X#2#{} {C:inactive}Level{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if SMODS.has_enhancement(v, card.ability.extra.target) then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus, card.ability.extra.bonus ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			may.level_up_all_hands_hyper(card, false, card.ability.extra.bonus, 0)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if SMODS.has_enhancement(v, card.ability.extra.target) then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			may.level_up_all_hands_hyper(card, false, card.ability.extra.bonus ^ amount, 0)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, self.config.extra.target) then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

-- Edition Cards

SMODS.Consumable {
	key = 'foil_card',
	config = { extra = { chips = 25, target = 'e_foil' } },
	loc_txt = {
		name = 'Foil Card',
		text = {
			{
				"Each card with {C:dark_edition}Foil Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:chips}+#1#{} Chips to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:chips}+#2#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 3, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'foil',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.chips, card.ability.extra.chips * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.chips}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + card.ability.extra.chips
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.chips*number}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + (card.ability.extra.chips * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end
}

SMODS.Consumable {
	key = 'holographic_card',
	config = { extra = { mult = 5, target = 'e_holo' } },
	loc_txt = {
		name = 'Holographic Card',
		text = {
			{
				"Each card with {C:dark_edition}Holographic Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}+#1#{} Mult to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:mult}+#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 1, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'holo',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.mult, card.ability.extra.mult * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.mult}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + card.ability.extra.mult
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.mult*number}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.mult * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end 
}

SMODS.Consumable {
	key = 'polychrome_card',
	config = { extra = { x_mult = 0.25, target = 'e_polychrome' } },
	loc_txt = {
		name = 'Polychrome Card',
		text = {
			{
				"Each card with {C:dark_edition}Polychrome Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}+X#1#{} Mult to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {X:mult,C:white}+X#2#{} {C:inactive}Mult{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'polychrome',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_mult}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_x_mult = (v2.ability.perma_x_mult or 0) + card.ability.extra.x_mult
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.x_mult*number}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_x_mult = (v2.ability.perma_x_mult or 0) + (card.ability.extra.x_mult * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end 
}

SMODS.Consumable {
	key = 'negative_card',
	config = { extra = { target = 'e_negative' } },
	loc_txt = {
		name = 'Negative Card',
		text = {
			{
				"Each card with {C:dark_edition}Negative Edition{}", 
				"{C:attention}held in hand{} creates", 
				"a random {C:dark_edition}Negative{}", 
				"{C:dark_edition}Modifier Card{}",
				"{C:inactive}Currently #1# Cards{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 5, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'negative',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+Modifier Card'}, colour = G.C.EDITION, delay = 0.45})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('timpani')
				local new = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, 'negative_card')
				new:add_to_deck()
				G.consumeables:emplace(new)
				new:set_edition('e_negative')
				new:juice_up(0.3, 0.5)
			return true end}))
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+Modifier Card'}, colour = G.C.EDITION, delay = 0.45})
			for i=1, number do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
					play_sound('timpani')
					local new = create_card('may_modifiercard', G.consumeables, nil, nil, nil, nil, nil, 'negative_card')
					new:add_to_deck()
					G.consumeables:emplace(new)
					new:set_edition('e_negative')
					new:juice_up(0.3, 0.5)
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end 
}

SMODS.Consumable {
	key = 'shimmering_card',
	config = { extra = { bonus1 = 7, bonus2 = 5, target = 'e_may_shimmering' } },
	loc_txt = {
		name = 'Shimmering Card',
		text = {
			{
				"Each card with {C:dark_edition}Shimmering Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:mult}+#3#{} {C:inactive}Mult and{} {C:chips}+#4#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_shimmering',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus2, card.ability.extra.bonus1 * amount, card.ability.extra.bonus2 * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + card.ability.extra.bonus1
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + card.ability.extra.bonus2
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1 * number}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.bonus1 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2 * number}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + (card.ability.extra.bonus2 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'laminated_card',
	config = { extra = { bonus1 = 1, bonus2 = 5, target = 'e_may_laminated' } },
	loc_txt = {
		name = 'Laminated Card',
		text = {
			{
				"Each card with {C:dark_edition}Laminated Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"per card with {C:dark_edition}Laminated Edition{} in {C:attention}full deck{}",
				"{C:inactive}Currently{} {C:mult}+#3#{} {C:inactive}Mult and{} {C:chips}+#4#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_laminated',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount1 = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount1 = amount1 + 1
				end
			end
		end 
		local amount2 = 0
		if G.playing_cards then 
			for k, v in pairs(G.playing_cards) do
				if v.edition and v.edition.key == 'e_may_laminated' then 
					amount2 = amount2 + 1
				end 
			end 
		end
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus2, card.ability.extra.bonus1 * amount1 * amount2, card.ability.extra.bonus2 * amount1 * amount2 } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		local amount = 0
		if G.playing_cards then 
			for k, v in pairs(G.playing_cards) do
				if v.edition and v.edition.key == 'e_may_laminated' then 
					amount = amount + 1
				end 
			end 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1 * amount}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.bonus1 * amount) 
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2 * amount}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + (card.ability.extra.bonus2 * amount)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		local amount = 0
		if G.playing_cards then 
			for k, v in pairs(G.playing_cards) do
				if v.edition and v.edition.key == 'e_may_laminated' then 
					amount = amount + 1
				end 
			end 
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1 * number * amount}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.bonus1 * number * amount)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2 * number * amount}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + (card.ability.extra.bonus2 * number * amount)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'amber_card',
	config = { extra = { bonus1 = -2, bonus2 = 20, target = 'e_may_amber' } },
	loc_txt = {
		name = 'Amber Card',
		text = {
			{
				"Each card with {C:dark_edition}Amber Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:mult}-#1#{} Mult and {C:chips}+#2#{} Chips to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:mult}-#3#{} {C:inactive}Mult and{} {C:chips}+#4#{} {C:inactive}Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_amber',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { math.abs(card.ability.extra.bonus1), card.ability.extra.bonus2,  math.abs(card.ability.extra.bonus1) * amount, card.ability.extra.bonus2 * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'-'.. math.abs(card.ability.extra.bonus1)}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + card.ability.extra.bonus1
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + card.ability.extra.bonus2
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'-'.. math.abs(card.ability.extra.bonus1) * number}, colour = G.C.MULT, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.bonus1 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus2 * number}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_bonus = (v2.ability.perma_bonus or 0) + (card.ability.extra.bonus2 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'goldfoil_card',
	config = { extra = { bonus1 = 1.5, target = 'e_may_goldfoil' } },
	loc_txt = {
		name = 'Goldfoil Card',
		text = {
			{
				"Each card with {C:dark_edition}Goldfoil Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:money}+#1#${} to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:money}+#2#${}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_goldfoil',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus1 * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1..'$'}, colour = G.C.MONEY, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_p_dollars = (v2.ability.perma_p_dollars or 0) + card.ability.extra.bonus1
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.bonus1 * number)..'$'}, colour = G.C.MONEY, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_p_dollars = (v2.ability.perma_p_dollars or 0) + (card.ability.extra.bonus1 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'neon_card',
	config = { extra = { bonus1 = 0.1, target = 'e_may_neon' } },
	loc_txt = {
		name = 'Neon Card',
		text = {
			{
				"Each card with {C:dark_edition}Neon Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:money}+#1#${} per owned card with an {C:dark_edition}Edition",
				"to {C:attention}all{} other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:money}+#2#${}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_neon',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		local amount2 = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
			for k, v in ipairs(G.jokers.cards) do
				if v.edition then
					amount2 = amount2 + 1
				end
			end
			for k, v in ipairs(G.consumeables.cards) do
				if v.edition then
					amount2 = amount2 + 1
				end
			end
			for k, v in ipairs(G.playing_cards) do
				if v.edition then
					amount2 = amount2 + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus1 * amount * amount2 } }
	end,
	use = function(self, card, area, copier)
		local amount = 0
		for k, v in ipairs(G.jokers.cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		for k, v in ipairs(G.consumeables.cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		for k, v in ipairs(G.playing_cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1 * amount..'$'}, colour = G.C.MONEY, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_p_dollars = (v2.ability.perma_p_dollars or 0) + (card.ability.extra.bonus1 * amount)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local amount = 0
		for k, v in ipairs(G.jokers.cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		for k, v in ipairs(G.consumeables.cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		for k, v in ipairs(G.playing_cards) do
			if v.edition then
				amount = amount + 1
			end
		end
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.perma_dollars * number * amount)..'$'}, colour = G.C.MONEY, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_p_dollars = (v2.ability.perma_p_dollars or 0) + (card.ability.extra.perma_dollars * number * amount)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'vignette_card',
	config = { extra = { bonus1 = 2, bonus2 = 0.15, target = 'e_may_vignette' } },
	loc_txt = {
		name = 'Vignette Card',
		text = {
			{
				"Each card with {C:dark_edition}Vignette Edition{}", 
				"{C:attention}held in hand{} gives", 
				"{C:purple}+#1#{} Mult & Chips and {X:purple,C:white}+X#2#{} Mult & Chips to {C:attention}all{}", 
				"other {C:attention}playing cards{} in full deck", 
				"{C:inactive}Currently{} {C:purple}+#3#{} {C:inactive}Mult & Chips and{} {X:purple,C:white}+X#4#{} {C:inactive}Mult & Chips{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	modifier_shader = 'may_shimmering',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.edition and v.edition.key == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.bonus1, card.ability.extra.bonus2,  card.ability.extra.bonus1 * amount, card.ability.extra.bonus2 * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.bonus1..'Mult & Chips'}, colour = G.C.PURPLE, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + card.ability.extra.bonus1
					v2.ability.perma_chips = (v2.ability.perma_chips or 0) + card.ability.extra.bonus1
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.bonus2..'Mult & Chips'}, colour = G.C.PURPLE, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_x_mult = (v2.ability.perma_x_mult or 0) + card.ability.extra.bonus2
					v2.ability.perma_x_chips = (v2.ability.perma_x_chips or 0) + card.ability.extra.bonus2
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.edition and v.edition.key == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.bonus1 * number)..'Mult & Chips'}, colour = G.C.PURPLE, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_mult = (v2.ability.perma_mult or 0) + (card.ability.extra.bonus1 * number)
					v2.ability.perma_chips = (v2.ability.perma_chips or 0) + (card.ability.extra.bonus1 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..(card.ability.extra.bonus2 * number)..'Mult & Chips'}, colour = G.C.PURPLE, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if not table_hasvalue(targets, v2) then 
					v2.ability.perma_x_mult = (v2.ability.perma_x_mult or 0) + (card.ability.extra.bonus2 * number)
					v2.ability.perma_x_chips = (v2.ability.perma_x_chips or 0) + (card.ability.extra.bonus2 * number)
					if v2.area ~= G.deck and v2.area ~= G.discard then
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus', 1, 0.5)
						return true end})) 
					end 
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader(self.modifier_shader, nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.edition and v.edition.key == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

-- Seal Cards

SMODS.Consumable {
	key = 'red_seal_card',
	config = { extra = { retriggers = 1, target = 'Red' } },
	loc_txt = {
		name = 'Red Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Red Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{C:attention}+#1#{} retrigger to", 
				"{C:attention}1{} {C:green}random{} card {C:attention}held in hand{}",
				"{C:inactive}Currently +#2# retriggers{}"
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 1, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.retriggers, card.ability.extra.retriggers * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.retriggers..' Retriggers'}, colour = G.C.FILTER, delay = 0.45})
			local card2 = pseudorandom_element(G.hand.cards, 'may_red_seal_card')
			card2.ability.perma_repetitions = (card2.ability.perma_repetitions or 0) + card.ability.extra.retriggers
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				card2:juice_up(0.3, 0.5)
				play_sound('may_permabonus', 1, 0.6)
			return true end}))
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			for i = 1, number do
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.retriggers..' Retriggers'}, colour = G.C.FILTER, delay = 0.45})
				local card2 = pseudorandom_element(G.hand.cards, 'may_red_seal_card')
				card2.ability.perma_repetitions = (card2.ability.perma_repetitions or 0) + card.ability.extra.retriggers
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
					card2:juice_up(0.3, 0.5)
					play_sound('may_permabonus', 1, 0.6)
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
}

SMODS.Consumable {
	key = 'blue_seal_card',
	config = { extra = { planets = 2, target = 'Blue' } },
	loc_txt = {
		name = 'Blue Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Blue Seal{}", 
				"{C:attention}held in hand{} creates", 
				"{C:attention}#1#{} random {C:planet}Planet Cards{}", 
				"{C:inactive}Currently #2# Planet Cards{}",
				"{C:inactive}Does not require room{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.planets, card.ability.extra.planets * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.planets..' Planets'}, colour = G.C.SECONDARY_SET.Planet, delay = 0.45})
			for i = 1, card.ability.extra.planets do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Planet", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.planets * number..' Planets'}, colour = G.C.SECONDARY_SET.Planet, delay = 0.45})
			for i = 1, card.ability.extra.planets * number do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Planet", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
}

SMODS.Consumable {
	key = 'purple_seal_card',
	config = { extra = { tarots = 2, target = 'Purple' } },
	loc_txt = {
		name = 'Purple Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Purple Seal{}", 
				"{C:attention}held in hand{} creates", 
				"{C:attention}#1#{} random {C:tarot}Tarot Cards{}", 
				"{C:inactive}Currently #2# Tarot Cards{}",
				"{C:inactive}Does not require room{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 2, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.tarots, card.ability.extra.tarots * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.tarots..' Tarots'}, colour = G.C.SECONDARY_SET.Tarot, delay = 0.45})
			for i = 1, card.ability.extra.tarots do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Tarot", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.tarots * number..' Tarots'}, colour = G.C.SECONDARY_SET.Tarot, delay = 0.45})
			for i = 1, card.ability.extra.tarots * number do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Tarot", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
}

SMODS.Consumable {
	key = 'gold_seal_card',
	config = { extra = { interest_cap = 5, target = 'Gold' } },
	loc_txt = {
		name = 'Gold Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Gold Seal{}", 
				"{C:attention}held in hand{} gives {C:money}+#1#{} Interest Cap",
				"{C:inactive}Currently{} {C:money}+#2#{} {C:inactive}Interest Cap{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.interest_cap, card.ability.extra.interest_cap * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.interest_cap..' Interest Cap'}, colour = G.C.MONEY, delay = 0.45})
			may.ease_interest_cap(-1, card.ability.extra.interest_cap)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..(card.ability.extra.interest_cap * number)..' Interest Cap'}, colour = G.C.MONEY, delay = 0.45})
			may.ease_interest_cap(-1, card.ability.extra.interest_cap * number)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
		end
	end
}

SMODS.Consumable {
	key = 'copper_seal_card',
	config = { extra = { odds = 3, target = 'may_copper_seal' } },
	loc_txt = {
		name = 'Copper Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Copper Seal{}", 
				"{C:attention}held in hand{}", 
				"has a {C:green}#1# in #2#{} chance", 
				"to redeem a random regular {C:green}Voucher{}",
			}, 
			{
				"{C:inactive,E:1}Art by Superb Thing{}"
			}
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local normal, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "Copper Seal Card")
		return { vars = { normal, odds } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			if SMODS.pseudorandom_probability(card, "may_copper_seal", 1, card.ability.extra.odds, "Copper Seal") then
			    card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+1 Voucher'}, colour = G.C.GREEN, delay = 0.45})
				G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				    may.voucher(may.get_next_voucher_key())
			    return true end}))
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.RED,
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
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			for i = 1, number do
			    if SMODS.pseudorandom_probability(card, "may_copper_seal", 1, card.ability.extra.odds, "Copper Seal") then
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+1 Voucher'}, colour = G.C.GREEN, delay = 0.45})
				    G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
						may.voucher(may.get_next_voucher_key())
					return true end}))
			    else
				    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.RED,
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
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end, 
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'yellow_seal_card',
	config = { extra = { spectrals = 1, target = 'may_yellow_seal' } },
	loc_txt = {
		name = 'Yellow Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Yellow Seal{}", 
				"{C:attention}held in hand{} creates", 
				"{C:attention}#1#{} random {C:spectral}Spectral Card{}", 
				"{C:inactive}Currently #2# Spectral Cards{}",
				"{C:inactive}Does not require room{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 3 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.spectrals, card.ability.extra.spectrals * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.spectrals..' Spectral'}, colour = G.C.SECONDARY_SET.Spectral, delay = 0.45})
			for i = 1, card.ability.extra.spectrals do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Spectral", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.spectrals * number..' Spectral'}, colour = G.C.SECONDARY_SET.Spectral, delay = 0.45})
			for i = 1, card.ability.extra.spectrals * number do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local card2 = create_card("Spectral", G.consumables, nil, nil, nil, nil, nil, "may_blue_seal_cards")
					card2:add_to_deck()
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'lime_seal_card',
	config = { extra = { x_chips = 1.2, target = 'may_lime_seal' } },
	loc_txt = {
		name = 'Lime Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Lime Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{X:chips,C:white}X#1#{} Chips to all {C:purple}Poker Hands{}", 
				"{C:inactive}Currently X#2# Chips{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 2, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_chips, card.ability.extra.x_chips ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_chips..' Chips'}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(card, false, {0, card.ability.extra.x_chips})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_chips ^ number..' Chips'}, colour = G.C.CHIPS, delay = 0.45})
			may.hand_multchips_all(card, false, {0, card.ability.extra.x_chips ^ number})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'inverted_seal_card',
	config = { extra = { consumables = 1, target = 'may_inverted_seal' } },
	loc_txt = {
		name = 'Inverted Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Inverted Seal{}", 
				"{C:attention}held in hand{} creates", 
				"{C:attention}#1#{} random {C:dark_edition}Negative{} {C:attention}Consumable{}",
				"{C:inactive}Currently #2# Consumables{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.consumables, card.ability.extra.consumables * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.consumables..' Consumable'}, colour = G.C.DARK_EDITION, delay = 0.45})
			for i = 1, card.ability.extra.consumables do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local choice = may.random_consumable('may_inverted_seal_card')
					local card2 = create_card(choice.set, G.consumables, nil, nil, nil, nil, choice.key, "may_inverted_seal_card")
					card2:add_to_deck()
					card2:set_edition('e_negative')
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+'..card.ability.extra.consumables * number..' Consumables'}, colour = G.C.DARK_EDITION, delay = 0.45})
			for i = 1, card.ability.extra.consumables * number do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
					local choice = may.random_consumable('may_inverted_seal_card')
					local card2 = create_card(choice.set, G.consumables, nil, nil, nil, nil, choice.key, "may_inverted_seal_card")
					card2:add_to_deck()
					card2:set_edition('e_negative')
					G.consumeables:emplace(card2)
					play_sound('timpani')
				return true end}))
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'orange_seal_card',
	config = { extra = { x_mult = 1.2, target = 'may_orange_seal' } },
	loc_txt = {
		name = 'Orange Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Orange Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}X#1#{} Mult to all {C:purple}Poker Hands{}", 
				"{C:inactive}Currently X#2# Mult{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult..' Mult'}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(card, false, nil, {0, card.ability.extra.x_mult})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_mult ^ number..' Mult'}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(card, false, nil, {0, card.ability.extra.x_chips ^ number})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'pink_seal_card',
	config = { extra = { x_level = 1.15, x_dollars = 0.75, target = 'may_pink_seal' } },
	loc_txt = {
		name = 'Pink Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Pink Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{X:planet,C:white}X#1#{} Level but {X:money,C:white}X#2#${}",
				"to all {C:purple}Poker Hands{}", 
				"{C:inactive}Currently X#3# Level and X#4#${}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_level, card.ability.extra.x_dollars, card.ability.extra.x_level ^ amount, card.ability.extra.x_dollars ^ amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_level..' Level'}, colour = G.C.SECONDARY_SET.Planet, delay = 0.45})
			may.level_up_all_hands_hyper(card, false, card.ability.extra.x_level, 0)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_dollars..'$'}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(card, false, card.ability.extra.x_dollars, 0)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_level ^ number..' Level'}, colour = G.C.SECONDARY_SET.Planet, delay = 0.45})
			may.level_up_all_hands_hyper(card, false, card.ability.extra.x_level ^ number, 0)
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..card.ability.extra.x_dollars ^ number..'$'}, colour = G.C.MONEY, delay = 0.45})
			may.hand_mod_dollars_all(card, false, card.ability.extra.x_dollars ^ number, 0)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'silver_seal_card',
	config = { extra = { x_mult = 1.1, mul = 1.4, target = 'may_silver_seal' } },
	loc_txt = {
		name = 'Silver Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Silver Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{X:mult,C:white}X#1#{} Mult to all {C:purple}Poker Hands{},", 
				"{C:green}bonus{} per card is {C:green}multiplied{} by {X:green,C:white}X#2#{}",
				"for every card with {C:dark_edition}Silver Seal{}", 
				"{C:attention}held in hand{}", 
				"{C:inactive}Currently X#3# Mult{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.x_mult, card.ability.extra.mul, (card.ability.extra.x_mult * (card.ability.extra.mul ^ amount)) ^ amount, } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..(card.ability.extra.x_mult * (card.ability.extra.mul ^ #targets))..' Mult'}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(card, false, nil, {0, (card.ability.extra.x_mult * (card.ability.extra.mul ^ #targets))})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'X'..((card.ability.extra.x_mult * (card.ability.extra.mul ^ #targets)) ^ number)..' Mult'}, colour = G.C.MULT, delay = 0.45})
			may.hand_multchips_all(card, false, nil, {0, ((card.ability.extra.x_mult * (card.ability.extra.mul ^ #targets)) ^ number)})
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'white_seal_card',
	config = { extra = { mul = 12, target = 'may_white_seal' } },
	loc_txt = {
		name = 'White Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}White Seal{}", 
				"{C:attention}held in hand{} gains", 
				"{C:chips}+Chips{} equal to {X:green,C:white}X#1#{}", 
                "their {C:attention}Nominal Chips{}", 
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		return { vars = { card.ability.extra.mul, } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus'})
			v.ability.perma_bonus = (v.ability.perma_bonus or 0) + (v:may_get_nominal_chips() * card.ability.extra.mul)
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus'})
			v.ability.perma_bonus = (v.ability.perma_bonus or 0) + (v:may_get_nominal_chips() * card.ability.extra.mul * number )
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end
}

SMODS.Consumable {
	key = 'black_seal_card',
	config = { extra = { add_mul = 0.5, target = 'may_black_seal' } },
	loc_txt = {
		name = 'Black Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}Black Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{X:chips,C:white}+X#1#{} Chips to all",
				"cards with {C:dark_edition}Black Seal{} in full deck{}",
				"{C:inactive}Currently +X#2# Chips{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { card.ability.extra.add_mul, card.ability.extra.add_mul * amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..card.ability.extra.add_mul..' Chips'}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if v2.seal and v2.seal == card.ability.extra.target then 
					v2.ability.perma_x_chips = (v2.ability.perma_x_chips or 0) + card.ability.extra.add_mul
					if v2.area == G.hand or v2.area == G.jokers or v2.area == G.consumeables then
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus')
						return true end}))
					end
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+X'..(card.ability.extra.add_mul * number)..' Chips'}, colour = G.C.CHIPS, delay = 0.45})
			for k2, v2 in pairs(G.playing_cards) do
				if v2.seal and v2.seal == card.ability.extra.target then 
					v2.ability.perma_x_chips = (v2.ability.perma_x_chips or 0) + (card.ability.extra.add_mul * number)
					if v2.area == G.hand or v2.area == G.jokers or v2.area == G.consumeables then
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
							v2:juice_up(0.3, 0.5)
							play_sound('may_permabonus')
						return true end}))
					end
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}

SMODS.Consumable {
	key = 'error_seal_card',
	config = { extra = { target = 'may_error_seal' } },
	loc_txt = {
		name = 'ERROR Seal Card',
		text = {
			{
				"Each card with {C:dark_edition}ERROR Seal{}", 
				"{C:attention}held in hand{} gives", 
				"{C:may_ethereal,E:1}unknown{} bonuses",
				"{C:inactive}Currently #1# ????s{}",
			}, 
		}
	},
	set = 'may_modifiercard',
	pos = { x = 0, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
	reserve = true, 
	atlas = 'modifier',
	can_use = function(self, card)
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					return may.canuse()
				end
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card) 
		info_queue[#info_queue + 1] = SMODS.Seals[card.ability.extra.target]
		local amount = 0
		if G.hand then
			for k, v in pairs(G.hand.cards) do 
				if v.seal and v.seal == card.ability.extra.target then
					amount = amount + 1
				end
			end
		end 
		return { vars = { amount } }
	end,
	use = function(self, card, area, copier)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			local choice = pseudorandom(pseudoseed('may_present'), 1, 5)
			if choice == 1 then 
				for k, v in pairs(G.hand.cards) do
					v.ability.perma_mult = (v.ability.perma_mult or 0) + 5
					card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
				end
			elseif choice == 2 then 
				for k, v in pairs(G.hand.cards) do
					v.ability.perma_chips = (v.ability.perma_chips or 0) + 7
					card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus' })
				end
			elseif choice == 3 then 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+0.1 Interest'}, colour = G.C.MONEY, delay = 0.45})
				may.ease_interest(-1, 0.25)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					card:juice_up(0.3, 0.5)
				return true end}))
			elseif choice == 4 then 
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+1 Tag'}, colour = G.C.FILTER, delay = 0.45})
				may.random_tag()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					play_sound('tarot1')
					card:juice_up(0.3, 0.5)
				return true end}))
			else
				may.level_up_all_hands(card, nil, false, 0.5)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		local targets = {}
		for k, v in pairs(G.hand.cards) do 
			if v.seal and v.seal == card.ability.extra.target then 
				table.insert(targets, v)
			end
		end
		for k, v in pairs(targets) do 
			local percent = 0.85 + (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = true
				play_sound('card1', percent)
			return true end})) 
		end
		for k, v in pairs(targets) do 
			for i = 1, number do
				local choice = pseudorandom(pseudoseed('may_present'), 1, 5)
				if choice == 1 then 
					for k, v in pairs(G.hand.cards) do
						v.ability.perma_mult = (v.ability.perma_mult or 0) + 5
						card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.MULT, delay = 0.45, sound = 'may_permabonus' })
					end
				elseif choice == 2 then 
					for k, v in pairs(G.hand.cards) do
						v.ability.perma_chips = (v.ability.perma_chips or 0) + 7
						card_eval_status_text(v, 'extra', nil, nil, nil, { message = {'Upgraded!'}, colour = G.C.CHIPS, delay = 0.45, sound = 'may_permabonus' })
					end
				elseif choice == 3 then 
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+0.1 Interest'}, colour = G.C.MONEY, delay = 0.45})
					may.ease_interest(-1, 0.25)
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						card:juice_up(0.3, 0.5)
					return true end}))
				elseif choice == 4 then 
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = {'+1 Tag'}, colour = G.C.FILTER, delay = 0.45})
					may.random_tag()
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						play_sound('tarot1')
						card:juice_up(0.3, 0.5)
					return true end}))
				else
					may.level_up_all_hands(card, nil, false, 0.5)
				end
			end
		end
		for k, v in pairs(targets) do 
			local percent = 1.15 - (k-0.999)/(#targets-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
				v.highlighted = false
				play_sound('card1', percent)
			return true end})) 
		end
	end,
    in_pool = function(self, args)
		for k, v in pairs(G.playing_cards) do
			if v.seal == self.config.extra.target then
				return true, {allow_duplicates = true}
			end
		end
		return false, {allow_duplicates = false}
	end 
}