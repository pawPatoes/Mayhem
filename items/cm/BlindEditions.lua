-- Blind Editions cross-mod

-- Idea of adding sounds to blind editions was *borrowed* from POLTERWORX
SMODS.BlindEdition:take_ownership('ble_foil', {
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('foil1')
			SMODS.juice_up_blind()
		return true end}))
	end
})

SMODS.BlindEdition:take_ownership('ble_holographic', {
	set_blind = function(self, blind_on_deck)
		G.hand:change_size(-1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('holo1', 1.2*1.58)
			SMODS.juice_up_blind()
		return true end}))
	end
})

SMODS.BlindEdition:take_ownership('ble_polychrome', {
	set_blind = function(self, blind_on_deck)
		ease_hands_played(-1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('polychrome1', 1.2)
			SMODS.juice_up_blind()
		return true end}))
	end,
})

SMODS.BlindEdition {
	key = 'shimmering',
	blind_shader = 'may_shimmering',
	loc_txt = {
		name = "Shimmering",
		text = {"-1 Discard"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_discard(-1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_shimmering')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.5,
}

SMODS.BlindEdition {
	key = 'amber',
	blind_shader = 'may_amber',
	loc_txt = {
		name = "Amber",
		text = {"Apply Rental to a random Joker"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_amber')
			SMODS.juice_up_blind()
			if #G.jokers.cards ~= 0 then
				G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
					local joker = pseudorandom_element(G.jokers.cards, pseudoseed('may_hourglass'))
					play_sound("tarot1")
					joker:set_rental(true)
                    joker:juice_up(0.3, 0.5)
				return true end}))
			end
		return true end}))
	end,
	weight = 0.4,
}

SMODS.BlindEdition {
	key = 'magenta',
	blind_shader = 'may_magenta',
	loc_txt = {
		name = "Magenta",
		text = {"^1.05 Blind Size"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_magenta')
			SMODS.juice_up_blind()
            G.GAME.blind.chips = G.GAME.blind.chips ^ 1.05
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		return true end}))
	end,
	weight = 0.35,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 4
	end
}

SMODS.BlindEdition {
	key = 'laminated',
	blind_shader = 'may_laminated',
	loc_txt = {
		name = "Laminated",
		text = {"+2% base Blind Size per", "Laminated card"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		local amount = 0
        for k, v in pairs(G.playing_cards) do
            if v.edition and v.edition.key == 'e_may_laminated' then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.jokers.cards) do
            if v.edition and v.edition.key == 'e_may_laminated' then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.edition and v.edition.key == 'e_may_laminated' then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.vouchers.cards) do
            if v.edition and v.edition.key == 'e_may_laminated' then 
                amount = amount + 1
            end 
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * amount * 0.02) 
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound('may_e_laminated') 
            SMODS.juice_up_blind() 
        return true end})) 
	end, 
	weight = 0.3,
}

SMODS.BlindEdition {
	key = 'neon',
	blind_shader = 'may_neon',
	loc_txt = {
		name = "Laminated",
		text = {"-$0.3 per card with", "an Edition"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		local amount = 0
        for k, v in pairs(G.playing_cards) do
            if v.edition then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.jokers.cards) do
            if v.edition then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.edition then 
                amount = amount + 1
            end 
        end
        for k, v in pairs(G.vouchers.cards) do
            if v.edition then 
                amount = amount + 1
            end 
        end
        ease_dollars(amount * - 0.3)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            SMODS.juice_up_blind()
            play_sound('may_e_neon')
        return true end})) 
	end,
	weight = 0.2,
}

SMODS.BlindEdition {
	key = 'alloy',
	blind_shader = 'may_alloy',
	loc_txt = {
		name = "Alloy",
		text = {"+2% base Blind Size per", "Gold and Steel Card"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
        local amount = 0
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_steel') or SMODS.has_enhancement(v, 'm_gold') then 
                amount = amount + 1
            end 
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips * amount * 0.02)
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips) 
			play_sound('may_e_alloy')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.1,
}

