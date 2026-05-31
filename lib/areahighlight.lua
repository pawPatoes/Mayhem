-- Misc value increases (Hand Size, Card Selection Limit etc.)
-- taken from POLTERWORX

-- Disable if Spotlight (mod that does same thing) is installed 
if #SMODS.find_mod('Spotlight') == 0 then 
    
local vanf_casc = CardArea.change_size
function CardArea:change_size(mod, silent)
	vanf_casc(self, mod)
	if not silent then self:may_highlight_mod(mod) end
end

function CardArea:may_highlight_mod(mod)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = '+'
			local col = G.C.FILTER
			if mod < 0 then
				text = '-'
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
			-- juicing hand does some funky UI stuff so no
			if self ~= G.hand then
				self:juice_up(0.3, 0.5)
			end
		return true end}))
		delay(0.5)
	end
end

function CardArea:change_max_highlight(mod, silent)
	self.config.highlighted_limit = self.config.highlighted_limit + (mod or 0)
	if self == G.hand then
		SMODS.change_play_limit(mod)
		SMODS.change_discard_limit(mod)
	end
	if not silent then self:may_highlight_mod_selection_limit(mod) end
end

function CardArea:may_highlight_mod_selection_limit(mod)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = 'Selection Limit +'
			local col = G.C.FILTER
			if mod < 0 then
				text = 'Selection Limit -'
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up(0.3, 0.5)
			end
		return true end}))
		delay(0.5)
	end
end

end

-- Hyperoperations on CardArea slots
function CardArea:change_size_hyper(mod, arrow, silent)
	if mod ~= 0 then 
		G.E_MANAGER:add_event(Event({func = function() 
			self.config.real_card_limit = to_number(to_big((self.config.real_card_limit or self.config.card_limit)):arrow(arrow, mod))
			self.config.card_limit = math.max(0, self.config.real_card_limit)
			if mod > 0 and self.config.real_card_limit > 1 and self == G.hand and self.cards[1] and (G.STATE == G.STATES.DRAW_TO_HAND or G.STATE == G.STATES.SELECTING_HAND) then 
				local card_count = math.abs(mod)
				for i=1, card_count do
					draw_card(G.deck,G.hand, i*100/card_count,nil, nil , nil, 0.07)
					G.E_MANAGER:add_event(Event({func = function() self:sort() return true end}))
				end
			end
			if self == G.hand then check_for_unlock({type = 'min_hand_size'}) end
		return true end}))
    end
	if not silent then self:may_highlight_mod_hyper(mod, arrow) end
end

function CardArea:may_highlight_mod_hyper(mod, arrow)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text
			if arrow == 0 then
				text = 'X'
			else
				text = may.generate_arrow_text(arrow, 5)
			end
			local col = G.C.DARK_EDITION
			if mod < 1 then
				col = G.C.RED
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			if self == G.jokers then
				play_sound('may_hyper_joker_slots', 1, 0.3)
			elseif self == G.hand then
				play_sound('may_hyper_selection_limit', 1, 0.3)
			else
				play_sound('may_hyper_consumable_slots', 1, 0.3)
			end
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up(0.3, 0.5)
			end
		return true end}))
		delay(0.5)
	end
end

function CardArea:change_max_highlight_hyper(mod, arrow, silent)
	self.config.highlighted_limit = to_number(to_big(self.config.highlighted_limit):arrow(arrow, mod))
	if not silent then self:may_highlight_mod_selection_limit_hyper(mod, arrow) end
end

function CardArea:may_highlight_mod_selection_limit_hyper(mod, arrow)
	if (mod or 0) ~= 0 then
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			mod = mod or 0
			local text = 'Selection Limit'
			local col = G.C.DARK_EDITION
			if mod < 0 then
				col = G.C.RED
			end
			if arrow == 0 then
				text = text..' X'
			else
				text = text..' '..may.generate_arrow_text(arrow, 5)
			end
			attention_text({
				text = text..tostring(math.abs(mod)),
				scale = 1, 
				hold = 1,
				cover = self,
				cover_colour = col,
				align = 'cm',
			})
			play_sound('highlight2', 0.715, 0.2)
			play_sound('may_hyper_selection_limit', 1, 0.3)
			play_sound('generic1')
			if self ~= G.hand then
				self:juice_up(0.3, 0.5)
			end
		return true	end}))
		delay(0.5)
	end
end