-- Rarities

-- Mayhem has functionally identical Epic Jokers from Cryptid so this is used to not have 2 Epic rarities
may.epic_key = 'may_epic'
if #SMODS.find_mod('Cryptid') ~= 0 then
	may.epic_key = 'cry_epic'
end

if #SMODS.find_mod('Cryptid') == 0 then

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
	key = 'mystery',
	name = "??????",
	loc_txt = {
		name = "??????"
	},
	badge_colour = G.C.BLACK,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'transcendent',
	loc_txt = {
	name = "Transcendent"
	},
	badge_colour = G.C.DARK_EDITION,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'surreal',
	loc_txt = {
		name = "Surreal"
	},
	badge_colour = SMODS.Gradients.may_col_surreal,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'interdimensional',
	loc_txt = {
		name = "Interdimensional"
	},
	badge_colour = SMODS.Gradients.may_col_interdimensional,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'ethereal',
	loc_txt = {
		name = "Ethereal",
	},
	badge_colour = SMODS.Gradients.may_col_ethereal,
	default_rate = 0,
	pools = {["Joker"] = true}
}

SMODS.Rarity{
	key = 'hyperascendant',
	name = "HyperAscendant",
	loc_txt = {
		name = "HyperAscendant"
	},
	badge_colour = SMODS.Gradients.may_col_hyperascendant,
	default_rate = 0,
	pools = {["Joker"] = true}
}

-- Rarity badge function so the text can be scaled up
may.hyperascendant_badge = function(self, card, badges)
	badges[#badges + 1] = create_badge('HyperAscendant', SMODS.Gradients.may_col_hyperascendant, nil, 1.7)
end 