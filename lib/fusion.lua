-- Mostly copy and paste from FusionJokers, specificially the fork made by lshtech: https://github.com/lshtech/Fusion-Jokers

G.localization.misc.dictionary["b_fuse"] = "FUSE"
may.fusions = { recipes = { } }

function may.fusions:add_fusion(joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, code, shake, condition)
	table.insert(self.recipes, 
		{ jokers = {
			{ name = joker1, carry_stat = carry_stat1, extra_stat = extra1 },
			{ name = joker2, carry_stat = carry_stat2, extra_stat = extra2 }
		}, result_joker = result_joker, cost = cost, sound = sound, code = code, shake = shake, condition = condition }
	)
end

local function has_joker(val, start_pos)
	if not start_pos then
		start_pos = 0
	end
	for i, v in ipairs(G.jokers.cards) do
		if v.ability.set == 'Joker' and v.config.center_key == val and i > start_pos then
			return i
		end
	end
	return -1
end

function Card:may_fuse_card()
	G.CONTROLLER.locks.selling_card = true
    stop_use()
    local area = self.area
    G.CONTROLLER:save_cardarea_focus('jokers')
    if self.children.use_button then self.children.use_button:remove(); self.children.use_button = nil end
    if self.children.sell_button then self.children.sell_button:remove(); self.children.sell_button = nil end
	local my_pos = has_joker(self.config.center_key)
	local edition = nil
	if self.edition then
		edition = self.edition
	end
	local chosen_fusion = nil
	local joker_pos = {}
	local found_me = false
	for _, fusion in ipairs(may.fusions.recipes) do
		joker_pos = {}
		found_me = false
		for _, joker in ipairs(fusion.jokers) do
			if fusion.jokers[1].name == fusion.jokers[2].name then
				if #SMODS.find_card(joker.name) > 1 and #joker_pos == 0 then
					local first_pos = has_joker(joker.name)
					table.insert(joker_pos, {pos = first_pos, joker = joker})
					table.insert(joker_pos, {pos = has_joker(joker.name, first_pos), joker = joker})
				end
			elseif next(SMODS.find_card(joker.name)) then
				table.insert(joker_pos, {pos = has_joker(joker.name), joker = joker})
			end
			if joker.name == self.config.center_key then
				found_me = true
			end
		end
		if #joker_pos == #fusion.jokers and found_me then
			chosen_fusion = fusion
			break
		end
	end
	if chosen_fusion ~= nil then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
			play_sound('whoosh1')
			for _, pos in ipairs(joker_pos) do
				if not edition and G.jokers.cards[pos.pos].edition then
					edition = G.jokers.cards[pos.pos].edition
				end
				G.jokers.cards[pos.pos]:juice_up(0.3, 0.4)
			end
			return true
		end}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			ease_dollars(-(chosen_fusion.cost * (G.GAME.may_fusion_price_multiplier or 1)))
			local j_fusion = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_fusion.result_joker, nil)
			if edition and not j_fusion.edition then
				j_fusion.edition = edition
			end
			table.sort(joker_pos, function (a, b)
				return a.pos > b.pos
			end)
			for index, pos in ipairs(joker_pos) do
				local isPrimary = false
				if G.jokers.cards[pos.pos] == self then
					isPrimary = true
				end
				for k,_ in pairs(SMODS.Stickers) do
					if G.jokers.cards[pos.pos].ability[k] then
						j_fusion.ability[k] = true
					end
				end
				local check_joker = pos.joker
				if check_joker.carry_stat then
					if check_joker.extra_stat then
						j_fusion.ability.extra[check_joker.carry_stat] = G.jokers.cards[pos.pos].ability.extra[check_joker.carry_stat]
					else
						j_fusion.ability[check_joker.carry_stat] = G.jokers.cards[pos.pos].ability[check_joker.carry_stat]
					end
				end
				if check_joker.merge_stat then
					if chosen_fusion.merge_extra then
						if check_joker.extra_stat then
							j_fusion.ability.extra[chosen_fusion.merged_stat] = j_fusion.ability.extra[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability.extra[check_joker.merge_stat]
						else
							j_fusion.ability.extra[chosen_fusion.merged_stat] = j_fusion.ability.extra[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability[check_joker.merge_stat]
						end
					else
						if check_joker.extra_stat then
							j_fusion.ability[chosen_fusion.merged_stat] = j_fusion.ability[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability.extra[check_joker.merge_stat]
						else
							j_fusion.ability[chosen_fusion.merged_stat] = j_fusion.ability[chosen_fusion.merged_stat] + G.jokers.cards[pos.pos].ability[check_joker.merge_stat]
						end
					end
				end
				G.jokers.cards[pos.pos].ability.merging = true
				G.jokers.cards[pos.pos]:remove()
			end
			delay(0.3)
			j_fusion:add_to_deck()
			G.jokers:emplace(j_fusion)
			play_sound('explosion_release1')
			if chosen_fusion.sound then
				play_sound(chosen_fusion.sound, 1, (chosen_fusion.sound == 'may_ethereal_joker' or chosen_fusion.sound == 'may_prismatic_joker') and 1.5 or 1)
			end
			if chosen_fusion.code then
				chosen_fusion.code()
			end
			if chosen_fusion.shake then
				G.ROOM.jiggle = G.ROOM.jiggle + chosen_fusion.shake
			end
			if may.conf.fusion_punishment then
				if j_fusion:gc().rarity == 'may_mythic' then
					may.add_round_timer(10, 'mythic_fuse')
					may.a('Mythic Scaling will activate in 10 rounds!', '5', 0.5, G.C.RED)
				elseif j_fusion:gc().rarity == 'may_ethereal' then
					may.add_round_timer(10, 'ethereal_fuse')
					may.a('Ethereal Scaling will activate in 10 rounds!', '5', 0.5, G.C.RED)
				elseif j_fusion:gc().rarity == 'may_prismatic' then
					may.add_round_timer(10, 'prismatic_fuse')
					may.a('Prismatic Scaling will activate in 10 rounds!', '5', 0.5, G.C.RED)
				elseif j_fusion:gc().rarity == 'may_demiurgic' then
					may.add_round_timer(6, 'demiurgic_fuse')
					may.a('Demiurgic Scaling will activate in 6 rounds!', '5', 0.5, G.C.RED)
				elseif j_fusion:gc().rarity == 'may_transcendent' then
					may.add_round_timer(3, 'transcendent_fuse')
					may.a('Transcendent Scaling will activate in 3 rounds!', '5', 0.5, G.C.RED)
				end
			end
			delay(0.1)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3, blocking = false,
			func = function()
				G.E_MANAGER:add_event(Event({trigger = 'immediate',
				func = function()
					G.E_MANAGER:add_event(Event({trigger = 'immediate',
					func = function()
						G.CONTROLLER.locks.selling_card = nil
						G.CONTROLLER:recall_cardarea_focus(area == G.jokers and 'jokers' or 'consumeables')
					return true
					end}))
				return true
				end}))
			return true
			end}))
			return true
		end}))
	end
	G.CONTROLLER.locks.selling_card = nil
	G.CONTROLLER:recall_cardarea_focus('jokers')
