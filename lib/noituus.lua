-- Noituus integration

Noituus.CustomPluralNames = Noituus.CustomPluralNames or {}
Noituus.CustomPluralNames['may_miscellaneous'] = 'MISCELLANEOUS'

-- Allow stacking/bulk use/mass use for Mayhem consumable types

AllowBulkUse('may_modifiercard')
AllowMassUsing('retrocards')
AllowStacking('yottacards')
AllowStacking('may_misc')
AllowStacking('upside_down_tarots')
AllowMassUsing('upside_down_planets')
AllowStacking('upside_down_spectrals')