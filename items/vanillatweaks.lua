-- Changes to Vanilla content

-- Add rarity badge to Soul and change formatting

SMODS.Consumable:take_ownership('c_soul', {
	misc_badge = may_rare_badge, 
    loc_txt = {
        name = 'The Soul', 
        text = {
            "Create a {C:attention}random{}", 
            "{X:legendary,C:white}Legendary{} {C:attention}Joker{}", 
            "{C:inactive}(Requires room){}"
        }
    }
})

-- Buff Spectral and celestial Packs
	
SMODS.Booster:take_ownership('p_spectral_normal_1', {
	weight = 1.2,
	config = {extra = 3, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_normal_2', {
	weight = 1.2,
	config = {extra = 3, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_jumbo_1', {
	weight = .8,
	config = {extra = 5, choose = 1}
})

SMODS.Booster:take_ownership('p_spectral_mega_1', {
	weight = .6,
	config = {extra = 6, choose = 2}
})

for i=1, 4 do
    SMODS.Booster:take_ownership('p_celestial_normal_'..i, {
	    weight = 1,
	    config = {extra = 4, choose = 1}, 
		draw_hand = true
    })
end 

for i=1, 2 do
    SMODS.Booster:take_ownership('p_celestial_jumbo_'..i, {
	    weight = .5,
	    config = {extra = 6, choose = 1}, 
		draw_hand = true, 
    })
end

for i=1, 2 do
    SMODS.Booster:take_ownership('p_celestial_mega_'..i, {
	    weight = .25,
	    config = {extra = 7, choose = 2},
		draw_hand = true,
    })
end

-- Unable to duplicate Fusion Jokers

SMODS.Consumable:take_ownership('c_ankh', {
    loc_txt = {
        name = "Ankh", 
        text = {
            "{C:attention}Duplicate{} a {C:attention}random{}", 
            "{C:mult}non-{}{C:dark_edition}Fusion{} {C:attention}Joker{}", 
            "{C:mult}Destroy{} all {C:attention}other{} {C:mult}non-{}{C:dark_edition}Fusion{} {C:attention}Jokers{}", 
            "{C:inactive}Surreal Jokers count as Fusion Jokers{}"
        }
    }, 
    can_use = function(self, card)
        for k, v in pairs(G.jokers.cards) do
            if not v:may_is_fusion() and not (v:gc().rarity == 'may_surreal') then 
                return may.canuse()
            end
        end 
        return false 
    end,
    use = function(self, card)
        local targets = {}
        for k, v in pairs(G.jokers.cards) do
            if not v:may_is_fusion() and not (v:gc().rarity == 'may_surreal') then 
                table.insert(targets, v)
            end
        end
        local target = pseudorandom_element(targets, pseudoseed('may_ankh'))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
            local card2 = copy_card(target, nil, nil, nil, nil)
            card2:start_materialize()
            card2:add_to_deck()
            G.jokers:emplace(card2)
            play_sound('timpani')
        return true end})) 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
            for k, v in pairs(targets) do
                if v ~= target then 
                    v:start_dissolve()
                end
            end
        return true end}))
    end
})

SMODS.Joker:take_ownership('j_invisible', {
    loc_txt = {
        name = "Invisible Joker", 
        text = {
            "After {C:attention}#1# rounds{},", 
            "{C:money}sell{} {C:attention}this Joker{} to {C:green}duplicate{}",
            "another {C:attention}random{} {C:mult}non-{}{C:dark_edition}Fusion{} {C:attention}Joker{}", 
            "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#){}", 
            "{C:inactive}Surreal Jokers count as Fusion Jokers{}", 
			"{C:inactive}Removes Negative Edition from copy{}"
        }
    }, 
    config = { extra = { invis_rounds = 0, total_rounds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.invis_rounds } }
    end, 
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.invis_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            local jokers = {}
            for k, v in pairs(G.jokers.cards) do
                if v ~= card and not v:may_is_fusion() and not (v:gc().rarity == 'may_surreal') then
                    table.insert(jokers, v)
                end
            end
            if #jokers > 0 then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    local chosen_joker = pseudorandom_element(jokers, 'may_invisible_joker')
                    local copied_joker = copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
                    copied_joker:add_to_deck()
                    G.jokers:emplace(copied_joker)
                    return { message = localize('k_duplicated_ex') }
                else
                    return { message = localize('k_no_room_ex') }
                end
            else
                return { message = localize('k_no_other_jokers') }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.invis_rounds = card.ability.extra.invis_rounds + 1
            if card.ability.extra.invis_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.invis_rounds < card.ability.extra.total_rounds) and (card.ability.extra.invis_rounds .. '/' .. card.ability.extra.total_rounds) or localize('k_active_ex'),
            }
        end
    end
})

