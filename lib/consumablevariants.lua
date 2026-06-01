-- Consumable variants
-- code mostly taken from POLTERWORX
-- you will need to copy this and replace may_ with your mod prefix if you add empowered consumables

may.can_be_upsd = {
	'fool',
	'magician',
	'high_priestess',
	'empress',
	'emperor',
	'heirophant',
	'lovers',
	'chariot',
	'justice',
	'hermit',
	'wheel_of_fortune',
	'strength',
	'hanged_man',
	'death',
	'temperance',
	'devil',
	'tower',
	'star',
	'moon',
	'sun',
	'judgement',
	'world',

	'mercury',
	'venus',
	'earth',
	'mars',
	'jupiter',
	'saturn',
	'uranus',
	'neptune',
	'pluto',
	'planet_x',
	'ceres',
	'eris',
	'may_proxima_centauri',
	
	'familiar',
	'grim', 
	'incantation',
	'talisman',
	'aura',
	'wraith',
	'sigil',
	'ouija',
	'ectoplasm',
	'immolate',
	'ankh',
	'deja_vu',
	'hex',
	'trance',
	'medium',
	'cryptid',
	'soul',
	'black_hole'
}

may.can_be_ascended = {
	'fool',
	'magician',
	'high_priestess',
	'empress',
	'hermit',
	
	'pluto',
	
	'familiar',
	
	'may_planetae', 
	'may_cupiditas',
	'may_potestas',
    'may_speculum'
}

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
		-- Ascended 
		if G.GAME.selected_back.effect.center.original_key ~= 'celestial_hierarchy_deck' then
			for k, v in pairs(may.can_be_ascended) do
				if pseudorandom('spawn_ascended') < 1 / G.GAME.may_asc_rate and card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v.. '_asc'] and not G.GAME.banned_keys['c_may_'..v.. '_asc'] then
					G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
						if card then
							card:set_ability(G.P_CENTERS['c_may_'..v..'_asc'])
							card:set_cost()
							if card:gc().set ~= 'yottacards' then
							    play_sound('may_c_ascended', 1, 1.5)
								card:juice_up(1, 1)
							else
								play_sound('may_ascended_yotta')
								card:juice_up(2, 2)
								G.ROOM.jiggle = G.ROOM.jiggle + 0.7
							end
						end
					return true end}))
					break
				end
			end
		else
			
        end
		-- Upside down
		if G.GAME.may_upside_down_deck then
			for k, v in pairs(may.can_be_upsd) do
				if card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v..'_upsd'] and not G.GAME.banned_keys['c_may_'..v.. '_upsd'] then
					card:set_ability(G.P_CENTERS['c_may_'..v..'_upsd'])
					card:set_cost()
					break
				end
			end
		else
			if pseudorandom('may_spawn_upsd') < 1 / G.GAME.may_upsd_rate then 
				for k, v in pairs(may.can_be_upsd) do
					if card:gc().key == ('c_'..v) and G.P_CENTERS['c_may_'..v..'_upsd'] and not G.GAME.banned_keys['c_may_'..v.. '_upsd'] then
						card:set_ability(G.P_CENTERS['c_may_'..v..'_upsd'])
						card:set_cost()
						break
					end
				end
			end
		end
		-- Play special card sounds		
		if card and card:gc().set == 'upside_down_tarots' or card:gc().set == 'upside_down_planets' or card:gc().set == 'upside_down_spectrals' then
			G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, blockable = false, blocking = false, func = function()
					play_sound('may_upside_down', 1, 0.75)
					card:juice_up(1, 0.5)
				return true end}))
			return true end}))
		end
		if card and card:gc().set == 'yottacards' then
			G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
					play_sound('may_yotta', 1, 0.75)
					card:juice_up(1, 0.5)
					G.ROOM.jiggle = G.ROOM.jiggle + 3
				return true end}))
			return true end}))
		end
		if card and card:gc().set == 'ascendedyottas' then
				G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
					play_sound('may_ascended_yotta')
					card:juice_up(2, 2)
					G.ROOM.jiggle = G.ROOM.jiggle + 20
				return true end}))
			return true end}))
		end
		if card and card:gc().planet_rarity == 2 then
			G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
					play_sound('may_rare_planet', 1, 0.75)
					card:juice_up(1, 0.5)
				return true end}))
			return true end}))
		end
		if card and card:gc().planet_rarity == 3 then
			G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
					play_sound('may_legendary_planet', 1, 0.75)
					card:juice_up(1, 0.5)
					G.ROOM.jiggle = G.ROOM.jiggle + 3
				return true end}))
			return true end}))
		end
		if card and card:gc().planet_rarity == 4 then
			G.E_MANAGER:add_event(Event({func = function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, blockable = false, blocking = false, func = function()
					play_sound('may_mythic_planet', 1, 0.75)
					card:juice_up(1, 0.5)
					G.ROOM.jiggle = G.ROOM.jiggle + 5
				return true end}))
			return true end}))
		end
		if card:gc().on_discover and type(card:gc().on_discover) == 'function' then 
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