end

function Card:may_can_fuse_card()
	--[[for _, fusion in ipairs(may.fusions.recipes) do
		if to_big(G.GAME.dollars) >= to_big(fusion.cost) * (G.GAME.may_fusion_price_multiplier or 1) then
			if fusion.condition then
				if fusion.condition() then
					local instability_check
					if fusion.jokers[1].name == 'j_may_omniversal_catalyst' or fusion.jokers[2].name == 'j_may_omniversal_catalyst' then
						instability_check = (G.GAME.may_instability or 0) >= 5
					else
						instability_check = true
					end
					if instability_check then
					    local found_me = false
					    local all_jokers = true
					    for _, joker in ipairs(fusion.jokers) do
						    if fusion.jokers[1].name == fusion.jokers[2].name then
							    if #SMODS.find_card(joker.name) > 1 then
								    return true
							    else
								    return false
							    end
						    end
						    if not next(SMODS.find_card(joker.name)) then
							    all_jokers = false
						    end
						    if joker.name == self.config.center_key then
							    found_me = true
						    end
					    end
					    if found_me and all_jokers then
						    return true
					    end
					end
				end
			end
		end
	end 
	return false]] 
	if self:gc() and may.is_fusable(self:gc()) then
		local fusion 
		local other
		for k, v in pairs(may.fusions.recipes) do
			if v.jokers[1].name == self:gc().key then
				fusion = v
				other = v.jokers[2].name
				break
			elseif v.jokers[2].name == self:gc().key then
				fusion = v
				other = v.jokers[1].name
				break
			end
		end
		if to_big(G.GAME.dollars) >= to_big(fusion.cost) * (G.GAME.may_fusion_price_multiplier or 1) then
			if G.GAME.may_fusion_conditions[fusion.result_joker] == true then
				local rounds
				if fusion.jokers[1].name == 'j_may_omniversal_catalyst' or fusion.jokers[2].name == 'j_may_omniversal_catalyst' then 
					if self:gc().key == 'j_may_omniversal_catalyst' and self.ability.extra.rounds >= 5 then 
						rounds = true
					else
						for k, v in pairs(G.jokers.cards) do
							if v:gc().key == 'j_may_omniversal_catalyst' and v.ability.extra.rounds >= 5 then
								rounds = true 
								break
							end 
						end
					end
				else
					rounds = true
				end
				if rounds then
					return may.has_card(other)
				end
			end
		end
	end
	return false
