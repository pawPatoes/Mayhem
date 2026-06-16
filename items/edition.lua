-- Editions

SMODS.Edition {
	key = "shimmering",
	loc_txt = {
		name = "Shimmering",
		label = "Shimmering",
		text = {
			"{C:mult}+15{} Mult and {C:chips}+10{} Chips"
		}
	},
	shader = 'shimmering',
	discovered = true,
	badge_colour = HEX('ffc9ff'),
	sound = { sound = "may_e_shimmering", per = 1, vol = 0.9 },
	unlocked = true,
	config = { mult = 15, chips = 15 },
	in_shop = true,
	weight = 10,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				chips = self.config.chips,
				mult = self.config.mult
			}
		end
	end
}

SMODS.Edition {
	key = "magenta",
	loc_txt = {
		name = "Magenta",
		label = "Magenta",
		text = {
			"{X:may_score,C:white}^1.05{} Score",
			"{C:inactive}Shader by Supernova{}"
		}
	},
	shader = 'magenta',
	discovered = true,
	badge_colour = HEX('9649cc'),
	sound = { sound = "may_e_magenta", per = 1, vol = 0.9 },
	unlocked = true,
	config = { e_score = 1.05 },
	in_shop = true,
	weight = 6,
	extra_cost = 5,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.after and (context.cardarea == G.play or context.cardarea == G.consumeables or context.cardarea == G.jokers) then
			G.E_MANAGER:add_event(Event({func = function() 
				G.GAME.chips = to_big(G.GAME.chips):arrow(1, 1.05)
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.4, 0.4)
			return true end}))
			card_eval_status_text(card, 'jokers', nil, percent, nil, {message = "^"..self.config.e_score.." Score", colour =  G.C.EDITION, edition = true})
		end
	end
}

SMODS.Edition {
	key = "laminated",
	loc_txt = {
		name = "Laminated",
		label = "Laminated",
		text = {
			"{C:mult}+3{} Mult and {C:chips}+10{} Chips",
			"{C:attention}per{} {C:dark_edition}Laminated{} card in card area",
			"{C:inactive}Currently +#1# Mult and +#2# Chips{}",
		}
	},
	shader = 'laminated',
	discovered = true,
	badge_colour = HEX('ffc9ff'),
	sound = { sound = "may_e_laminated", per = 1, vol = 0.9 },
	unlocked = true,
	config = { mult = 3, chips = 10 },
	in_shop = true,
	weight = 25,
	extra_cost = 3,
	apply_to_float = true,
	loc_vars = function(self, info_queue, card)
		local amount = 0
		if G.GAME.blind and card.area then
			for k, v in ipairs(card.area.cards) do
				if v.edition and v.edition.key == 'e_may_laminated' then
					amount = amount + 1
				end
			end
		end
		if Engulf and card and card.gc then
			if Engulf.table_contains(Engulf.AllowedSets, card:gc().set) or Engulf.table_contains(Engulf.AllowedKeys, card:gc().key) and not Engulf.table_contains(Engulf.CardBlacklist, card:gc().key) then 
				info_queue[#info_queue + 1] = { key = "may_enf_laminated", set = "Other" } 
			end
		end
		return { vars = { self.config.mult * amount, self.config.chips * amount }, }
	end,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			local count = 0
			for k, v in pairs(card.area.cards) do
				if v.edition and v.edition.key == 'e_may_laminated' then
					count = count + 1
				end
			end
			return {
				chips = self.config.chips * count,
				mult = self.config.mult * count
			}
		end
	end
}

SMODS.Edition {
	key = "alloy",
	loc_txt = {
		name = "Alloy",
		label = "Alloy",
		text = {
			"{X:mult,C:white}X0.5{} Mult per {C:attention}Steel Card{}",
			"in full deck",
			"{X:money,C:white}+1{} Interest Cap per {C:attention}Gold Card{}",
			"in full deck",
			"{C:inactive}Currently X#1# Mult and +#2# Interest Cap{}",
			"{C:inactive}Shader by Supernova{}"
		}
	},
	shader = 'alloy',
	discovered = true,
	badge_colour = HEX('cccccc'),
	sound = { sound = "may_e_alloy", per = 1, vol = 0.9 },
	unlocked = true,
	config = { x_mult = 0.15, interest_cap = 1 },
	in_shop = true,
	weight = 5,
	extra_cost = 9,
	apply_to_float = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		local steel = 0
		local gold = 0
		if G.GAME.blind then
			for k, v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, 'm_steel') then
					steel = steel + 1
				elseif SMODS.has_enhancement(v, 'm_gold') then
					gold = gold + 1
				end
			end
		end
		return { vars = { 1 + (self.config.x_mult * steel), gold }, }
	end,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			local steel = 0
			local gold = 0
			for k, v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, 'm_steel') then
					steel = steel + 1
				elseif SMODS.has_enhancement(v, 'm_gold') then
					gold = gold + 1
				end
			end
			G.E_MANAGER:add_event(Event({func = function()
				may.ease_interest_cap(-1, gold)
			return true end}))
			return {
				x_mult = 1 + (self.config.x_mult * steel),
			}
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Edition {
	key = "amber",
	loc_txt = {
		name = "Amber",
		label = "Amber",
		text = {
			"{C:mult}-5{} Mult and {C:chips}+75{} Chips"
		}
	},
	shader = 'amber',
	discovered = true,
	badge_colour = HEX('854711'),
	sound = { sound = "may_e_amber", per = 1, vol = 1 },
	unlocked = true,
	config = { mult = -5, chips = 75 },
	in_shop = true,
	weight = 10,
	extra_cost = 4,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				chips = self.config.chips,
				mult = self.config.mult,
			}
		end
	end
}

