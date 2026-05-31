-- Displays

function may.toggle_ring_display(enable)
	if enable then
		local found
		for k, v in pairs(G.GAME.may_displays or {}) do
			if v and v:gc().key == 'c_may_ring_display' then
				found = true
				break
			end
		end
		if not found then
			G.GAME.may_displays = G.GAME.may_displays or {}
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local card2 = create_card('may_display', G.deck, nil, nil, nil, nil, nil, 'may_ring_display')
				G.deck:remove_card(card2)
				card2:set_eternal(true)
				table.insert(G.GAME.may_displays, card2)
			return true end}))
		end
	else
		if G.GAME.may_displays then
		    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			    for k, v in pairs(G.GAME.may_displays or {}) do
				    if v and v:gc().key == 'c_may_ring_display' then
					    v:start_dissolve()
				    end
			    end
				G.GAME.may_displays = {}
		    return true end}))
		end
	end
end