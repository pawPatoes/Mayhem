-- Stakes

SMODS.Stake {
	key = 'amethyst',
	applied_stakes = { 'gold' },
	loc_txt = {
		name = 'Amethyst Stake',
		text = {
			'Required {C:attention}score{} scales',
			'{C:attention}faster{} for each {C:ante}Ante{}'
		},
		sticker = {
			name = 'Amethyst Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Amethyst{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 0, y = 0, },
	prefix_config = { applied_stakes = { mod = false } },
	unlocked = true,
	colour = G.C.PURPLE,
	above_stake = 'gold',
	modifiers = function()
		G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'garnet',
	applied_stakes = { 'may_amethyst' },
	loc_txt = {
		name = 'Garnet Stake',
		text = {
			'{C:attention}-1 Hand Size{}'
		},
		sticker = {
			name = 'Garnet Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Garnet{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 0, y = 1 },
	unlocked = true,
	colour = G.C.RED,
	above_stake = 'may_amethyst',
	modifiers = function()
		G.GAME.starting_params.hand_size = (G.GAME.starting_params.hand_size or 8) - 1
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'cryolite',
	applied_stakes = { 'may_garnet' },
	loc_txt = {
		name = 'Cryolite Stake',
		text = {
			'{C:mult}-0.1{} {C:money}Interest{}'
		},
		sticker = {
			name = 'Cryolite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Cryolite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 5, y = 0 },
	unlocked = true,
	colour = G.C.YELLOW,
	above_stake = 'may_garnet',
	modifiers = function()
		G.GAME.interest_amount = G.GAME.interest_amount - 0.1
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'cinnabar',
	applied_stakes = { 'may_cryolite' },
	loc_txt = {
		name = 'Cinnabar Stake',
		text = {
			'{C:attention}Big Blind{} gives {X:money,C:white}X0.8${}',
			'when {C:attention}selected{}'
		},
		sticker = {
			name = 'Cinnabar Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Cinnabar{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 4, y = 0 },
	unlocked = true,
	colour = G.C.RED,
	above_stake = 'may_cryolite',
	calculate = function(self, context)
		if context.setting_blind and G.GAME.blind:get_type() == 'Big' then
			may.hypermoney(0, 0.8, false)
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'peridot',
	applied_stakes = { 'may_cinnabar' },
	loc_txt = {
		name = 'Peridot Stake',
		text = {
			'{X:attention,C:white}X1.5{} {C:attention}Boss Blind{} size'
		},
		sticker = {
			name = 'Peridot Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Peridot{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 2, y = 2 },
	unlocked = true,
	colour = G.C.GREEN,
	above_stake = 'may_cinnabar',
	calculate = function(self, context)
		if context.setting_blind and G.GAME.blind.boss then
			G.GAME.blind.chips = G.GAME.blind.chips * 1.5
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
			play_sound('may_blind_size')
			delay(0.4)
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'pyrite',
	applied_stakes = { 'may_peridot' },
	loc_txt = {
		name = 'Pyrite Stake',
		text = {
			'{C:mult}-1{} {C:green}Booster Pack{} in shop'
		},
		sticker = {
			name = 'Pyrite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Pyrite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 5, y = 2 },
	unlocked = true,
	colour = G.C.WHITE,
	above_stake = 'may_peridot',
	modifiers = function()
		G.GAME.modifiers.extra_boosters = (G.GAME.modifiers.extra_boosters or 0) - 1
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'opal',
	applied_stakes = { 'may_pyrite' },
	loc_txt = {
		name = 'Opal Stake',
		text = {
			'{C:mult}-5{} {C:money}Interest Cap{}'
		},
		sticker = {
			name = 'Opal Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Opal{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 1, y = 2 },
	unlocked = true,
	colour = G.C.GREEN,
	above_stake = 'may_pyrite',
	modifiers = function()
		G.GAME.interest_cap = (G.GAME.interest_cap or 25) - 5
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'onyx',
	applied_stakes = { 'may_opal' },
	loc_txt = {
		name = 'Onyx Stake',
		text = {
			'{C:mult}-1{} {C:attention}Card Slot{} in shop'
		},
		sticker = {
			name = 'Onyx Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Onyx{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 0, y = 2 },
	unlocked = true,
	colour = G.C.BLACK,
	above_stake = 'may_opal',
	modifiers = function()
		change_shop_size(-1)
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'jasper',
	applied_stakes = { 'may_onyx' },
	loc_txt = {
		name = 'Jasper Stake',
		text = {
			'{C:attention}Ante{} is {C:attention}increased by 1{}',
			'every {C:attention}3 Boss Blinds{} selected',
		},
		sticker = {
			name = 'Jasper Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Jasper{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 2, y = 1 },
	unlocked = true,
	colour = G.C.ORANGE,
	above_stake = 'may_onyx',
	calculate = function(self, context)
		if context.setting_blind and G.GAME.blind.boss then
			G.GAME.may_onyx_bosses = (G.GAME.may_onyx_bosses or 0) + 1
			if G.GAME.may_onyx_bosses ~= 0 and G.GAME.may_onyx_bosses % 3 == 0 then
				ease_ante(1)
			end
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'uranium',
	applied_stakes = { 'may_jasper' },
	loc_txt = {
		name = 'Uranium Stake',
		text = {
			'{C:attention}UltraBlinds{} can appear',
			'after {C:attention}Ante 5{}'
		},
		sticker = {
			name = 'Uranium Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Uranium{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 2, y = 2 },
	unlocked = true,
	colour = G.C.GREEN,
	above_stake = 'may_jasper',
	calculate = function(self, context)
		if context.setting_blind and math.ceil(G.GAME.round_resets.ante) == 5 then
			G.GAME.may_ultrablind_premature = true
		end
	end,
}

SMODS.Stake {
	key = 'citrine',
	applied_stakes = { 'may_uranium' },
	loc_txt = {
		name = 'Citrine Stake',
		text = {
			'{C:mult}Fixed{} {C:green}1 in 5{} chance',
			'to {C:mult}unredeem{} a {C:attention}random{} {C:green}Voucher{}',
			'when {C:attention}blind{} is {C:attention}selected{}'
		},
		sticker = {
			name = 'Citrine Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Uranium{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 5, y = 0 },
	unlocked = true,
	colour = G.C.MONEY,
	above_stake = 'may_uranium',
	calculate = function(self, context)
		if context.setting_blind then
			if SMODS.pseudorandom_probability(card, "may_citrine_stake", 1, 5, "Citrine Stake") then
				if G.vouchers and #G.vouchers.cards > 0 then
					local voucher = pseudorandom_element(G.vouchers.cards, pseudoseed('may_citrine_stake'))
					local area
					if G.STATE == G.STATES.HAND_PLAYED then
						if not G.redeemed_vouchers_during_hand then
							G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
						end
						area = G.redeemed_vouchers_during_hand
					else
						area = G.play
					end
					local card = copy_card(voucher)
					card.ability.extra = copy_table(voucher.ability.extra)
					if card.facing == "back" then
						card:flip()
					end
					card:start_materialize()
					area:emplace(card)
					card.cost = 0
					card.shop_voucher = false
					local current_round_voucher = G.GAME.current_round.voucher
					card:unredeem()
					G.GAME.current_round.voucher = current_round_voucher
					G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, func = function()
						card:start_dissolve()
						voucher:start_dissolve()
					return true end}))
				end
			end
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'rhodonite',
	applied_stakes = { 'may_citrine' },
	loc_txt = {
		name = 'Rhodonite Stake',
		text = {
			'{C:purple}Poker Hands{} start with',
			'{C:mult}-0.2{} {C:planet}levels{}'
		},
		sticker = {
			name = 'Rhodonite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Rhodonite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 6, y = 2 },
	unlocked = true,
	colour = G.C.RED,
	above_stake = 'may_citrine',
	modifiers = function()
		for k, v in pairs(G.GAME.hands) do
			v.level = v.level - 0.2
			v.mult = v.mult + (v.l_mult * -0.2)
			v.chips = v.chips + (v.l_chips * -0.2)
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'topaz',
	applied_stakes = { 'may_rhodonite' },
	loc_txt = {
		name = 'Topaz Stake',
		text = {
			'{C:attention}Playing cards{} may appear',
			'{C:attention}in shop{} by default'
		},
		sticker = {
			name = 'Topaz Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Topaz{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 0, y = 3 },
	unlocked = true,
	colour = G.C.ORANGE,
	above_stake = 'may_rhodonite',
	modifiers = function()
		G.GAME.playing_card_rate = 15
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'vanadinite',
	applied_stakes = { 'may_topaz' },
	loc_txt = {
		name = 'Vanadinite Stake',
		text = {
			'{C:attention}Skipping{} Blinds gives',
			'{C:mult}-0.1{} {C:money}Interest{}'
		},
		sticker = {
			name = 'Vanadinite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Vanadinite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 2, y = 3 },
	unlocked = true,
	colour = G.C.ORANGE,
	above_stake = 'may_topaz',
	calculate = function(self, context)
		if context.skip_blind then
			G.GAME.interest_amount = G.GAME.interest_amount - 0.1
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'xanthiosite',
	applied_stakes = { 'may_vanadinite' },
	loc_txt = {
		name = 'Xanthiosite Stake',
		text = {
			'{C:planet}Planet Cards{} {C:mult}no longer{}',
			'appear in {C:attention}shop{}',
			'by default'
		},
		sticker = {
			name = 'Xanthiosite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Xanthiosite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 4, y = 3 },
	unlocked = true,
	colour = G.C.GREEN,
	above_stake = 'may_vanadinite',
	-- 	WHY CANT YOU CHANGE CONSUMABLE RATES WITH MODIFIER
	calculate = function(self, context)
		if context.setting_blind and not G.GAME.may_xanthiosite_apllied then
			G.GAME.planet_rate = 0
			G.GAME.may_xanthiosite_apllied = true
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'placheite',
	applied_stakes = { 'may_xanthiosite' },
	loc_txt = {
		name = 'Placheite Stake',
		text = {
			'{X:money,C:white}X0.85${} when a',
			'{C:green}Booster Pack{} is {C:attention}opened{}'
		},
		sticker = {
			name = 'Placheite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Placheite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 4, y = 2 },
	unlocked = true,
	colour = G.C.GREEN,
	above_stake = 'may_xanthiosite',
	calculate = function(self, context)
		if context.open_booster then
			may.hypermoney(0, 0.85, false)
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'jacinth',
	applied_stakes = { 'may_placheite' },
	loc_txt = {
		name = 'Jacinth Stake',
		text = {
			'When {C:attention}Big Blind{} is {C:attention}selected{}',
			'create and shuffle {C:attention}2{} random',
			'{C:mult}unmodified{} {C:attention}playing cards{} into',
			'your {C:attention}deck{}',
		},
		sticker = {
			name = 'Jacinth Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Jacinth{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 1, y = 1 },
	unlocked = true,
	colour = G.C.RED,
	above_stake = 'may_placheite',
	calculate = function(self, context)
		if context.setting_blind and G.GAME.blind:get_type() == 'Big' then
			for i=1, 2, 1 do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
					local new = create_playing_card(nil, G.play, nil, i ~= 1, {G.C.SECONDARY_SET.Planet})
					new:juice_up()
					play_sound('card1')
				return true end}))
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
				for k, v in pairs(G.play.cards) do
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
						v:add_to_deck()
						G.play:remove_card(v)
						G.deck:emplace(v)
						play_sound('card1')
					return true end}))
				end
			return true end}))
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'malachite',
	applied_stakes = { 'may_jacinth' },
	loc_txt = {
		name = 'Malachite Stake',
		text = {
			'When {C:attention}Boss Blind{} is {C:attention}selected{},',
			'{C:mult}lose{} 1 {C:attention}empty Joker Slot{}'
		},
		sticker = {
			name = 'Malachite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Malachite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 4, y = 1 },
	unlocked = true,
	colour = G.C.BLUE,
	above_stake = 'may_jacinth',
	calculate = function(self, context)
		if context.setting_blind and G.GAME.blind.boss then
			if #G.jokers.cards < G.jokers.config.card_limit then
				G.jokers:change_size(-1, false)
			end
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'lapis',
	applied_stakes = { 'may_malachite' },
	loc_txt = {
		name = 'Lapis Stake',
		text = {
			'{C:mult}-1{} Consumable Slot',
			'{C:inactive}Minimum of 1{}'
		},
		sticker = {
			name = 'Lapis Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Lapis{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 3, y = 1 },
	unlocked = true,
	colour = G.C.BLUE,
	above_stake = 'may_malachite',
	modifers = function()
		G.consumeables.config.card_limit = math.max(1, G.consumeables.config.card_limit - 1)
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'moonstone',
	applied_stakes = { 'may_lapis' },
	loc_txt = {
		name = 'Moonstone Stake',
		text = {
			'{C:mult}Fixed{} {C:green}1 in 10{} chance',
			'to {C:mult}exit{} the {C:green}shop{} {C:attention}after rerolling{}'
		},
		sticker = {
			name = 'Moonstone Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Moonstone{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 5, y = 1 },
	unlocked = true,
	colour = G.C.GRAY,
	above_stake = 'may_lapis',
	calculate = function(self, context)
		if context.reroll_shop and SMODS.pseudorandom_probability(card, "may_moonstone_stake", 1, 10, "Moonstone Stake") then
			G.FUNCS.toggle_shop()
		end
	end,
}

SMODS.Stake {
	key = 'morganite',
	applied_stakes = { 'may_moonstone' },
	loc_txt = {
		name = 'Morganite Stake',
		text = {
			'Extra {C:chips}hands{} earn',
			'{X:attention,C:white}X0.5{} less {C:money}money{}',
			'at the end of round',
			'{C:inactive}Can be increased by obtained items{}'
		},
		sticker = {
			name = 'Morganite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Morganite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 6, y = 1 },
	unlocked = true,
	colour = HEX('ffc9ff'),
	above_stake = 'may_moonstone',
	modifiers = function()
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) * 0.5
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'beryl',
	applied_stakes = { 'may_morganite' },
	loc_txt = {
		name = 'Beryl Stake',
		text = {
			'{C:attention}Blind requirements{} are increased',
			'by {X:attention,C:white}X1.1{} after scoring'
		},
		sticker = {
			name = 'Beryl Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Beryl{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 2, y = 0 },
	unlocked = true,
	colour = G.C.CHIPS,
	above_stake = 'may_morganite',
	calculate = function(self, context)
		if context.after then
			G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
				G.GAME.blind.chips = G.GAME.blind.chips:mul(1.1)
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				G.hand_text_area.blind_chips:juice_up()
				play_sound('may_blind_size')
			return true end}))
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'azurite',
	applied_stakes = { 'may_beryl' },
	loc_txt = {
		name = 'Azurite Stake',
		text = {
			'You can {C:mult}only select{}',
			'{C:attention}1 card{} from any {C:green}Booster Pack{}',
		},
		sticker = {
			name = 'Azurite Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Azurite{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 1, y = 0 },
	unlocked = true,
	colour = G.C.BLUE,
	above_stake = 'may_beryl',
	calculate = function(self, context)
		if context.open_booster then
			G.GAME.pack_choices = 1
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'pink_diamond',
	applied_stakes = { 'may_azurite' },
	loc_txt = {
		name = 'Pink Diamond Stake',
		text = {
			'{C:dark_edition,E:2,u:dark_edition}Diamond Stake{}',
			'  ',
			'{C:attention}Randomize{} played {C:attention}cards after scoring{}',
			'{C:inactive}Suit and rank only{}'
		},
		sticker = {
			name = 'Pink Diamond Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Pink Diamond{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 3, y = 2 },
	unlocked = true,
	colour = HEX('ffc9ff'),
	above_stake = 'may_azurite',
	calculate = function(self, context)
		if context.after then
			may.randomise(G.play.cards, false, true)
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'yellow_diamond',
	applied_stakes = { 'may_azurite' },
	loc_txt = {
		name = 'Yellow Diamond Stake',
		text = {
			'{C:dark_edition,E:2,u:dark_edition}Diamond Stake{}',
			'  ',
			'{C:attention}Shuffle{} all {C:attention}Jokers{}',
			'{C:attention}before scoring{}'
		},
		sticker = {
			name = 'Yellow Diamond Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Yellow Diamond{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 5, y = 3 },
	unlocked = true,
	colour = G.C.YELLOW,
	above_stake = 'may_azurite',
	calculate = function(self, context)
		if context.before then
			G.E_MANAGER:add_event(Event({func = function()
				G.jokers:shuffle('may_yellow_diamond')
				play_sound('cardSlide1', 0.85)
			return true end}))
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'black_diamond',
	applied_stakes = { 'may_azurite' },
	loc_txt = {
		name = 'Black Diamond Stake',
		text = {
			'{C:dark_edition,E:2,u:dark_edition}Diamond Stake{}',
			'  ',
			'{C:attention}Skipping{} a {C:green}Booster Pack{}',
			'{C:mult}removes{} all {C:attention}other{} {C:green}Booster Packs{}',
			'and {C:green}Vouchers{} from current shop'
		},
		sticker = {
			name = 'Black Diamond Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Black Diamond{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 3, y = 0 },
	unlocked = true,
	colour = G.C.BLACK,
	above_stake = 'may_azurite',
	calculate = function(self, context)
		if context.skipping_booster then
			if G.shop_booster then
				G.shop_booster.cards = {}
			end
			if G.shop_vouchers then
				G.shop_vouchers.cards = {}
			end
		end
	end,
	shiny = true,
}

SMODS.Stake {
	key = 'white_diamond',
	applied_stakes = { 'may_azurite' },
	loc_txt = {
		name = 'White Diamond Stake',
		text = {
			'{C:dark_edition,E:2,u:dark_edition}Diamond Stake{}',
			'  ',
			'{C:attention}Using{} a {C:attention}consumable{} {C:mult}removes{}',
			'all {C:attention}other held consumables{} of',
			'the {C:attention}same consumable type{}'
		},
		sticker = {
			name = 'White Diamond Sticker',
			text = {
				'Used this {C:attention}Joker{}',
				'to win on {C:attention}Black White{}',
				'{C:attention}Stake{} difficulty',
			},
		},
	},
	atlas = 'stake',
	pos = { x = 3, y = 3 },
	unlocked = true,
	colour = G.C.WHITE,
	above_stake = 'may_azurite',
	calculate = function(self, context)
		if context.using_consumeable and context.consumeable then
			for k, v in pairs(G.consumeables.cards) do
				if v:gc().set == context.consumeable:gc().set then
					v:start_dissolve()
				end
			end
		end
	end,
	shiny = true,
}