end

function Card:may_get_card_fusion()
	if self.gc then
		for k, v in pairs(may.fusions.recipes) do 
			if self:gc().key == v.jokers[1].name or self:gc().key == v.jokers[2].name then
				return v
			end
		end
	end
    return nil
end

G.FUNCS.may_fuse_card = function(e)
	local card = e.config.ref_table
	card:may_fuse_card()
end

G.FUNCS.may_can_fuse_card = function(e)
	if e.config.ref_table:may_can_fuse_card() then 
		e.config.colour = G.C.DARK_EDITION
		e.config.button = 'may_fuse_card'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)	
	if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card:may_get_card_fusion() and card:gc().key ~= 'j_may_omniversal_catalyst' then
		card.fusion_cost = card:may_get_card_fusion().cost * (G.GAME.may_fusion_price_multiplier or 1)
		local fuse = 
		{n=G.UIT.C, config={align = "cr"}, nodes={ 
			{n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'may_can_fuse_card'}, nodes={
				{n=G.UIT.B, config = {w=0.1,h=0.6}},
				{n=G.UIT.C, config={align = "tm"}, nodes={
					{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
						{n=G.UIT.T, config={text = localize('b_fuse'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
					}},
					{n=G.UIT.R, config={align = "cm"}, nodes={
						{n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
						{n=G.UIT.T, config={ref_table = card, ref_value = 'fusion_cost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
					}}
				}}
			}}
		}}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, fuse)
		return retval
	end
	return retval
end

local card_h_popupref = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    local retval = card_h_popupref(card)
    if not card.config.center or -- no center
	(card.config.center.unlocked == false and not card.bypass_lock) or -- locked card
	card.debuff or -- debuffed card
	(not card.config.center.discovered and ((card.area ~= G.jokers and card.area ~= G.consumeables and card.area) or not card.area)) -- undiscovered card
	then return retval end
	if card.config.center.rarity == 5 then
		retval.nodes[1].nodes[1].nodes[1].nodes[3].nodes[1].nodes[1].nodes[2].config.object:remove()
		retval.nodes[1].nodes[1].nodes[1].nodes[3].nodes[1] = create_badge(localize('k_fusion'), loc_colour("fusion", nil), nil, 1.2)
	end
	return retval
end

local updateref = Card.update
function Card:update(dt)
	updateref(self, dt)
	if G.STAGE == G.STAGES.RUN then
		if self:may_get_card_fusion() then
			if (self:may_get_card_fusion().condition or function() return true end)() then 
				if not self.fusion_juice then
					juice_card_until(self, function(card) return (card and card:may_can_fuse_card()) end, true)
					self.fusion_juice = true
				end
			else 
				self.fusion_juice = nil
			end
		end
	end
end

function Card:may_is_fusion()
	if self:gc() then
		if self:gc().rarity then
			return self:gc().rarity == 'may_mythic' or self:gc().rarity == 'may_ethereal' or self:gc().rarity == 'may_prismatic' or self:gc().rarity == 'may_demiurgic' or self:gc().rarity == 'may_surreal' or self:gc().rarity == 'may_transcendent' or self:gc().rarity == 'may_paradoxical'
		end
	end
end

function may.has_fusion()
	return may.get_joker_count('may_mythic') ~= 0 or may.get_joker_count('may_ethereal') ~= 0 or may.get_joker_count('may_prismatic') ~= 0 or may.get_joker_count('may_demiurgic') ~= 0 or may.get_joker_count('may_surreal') ~= 0 or may.get_joker_count('may_transcendent') ~= 0 or may.get_joker_count('may_paradoxical') ~= 0 
end

-- Card.may_is_fusion but for centers
function may.is_fusion(center)
	return center.rarity and center.rarity == 'may_mythic' or center.rarity == 'may_ethereal' or center.rarity == 'may_prismatic' or center.rarity == 'may_demiurgic' or center.rarity == 'may_surreal' or center.rarity == 'may_transcendent' or center.rarity == 'may_paradoxical'
end 

-- Also for centers
function may.is_fusable(center)
	for k, v in pairs(may.fusions.recipes) do
		if v.jokers[1].name == center.key or v.jokers[2].name == center.key then
			return true 
		end 
	end 
	return false
end

function may.update_fusion_conditions()
	G.GAME.may_fusion_conditions = G.GAME.may_fusion_conditions or {}
	for k, v in pairs(may.fusions.recipes) do 
		G.GAME.may_fusion_conditions[v.result_joker] = (v.condition or function() return true end)()
	end
end

function may.get_condition(key)
	return may.fusions.conditions[key]
end

-- Fusion conditions
may.fusions.conditions = {}

may.fusions.conditions.diskus = 'Holding {C:tarot}The Wheel of Fortune{}'
may.fusions.conditions.wizard_university = 'At least {C:attention}25{} {C:dark_edition}Enhanced{} playing cards'
may.fusions.conditions.bedrock_joker = 'At least {C:attention}10{} {C:dark_edition}Stone Cards{} in full deck'

may.fusions.conditions.ultimate_hurley = 'At least {C:attention}20 10s{} in full deck'
may.fusions.conditions.cosmos = 'Have a {C:purple}Poker Hand{} with at least {C:planet}level{} {C:attention}45{}'
may.fusions.conditions.acum = 'At least {C:attention}11 Aces{} in full deck'
may.fusions.conditions.intergalactic_tempest = 'Used at least {C:attention}20{} {C:planet}Planet Cards{}'
may.fusions.conditions.little_prince = 'Played at least {C:attention}1 Royal Flush{}'
may.fusions.conditions.party_time = '{C:dark_edition}Prismatic Scaling{} or above active'
may.fusions.conditions.diskus_kollectum = 'Holding at least {C:attention}70{} copies of {C:tarot}The Wheel of Fortune{}'
may.fusions.conditions.bismuth_joker = '{C:mult}Destroyed{} at least {C:attention}20{} {C:dark_edition}Stone Cards{}'
-- may.fusions.conditions.schematicum =  'Used at least {C:attention}20{} {C:spectral}Potents{} & {C:dark_edition}Transcendent Scaling{} or above active'

may.fusions.conditions.acum_universum = 'At least {C:attention}33 Aces{} in full deck' 
may.fusions.conditions.kepler = 'Have a {C:purple}Poker Hand{} with at least {C:planet}level{} {C:attention}100{}'
may.fusions.conditions.diskus_dominus = 'Holding at least {C:attention}140{} copies of {C:tarot}The Wheel of Fortune{}'
may.fusions.conditions.world_destroyer = 'Used at least {C:attention}50{} {C:planet}Planet Cards{}'
may.fusions.conditions.aurora_rave = '{C:dark_edition}Demiurgic Scaling{} or above active'
may.fusions.conditions.eternity_stone = '{C:mult}Destroyed{} at least {C:attention}40{} {C:dark_edition}Stone Cards{}'

may.fusions.conditions.acum_multiplexum = 'At least {C:attention}55 Aces{} in full deck' 
may.fusions.conditions.keplers_dream = 'Have a {C:purple}Poker Hand{} with at least {C:planet}level{} {C:attention}250{}' 
may.fusions.conditions.planet_ibiza = 'At least {C:attention}70{} {C:dark_edition}Enhanced{} playing cards'
may.fusions.conditions.diskus_distruktum = 'Holding at least {C:attention}1400{} copies of {C:tarot}The Wheel of Fortune{}'
may.fusions.conditions.astral_expunger = 'Used at least {C:attention}50{} {C:tarot}Tarot Cards{}'
may.fusions.conditions.rock_of_paramountcy = '{C:mult}Destroyed{} at least {C:attention}80{} {C:dark_edition}Stone Cards{}'

may.fusions.conditions.as_ultimatum = 'Have a {C:purple}Poker Hand{} with at least {C:planet}level{} {C:attention}350{}'
may.fusions.conditions.rondo_discoteca = 'Used at least {C:attention}100{} {C:planet}Planet Cards{} & {C:dark_edition}Score Operator{} level is {C:attention}3{} or above'
may.fusions.conditions.zodium_calamitas = 'Used {C:attention}100{} {C:tarot}Tarot Cards{} & {C:mult}destroyed{} {C:attention}100{} {C:dark_edition}Stone Cards{}'

-- Load Fusions

-- joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, sound, code, shake, condition

	-- Mythic

may.fusions:add_fusion('j_may_man', nil, nil, 'j_may_wheel_of_eternity', nil, nil, 'j_may_diskus', 140, 'may_mythic_joker', nil, 0, function()
	if #G.consumeables.cards == 0 then return false end
	for k, v in pairs(G.consumeables.cards) do
		if v:gc().key == 'c_wheel_of_fortune' then 
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_mana_orb', nil, nil, 'j_may_hierarchy', nil, nil, 'j_may_wizard_university', 170, 'may_mythic_joker', nil, 0, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v.config.center.key ~= 'c_base' then
			count = count + 1
		end
		if count >= 25 then
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_granite_joker', nil, nil, 'j_marble', nil, nil, 'j_may_bedrock_joker', 130, 'may_mythic_joker', nil, 0, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v.config.center.key == 'm_stone' then
			count = count + 1
			if count >= 10 then 
				return true
			end 
		end
	end
	return false
end)
 
	-- Ethereal

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_nebula', nil, nil, 'j_may_cosmos', 200, 'may_ethereal_joker', nil, 0, function()
	for k, v in pairs(G.GAME.hands) do
		if to_big(v.level) >= to_big(45) then
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_aaaa', nil, nil, 'j_may_acum', 222, 'may_ethereal_joker', nil, 0, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v:get_id() == 14 then
			count = count + 1
			if count >= 11 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_destroyer', nil, nil, 'j_may_paragon', 250, 'may_ethereal_joker', nil, 0, function()
	return may.ctu('Planet') > 20
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_royale', nil, nil, 'j_may_little_prince', 210, 'may_ethereal_joker', nil, 0, function()
	return G.GAME.hands['may_Royal Flush'].played >= 1
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_daredevil', nil, nil, 'j_may_party_time', 210, 'may_ethereal_joker', nil, 0, function()
	return ((G.GAME.may_prismatic_scaling or 0) > 0 or (G.GAME.may_demiurgic_scaling or 0) > 0 or (G.GAME.may_opalescent_scaling or 0) > 0 or (G.GAME.may_transcendent_scaling or 0) > 0) 
end)

may.fusions:add_fusion('j_may_diskus', nil, nil, 'j_may_collectionist', nil, nil, 'j_may_diskus_kollectum', 214, 'may_ethereal_joker', nil, 0, function()
	if #G.consumeables.cards == 0 then return false end
	local count = 0
	for k, v in pairs(G.consumeables.cards) do
		if v:gc().key == 'c_wheel_of_fortune' then 
			count = count + v:getQty()
			if count >= 70 then 
				return true
			end
		end
	end
	return false 
end)

may.fusions:add_fusion('j_may_bedrock_joker', nil, nil, 'j_stone', nil, nil, 'j_may_bismuth_joker', 220, 'may_ethereal_joker', nil, 0, function()
	return (G.GAME.may_stones_destroyed or 0) >= 20
end)

	-- Prismatic 
 
may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_acum', nil, nil, 'j_may_acum_universum', 555, 'may_prismatic_joker', nil, 0.8, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v:get_id() == 14 then
			count = count + 1
			if count >= 33 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_cosmos', nil, nil, 'j_may_kepler', 500, 'may_prismatic_joker', nil, 0.8, function()
	for k, v in pairs(G.GAME.hands) do
		if to_big(v.level) >= to_big(100) then
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_diskus_kollectum', nil, nil, 'j_may_collectors_edition', nil, nil, 'j_may_diskus_dominus', 560, 'may_prismatic_joker', nil, 0.8, function()
	if #G.consumeables.cards == 0 then return false end
	local count = 0
	for k, v in pairs(G.consumeables.cards) do
		if v:gc().key == 'c_wheel_of_fortune' then 
			count = count + v:getQty()
			if count >= 140 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_intergalactic_tempest', nil, nil, 'j_may_world_destroyer', 500, 'may_prismatic_joker', nil, 0.8, function()
	return may.ctu('Planet') > 50
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_party_time', nil, nil, 'j_may_aurora_rave', 600, 'may_prismatic_joker', nil, 0.8, function()
	return ((G.GAME.may_demiurgic_scaling or 0) > 0 or (G.GAME.may_opalescent_scaling or 0) > 0 or (G.GAME.may_transcendent_scaling or 0) > 0) 
end)

may.fusions:add_fusion('j_may_bismuth_joker', nil, nil, 'j_may_cement_joker', nil, nil, 'j_may_rocco_pfilosofia', 520, 'may_prismatic_joker', nil, 0.8, function()
	return (G.GAME.may_stones_destroyed or 0) >= 40
end)

	-- Demiurgic 
  
may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_acum_universum', nil, nil, 'j_may_acum_multiplexum', 1111, 'may_demiurgic_joker', nil, 1, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v:get_id() == 14 then
			count = count + 1
			if count >= 55 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_kepler', nil, nil, 'j_may_keplers_dream', 1e3, 'may_demiurgic_joker', nil, 1, function()
	for k, v in pairs(G.GAME.hands) do
		if to_big(v.level) >= to_big(250) then
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_omniversal_catalyst', nil, nil, 'j_may_diskus_kollectum_maximus', nil, nil, 'j_may_diskus_distruktum', 1e3, 'may_demiurgic_joker', nil, 1, function()
	if #G.consumeables.cards == 0 then return false end
	local count = 0
	for k, v in pairs(G.consumeables.cards) do
		if v:gc().key == 'c_wheel_of_fortune' then 
			count = count + v:getQty()
			if count >= 1400 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_wizard_university', nil, nil, 'j_may_aurora_rave', nil, nil, 'j_may_planet_ibiza', 1.5e3, 'may_demiurgic_joker', nil, 1, function()
	local count = 0
	for k, v in pairs(G.playing_cards) do
		if v.config.center.key ~= 'c_base' then
			count = count + 1
			if count >= 70 then 
				return true
			end
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_zodiac', nil, nil, 'j_may_world_destroyer', nil, nil, 'j_may_astral_expunger', 1e3, 'may_demiurgic_joker', nil, 1, function()
	return may.ctu('Tarot') > 50
end)