SMODS.Edition {
	key = "goldfoil",
	loc_txt = {
		name = "Goldfoil",
		label = "Goldfoil",
		text = {
			"{C:money}+$5{}", 
            "{C:inactive}Applies during scoring{}"
		}
	},
	shader = 'goldfoil',
	discovered = true,
	badge_colour = HEX('ffd561'),
	sound = { sound = "may_e_goldfoil", per = 1, vol = 0.9 },
	unlocked = true,
	config = { p_dollars = 5 },
	in_shop = true,
	weight = 8,
	extra_cost = 6,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				dollars = 5
			}
		end
	end
}

SMODS.Edition {
	key = "neon",
	loc_txt = {
		name = "Neon",
		label = "Neon",
		text = {
			"{C:money}+$0.2{} per {C:attention}owned card{}",
			"with an {C:dark_edition}Edition{}",
			"{C:inactive}Currently +$#1#{}",
			"{C:inactive}Shader by Supernova{}"
		}
	},
	shader = 'neon',
	discovered = true,
	badge_colour = HEX('000000'),
	sound = { sound = "may_e_neon", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 5,
	extra_cost = 9,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) or (context.using_consumeable and context.consumeable == card) then
			local amount = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.edition then
					amount = amount + 1
				end
			end
			for k, v in ipairs(G.consumeables.cards) do
				if v.edition then
					amount = amount + 1
				end
			end
			for k, v in ipairs(G.playing_cards) do
				if v.edition then
					amount = amount + 1
				end
			end
			return {
				dollars = (amount or 0) * 0.2
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		local amount = 0
		if G.GAME.blind then
			for k, v in ipairs(G.jokers.cards) do
				if v.edition then
					amount = amount + 1
				end
			end
			for k, v in ipairs(G.consumeables.cards) do
				if v.edition then
					amount = amount + 1
				end
			end
			for k, v in ipairs(G.playing_cards) do
				if v.edition then
					amount = amount + 1
				end
			end
		end
		return { vars = { (amount or 0) * 0.2 }, }
	end
}

SMODS.Edition {
	key = "dichromatic",
	loc_txt = {
		name = "Dichromatic",
		label = "Dichromatic",
		text = {
			"{X:mult,C:white}^1.4{} Mult",
			"{X:chips,C:white}X0.2{} Chips",
			"{C:inactive}Shader by Supernova{}"
		}
	},
	shader = 'dichromatic',
	discovered = true,
	badge_colour = HEX('ff0000'),
	sound = { sound = "may_e_dichromatic", per = 1, vol = 1 },
	unlocked = true,
	config = { e_mult = 1.4, x_chips = 0.2 },
	in_shop = true,
	weight = 6,
	extra_cost = 7,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				e_mult = 1.4,
				x_chips = 0.2,
			}
		end
	end
}

