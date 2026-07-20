-- Rarities

-- Mayhem has functionally identical Epic Jokers from Cryptid so this is used to not have 2 Epic rarities
may.epic_key = 'may_epic'
if #SMODS.find_mod('Cryptid') ~= 0 then
	may.epic_key = 'cry_epic'
else
	SMODS.Rarity{
		key = 'epic',
		name = "Epic",
		loc_txt = {
			name = "Epic"
		},
		badge_colour = HEX("ef0098"),
		default_rate = 0.009,
		pools = {["Joker"] = true}, 
    	get_weight = function(self, weight, object_type)
			return 0.003
		end, 
	}
end

SMODS.Rarity{
	key = 'mythic',
	name = "Mythic",
	loc_txt = {
		name = "Mythic"
	},
	badge_colour = G.C.FILTER,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'paradoxical',
	name = "Paradoxical",
	loc_txt = {
		name = "Paradoxical"
	},
	badge_colour = SMODS.Gradients.may_col_instability,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'ethereal',
	loc_txt = {
	name = "Ethereal"
	},
	badge_colour = SMODS.Gradients.may_col_e_otherworldly,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'opalescent',
	loc_txt = {
		name = "Opalescent"
	},
	badge_colour = SMODS.Gradients.may_col_opalescent,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'prismatic',
	loc_txt = {
		name = "Prismatic"
	},
	badge_colour = SMODS.Gradients.may_col_prismatic,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'demiurgic',
	loc_txt = {
		name = "Demiurgic",
	},
	badge_colour = SMODS.Gradients.may_col_demiurgic,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'transcendent',
	name = "Transcendent",
	loc_txt = {
		name = "Transcendent"
	},
	badge_colour = SMODS.Gradients.may_col_transcendent,
	default_rate = 0,
	pools = {["Joker"] = true}
}

-- Badge functions so the text can be scaled up and shaders
may.transcendent_badge = function(self, card, badges)
	badges[#badges + 1] = create_badge('Transcendent', HEX('FFFFFF'), nil, 1.7, 'may_transcendent')
end

may.paradoxical_badge = function(self, card, badges)
	badges[#badges + 1] = create_badge('Paradoxical', SMODS.Gradients.may_col_instability, nil, 1.2, 'may_paradoxical_bg')
end 