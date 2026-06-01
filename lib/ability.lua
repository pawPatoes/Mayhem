-- Card abilities
-- Buttons are in hooks.lua

G.FUNCS.may_can_use_ourania_kleidaria_ability = function(e)
	local joker
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == e.config.ref_table then
			if i < #G.jokers.cards then
				joker = G.jokers.cards[i + 1]
			end
        end
    end
	if joker and not SMODS.is_eternal(joker) then
		e.config.colour = G.C.DARK_EDITION
		e.config.button = "may_ourania_kleidaria_ability"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.may_ourania_kleidaria_ability = function(e)
	local joker
	for i = 1, #G.jokers.cards do
		if G.jokers.cards[i] == e.config.ref_table then
			if i < #G.jokers.cards then
				joker = G.jokers.cards[i + 1]
			end
        end
    end
	G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
		joker:set_eternal(true)
        joker:juice_up(0.3, 0.5)
        e.config.ref_table:juice_up(0.3, 0.5)
        play_sound('tarot1')
	return true end}))
end

G.FUNCS.may_can_use_guacamole_ability = function(e)
	if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
		e.config.colour = G.C.DARK_EDITION
		e.config.button = "may_guacamole_ability"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.may_guacamole_ability = function(e)
	SMODS.add_card({ key = 'c_may_quac_n7' })
	may.hypermoney(0, e.config.ref_table.ability.extra.x_dollars or 0.2)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
		play_sound('tarot1')
		play_sound('holo1')
		e.config.ref_table:juice_up(0.3, 0.5)
		e.config.ref_table:start_dissolve()
	return true end}))
end  