SMODS.Edition {
	key = "inverted",
	loc_txt = {
		name = "Inverted",
		label = "Inverted",
		text = {
			"{C:money}+0.03 Interest{}",
			"{C:inactive}Shader by Supernova{}"
		}
	},
	shader = 'inverted',
	discovered = true,
	badge_colour = HEX('555555'),
	sound = { sound = "may_e_inverted", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 8,
	extra_cost = 7,
	apply_to_float = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "may_interest_tutorial", set = "Other" }
		if Engulf and card and card.gc then
			if Engulf.table_contains(Engulf.AllowedSets, card:gc().set) or Engulf.table_contains(Engulf.AllowedKeys, card:gc().key) and not Engulf.table_contains(Engulf.CardBlacklist, card:gc().key) then 
				info_queue[#info_queue + 1] = { key = "may_enf_inverted", set = "Other" } 
			end 
		end
		return {}
    end,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			may.ease_interest(-1, 0.03)
			return {
				message = '+0.03 Interest',
				colour = G.C.EDITION
			}
		end
	end
}


SMODS.Edition {
	key = "radioactive",
	loc_txt = {
		name = "Radioactive",
		label = "Radioactive",
		text = {
			"{C:attention}Retrigger{} this card {C:attention}2{} times",
		}
	},
	shader = 'radioactive',
	discovered = true,
	badge_colour = HEX('82e66e'),
	sound = { sound = "may_e_radioactive", per = 1, vol = 2 },
	unlocked = true,
	config = { repetitions = 2 },
	in_shop = true,
	weight = 1,
	extra_cost = 12,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.other_card == card and ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) and not context.using_consumeable then
			return {
				message = 'Again!',
				repetitions = (card and card.edition and card.edition.repetitions or self.config.repetitions),
				card = card,
			}
		end
	end
}

SMODS.Edition {
	key = "hypnotic",
	loc_txt = {
		name = "Hypnotic",
		label = "Hypnotic",
		text = {
			"{C:mult}=Chips^1.5{} Mult",
			" ",
			"{C:inactive,E:1}Shader by Oiiman{}"
		}
	},
	shader = 'hypnotic',
	discovered = true,
	badge_colour = SMODS.Gradients.may_col_big_operator,
	sound = { sound = "may_e_hypnotic", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 2,
	extra_cost = 5,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				eq_mult = to_big(hand_chips):arrow(1, 1.5)
			}
		end
	end
}

