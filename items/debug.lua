-- Debug tools
if may.conf.Debug then

	local goog = to_big(1e100)
	
	-- added this way before the Alt+f5 shortcut and I've gotten used to it because contrary to popular belief im a human
	SMODS.Keybind {
		key_pressed = '`',
		action = function(self)
			SMODS.restart_game()
		end
	}
	
	SMODS.Keybind {
		key_pressed = '6',
		action = function(self)
			if may.conf.Mode == 1 then
				may.conf.Mode = 2
			else
				may.conf.Mode = 1
			end
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f1',
		action = function(self)
			mult = mod_mult((G.ARGS.score_intensity.required_score+1)*to_big(1e101))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f2',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(1, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f3',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(2, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f4',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(3, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f5',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(4, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f6',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(10, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f7',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(20, to_big(1e101)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f8',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(80, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f9',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(160, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f10',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(500, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f11',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(1000, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'f',
		action = function(self)
			mult = mod_mult((to_big(G.ARGS.score_intensity.required_score+1)):arrow(2000, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'a',
		action = function(self)
			mult = mod_mult(may.tr_constants.tr14)
			hand_chips = mod_chips(may.tr_constants.tr14)
			may.hm(mult)
			may.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '.',
		action = function(self)
			mult = mod_mult(may.tr_constants.tr15)
			hand_chips = mod_chips(may.tr_constants.tr15)
			may.hm(mult)
			may.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '=',
		action = function(self)
			mult = mod_mult(may.tr_constants.tr16)
			hand_chips = mod_chips(may.tr_constants.tr16)
			may.hm(mult)
			may.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ',',
		action = function(self)
			mult = mod_mult(may.tr_constants.tr17)
			hand_chips = mod_chips(may.tr_constants.tr17)
			may.hm(mult)
			may.hc(hand_chips)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'p',
		action = function(self)
			mult = mod_mult(may.tr_constants.tr18)
			hand_chips = mod_chips(may.tr_constants.tr18)
			may.hm(mult)
			may.hc(hand_chips)
		end
	}
	
	--[[SMODS.Keybind {
		key_pressed = 'c',
		action = function(self)
			mult = mod_mult(may.tr_constants.googchime:arrow(300000, to_big(1e101):arrow(1, 10)))
			hand_chips = mod_chips(may.tr_constants.googchime:arrow(300000, to_big(1e101):arrow(1, 10)))
			may.hm(mult)
			may.hc(hand_chips)
		end
	}]]
	
	SMODS.Keybind {
		key_pressed = '+',
		action = function(self)
			level_up_hand(G.jokers[1], 'High Card', nil, 1)
			may.ch()
		end
	}
	
	SMODS.Keybind {
		key_pressed = '-',
		action = function(self)
			level_up_hand(G.jokers[1], 'High Card', nil, -1)
			may.ch()
		end
	}
	
	SMODS.Keybind {
		key_pressed = '[',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(2, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(2, 10)
			end
			delay(0.5)
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eemult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eechip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('^^10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ']',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(3, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(3, 10)
			end
			delay(0.5)
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eeemult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('talisman_eeechip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('^^^10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = ';',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(4, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(4, 10)
			end
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hexmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '^^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hexchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('^^^^10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = "'",
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(5, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(5, 10)
			end
			delay(0.5)
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hepmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '^^^^^10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_hepchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('^^^^^10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'o',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:arrow(6, 10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:arrow(6, 10)
			end
			delay(0.5)
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_octmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '{6}10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_octchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('{6}10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'rshift',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = to_big(G.GAME.hands[k].mult):arrow(10, 10)
				G.GAME.hands[k].chips = to_big(G.GAME.hands[k].chips):arrow(10, 10)
			end
			delay(0.5)
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, '{10}10', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('{10}10', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'g',
		action = function(self)
			collectgarbage("collect")
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'i',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = G.GAME.hands[k].mult:aperiorate(10)
				G.GAME.hands[k].chips = G.GAME.hands[k].chips:aperiorate(10)
			end
			may.hn("All Hands")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, 'Mult^[10]', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('Chips^[10]', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'l',
		action = function(self)
			G.GAME.hands['High Card'].mult = G.GAME.hands['High Card'].mult:extend()
			G.GAME.hands['High Card'].chips = G.GAME.hands['High Card'].chips:extend()
			may.hn("High Card")
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('button')
			return true end}))
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decmult')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm(nil, 'Mult<->', true)
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('may_decchip')
				G.ROOM.jiggle = G.ROOM.jiggle + 2
			return true end}))
			may.hcm('Chips<->', nil, true)
			may.ch()
			delay(0.5)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '7',
		action = function(self)
			G.GAME.hands['High Card'].level = 1000
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'd',
		action = function(self)
			G.GAME.hands['High Card'].level = 205
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'up',
		action = function(self)
			change_operator(1)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'down',
		action = function(self)
			change_operator(-1)
		end
	}
	
	SMODS.Keybind {
		key_pressed = 's',
		action = function(self)
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_may_spadus', 'may_debug')
				G.jokers:emplace(card2)
				card2:add_to_deck()
				play_sound("may_hyperascendant_joker")
			return true end}))
		end
	}
	
	SMODS.Keybind {
		key_pressed = 'y',
		action = function(self)
			for k, v in pairs(G.GAME.hands) do
				G.GAME.hands[k].mult = math.max(G.GAME.hands[k].l_mult*(G.GAME.hands[k].level - 1), 1)
				G.GAME.hands[k].chips = math.max(G.GAME.hands[k].l_chips*(G.GAME.hands[k].level - 1), 0)
			end
		end
	}
	
	SMODS.Keybind {
		key_pressed = '4',
		action = function(self)
			G.jokers:change_size_hyper(2, 0)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '5',
		action = function(self)
			G.consumeables:change_size_hyper(2, 0)
		end
	}
	
	SMODS.Keybind {
		key_pressed = '6',
		action = function(self)
			G.hand:change_max_highlight_hyper(2, 0)
		end
	}
	
end