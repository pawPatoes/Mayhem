-- Tags

-- Bulk load Edition Tags 
-- edition key (unprefixed), tag key, display name, min ante, x, y, credit, endless
may.edition_tags = {
    {'may_shimmering', 'shimmering', 'Shimmering', 0, 4, 1, 'Superb Thing'},
    {'may_magenta', 'magenta', 'Magenta', 1, 6, 0, 'Superb Thing'},
    {'may_laminated', 'laminated', 'Laminated', 0, 2, 1, 'Superb Thing'},
    {'may_alloy', 'alloy', 'Alloy', 3, 0, 0, 'Superb Thing', true},
    {'may_amber', 'amber', 'Amber', 0, 2, 2},
	{'may_metallic', 'metallic', 'Metallic', 0, 5, 2},
	{'may_twilight', 'twilight', 'Twilight', 0, 6, 2, nil, true},
    {'may_goldfoil', 'goldfoil', 'Goldfoil', 1, 4, 0, 'Superb Thing'},
    {'may_neon', 'neon', 'Neon', 1, 0, 1, 'Superb Thing'},
    {'may_dichromatic', 'dichromatic', 'Dichromatic', 3, 3, 0, 'Superb Thing'},
    {'may_inverted', 'inverted', 'Inverted', 1, 5, 0, 'Superb Thing'},
    {'may_radioactive', 'radioactive', 'Radioactive', 6, 3, 1, 'Superb Thing', true},
    {'may_hypnotic', 'hypnotic', 'Hypnotic', 3, 3, 2},
    {'may_vignette', 'vignette', 'Vignette', 2, 5, 1, 'Superb Thing', true},
    {'may_nostalgic', 'nostalgic', 'Nostalgic', 5, 1, 1, 'Superb Thing', true},
    {'may_cosmic', 'cosmic', 'Cosmic', 4, 2, 0, 'Superb Thing'},
}

for k, v in pairs(may.edition_tags) do
    if v[7] then
        SMODS.Tag {
            atlas = 'tag', 
            pos = { x = v[5], y = v[6] }, 
            min_ante = v[4],
            config = { type = 'store_joker_modify', edition = v[1] }, 
            key = v[2],
            endless = v[8] or false, 
            loc_vars = function(self, info_queue)
                info_queue[#info_queue + 1] = G.P_CENTERS['e_'..v[1]]
                return {}
            end,
            loc_txt = {
                name = v[3]..' Tag', 
                text = {
                    {
                        "The next base edition shop", 
                        "Joker is free and", 
                        "becomes {C:dark_edition}"..v[3].."{}"
                    }, 
                    {
                        "{C:inactive,E:1}Art by "..v[7].."{}"
                    }, 
                }, 
            },
            apply = function(self, tag, context)
                if context.type == "store_joker_modify" then
                    local _applied = nil
                    if Cryptid and Cryptid.forced_edition and Cryptid.forced_edition() then
                        tag:nope()
                    end
                    if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
                        local lock = tag.ID
                        G.CONTROLLER.locks[lock] = true
                        context.card.temp_edition = true
                        tag:yep("+", G.C.DARK_EDITION, function()
                            context.card:set_edition('e_'..v[1], true)
                            context.card.ability.couponed = true
                            context.card:set_cost()
                            context.card.temp_edition = nil
                            G.CONTROLLER.locks[lock] = nil
					    return true end)
                        _applied = true
                        tag.triggered = true
                    end
                end
            end, 
            in_pool = function(self, args)
                if v[8] then 
                    return G.GAME.may_endless_mode, { allow_duplicates = true }
                end 
                return true, { allow_duplicates = true }
            end
        }
    else
        SMODS.Tag {
            atlas = 'tag', 
            pos = { x = v[5], y = v[6] }, 
            min_ante = v[4],
            config = { type = 'store_joker_modify', edition = v[1] }, 
            key = v[2],
            loc_vars = function(self, info_queue)
                info_queue[#info_queue + 1] = G.P_CENTERS['e_'..v[1]]
                return {}
            end,
            loc_txt = {
                name = v[3]..' Tag', 
                text = {
                    "The next base edition shop", 
                    "Joker is free and", 
                    "becomes {C:dark_edition}"..v[3].."{}"
                }, 
            },
            apply = function(self, tag, context)
                if context.type == "store_joker_modify" then
                    local _applied = nil
                    if Cryptid and Cryptid.forced_edition and Cryptid.forced_edition() then
                        tag:nope()
                    end
                    if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
                        local lock = tag.ID
                        G.CONTROLLER.locks[lock] = true
                        context.card.temp_edition = true
                        tag:yep("+", G.C.DARK_EDITION, function()
                            context.card:set_edition('e_'..v[1], true)
                            context.card.ability.couponed = true
                            context.card:set_cost()
                            context.card.temp_edition = nil
                            G.CONTROLLER.locks[lock] = nil
					    return true end)
                        _applied = true
                        tag.triggered = true
                    end
                end
            end, 
            in_pool = function(self, args)
                if v[8] then 
                    return G.GAME.may_endless_mode, { allow_duplicates = true }
                end 
                return true, { allow_duplicates = true }
            end
        }
    end
end

if #SMODS.find_mod('Cryptid') == 0 then

SMODS.Tag {
	atlas = "tag",
	pos = { x = 4, y = 2 },
	min_ante = 2,
	config = { type = "store_joker_create" },
	key = "epic",
	loc_txt = {
		name = 'Epic Tag',
		text = {
			"Shop has an",
			"{C:may_epic}Epic Joker{}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, may.epic_key, nil, nil, nil)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RARITY[may.epic_key], function()
				card:start_materialize()
				card:set_cost()
			return true end)
			tag.triggered = true
			return card
		end
	end,
}

end

SMODS.Tag {
	atlas = "tag",
	pos = { x = 1, y = 3 },
	min_ante = 1,
	config = { type = "voucher_add" },
	key = "pack",
	loc_txt = {
		name = 'Pack Tag',
		text = {
		    {
			    "Add {C:attention}2{} Booster Packs", 
			    "to next shop", 
		    }, 
		    {
			    "{C:inactive,E:1}Original art by _TeKKen_{}",
		    }
		}
	},
	apply = function(self, tag, context)
        if context.type == 'voucher_add' then
            tag:yep('+', G.C.SECONDARY_SET.Booster, function()
				for i = 1, 2 do
                    local pack = SMODS.add_booster_to_shop()
                    pack.from_tag = true
				end
                return true
            end)
            tag.triggered = true
        end
    end
}

SMODS.Tag {
	atlas = "tag",
	pos = { x = 0, y = 3 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "trio",
	endless = true,
	loc_txt = {
		name = 'Trio Tag',
		text = {
			"Creates a random", 
			"{C:tarot}Tarot{}, {C:planet}Planet{} and {C:spectral}Spectral{} Card", 
			"{C:inactive}Requires room{}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GREEN, function()
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if #G.consumeables.cards < G.consumeables.config.card_limit then
					    play_sound('timpani')
					    local card2 = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'may_trio_tag')
					    card2:add_to_deck()
					    G.consumeables:emplace(card2)
					    card2:juice_up(0.3, 0.5)
					end
				return true end}))
			    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if #G.consumeables.cards < G.consumeables.config.card_limit then
					    play_sound('timpani')
					    local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'may_trio_tag')
					    card2:add_to_deck()
					    G.consumeables:emplace(card2)
					    card2:juice_up(0.3, 0.5)
					end
				return true end})) 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					if #G.consumeables.cards < G.consumeables.config.card_limit then
					    play_sound('timpani')
					    local card2 = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'may_trio_tag')
					    card2:add_to_deck()
					    G.consumeables:emplace(card2)
					    card2:juice_up(0.3, 0.5)
					end
				return true end}))
			return true end)
			tag.triggered = true
		return true
		end
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