-- Turn Black Hole into a Spectral Planet
SMODS.Consumable:take_ownership('c_black_hole', {
    pools = { SpectralPlanet = true },
    cost = 6,
    soul_rate = may.spectral_planet_rate,
    loc_txt = {
		name = {"Black Hole", "{C:dark_edition,s:0.7}Spectral Planet{}"}, 
		text = {
			"{C:planet}Level up{} {C:attention}all{} {C:purple}Poker Hands{}", 
			"by {C:attention}#1#{}"
		}, 
	},
    config = { extra = { level = 1 } }, 
    loc_vars = function(self, info_queue, card)
    	return {vars = { card.ability.extra.level } }
    end, 
    use = function(self, card)
        may.level_up_all_hands(card, false, card.ability.extra.level)
    end
})

-- Add fusion notices to vanilla jokers
SMODS.Joker:take_ownership('j_blueprint', {
    loc_txt = {
        name = "Blueprint", 
        text = {
            {
                "Copies ability of", 
				"{C:attention}Joker{} to the right{}",
   		 }, 
    		may.add_fusion_text('Universal Collapse', 'Schematicum', '{C:dark_edition}Transcendent Scaling{} active & used {C:attention}20{} {C:spectral}Potents{}')
        }, 
    },
	no_tree = true,
})

SMODS.Joker:take_ownership('j_marble', {
    loc_txt = {
        name = "Marble Joker", 
        text = {
            {
                "Adds one", 
                "{C:dark_edition}Stone Card{}", 
                "to the deck", 
                "when {C:attention}Blind{} is",
                "selected"
   		 }, 
    		may.add_fusion_text('Granite Joker', 'Bedrock Joker', 'At least {C:attention}10{} {C:dark_edition}Stone Cards{} in deck')
        }, 
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    end
})

SMODS.Joker:take_ownership('j_stone', {
    loc_txt = {
        name = "Stone Joker", 
        text = {
            {
                "Gives {C:chips}+#1#{} Chips for", 
				"each {C:dark_edition}Stone Card{}", 
				"in your {C:attention}full deck{}", 
				"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}"
   		 }, 
    		may.add_fusion_text('Bedrock Joker', 'Bismuth Joker', 'At least {C:attention}120{} {C:dark_edition}Stone Cards{} {C:mult}destroyed{}')
        }, 
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		local amount = 0
		for k, v in pairs(G.playing_cards or {}) do 
			if SMODS.has_enhancement(v, 'm_stone') then 
				amount = amount + 1
			end
		end 
		return { card.ability.extra and (type(card.ability.extra) == 'table' and card.ability.extra.chips or false) or self.config.chips or 25, (card.ability.extra and (type(card.ability.extra) == 'table' and card.ability.extra.chips or false) or self.config.chips or 25) * amount }
    end
})

-- Rework High Priestess and The Fool 
SMODS.Consumable:take_ownership('c_high_priestess', {
    loc_txt = {
        name = 'The High Priestess', 
        text = {
            "Convert all {C:attention}selected{}", 
            "cards {C:attention}held in hand{}", 
            "into random", 
			"{C:tarot}Tarot{} or {C:planet}Planet{} {C:dark_edition}CCDs{}"
        }
    }, 
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'may_ccd_tutorial', set = 'Other' }
    end, 
    can_use = function(self, card)
        return may.canuse() and #G.hand.highlighted > 0
    end, 
    use = function(self, card, copier)
		local pool = {}
		for k, v in pairs(G.P_CENTER_POOLS.Tarot) do
			table.insert(pool, v)
		end 
		for k, v in pairs(G.P_CENTER_POOLS.Planet) do
			table.insert(pool, v)
		end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end }))
		for i=1, #G.hand.highlighted do
			local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		for i=1, #G.hand.highlighted do
			local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();G.hand.highlighted[i]:set_ability(may.random_consumable('may_hp', nil, 'c_high_priestess', pool, true), true, nil);play_sound('tarot2', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);G.hand.highlighted[i].highlighted = false;return true end }))
		end
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
            G.hand:unhighlight_all()
        return true end}))
    end,
})

