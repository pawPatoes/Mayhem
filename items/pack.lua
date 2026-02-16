-- Booster packs

SMODS.Booster {
	key = "b_premium1",
	kind = 'may_premium',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = .9,
	draw_hand = false,
	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, G.C.RED, G.C.ATTENTION },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = poll_edition('may_premium' .. G.GAME.round_resets.ante, 2, true, true)
        local _seal = SMODS.poll_seal({ mod = 10, guaranteed = true })
        local _enhance = SMODS.poll_enhancement({ guaranteed = true })
        return {
            set = "Playing Card",
            edition = _edition,
            seal = _seal,
            enhancement = _enhance,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "may_premium"
        }
    end,
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Premium Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Playing Cards{}",
            "with random {C:dark_edition}Enhancements{},", 
            "{C:dark_edition}Editions{} and {C:dark_edition}Seals{}", 
			"to be added to deck"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_premium_pack",
	cry_digital_hallucinations = {
		colour = G.C.FILTER,
		loc_key = "may_cry_plus_premium",
		create = function()
			local card = create_playing_card({ center = SMODS.poll_enhancement({ guaranteed = true })}, G.play, true, true, {G.C.MONEY})
		    card:set_edition('e_negative')
		    card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "may_premium" }), true, false)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play:remove(card)
                G.deck:emplace(card)
                play_sound('card1')
            return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_premium1",
	kind = 'may_premium',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 5, choose = 1 },
	cost = 9,
	weight = .8,
	draw_hand = false,
	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, G.C.RED, G.C.ATTENTION },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = poll_edition('may_premium' .. G.GAME.round_resets.ante, 2, true, true)
        local _seal = SMODS.poll_seal({ mod = 10, guaranteed = true })
        local _enhance = SMODS.poll_enhancement({ guaranteed = true })
        return {
            set = "Playing Card",
            edition = _edition,
            seal = _seal,
            enhancement = _enhance,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "may_premium"
        }
    end,
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Premium Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Playing Cards{}",
            "with random {C:dark_edition}Enhancements{},", 
            "{C:dark_edition}Editions{} and {C:dark_edition}Seals{}", 
			"to be added to deck"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_premium_pack",
	cry_digital_hallucinations = {
		colour = G.C.FILTER,
		loc_key = "may_cry_plus_premium",
		create = function()
			local card = create_playing_card({ center = SMODS.poll_enhancement({ guaranteed = true })}, G.play, true, true, {G.C.MONEY})
		    card:set_edition('e_negative')
		    card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "may_premium" }), true, false)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play:remove(card)
                G.deck:emplace(card)
                play_sound('card1')
            return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_mega_premium1",
	kind = 'may_premium',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 5, choose = 2 },
	cost = 12,
	weight = .7,
	draw_hand = false,
	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, G.C.RED, G.C.ATTENTION },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = poll_edition('may_premium' .. G.GAME.round_resets.ante, 2, true, true)
        local _seal = SMODS.poll_seal({ mod = 10, guaranteed = true })
        local _enhance = SMODS.poll_enhancement({ guaranteed = true })
        return {
            set = "Playing Card",
            edition = _edition,
            seal = _seal,
            enhancement = _enhance,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "may_premium"
        }
    end,
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Mega Premium Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Playing Cards{}",
            "with random {C:dark_edition}Enhancements{},", 
            "{C:dark_edition}Editions{} and {C:dark_edition}Seals{}", 
			"to be added to deck"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.RED, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_premium_pack",
	cry_digital_hallucinations = {
		colour = G.C.FILTER,
		loc_key = "may_cry_plus_premium",
		create = function()
			local card = create_playing_card({ center = SMODS.poll_enhancement({ guaranteed = true })}, G.play, true, true, {G.C.MONEY})
		    card:set_edition('e_negative')
		    card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "may_premium" }), true, false)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play:remove(card)
                G.deck:emplace(card)
                play_sound('card1')
            return true end}))
		end
	}
}