SMODS.BlindEdition {
	key = 'radioactive',
	blind_shader = 'may_radioactive',
	loc_txt = {
		name = "Radioactive",
		text = {"X3 Blind Size"}
	},
	contrast = 3, 
    blind_size_mult = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_radioactive')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.1,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.BlindEdition {
	key = 'vignette',
	blind_shader = 'may_shimmering',
	loc_txt = {
		name = "Vignette",
		text = {"X0.9$"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		may.hypermoney(0, 0.9)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_vignette')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.5,
}

SMODS.BlindEdition {
	key = 'inverted',
	blind_shader = 'may_inverted',
	loc_txt = {
		name = "Inverted",
		text = {"-0.02 Interest"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		may.ease_interest(-1, -0.02)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_inverted')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.25,
}

SMODS.BlindEdition {
	key = 'hypnotic',
	blind_shader = 'may_hypnotic',
	loc_txt = {
		name = "Hypnotic",
		text = {"Hands = Discards or vice versa,", "whichever is lower"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		local balanced = math.min(G.GAME.round_resets.hands, G.GAME.round_resets.discards)
		ease_discard(balanced - G.GAME.round_resets.discards)
        ease_hands_played(balanced - G.GAME.round_resets.hands)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_hypnotic')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.1,
}

if #SMODS.find_mod('Cryptid') ~= 0 and may.conf.CM.Cryptid then

SMODS.BlindEdition {
	key = 'misprint',
	blind_shader = 'may_misprint',
	loc_txt = {
		name = "Misprint",
		text = {"nil"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_discard(-math.random(-3, 5))
		ease_hands_played(-math.random(-3, 5))
		local hand_size = math.random(-5, 3)
		G.hand:change_size(hand_size)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + hand_size
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_misprint')
			SMODS.juice_up_blind()
			G.GAME.blind.chips = G.GAME.blind.chips:mul(math.random(0.3, 1.8))
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
			play_sound('may_blind_size')
		return true end}))
	end,
	weight = 0.2,
}

end

SMODS.BlindEdition {
	key = 'goldfoil',
	blind_shader = 'may_goldfoil',
	loc_txt = {
		name = "Goldfoil",
		text = {"-$5"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_goldfoil')
			SMODS.juice_up_blind()
			ease_dollars(-5)
		return true end}))
	end,
	weight = 0.6,
}

SMODS.BlindEdition {
	key = 'print',
	blind_shader = 'may_print',
	loc_txt = {
		name = "Print",
		text = {"Blind gives no reward money"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_print')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.4,
	dollars_mod = function(self, dollars)
		return 0
	end
}

SMODS.BlindEdition {
	key = 'nostalgic',
	blind_shader = 'may_nostalgic',
	loc_txt = {
		name = "Nostalgic",
		text = {"+1 Ante"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_ante(1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_nostalgic')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.02,
}

SMODS.BlindEdition {
	key = 'cosmic',
	blind_shader = 'may_cosmic',
	loc_txt = {
		name = "Cosmic",
		text = {"Level down most played", "Poker Hand by 1"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_cosmic')
			SMODS.juice_up_blind()
			may.th(may.favhand())
			level_up_hand(nil, may.favhand(), nil, -1)
			may.ch()
		return true end}))
	end,
	weight = 0.1,
}

SMODS.BlindEdition {
	key = 'dichromatic',
	blind_shader = 'may_dichromatic',
	loc_txt = {
		name = "Dichromatic",
		text = {"+1 Hand, -2 Discards"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		ease_discard(-2)
        ease_hands_played(1)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_dichromatic')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.2,
}

if may.conf.Mode == 2 then 
    
SMODS.BlindEdition {
	key = 'omega',
	blind_shader = 'may_omega',
	loc_txt = {
		name = "Omega",
		text = {"^^1.177 Blind Size"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.GAME.blind.chips = G.GAME.blind.chips:arrow(2, 1.177)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_omega')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.02,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 8
	end
}

SMODS.BlindEdition {
	key = 'otherworldly',
	blind_shader = 'may_otherworldly',
	loc_txt = {
		name = "Otherworldly",
		text = {"^^^1.5 Blind Size"}
	},
	contrast = 3,
	set_blind = function(self, blind_on_deck)
		G.GAME.blind.chips = G.GAME.blind.chips:arrow(3, 1.5)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
			play_sound('may_e_otherworldly')
			SMODS.juice_up_blind()
		return true end}))
	end,
	weight = 0.002,
	in_pool = function(self, blind_on_deck)
		return G.GAME.round_resets.ante > 8
	end
}

end