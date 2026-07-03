if not Spectrallib then

	may.vanilla_unapply_results = {}
	may.vanilla_unapply_results["Overstock"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	change_shop_size(-center_table.extra)
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Overstock Plus"] = may.vanilla_unapply_results["Overstock"]
	may.vanilla_unapply_results["Clearance Sale"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.discount_percent = 0
            	for k, v in pairs(G.I.CARD) do
                	if v.set_cost then
                    	v:set_cost()
                	end
            	end
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Liquidation"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.discount_percent = 25 -- no idea why the below returns nil, so it's hardcoded now
            	-- G.GAME.discount_percent = G.P_CENTERS.v_clearance_sale.extra
            	for k, v in pairs(G.I.CARD) do
                	if v.set_cost then
                    	v:set_cost()
                	end
            	end
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Hone"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.edition_rate = G.GAME.edition_rate / center_table.extra
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Glow Up"] = may.vanilla_unapply_results["Hone"]
	may.vanilla_unapply_results["Reroll Surplus"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra
            	G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + card.ability.extra)
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Reroll Glut"] = may.vanilla_unapply_results["Reroll Surplus"]
	may.vanilla_unapply_results["Crystal Ball"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.consumeables.config.card_limit = G.consumeables.config.card_limit - center_table.extra
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Grabber"] = function(card, center_table)
    	G.GAME.round_resets.hands = G.GAME.round_resets.hands - center_table.extra
    	ease_hands_played(-center_table.extra)
	end
	may.vanilla_unapply_results["Nacho Tong"] = may.vanilla_unapply_results["Grabber"]
	may.vanilla_unapply_results["Wasteful"] = function(card, center_table)
    	G.GAME.round_resets.discards = G.GAME.round_resets.discards - center_table.extra
    	ease_discard(-center_table.extra)
	end
	may.vanilla_unapply_results["Recyclomancy"] = may.vanilla_unapply_results["Wasteful"]
	may.vanilla_unapply_results["Tarot Merchant"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.tarot_rate = G.GAME.tarot_rate / center_table.extra
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Tarot Tycoon"] = may.vanilla_unapply_results["Tarot Merchant"]
	may.vanilla_unapply_results["Planet Merchant"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.planet_rate = G.GAME.planet_rate / center_table.extra
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Planet Tycoon"] = may.vanilla_unapply_results["Planet Merchant"]
	may.vanilla_unapply_results["Seed Money"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.interest_cap = 25 --note: does not account for potential deck effects
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Money Tree"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	if G.GAME.used_vouchers.v_seed_money then
                	G.GAME.interest_cap = 50
            	else
                	G.GAME.interest_cap = 25
            	end
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Antimatter"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	if G.jokers then
                	G.jokers.config.card_limit = G.jokers.config.card_limit - center_table.extra
            	end
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Magic Trick"] = function(card, center_table)
    	G.E_MANAGER:add_event(Event({
        	func = function()
            	G.GAME.playing_card_rate = 0
            	return true
        	end,
    	}))
	end
	may.vanilla_unapply_results["Hieroglyph"] = function (card, center_table)
    	ease_ante(center_table.extra)
    	G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    	G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + center_table.extra
	
    	G.GAME.round_resets.hands = G.GAME.round_resets.hands + center_table.extra
    	ease_hands_played(center_table.extra)
	end
	may.vanilla_unapply_results["Petroglyph"] = function (card, center_table)
    	ease_ante(center_table.extra)
    	G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    	G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + center_table.extra
	
    	G.GAME.round_resets.discards = G.GAME.round_resets.discards + center_table.extra
    	ease_discard(center_table.extra)
	end
	may.vanilla_unapply_results["Paint Brush"] = function(card, center_table)
    	G.hand:change_size(-center_table.extra)
	end
	may.vanilla_unapply_results["Palette"] = may.vanilla_unapply_results["Paint Brush"]
	
	function may.deep_table_merge(target, source, ...)
		assert(type(target) == "table", "Target is not a table")
		local tables_to_merge = { source, ... }
		if #tables_to_merge == 0 then
			return target
		end
	
		for k, t in ipairs(tables_to_merge) do
			assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
		end
	
		for i = 1, #tables_to_merge do
			local from = tables_to_merge[i]
			for k, v in pairs(from) do
				if type(v) == "table" then
					target[k] = target[k] or {}
					target[k] = may.deep_table_merge(target[k], v)
				else
					target[k] = v
				end
			end
		end
	
		return target
	end

	
	function may.event(input, _queue, _prepend)
    	-- thanks SleepyG11 for this event function
    	input = input or {}
    	if type(input) == "number" then input = { delay = input } end
    	if type(input) == "function" then input = { input } end
    	local queue = input.queue or _queue
    	local prepend = input.prepend or _prepend
	
    	local event_definition = {
        	trigger = input.trigger or "immediate",
        	func = input[1] or input.func or function(t) return t or true end,
        	blocking = input.blocking,
        	blockable = input.blockable,
        	delay = input.delay,
        	pause_force = input.pause_force or input.force_pause,
        	no_delete = input.no_delete,
        	timer = input.timer,
	
        	ref_table = input.ref_table,
        	ref_value = input.ref_value,
        	ease = input.ease or input.type,
        	ease_to = input.ease_to,
        	stop_val = input.stop_val,
    	}
    	-- delay doesnt work on immediate events
    	if event_definition.delay and event_definition.trigger == "immediate" then
        	event_definition.trigger = "after"
    	end
    	local event = Event(event_definition)
    	if input.extra then
        	may.deep_table_merge(event, input.extra)
    	end
    	-- option to call function inside immediately
    	if input.instant then
        	if event.trigger ~= "ease" then
            	event.func()
            	return event
        	end
    	end
    	-- only returns the event as a standalone object
    	if not input.no_insert then
        	G.E_MANAGER:add_event(event, queue, prepend)
    	end
    	return event
	end
	
	function may.redeem_animation(card, cfg)
    	cfg.colour = cfg.colour or G.C.WHITE
    	cfg.scale  = cfg.scale or 0.9
    	cfg.sounds = cfg.sounds or {'card1', 'coin1'}
    	cfg.top_txt = cfg.top_txt or localize({
        	type = 'name_text',
        	set = card.config.center.set,
        	key = card.config.center.key
    	})
    	cfg.btm_txt = localize('k_redeemed_ex')
	
    	local function redeem_dynatext(args)
        	return DynaText {
            	colours = { cfg.colour }, scale = cfg.scale,
            	shadow = true, bump = true, float = true,
	
            	string = args.string,
            	rotate = args.rotate,
            	pop_in = args.pop_in / G.SPEEDFACTOR,
            	pop_in_rate = 1.5 * G.SPEEDFACTOR,
            	pitch_shift = args.pitch_shift
        	}
    	end
    	local function redeem_uibox(pos, dynatext)
        	return UIBox({
            	definition =
            	{n=G.UIT.ROOT, config={ align="tm", r=0.15, colour=G.C.CLEAR, padding=0.15 }, nodes={
                	{n=G.UIT.O, config={ object=dynatext } },
            	}},
            	config = {
                	align = pos,
                	offset = {x=0, y=0},
                	parent = card
            	},
        	})
    	end
	
    	card.states.hover.can = false
    	local top_dynatext, btm_dynatext
	
    	may.event{
        	function ()
            	top_dynatext = redeem_dynatext{
                	string = cfg.top_txt,
                	rotate = 1, pop_in = 0.6
            	}
            	btm_dynatext = redeem_dynatext{
                	string = cfg.btm_txt,
                	rotate = 2, pop_in = 1.4,
                	pitch_shift = 0.25,
            	}
	
            	card:juice_up(0.3, 0.5)
            	for _,sound_key in ipairs(cfg.sounds) do
                	play_sound(sound_key)
            	end
	
            	card.children.top_disp = redeem_uibox("tm", top_dynatext)
            	card.children.bot_disp = redeem_uibox("bm", btm_dynatext)
	
            	return true
        	end,
        	trigger = 'after',
        	delay = 0.4,
    	}
	
    	if cfg.during_func then cfg.during_func() end
	
    	may.event(0.6)
    	may.event{
        	function ()
            	top_dynatext:pop_out(4)
            	btm_dynatext:pop_out(4)
            	return true
        	end,
        	trigger = 'after',
        	delay = 2.6
    	}
    	may.event{
        	function ()
            	card.children.top_disp:remove()
            	card.children.top_disp = nil
            	card.children.bot_disp:remove()
            	card.children.bot_disp = nil
            	return true
        	end,
        	trigger = 'after',
        	delay = 0.5
    	}
	end
	
	function Card:unredeem()
		if self.ability.set == "Voucher" then
			stop_use()
			if not self.config.center.discovered then
				discover_card(self.config.center)
			end
	
			may.redeem_animation(self, {
				colour = G.C.RED,
				sounds = {'card1', 'timpani'},
				btm_txt = localize("cry_unredeemed"),
				during_func = function()
					if not self.debuff then
						self:unapply_to_run()
					end
				end
			})
		end
	
		G.E_MANAGER:add_event(Event({
			func = function()
				may.update_used_vouchers()
				return true
			end,
		}))
	end
	
	function Card:unapply_to_run(center)
		local center_table = {
			name = center and center.name or self and self.ability.name,
			extra = self and self.ability.extra or center and center.config.extra,
		}
		local obj = center or self.config.center
		if type(obj.unredeem) == "function" then
			obj:unredeem(self)
			return
		end
	
		local vanilla_unapply_result = may.vanilla_unapply_results[center_table.name]
		if vanilla_unapply_result then
			vanilla_unapply_result(self, center_table)
		end
	end

	function may.update_used_vouchers()
		if not (G and G.GAME and G.vouchers) then return end
	
		G.GAME.used_vouchers = {}
		for _,voucher in ipairs(G.vouchers.cards) do
			G.GAME.used_vouchers[voucher.config.center_key] = true
		end
	end
else
	may.vanilla_unapply_results = Spectrallib.vanilla_unapply_results
	may.deep_table_merge = Spectrallib.deep_table_merge
	may.event = Spectrallib.event
	may.redeem_animation = Spectrallib.redeem_animation
	may.update_used_vouchers = Spectrallib.update_used_vouchers
end