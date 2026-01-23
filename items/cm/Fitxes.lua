-- Fitxes cross-mod

-- Make the Vouchers sellable
for k, v in pairs({'v_fxs_token_merchant', 'v_fxs_token_tycoon', 'v_fxs_token_acclimator'}) do
	SMODS.Voucher:take_ownership(v, {
		voucher_sellable = true
	}, true)
end