if may.mode == 2 then

SMODS.Tag {
	atlas = "tag",
	pos = { x = 0, y = 2 },
	min_ante = 2,
	config = { type = "store_joker_create" },
	key = "mythic",
    endless = true,
	loc_txt = {
		name = 'Mythic Tag',
		text = {
			"Shop has a",
			"{C:may_mythic}Mythic Joker{}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, 'may_mythic', nil, nil, nil)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.FILTER, function()
				card:start_materialize()
				card:set_cost()
				play_sound('may_mythic_joker')
			return true end)
			tag.triggered = true
			return card
		end
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

SMODS.Tag {
	atlas = "tag",
	pos = { x = 1, y = 2 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "unstable",
    endless = true, 
	loc_txt = {
		name = 'Unstable Tag',
		text = {
			"Creates an {C:attention}Universal Collapse{} Joker",
			"{C:attention}+3{} Ante",
			"{C:inactive}(requires room){}"
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				tag:yep("+", G.C.PURPLE, function()
					if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_universal_collapse', 'may_genesis')
						G.jokers:emplace(card2)
						play_sound('may_thunder'..math.random(1,2)..'', 1, 0.75)
						card2:add_to_deck()
						ease_ante(3)
						G.CONTROLLER.locks[lock] = nil
					end
				return true end)
			else
				tag:nope()
			end
			tag.triggered = true
		return true
		end
	end,
    in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}

end

--[[SMODS.Tag {
	atlas = "tag",
	pos = { x = 2, y = 0 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "save_tag",
	loc_txt = {
		name = 'Save Tag',
		text = {
			"Create a random {C:dark_edition}Negative{}",
			"{C:attention}Perishable{} {X:may_surreal,C:white}Surreal{} {C:attention}Joker{}",
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.PURPLE, function()
				local card = create_card("Joker", G.jokers, nil, 'may_surreal', nil, nil, nil)
				card:add_to_deck()
				card:set_edition({negative = true}, true)
				card:set_perishable(true)
				G.jokers:emplace(card)
				play_sound('may_surreal_joker')
				G.CONTROLLER.locks[lock] = nil
			return true end)
			tag.triggered = true
		return true
		end
	end,
}]]

SMODS.Tag {
	atlas = "tag",
	pos = { x = 6, y = 1 },
	min_ante = 7,
	config = { type = "immediate" },
	key = "astronomy",
	endless = true,
	loc_txt = {
		name = 'Astronomy Tag',
		text = {
			"Creates a {C:attention}random{} {X:mult,C:white}Rare{}",
			"{C:planet}Planet Card{}",
			"{C:inactive}Requires room{}",
		}
	},
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.RED, function()
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
						play_sound('timpani', 0.5)
						local card2 = create_card('Planet', G.consumeables, nil, nil, nil, nil, pseudorandom_element(may.rare_planets, pseudoseed('may_telescope_tag')), 'may_telescope_tag')
						card2:add_to_deck()
						G.consumeables:emplace(card2)
						card2:juice_up(0.3, 0.5)
					return true end}))
				end
			return true end)
			tag.triggered = true
		return true
		end
	end, 
	in_pool = function(self, args)
        return G.GAME.may_endless_mode, { allow_duplicates = true }
    end
}