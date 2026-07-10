-- Consumable variants

-- Deprecated, kept for compatibility
-- Add upsd_base to your center instead
may.can_be_upsd = {}

function may.has_upsd(key)
	for k, v in pairs(G.P_CENTERS) do
		if (v.upsd_base or '') == key then
			return true
		end
	end
	return false
end

function may.get_upsd(key)
	for k, v in pairs(G.P_CENTERS) do
		if (v.upsd_base or '') == key then
			return v
		end
	end
	return
end

local ccr = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if G.STAGE ~= G.STAGES.MAIN_MENU and card.gc and card:gc() then
		if not G.GAME.may_asc_rate then
			G.GAME.may_asc_rate = 100
		end
        if not G.GAME.may_upsd_rate then
			G.GAME.may_upsd_rate = 80
		end
		
		if card.gc and may.has_upsd(card:gc().key) and not G.GAME.banned_keys[may.get_upsd(card:gc().key).key] then	
			if (G.GAME.may_upside_down_deck or SMODS.pseudorandom_probability(card, "may_spawn_upsd", 1, G.GAME.may_upsd_rate, "Upside Down")) then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function() 
					if (not card.no_upsd) and (not card.no_variants) then 
						card:set_ability(G.P_CENTERS[may.get_upsd(card:gc().key).key])
						card:set_cost()
					end
				return true end})) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
					if (not card.no_upsd) and (not card.no_variants) then 
						play_sound('may_upside_down', 1, 0.75)
						card:juice_up(1, 0.5)
					end
				return true end}))
			end
		end
		-- Play special card sounds		
		if card and card:gc().set == 'yottacards' then 
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
				play_sound('may_yotta', 1, 0.75)
				card:juice_up(1, 0.5)
				G.ROOM.jiggle = G.ROOM.jiggle + 3
			return true end}))
		elseif card:gc().on_discover and type(card:gc().on_discover) == 'function' then 
			G.E_MANAGER:add_event(Event({func = function()
				card:gc().on_discover(card, area, skip_materialize)
			return true end}))
		end
		-- Osmium deck
		if G.GAME.may_osmium_deck and card.ability.consumeable and card:gc().set ~= 'may_display' then
			card:set_edition('e_may_metallic')
		end
	end
	return card
end