SMODS.Edition {
	key = "vignette",
	loc_txt = {
		name = "Vignette",
		label = "Vignette",
		text = {
			"{X:purple,C:white}+5{} Mult & Chips",
			"{X:purple,C:white}X1.2{} Mult & Chips",
			"{C:inactive}WIP Shader{}"
		}
	},
	shader = 'shimmering',
	discovered = true,
	badge_colour = HEX('aaaaaa'),
	config = { mult = 5, chips = 5, x_mult = 1.2, x_chips = 1.2 },
	sound = { sound = "may_e_vignette", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 7,
	extra_cost = 5,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				mult = 5,
				chips = 5,
				x_mult = 1.2,
				x_chips = 1.2
			}
		end
	end, 
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Edition{
	key = "print",
	loc_txt = {
		name = "Print",
		label = "Print",
		text = {
			"Card is {C:money}80% cheaper{}"
		}
	},
	shader = 'print',
	discovered = true,
	badge_colour = HEX('aaaaaa'),
	sound = { sound = "may_e_print", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 3,
	extra_cost = 0,
	apply_to_float = true,
}

SMODS.Edition{
	key = "metallic",
	loc_txt = {
		name = "Metallic",
		label = "Metallic",
		text = {
			"{C:mult}Destroying{} this card in any way",
			"has a {C:mult}fixed{} {C:green}50%{} chance",
			"of {C:green}success{}",
			" ",
			"{C:inactive,E:1}Shader by Oiiman{}"
		}
	},
	shader = 'metallic',
	discovered = true,
	badge_colour = HEX('aaaaaa'),
	sound = { sound = "may_e_metallic", per = 1, vol = 0.7 },
	unlocked = true,
	in_shop = true,
	weight = 1,
	extra_cost = 11,
	apply_to_float = true,
}

SMODS.Edition{
	key = "nostalgic",
	loc_txt = {
		name = "Nostalgic",
		label = "Nostalgic",
		text = {
            "When {C:attention}Blind{} is {C:attention}selected{}", 
            "create a copy of", 
            "{C:tarot}The Fool{} or {C:planet}Dysnomia{}", 
            "{C:green}regardless{} of {C:attention}card area{}", 
            "{C:inactive}Requires room{}"
		}
	},
	shader = 'nostalgic',
	discovered = true,
	badge_colour = HEX('d1a54d'),
	sound = { sound = "may_e_nostalgic", per = 1, vol = 0.9 },
	unlocked = true,
	in_shop = true,
	weight = 3,
	extra_cost = 11,
	apply_to_float = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
        info_queue[#info_queue + 1] = G.P_CENTERS.c_may_dysnomia
    end,
    calculate = function(self, card, context)
        if context.setting_blind then 
            if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then 
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                    local choice = pseudorandom_element({'c_fool', 'c_may_dysnomia'}, pseudoseed('may_nostalgic'))
                    SMODS.add_card({ key = choice })
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = {(choice == 'c_fool' and '+The Fool' or '+Dysnomia')}, colour = (choice == 'c_fool' and G.C.SECONDARY_SET.Tarot or G.C.SECONDARY_SET.Planet), delay = 0.45})
                return true end}))
            end 
        end 
    end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Edition {
	key = "twilight",
	loc_txt = {
		name = "Twilight",
		label = "Twilight",
		text = {
			"{C:purple}+#1#{} Mult & Chips", 
			"Scales {C:dark_edition}exponentially{} and {C:green}globally{}", 
			"when any card with {C:dark_edition}Twilight Edition{}", 
			"is triggered", 
			"Does {C:mult}not{} {C:green}scale{} on {C:attention}playing cards{}", 
			" ",
			"{C:inactive,E:1}Shader by Oiiman{}"
		}
	},
	shader = 'twilight',
	discovered = true,
	badge_colour = HEX('880000'),
	sound = { sound = "may_e_twilight", per = 1, vol = 1 },
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		if Engulf and card and card.gc then
			if Engulf.table_contains(Engulf.AllowedSets, card:gc().set) or Engulf.table_contains(Engulf.AllowedKeys, card:gc().key) and not Engulf.table_contains(Engulf.CardBlacklist, card:gc().key) then
				info_queue[#info_queue + 1] = { key = "may_enf_twilight", set = "Other" } 
			end
		end
		return { vars = { G.GAME.may_twilight_amount or 5 } }
	end,
	calculate = function(self, card, context)
		if context.pre_joker then
			local previous = G.GAME.may_twilight_amount or 5
			G.GAME.may_twilight_amount = math.min(1e300, ((G.GAME.may_twilight_amount or 5) ^ 1.05))
			return {
				mult = previous,
				chips = previous,
			}
		end
		if context.main_scoring and context.cardarea == G.play then 
			return {
				mult = (G.GAME.may_twilight_amount or 5),
				chips = (G.GAME.may_twilight_amount or 5),
			}
		end
	end,
	in_shop = true,
	weight = 6,
	extra_cost = 5,
	apply_to_float = true,
} 

SMODS.Edition {
	key = "cosmic",
	loc_txt = {
		name = "Cosmic",
		label = "Cosmic",
		text = {
			"{C:planet}Level up{} played {C:purple}Poker Hand{}",
			"before scoring",
		}
	},
	shader = 'cosmic',
	discovered = true,
	badge_colour = HEX('117b9c'),
	sound = { sound = "may_e_cosmic", per = 1, vol = 0.9 },
	unlocked = true,
    loc_vars = function(self, info_queue, card)
		if Engulf and card and card.gc then
			if Engulf.table_contains(Engulf.AllowedSets, card:gc().set) or Engulf.table_contains(Engulf.AllowedKeys, card:gc().key) and not Engulf.table_contains(Engulf.CardBlacklist, card:gc().key) then 
				info_queue[#info_queue + 1] = { key = "may_enf_cosmic", set = "Other" } 
			end
		end
        return {}
    end, 
	calculate = function(self, card, context)
		if context.before and (context.cardarea == G.play or context.cardarea == G.jokers) then
			level_up_hand(card, context.scoring_name, nil, 1)
		end
	end,
	in_shop = true,
	weight = 5,
	extra_cost = 7,
	apply_to_float = true,
}

SMODS.Edition {
	key = "light",
	loc_txt = {
		name = "Light",
		label = "Light",
		text = {
			"{C:purple}+150{} Mult & Chips",
			"{X:purple,C:white}X15{} Mult & Chips",
			"{X:purple,C:white}^1.5{} Mult & Chips",
			"{C:attention}Retrigger{} this card",
			" ",
			"{C:inactive,E:1}Shader by Oiiman{}"
		}
	},
	shader = 'light',
	discovered = true,
	badge_colour = HEX('dddd11'),
	sound = { sound = "may_e_light", per = 1, vol = 0.9 },
	unlocked = true,
	config = { mult = 150, chips = 150, x_mult = 15, x_chips = 15, e_mult = 1.5, e_chips = 1.5, repetitions = 1 },
	in_shop = true,
	weight = 0.25,
	extra_cost = 45,
	apply_to_float = true,
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				chips = self.config.chips,
				mult = self.config.mult,
				x_chips = self.config.x_chips,
				x_mult = self.config.x_mult,
				e_chips = self.config.e_chips,
				e_mult = self.config.e_mult,
			}
		end
		if context.other_card == card and ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) and not context.using_consumeable then
			return {
				message = 'Again!',
				repetitions = (card and card.edition and card.edition.repetitions or self.config.repetitions),
				card = card,
			}
		end
	end
}