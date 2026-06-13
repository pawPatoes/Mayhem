-- Mystery Jokers

local UC_messages = {
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
	"Fun fact: Mayhem was originally vanilla+.",
	"F16E9D97CD7388B4", 
	"Gains ^0.02 Mult whe- oh wrong version", 
	"Hello world! And goodbye world!", 
	"I have no idea what I'm doing.",
	"Oh yeah I'm also the fun facts guy.", 
	"LONG LIVE LEGUMES",
}

SMODS.Joker {
	key = 'universal_collapse',
	loc_txt = {
		name = 'Universal Collapse',
		text = {
			{
				"{s:1.2,X:may_instability,C:white}INSTABILITY:{} {s:1.2,C:may_instability,E:2}#1#{}"
			},
			{
				"{C:may_instability}+1{} Instability at the {C:attention}end of round{}", 
				"{X:may_instability,C:white}X1.5{} Instability when {C:attention}Boss Blind{} is defeated", 
				may.pager(), 
				"Must reach {C:may_instability}5{} Instability to {C:attention}fuse{} this Joker", 
				may.pager(), 
				"{X:attention,C:white}+^0.1{} Blind Size per {C:may_instability}Instability{}", 
				may.pager(), 
				"At {C:may_instability}#2#{} Instability, {X:attention,C:white}#3##4#{} Blind Size permanently,", 
				"{X:may_instability,C:white}X2{} threshold and {X:attention,C:white}^3{} Blind Size increase",
				"{C:dark_edition}Hyperoperator{} is based on owned {C:dark_edition}Fusion{} Jokers",
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
		local N = 0
		if G.jokers then
		    for k, v in pairs(G.jokers.cards) do
				if v:gc().rarity == 'may_hyperascendant' then
					N = math.max(N, 35) 
					break
				elseif v:gc().rarity == 'may_surreal' then
					N = math.max(N, 4)
				elseif v:gc().rarity == 'may_ethereal' then
					N = math.max(N, 3)
					break
				elseif v:gc().rarity == 'may_interdimensional' then
					N = math.max(N, 2)
				elseif v:gc().rarity == 'may_transcendent' or v:gc().rarity == 'may_mythic' then
					N = math.max(N, 1)
				end
			end
		end	
		return { vars = { G.GAME.may_instability or 0, G.GAME.may_instability_threshold or 8, '{'..number_format(N)..'}', G.GAME.may_instability_increase or 10, UC_messages[math.random(#UC_messages)] } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			play_sound("may_universal_collapse", 1, 2)
		end
	end,
	rarity = 'may_mystery',
	atlas = '003_temp',
	blueprint_compat = false,
	demicoloncompat = false,
	immutable = true,
	indestructible = true,
	pos = { x = 5, y = 2 },
	cost = 100,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
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
	key = 'doomsday_device_ascended',
	loc_txt = {
		name = '{s:1.3,E:1}Doomsday Device{} {C:may_interdimensional,s:1.3,E:1}(Ascended){}{}',
		text = {
            {
			    "{C:money}Selling{} {C:attention}Jokers{} gives {C:attention}all{} {C:purple}Poker Hands{} {X:purple,C:white}^^^#1#{} Mult & Chips", 
				may.pager(),
                "Held copies of {C:dark_edition}Universal Collapse{} give", 
                "{X:purple,C:white}^^^#2#{} Mult & Chips", 
				may.pager(),
                "At {C:attention}the end of round{}, add {C:may_instability}Instability{}", 
				"to {C:attention}above values{}", 
				may.pager(),
				"{C:inactive}Currently #3#{}", 
				may.pager(), 
                "{C:inactive,E:1,s:0.7}i am evil now{}"
            }, 
            {
                "{C:inactive,E:1}Original art by silly_goober_0nthewall{}"
            }
		}
	},
	config = { extra = { EEEmultchips = 20, EEEmultchips2 = 250 } },
	rarity = 'may_mystery',
	atlas = 'temp_doomsdaydevice',
	pos = { x = 2, y = 0 },
    soul_pos = { x = 4, y = 0, extra = { x = 3, y = 0 } }, 
    immutable = true, 
    blueprint_compat = true,
	cost = 50000,
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
	end
}