may.fusions:add_fusion('j_may_rocco_pfilosofia', nil, nil, 'j_may_omniversal_catalyst', nil, nil, 'j_may_infinity_stone', 1.3e3, 'may_demiurgic_joker', nil, 1, function()
	return (G.GAME.may_stones_destroyed or 0) >= 80
end)

	-- Transcendent 

may.fusions:add_fusion('j_may_acum_multiplexum', nil, nil, 'j_may_keplers_dream', nil, nil, 'j_may_as_ultimatum', 3333, 'may_transcendent_joker', nil, 1.5, function()
	for k, v in pairs(G.GAME.hands) do
		if to_big(v.level) >= to_big(350) then
			return true
		end
	end
	return false
end)

may.fusions:add_fusion('j_may_diskus_distruktum', nil, nil, 'j_may_planet_ibiza', nil, nil, 'j_may_rondo_discoteca', 4000, 'may_transcendent_joker', nil, 1.5, function()
    local op = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order
	if G.GAME.current_scoring_calculation_key == 'talisman_hyper' then
	    op = G.GAME.hyper_operator
	end
	return may.ctu('Planet') >= 100 and op >= 3
end)

may.fusions:add_fusion('j_may_infinity_stone', nil, nil, 'j_may_astral_expunger', nil, nil, 'j_may_zodium_calamitas', 3.5e3, 'may_transcendent_joker', nil, 1.5, function()
	return (G.GAME.may_stones_destroyed or 0) >= 100 and may.ctu('Tarot') >= 100
end)
