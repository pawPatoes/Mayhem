-- Displays

-- Deprecated
function may.toggle_ring_display(enable)
	may.toggle_display('c_may_ring_display', enable)
end

function may.toggle_display(key, enable)
	G.GAME.may_displays = G.GAME.may_displays or {} 
	if enable then
		if not (G.GAME.may_displays[key] or {})[1] then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local card2 = create_card('may_display', G.deck, nil, nil, nil, nil, nil, key)
				G.deck:remove_card(card2)
				card2:set_eternal(true)
				G.GAME.may_displays[key] = {true, card2}
			return true end}))
		end
	else
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			for k, v in pairs(G.GAME.may_displays or {}) do
				if k == key and v[1] then
					if v[2] and v[2].start_dissolve then
						v[2]:start_dissolve() 
					end
					G.GAME.may_displays[key] = {false, nil}
				end
			end
		return true end}))
	end
end