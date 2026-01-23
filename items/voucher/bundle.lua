-- Voucher Bundles-- 2 Vouchers
for i=1, 4 do
    SMODS.Voucher {	key = '2_voucher_bundle_'..i,	loc_txt = {		name = "2 Voucher Bundle",		text = {			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",		}	},	pos = { x = i-1, y = 0 },	atlas = 'may_voucher_bundle',	config = { extra = { vouchers = 2 } },	cost = 15,	unlocked = true,
    pools = { VoucherBundle = true }, 
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Voucher Bundle', get_type_colour(self or card.config, card), nil, 1.2)
	end,	loc_vars = function(self, info_queue, card)		return { vars = { card.ability.extra.vouchers } }	end,	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()		    if card then			    may.massvoucher(nil, card.ability.extra.vouchers or 2, true)		    else			    may.massvoucher(nil, 2, true)		    end
        return true end}))	end}

end-- 3 Vouchers

for i=1, 4 doSMODS.Voucher {	key = '3_voucher_bundle_'..i,	loc_txt = {		name = "3 Voucher Bundle",		text = {			"Redeem {C:attention}#1#{} random {C:green}Vouchers{}",		}	},	pos = { x = i-1, y = 1 },	atlas = '003_temp',	config = { extra = { vouchers = 3 } },	requires = {'v_may_2_voucher_bundle_'..i},	cost = 20,	unlocked = true,
    pools = { VoucherBundle = true }, 
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge('Voucher Bundle', get_type_colour(self or card.config, card), nil, 1.2)
	end,	loc_vars = function(self, info_queue, card)		return { vars = { card.ability.extra.vouchers } }	end,	redeem = function(self, card)		G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.3, func = function()		    if card then			    may.massvoucher(nil, card.ability.extra.vouchers or 2, true)		    else			    may.massvoucher(nil, 3, true)		    end
        return true end}))	end}

end