SMODS.Consumable:take_ownership('c_fool', {
    config = { extra = { cards = 1 } }, 
    loc_txt = {
        name = 'The Fool', 
        text = {
            "Create #1# {C:attention}copy{} of", 
            "the {C:attention}last{} {C:tarot}Tarot Card{}", 
            "{C:attention}used{} this run", 
            "{C:inactive}(The Fool excluded, requires room){}"
        }
    }, 
    loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.last_tarot and G.P_CENTERS[G.GAME.last_tarot] or nil
        local last_tarot = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or localize('k_none')
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN
        if fool_c and fool_c.name ~= 'The Fool' then
            info_queue[#info_queue + 1] = fool_c
        end
        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }
        return { vars = { card.ability.extra.cards or 1 }, main_end = main_end }
    end, 
    use = function(self, card, copier)
        for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.last_tarot })
                    card:juice_up(0.3, 0.5)
                end
            return true end}))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
		return may.canuse() and (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit + ( card.area == G.consumeables and 1 or 0 )) and (G.GAME.last_tarot or 'c_fool') ~= 'c_fool'
	end,
})

-- Choose new defaults for vanilla consumables and change their collection display size

SMODS.ObjectTypes.Tarot.collection_rows = {7, 7, 7}
SMODS.ObjectTypes.Planet.collection_rows = {8, 8, 8}
SMODS.ObjectTypes.Spectral.collection_rows = {6, 7, 6}

SMODS.ObjectTypes.Planet.default = 'c_may_dysnomia'
SMODS.ObjectTypes.Tarot.default = 'c_fool'
SMODS.ObjectTypes.Spectral.default = 'c_may_aeon'

-- Buff The Lovers

SMODS.Consumable:take_ownership('c_lovers', {
    config = { max_highlighted = 2, mod_conv = 'm_wild' }, 
    loc_txt = {
        name = 'The Lovers', 
        text = {
            "Enhances {C:attention}#1#{}", 
            "selected cards to", 
            "{C:attention}Wild Cards{}"
        }
    }, 
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { self.config.max_highlighted } }
    end
})

-- Make Hiker use Mayhem permabonus sound

SMODS.Joker:take_ownership('j_hiker', {
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS, 
                sound = 'may_permabonus'
            }
        end
    end
})

-- Perkeo unable to duplicate hidden and special consumables

SMODS.Joker:take_ownership('j_perkeo', {
    calculate = function(self, card, context)
        if context.ending_shop then
			if G.consumeables.cards[1] then
				local available
				for i = 1, #G.consumeables.cards do
					if not (G.consumeables.cards[i]:gc().hidden or G.consumeables.cards[i]:gc().no_doe or G.consumeables.cards[i]:gc().no_perkeo) then
					    available = true
					    break
					end
				end
				if available then
				    G.E_MANAGER:add_event(Event({func = function() 
					    local total, checked, center = 0, 0, nil
					    for i = 1, #G.consumeables.cards do
						    if not (G.consumeables.cards[i]:gc().hidden or G.consumeables.cards[i]:gc().no_doe or G.consumeables.cards[i]:gc().no_perkeo) then
								total = total + (G.consumeables.cards[i]:getQty())
						    end
					    end
					    local poll = pseudorandom(pseudoseed('perkeo'))*total
					    for i = 1, #G.consumeables.cards do
						    checked = checked + (G.consumeables.cards[i]:getQty())
						    if checked >= poll then
							    center = G.consumeables.cards[i]
						    break
						    end
					    end
					    if center then
							local card = copy_card(center, nil)
							card:setQty(1)
							card:setInfinite(false)
							card:set_edition({negative = true}, true)
						    card:add_to_deck()
						    G.consumeables:emplace(card) 
					    end
				    return true end}))
				    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
				    return {calculated = true}
				else
					return {
					    message = localize('k_nope_ex'), 
					    colour = G.C.RED
				    }
				end
			else
				return {
					message = localize('k_nope_ex'), 
					colour = G.C.RED
				}
			end 
		end
    end
})

-- Make the following discovered and unlocked by default for the intro
may.intro_unlocks = {'b_blue', 'b_green', 'b_black', 'b_yellow'}
SMODS.Joker:take_ownership('j_sly', {
	discovered = true
}, true)

for k, v in pairs(may.intro_unlocks) do
    SMODS.Back:take_ownership(v, {
	    discovered = true, 
	    unlocked = true,
    }, true)
end

-- Make certain Vanilla Vouchers sellable
may.sellable_vanilla_vouchers = {
	'v_tarot_merchant',
    'v_tarot_tycoon', 
	'v_planet_merchant', 
	'v_planet_tycoon', 
	'v_magic_trick', 
	'v_omen_globe', 
	'v_hieroglyph', 
	'v_petroglyph', 
	'v_telescope', 
	'v_hone', 
	'v_glow_up'
}
for k, v in pairs(may.sellable_vanilla_vouchers) do
	SMODS.Voucher:take_ownership(v, {
	    voucher_sellable = true
    }, true)
end