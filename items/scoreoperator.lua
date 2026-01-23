-- Score operators

SMODS.Scoring_Calculation:take_ownership('add', {colour = G.C.CHIPS})

SMODS.Scoring_Calculation:take_ownership('exponent', {colour = SMODS.Gradients.may_col_eternum_green})

SMODS.Scoring_Calculation:take_ownership('talisman_hyper', {colour = SMODS.Gradients.may_col_ethereal})

SMODS.Scoring_Calculation {
	order = -2,
	key = "substract",
	func = function(self, chips, mult, flames) return chips - mult end,
	text = '-',
	colour = SMODS.Gradients.may_col_mayhem_gradient
}

SMODS.Scoring_Calculation {
	order = -3,
	key = "divide",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return to_big(chips):div(to_big(mult))
		else
			return to_big(0)
		end
	end,
	text = '/',
	colour = G.C.GREY
}

SMODS.Scoring_Calculation {
	order = -4,
	key = "chips_exclusive",
	func = function(self, chips, mult, flames) return chips end,
	text = '<',
	colour = SMODS.Gradients.may_col_e_omega
}

SMODS.Scoring_Calculation {
	order = -5,
	key = "mult_exclusive",
	func = function(self, chips, mult, flames) return mult end,
	text = '>',
	colour = SMODS.Gradients.may_col_e_omega
}

SMODS.Scoring_Calculation {
	order = -6,
	key = "max",
	func = function(self, chips, mult, flames) return math.max(chips, mult) end,
	text = 'max',
	colour = SMODS.Gradients.may_col_hidden_enhancement
}

SMODS.Scoring_Calculation {
	order = -7,
	key = "min",
	func = function(self, chips, mult, flames) return math.min(chips, mult) end,
	text = 'min',
	colour = SMODS.Gradients.may_col_surreal
}

SMODS.Scoring_Calculation {
	order = -8,
	key = "log_mult",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return to_big(chips):logBase(to_big(mult))
		else
			return to_big(0)
		end
	end,
	text = '>log>',
	colour = G.C.PURPLE
}

SMODS.Scoring_Calculation {
	order = -9,
	key = "log_chips",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return to_big(mult):logBase(to_big(chips))
		else
			return to_big(0)
		end
	end,
	text = '<log<',
	colour = G.C.PURPLE
}

SMODS.Scoring_Calculation {
	order = -10,
	key = "negative_multiply",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return to_big(mult):mul(to_big(chips)) * -1
		else
			return to_big(0)
		end
	end,
	text = 'X-1X',
	colour = G.C.BLACK
}

SMODS.Scoring_Calculation {
	order = -11,
	key = "negative_exponent",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return to_big(mult):arrow(1, to_big(chips)) * -1
		else
			return to_big(0)
		end
	end,
	text = 'X-1^',
	colour = G.C.BLACK
}

SMODS.Scoring_Calculation {
	hidden = true,
	order = -2,
	key = "balance",
	func = function(self, chips, mult, flames) return (chips + mult) / 2 end,
	text = 'BAL',
	colour = G.C.PURPLE
}

SMODS.Scoring_Calculation {
	hidden = true,
	order = 0,
	key = "desmos",
	func = function(self, chips, mult, flames) 
		if to_big(chips) ~= to_big(0) and to_big(mult) ~= to_big(0) then
			return ((chips + (mult * (1  +math.log10(chips)))) * chips) ^ 0.8
		else
			return to_big(0)
		end
	end,
	text = 'DSM',
	colour = G.C.DARK_EDITION
}

-- support for hidden operators
function change_operator(amount)
	local order = SMODS.Scoring_Calculations[G.GAME.current_scoring_calculation_key or "multiply"].order + amount
	if not order then return end
	if G.GAME.current_scoring_calculation_key == "talisman_hyper" then
		G.GAME.hyper_operator = (G.GAME.hyper_operator or 2) + amount
		order = G.GAME.hyper_operator
	end
	local next = "add"
	local keys = {}
	for i, v in pairs(SMODS.Scoring_Calculations) do
		if v.order then
			keys[#keys+1] = i
		end
	end
	table.sort(keys, function(a, b) return SMODS.Scoring_Calculations[a].order < SMODS.Scoring_Calculations[b].order end)
	for i, v in pairs(keys) do
		if SMODS.Scoring_Calculations[v].order <= order and not SMODS.Scoring_Calculations[v].hidden then
			next = v
		end
	end
	if next then
		SMODS.set_scoring_calculation(next)
	end
	if amount > 0 then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
			play_sound('may_increase_operator')
		return true end}))
	else
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
			play_sound('may_decrease_operator')
		return true end}))
	end
end