-- Paradoxical Jokers

may.omniversal_catalyst_messages = {
	"I don't feel safe around this thing...",
	"Are you sure this is a good idea?",
	"I dont like where this is going.",
	"I choose to remain mysterious out of laziness.",
	"I feel funny...",
	"How did we get here?",
	"Is this thing really that important to you?",
	"Why am I saying strange things? I thought this mod has no lore!",
	"I am self aware, I just like not to think about it.",
	"This thing's making me hear colors!",
	"Maybe the Wheel of Fortune will work next time...",
	"I AM OMINOUS. PLEASE BE SCARED.",
	"Nice face cards you got there, gonna summon The Plant just for you!",
	"Fun fact: Mayhem was originally Vanilla+.",
	"F16E9D97CD7388B4", 
	"Gains ^0.02 Mult whe- oh wrong version", 
	"Hello world! And goodbye world!", 
	"I have no idea what I'm doing.",
	"Oh yeah I'm also the fun facts guy.", 
	"LONG LIVE LEGUMES",
	"ALL HAIL THE DARK LORD OF THE TWIN MOONS", 
	"Alex. Bring him. Embrace my chaos. And transcend.",
	"Pineapple on pizza doesn't deserve the hate."
}

SMODS.Joker {
	key = 'omniversal_catalyst',
	loc_txt = {
		name = '{X:white,C:may_demiurgic,E:may_omniversal_name}Omniversal{} {X:white,C:may_demiurgic,E:may_omniversal_name}Catalyst{}',
		text = {
			{
				"{s:1.2,X:may_instability,C:white}INSTABILITY:{} {s:1.2,C:may_instability,E:2}#1#{}"
			},
			{
				"{C:may_instability}+1{} Instability at the {C:attention}end of round{}", 
				"{X:may_instability,C:white}X1.5{} Instability when {C:attention}Boss Blind{} is defeated", 
				may.pager(), 
				"Must {C:attention}own{} this Joker for {C:attention}5{} {C:inactive}(#7#){} Rounds to {C:attention}fuse{} it", 
				may.pager(), 
				"{X:may_col_huge_operator_alt,C:white}+#3#0.1{} Blind Size per {C:may_instability}Instability{}", 
				may.pager(), 
				"{C:inactive}G = #6#{}",
				may.pager(), 
				"{C:inactive,s:0.7,E:1}#5#{}", 
			}, 
			may.add_fusion_text('many Jokers', 'more powerful counterparts', 'Varies'),
			{
				"{C:inactive,E:1}Art by FirstTry{}",
				"{C:inactive,E:1}Original idea by Pakins{}"
			},
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "may_global_op_tutorial", set = "Other" }
		return { vars = { G.GAME.may_instability or 0, G.GAME.may_instability_threshold or 8, '{G}', G.GAME.may_instability_increase or 10, may.omniversal_catalyst_messages[math.random(#may.omniversal_catalyst_messages)], may.global_op(), math.max(0, 5 - card.ability.extra.rounds) } }
	end,
	config = { extra = { rounds = 0 } },
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_omniversal_catalyst", 1, 2)
		end
	end,
	rarity = 'may_paradoxical',
	atlas = 'joker1',
	blueprint_compat = false,
	demicoloncompat = false,
	immutable = true,
	indestructible = true,
	pos = { x = 5, y = 4 },
	cost = 100,
	attributes = {
		'hyperblindsize', 
		'eblindsize'
	}, 
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.rounds = card.ability.extra.rounds + 1
			if context.beat_boss then
				may.ease_instability(0, 1.5)
				return {
					message = "X1.5 Instability", 
					card = card,
					colour = SMODS.Gradients.may_col_instability
				}
			else
				may.ease_instability(-1, 1)
				return {
					message = "+1 Instability", 
					card = card,
					colour = SMODS.Gradients.may_col_instability
				}
            end
		end
	end
}

SMODS.Joker {
	key = 'alex343xd_ascended',
	loc_txt = {
		name = '{X:white,s:1.3,E:may_alex343xd_name,C:may_col_mayhem_gradient}alex343xd{} {X:white,C:may_prismatic,s:1.3,E:may_doomsday_name}(Ascended){}',
		text = {
            {
			    "{C:money}Selling{} {C:attention}Jokers{} gives", 
				"{C:attention}all{} {C:purple}Poker Hands{} "..may.hyp(3, 'multchips', '^^^#1#').." Chips & Mult", 
				may.pager(60),
                "Held copies of {C:dark_edition}Omniversal Catalyst{} give", 
                may.hyp(3, 'multchips', '^^^#2#').." Chips & Mult", 
				may.pager(60),
                "At {C:attention}the end of round{}, add {C:may_instability}Instability{}", 
				"to {C:attention}above values{}", 
				may.pager(60),
				"{C:inactive}Instability is currently #3#{}", 
				may.pager(60), 
                "{C:inactive,E:1,s:0.7}i am evil now{}"
            }, 
            {
                "{C:inactive,E:1}Original art by silly_goober_0nthewall{}"
            }
		}
	},
	config = { extra = { EEEmultchips = 20, EEEmultchips2 = 250 } },
	rarity = 'may_paradoxical',
	atlas = 'joker2',
	pos = { x = 4, y = 1 },
    soul_pos = { x = 0, y = 2, extra = { x = 5, y = 1 } }, 
    immutable = true, 
    blueprint_compat = true,
	cost = 800,
	attributes = {
		'joker', 
		'eeemult', 
		'eeechip', 
		'scaling'
	}, 
	misc_badge = {
		colour = SMODS.Gradients.may_col_prismatic,
		text_colour = G.C.WHITE,
		text = {
			'Secret',
		}
	},
	endless = true, 
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_may_universal_collapse
		return { vars = { card.ability.extra.EEEmultchips, card.ability.extra.EEEmultchips2, (G.GAME.may_instability or 0) } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then 
            may.hand_mod_multchips_all('multchips', 3, card.ability.extra.EEEmultchips, false, card)
        end
        if context.other_joker and context.other_joker:gc().key == 'j_may_universal_collapse' then
            return {
				message = "^^^"..card.ability.extra.EEEmultchips2.." Mult & Chips",
				EEEmult_mod = card.ability.extra.EEEmultchips2,
				EEEchip_mod = card.ability.extra.EEEmultchips2,
				colour = G.C.PURPLE,
				sound = 'may_eeeboth'
			}
        end
		if context.end_of_round and context.game_over == false and context.main_eval then
			card.ability.extra.EEEmultchips = card.ability.extra.EEEmultchips + (G.GAME.may_instability or 0)
			card.ability.extra.EEEmultchips2 = card.ability.extra.EEEmultchips2 + (G.GAME.may_instability or 0)
			if G.GAME.may_instability > 0 then 
				return {
					message = localize('k_upgrade_ex'), 
					colour = SMODS.Gradients.may_col_instability, 
					card = card,
				}
			end
		end 
	end, 
	global_op = function(self, card)
		return 3
	end
}