SMODS.Booster {
	key = "b_editioncard1",
	kind = 'may_modifiercard',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = true,
	create_card = function(self, card)
		return create_card("may_modifiercard", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Enhanced Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Modifier Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_modifiercard_pack",
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end, 
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("may_modifiercard", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_modifiercard1",
	kind = 'may_modifiercard',
	atlas = "booster",
	pos = { x = 1, y = 0 },
	config = { extra = 6, choose = 1 },
	cost = 8,
	weight = .9,
	draw_hand = true,
	create_card = function(self, card)
		return create_card("may_modifiercard", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Enhanced Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Modifier Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_modifiercard_pack",
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end, 
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("editioncards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}

SMODS.Booster {
	key = "b_mega_editioncard1",
	kind = 'may_modifiercard',
	atlas = "booster",
	pos = { x = 2, y = 0 },
	config = { extra = 6, choose = 2 },
	cost = 10,
	weight = .8,
	draw_hand = true,
	create_card = function(self, card)
		return create_card("may_modifiercard", G.pack_cards, nil, nil, true, true, nil, "may_edcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Mega Enhanced Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Modifier Cards{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_modifiercard_pack",
    in_pool = function(self, args)
        return G.GAME.round > 6, { allow_duplicates = true }
    end, 
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_edition_card",
		create = function()
			local ccard = create_card("may_modifiercard", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}
for i=1, 2 do
    
SMODS.Booster {
	key = "b_retrocard"..i,
	kind = 'retrocards',
	atlas = "booster",
	pos = { x = i-1, y = 3 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Pixel Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2# Retro Cards{}",
			    "to be used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}, 
    in_pool = function(self, args)
        return G.GAME.round >= 9, { allow_duplicates = true }
    end
}

end

SMODS.Booster {
	key = "b_jumbo_retrocard1",
	kind = 'retrocards',
	atlas = "booster",
	pos = { x = 2, y = 3 },
	config = { extra = 5, choose = 1 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Pixel Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2# Retro Cards{}",
			    "to be used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	},
    in_pool = function(self, args)
        return G.GAME.round >= 9, { allow_duplicates = true }
    end
}

SMODS.Booster {
	key = "b_mega_retrocard1",
	kind = 'retrocards',
	atlas = "booster",
	pos = { x = 3, y = 3 },
	config = { extra = 5, choose = 2 },
	cost = 6,
	weight = 1,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("retrocards", G.pack_cards, nil, nil, true, true, nil, "may_rcpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Mega Pixel Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2# Retro Cards{}",
			    "to be used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('1b7500'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_retro_pack",
	cry_digital_hallucinations = {
		colour = HEX('1b7500'),
		loc_key = "may_cry_plus_retro_card",
		create = function()
			local ccard = create_card("retrocards", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}, 
    in_pool = function(self, args)
        return G.GAME.round >= 9, { allow_duplicates = true }
    end
}

-- have to use pseudorandom element because all of the yotta cards are technically hidden
may.yotta_cards = {
	'c_may_planetae',
	'c_may_cupiditas',
	'c_may_potestas'
}

may.asc_yotta_cards = {
	'c_may_planetae_asc',
	'c_may_cupiditas_asc',
	'c_may_potestas_asc'
}

if may.conf.content.WIP and may.conf.Mode == 2 then

SMODS.Booster {
	key = "b_yottacard1",
	kind = 'yottacard',
	atlas = "placeholder_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 1, choose = 1 },
	cost = 100,
	weight = .5,
	misc_badge = may_wip_badge,
	draw_hand = false,
    endless = true, 
	create_card = function(self, card)
		return create_card("yottacards", G.pack_cards, nil, nil, true, true, pseudorandom_element(may.yotta_cards, pseudoseed('may_yotta_pack')), "may_yottapack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.YELLOW, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Yotta Card Pack",
		text = {
			"Choose {C:attention}#1#{} random {C:money}Yotta Card{}",
			"to be used immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		if (G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "ascendedyottas") then
			ease_background_colour({ new_colour = G.C.BLACK, special_colour = SMODS.Gradients.may_col_asc_yotta, contrast = 2 })
		else
			ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.YELLOW, contrast = 2 })
		end
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_yotta_pack",
	cry_digital_hallucinations = {
		colour = G.C.YELLOW,
		loc_key = "may_cry_plus_yotta",
		create = function()
			local ccard = create_card("yottacards", G.consumables, nil, nil, nil, nil, pseudorandom_element(may.yotta_cards, pseudoseed('may_yotta_pack')), "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

end

for i=1, 4 do
	
local pos = { x = i + 2, y = 0}
if i > 2 then
	pos.x = i - 3
	pos.y = 1
end

SMODS.Booster {
	key = "b_voucherpack"..i,
	kind = 'voucher',
	atlas = "booster",
	pos = pos,
	config = { extra = 2, choose = 1 },
	cost = 11,
	weight = 0.9,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, may.get_next_voucher_key(), "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} regular {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				may.voucher()
			return true end}))
		end
	},
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0,0, {
			timer = 0.05,
			scale = 0.2,
			initialize = true,
			lifespan = 6,
			speed = 0.1,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = {G.C.GREEN, G.C.BLACK},
			fill = true
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
}

end

for i=1, 2 do

SMODS.Booster {
	key = "b_jumbo_voucherpack"..i,
	kind = 'voucher',
	atlas = "booster",
	pos = { x = i + 1, y = 1 },
	order = 5,
	config = { extra = 3, choose = 1 },
	cost = 15,
	weight = .6,
	draw_hand = false,
    endless = true,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} regular {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				may.voucher()
			return true end}))
		end
	},
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0,0, {
			timer = 0.05,
			scale = 0.2,
			initialize = true,
			lifespan = 6,
			speed = 0.1,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = {G.C.GREEN, G.C.BLACK},
			fill = true
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

end

for i=1, 2 do

SMODS.Booster {
	key = "b_mega_voucherpack"..i,
	kind = 'voucher',
	atlas = "booster",
	pos = { x = i, y = 2 },
	order = 5,
	config = { extra = 5, choose = 1 },
	cost = 25,
	weight = .4,
    endless = true,
	draw_hand = false,
	create_card = function(self, card)
		return create_card("Voucher", G.pack_cards, nil, nil, true, true, nil, "may_voucherpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Mega Voucher Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} regular {C:green}Vouchers{}",
			"to be redeemed immediately"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.GREEN, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_voucher_pack",
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "may_cry_plus_voucher",
		create = function()
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				may.voucher()
			return true end}))
		end
	},
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0,0, {
			timer = 0.05,
			scale = 0.2,
			initialize = true,
			lifespan = 6,
			speed = 0.1,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = {G.C.GREEN, G.C.BLACK},
			fill = true
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

end

may.universal_choices = {'Tarot', 'Planet', 'Spectral'}

SMODS.Booster {
	key = "b_universalpack1",
	kind = 'universal',
	atlas = "booster",
	pos = { x = 4, y = 3 },
	order = 5,
	config = { extra = 7, choose = 2 },
	cost = 9,
	weight = 1,
	draw_hand = true,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Universal Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{} or",
			    "{C:spectral}Spectral{} Cards to be",
			    "used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

SMODS.Booster {
	key = "b_universalpack2",
	kind = 'universal',
	atlas = "booster",
	pos = { x = 0, y = 4 },
	order = 5,
	config = { extra = 7, choose = 2 },
	cost = 9,
	weight = 1,
	draw_hand = true,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Universal Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{} or",
			    "{C:spectral}Spectral{} Cards to be",
			    "used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

SMODS.Booster {
	key = "b_jumbo_universalpack1",
	kind = 'universal',
	atlas = "booster",
	pos = { x = 1, y = 4 },
	order = 5,
	config = { extra = 8, choose = 3 },
	cost = 11,
	weight = .8,
	draw_hand = true,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Jumbo Universal Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{} or",
			    "{C:spectral}Spectral{} Cards to be",
			    "used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

SMODS.Booster {
	key = "b_mega_universalpack1",
	kind = 'universal',
	atlas = "booster",
	pos = { x = 2, y = 4 },
	order = 5,
	config = { extra = 9, choose = 3 },
	cost = 13,
	weight = .6,
	draw_hand = true,
	create_card = function(self, card)
		return create_card(pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack')), G.pack_cards, nil, nil, true, true, nil, "may_universalpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Mega Universal Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2#{} {C:purple}Tarot{}, {C:planet}Planet{} or",
			    "{C:spectral}Spectral{} Cards to be",
			    "used immediately"
            }, 
            {
                "{C:inactive,E:1}Art by T3rragon{}"
            }
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.ETERNAL, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_universal_pack",
	cry_digital_hallucinations = {
		colour = G.C.ETERNAL,
		loc_key = "may_cry_plus_universal",
		create = function()
			local choice = pseudorandom_element(may.universal_choices, pseudoseed('may_universalpack'))
			local ccard = create_card(choice, G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			if choice == 'Voucher' then
				if not G.P_CENTERS[ccard:gc().key] then return end
				local area
				if G.STATE == G.STATES.HAND_PLAYED then
					if not G.redeemed_vouchers_during_hand then
						G.redeemed_vouchers_during_hand = CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, {type = 'play', card_limit = 5})
					end
					area = G.redeemed_vouchers_during_hand
				else
					area = G.play
				end
				ccard:start_materialize()
				area:emplace(ccard)
				ccard.cost=0
				ccard.shop_voucher=false
				ccard:redeem()
				G.E_MANAGER:add_event(Event({delay = 0,func = function() 
					ccard:start_dissolve()
				return true end}))
			else
				G.consumeables:emplace(ccard)
			end
		end
	}
}

--[[SMODS.Booster {
	key = "b_booster_bundle",
	kind = 'booster',
	atlas = "booster",
	pos = { x = 0, y = 0 },
	order = 5,
	config = { extra = 5, choose = 2 },
	cost = 7,
	weight = .7,
	draw_hand = false,
	select_card = 'consumeables',
	create_card = function(self, card)
		return create_card("Booster", G.pack_cards, nil, nil, true, true, nil, "may_boosterbundle")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.EDITION, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Booster Bundle",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2#{} {C:green}Booster Packs{}",
			"to be added to your Consumable Slots"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = G.C.PURPLE, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_booster_bundle",
	cry_digital_hallucinations = {
		colour = G.C.EDITION,
		loc_key = "may_cry_plus_booster",
		create = function()
			local ccard = create_card("Booster", G.consumables, nil, nil, nil, nil, nil, "diha")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end
	}
}]]

for i=1, 4 do
    
SMODS.Booster {
	key = "b_fusion"..i,
	kind = 'fusion',
	atlas = "booster",
	pos = { x = i-1, y = 5 },
	config = { extra = 5, choose = 1 },
	cost = 15,
	weight = 0.5,
	draw_hand = false,
	endless = true,
	create_card = function(self, card)
		return create_card("Fusable_NOBP", G.pack_cards, nil, nil, true, true, nil, "may_fpack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = SMODS.Gradients.may_col_mayhem_gradient, special_colour = HEX('aa0000'), contrast = 1 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Fusion Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of",
			    "up to {C:attention}#2#{} {C:dark_edition}fusable{} {C:attention}Base Jokers{}",
				"{C:inactive}Blueprint excluded{}"
            }, 
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLACK)
		ease_background_colour({ new_colour = SMODS.Gradients.may_col_mayhem_gradient, special_colour = HEX('aa0000'), contrast = 1 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_may_fusion_pack",
	cry_digital_hallucinations = {
		colour = SMODS.Gradients.may_col_mayhem_gradient,
		loc_key = "may_cry_plus_fusable",
		create = function()
			local pool = {}
		    for k, v in pairs(G.P_CENTERS) do
			    if v.set == 'Joker' and may.is_fusable(v) and not may.is_fusion(v) then 
				    table.insert(pool, v)
			    end 
		    end
			local ccard = create_card("Joker", G.jokers, nil, nil, nil, nil, may.random_consumable('diha', nil, nil, pool, true), "diha").key
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.jokers:emplace(ccard)
		end
	}, 
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0,0, {
			timer = 0.05,
			scale = 0.2,
			initialize = true,
			lifespan = 6,
			speed = 0.1,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = {SMODS.Gradients.may_col_mayhem_gradient, G.C.BLACK},
			fill = true
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = false }
    end
}

end