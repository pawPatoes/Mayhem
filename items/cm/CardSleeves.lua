-- CardSleeves cross-mod

SMODS.Atlas {
	key = "cardsleeves",
	path = "cardsleeves.png",
	px = 73,
	py = 95
}

CardSleeves.Sleeve {
	key = 'orange_sleeve',
	atlas = 'may_cardsleeves',
	pos = { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_orange_deck" then
			key = self.key .. "_alt"
			self.config = { hand_size = 2 }
		else
			key = self.key
			self.config = { hand_size = 1 }
		end
		vars = { self.config.hand_size }
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
	end
}

CardSleeves.Sleeve {
	key = 'purple_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_purple_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	calculate = function(self, sleeve, context)
		if self.get_current_deck_key() ~= "b_may_purple_deck" then
			if context.open_booster and G.GAME.pack_choices + 1 <= G.GAME.pack_size then
				G.GAME.pack_choices = G.GAME.pack_choices + 1
			end
		else
			if context.open_booster then
				G.GAME.pack_choices = G.GAME.pack_size
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'pink_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_pink_deck" then
			key = self.key .. "_alt"
			self.config = { blind_size = 0.7 }
		else
			key = self.key
			self.config = { blind_size = 0.8 }
		end
		vars = { self.config.blind_size }
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*self.config.blind_size
		if self.get_current_deck_key() == "b_may_pink_deck" then
			G.GAME.pink_sleeve_alt = true
		end
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and G.GAME.blind.boss and G.GAME.pink_sleeve_alt then
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.blind.chips = G.GAME.blind.chips:arrow(1, card.ability.extra.size)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
				delay(0.4)
			return true end}))
		end
	end
}


CardSleeves.Sleeve {
	key = 'lime_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_lime_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		SMODS.change_voucher_limit(1)
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and self.get_current_deck_key() == "b_may_lime_deck" then
			for k, v in pairs(G.playing_cards) do
				v:set_seal('may_copper_seal', true, true)
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'brown_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },	
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_brown_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.GAME.playing_card_multiplier = 10
	end,
	calculate = function(self, sleeve, context)
		if context.individual and context.cardarea == G.play and self.get_current_deck_key() == "b_may_brown_deck" then
			if context.other_card.ability.name ~= 'Stone Card' and context.other_card:get_id() > 0 then
				return {
					x_chips = context.other_card:get_id(),
					card = context.other_card,
				}
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'gray_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },	
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_gray_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.E_MANAGER:add_event(Event({func = function()
			for k, v in ipairs(G.playing_cards) do
				v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
			end
		return true end}))
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and self.get_current_deck_key() == "b_may_gray_deck" then
			for k, v in ipairs(G.playing_cards) do
				if not v.seal then
					v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_sleeve" }), true, false)
				end
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'turqoise_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_turqoise_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.discount_percent = 25
			for k, v in pairs(G.I.CARD) do
				if v.set_cost then v:set_cost() end
			end
		return true end}))
	end,
	calculate = function(self, sleeve, context)
		if context.buying_card and self.get_current_deck_key() == "b_may_turqoise_deck" then
			if pseudorandom('may_turqoise_sleeve_alt') < 1 / 5 then
				ease_dollars(context.card.cost)
			end
		end
	end
}

CardSleeves.Sleeve {
	key = 'blurple_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_blurple_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_blurple_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'blurple_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, true, 4, false, nil, nil, 'blurple_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		end
	end
}

CardSleeves.Sleeve {
	key = 'monochrome_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_monochrome_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_monochrome_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
				card2:set_edition({negative = true}, false, false)
				G.jokers:emplace(card2)
				card2:add_to_deck()
				for i=1, 4, 1 do
					local copy = copy_card(card2, nil)
					G.jokers:emplace(copy)
					copy:add_to_deck()
					copy:set_edition({negative = true}, false, false)
				end
				play_sound('holo1')
			return true end}))
		end
	end,
	calculate = function(self, sleeve, context)
		if context.setting_blind and G.GAME.blind.boss and self.get_current_deck_key() == "b_may_monochrome_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 0.8, nil, true, nil, 'monochrome_deck')
				card2:set_edition({negative = true}, false, false)
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		end
	end
}

CardSleeves.Sleeve {
	key = 'rainbow_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_rainbow_deck" then
			key = self.key .. "_alt"
			self.config = { extra_discard_bonus = 1 }
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_rainbow_deck" then
			G.GAME.starting_params.hand_size = 8 + 1
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*0.9
			G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'rainbow_deck')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.discount_percent = 25
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
			return true end}))
			G.GAME.playing_card_multiplier = 10
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
				end
			return true end}))
		end
	end,
	calculate = function(self, sleeve, context)
		if context.open_booster and self.get_current_deck_key() == "b_may_rainbow_deck" and G.GAME.pack_choices + 1 <= G.GAME.pack_size  then
			G.GAME.pack_choices = G.GAME.pack_choices + 1
		end
	end
}

