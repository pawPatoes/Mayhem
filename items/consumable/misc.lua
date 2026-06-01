-- Miscellaneous Consumables

SMODS.Consumable {
	key = 'present',
	set = 'may_misc',
	name = 'Medusa',
	loc_txt = {
		name = "Present",
		text = {
			"Does {C:attention}one{} of the following", 
			"when {C:green}opened{}:", 
			may.pager(45),
			"Create a random {C:tarot}Tarot{},", 
			"{C:planet}Planet{} or {C:spectral}Spectral{} Card", 
			may.pager(45), 
			"Create a {C:attention}random Joker{}",
			may.pager(45),
			"{C:money}+$10{}",
			may.pager(45), 
			"Create {C:attention}2{} random {C:attention}Tags{}", 
			may.pager(45), 
			"{C:inactive}Does not require room{}"
		}
	},
	pos = { x = 0, y = 0 },
	display_size = { w = 71, h = 71 },
	atlas = 'present',
	cost = 8,
	unlocked = true,
	no_grc = true, 
	no_doe = true,
	can_use = function(self, card)
		return may.canuse()
	end,
	discovered = true,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('may_bundle')
			card:may_explode(nil, nil, true)
		return true end}))
		local choice = pseudorandom(pseudoseed('may_present'), 1, 4)
		if choice == 1 then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				SMODS.add_card({ set = pseudorandom_element({'Tarot', 'Planet', 'Spectral'}, pseudoseed('may_present')) })
				play_sound('timpani')
			return true end})) 
		elseif choice == 2 then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				SMODS.add_card({ set = 'Joker' })
				play_sound('timpani')
			return true end}))
		elseif choice == 3 then 
			ease_dollars(10)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
			return true end}))
		else 
			for i = 1, 2 do
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    play_sound('tarot1')
				    may.random_tag()
			    return true end}))
			end
		end
	end,
	bulk_use = function(self, card, area, copier, number)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('may_bundle')
			card:may_explode(nil, nil, true)
		return true end}))
		local choices = {0, 0, 0, 0}
		for i = 1, number do 
			local choice = pseudorandom(pseudoseed('may_present'), 1, 4)
			choices[choice] = choices[choice] + 1
		end
		if choices[1] > 0 then 
			for i = 1, choices[1] do
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    SMODS.add_card({ set = pseudorandom_element({'Tarot', 'Planet', 'Spectral'}, pseudoseed('may_present')) })
				    play_sound('timpani')
			    return true end})) 
			end
		end
		if choices[2] > 0 then 
			for i = 1, choices[2] do
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    SMODS.add_card({ set = 'Joker' })
				    play_sound('timpani')
			    return true end}))
			end
		end
		if choices[3] > 0 then
			ease_dollars(10 * choices[3])
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				play_sound('timpani')
			return true end}))
		end 
		if choices[4] > 0 then 
			for i = 1, 2 * choices[4] do
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				    play_sound('tarot1')
				    may.random_tag()
			    return true end}))
			end
		end
	end
}