--[[CardSleeves.Sleeve {
	key = 'centurion_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
    config = { vouchers}
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_centurion_deck" then
			key = self.key .. "_alt"
			self.config = { extra_discard_bonus = 1 }
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_rainbow_deck" then
			G.GAME.starting_params.hand_size = 8 + 1
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling*0.9
			G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
			G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, 3, false, nil, nil, 'rainbow_deck')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				G.GAME.discount_percent = 25
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
			return true end}))
			G.GAME.playing_card_multiplier = 10
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "gray_deck" }), true, false)
				end
			return true end}))
		end
	end,
	calculate = function(self, sleeve, context)
		if context.open_booster and self.get_current_deck_key() == "b_may_rainbow_deck" and G.GAME.pack_choices + 1 <= G.GAME.pack_size  then
			G.GAME.pack_choices = G.GAME.pack_choices + 1
		end
	end
}]]

--[[CardSleeves.Sleeve {
	key = 'aaaa_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_aaaa_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_aaaa_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					assert(SMODS.change_base(v, nil, 'Ace'))
				end
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_aaaa', 'may_aaaa_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				for k, v in ipairs(G.playing_cards) do
					assert(SMODS.change_base(v, nil, self.config.rank))
				end
			return true end}))
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_acum', 'may_aaaa_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound('holo1')
				play_sound('may_transcendent_joker')
			return true end}))
		end
	end,
}]] 

if may.conf.Mode == 2 then
    
CardSleeves.Sleeve {
	key = 'unstable_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_unstable_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_unstable_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_unstable_sleeve')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound("may_thunder"..math.random(1,2))
			return true end}))
		else
			G.GAME.may_unstable_sleeve_alt = true
		end
	end,
}

CardSleeves.Sleeve {
	key = 'mythic_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_mythic_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_mythic_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_mythic", nil, nil, nil, "may_mythic_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_mythic_joker')
				end
			return true end}))
		end
	end,
	calculate = function(self, back, context)
		if context.other_joker and context.other_joker.config.center.rarity == 'may_mythic' then
			G.E_MANAGER:add_event(Event({func = function()
				context.other_joker:juice_up()
			return true end}))
			return {
				EEmult_mod = 3,
				message = '^^3 Mult',
				colour = G.C.RED,
				card = back,
			}
		end
	end
}

CardSleeves.Sleeve {
	key = 'transcendent_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -1, discards = -1 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_transcendent_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_transcendent_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_transcendent", nil, nil, nil, "may_transcendent_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_transcendent_joker')
					if card.config.center.key == 'j_may_party_time' then
						if Overflow then
							local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_sleeve")
							card:add_to_deck()
							card:setQty(40)
							card:start_materialize()
							G.consumeables:emplace(card)
							card:set_edition({negative = true}, false, false)
						else
							for i=1, 40, 1 do
								local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, 'c_jupiter', "may_transcendent_sleeve")
								card:add_to_deck()
								card:start_materialize()
								G.consumeables:emplace(card)
								card:set_edition({negative = true}, false, false)
							end
						end
						play_sound('holo1')
					end
				end
			return true end}))
		else
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_interdimensional", nil, nil, nil, "may_transcendent_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_interdimensional_joker')
				end
			return true end}))
		end
	end,
}

--[[CardSleeves.Sleeve {
	key = 'surreal_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -2 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_surreal_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_surreal_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_surreal", nil, nil, nil, "may_surreal_deck")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_surreal_joker')
				end
			return true end}))
		else
			G.GAME.may_surreal_sleeve_alt = true
		end
	end,
}]] 

CardSleeves.Sleeve {
	key = 'interdimensional_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = -1, discards = -1, joker_slot = -1, hand_size = -1 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_interdimensional_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_interdimensional_deck" then
			CardSleeves.Sleeve.apply(self, sleeve)
			G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_interdimensional", nil, nil, nil, "may_interdimensional_sleeve")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_interdimensional_joker')
				end
			return true end}))
		else
			G.GAME.may_interdimensional_sleeve_alt = true
		end
	end,
}

CardSleeves.Sleeve {
	key = 'ethereal_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	config = { hands = 2, discards = 2, joker_slot = 3 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_ethereal_deck" then
			key = self.key .. "_alt"
			self.config = { hands = 2, discards = 2, joker_slot = 3 }
		else
			key = self.key
			self.config = { hands = -2, discards = -2, joker_slot = -3 }
		end
		return { key = key, vars = vars }
	end,
	apply = function(self, sleeve)
		CardSleeves.Sleeve.apply(self, sleeve)
		if self.get_current_deck_key() ~= "b_may_ethereal_deck" then
			G.E_MANAGER:add_event(Event({func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "may_ethereal", nil, nil, nil, "may_etherealdeck")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					play_sound('may_ethereal_joker')
				end
			return true end}))
		end
	end,
}

CardSleeves.Sleeve {
	key = 'power_sleeve',
	atlas = 'may_cardsleeves',
	pos =  { x = 0, y = 0 },
	loc_vars = function(self)
		local key, vars
		if self.get_current_deck_key() == "b_may_power_deck" then
			key = self.key .. "_alt"
		else
			key = self.key
		end
		return { key = key, vars = vars }
	end,
	calculate = function(self, back, context)
		if context.after and pseudorandom('may_power_sleeve') < G.GAME.probabilities.normal / 10 and self.get_current_deck_key() ~= "b_may_power_deck" then
			change_operator(1)
		end
		if context.setting_blind and G.GAME.blind.boss and self.get_current_deck_key() == "b_may_power_deck" then
			change_operator(1)
		end
	end
}

end