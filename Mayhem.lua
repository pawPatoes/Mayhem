-- MAYHEM CORE

may = may or {}

-- Bulk load modules

assert(SMODS.load_file("items/color.lua"))()
print('MAYHEM: ITEM color.lua loaded!')

may.libs = {
	'init.lua',
	'fusion.lua',
	'jenlib.lua',
	'hooks.lua',
	'consumablevariants.lua',
    'hands.lua',
	'timers.lua',
	'calculationkeys.lua',
	'omeganum.lua',
	'unredeem.lua',
	'pools.lua',
    'menu.lua',
	'misc.lua',
	'transcendence.lua',
	'ability.lua',
	'drawstep.lua',
	'notification.lua', 
	'noituus.lua',
	'ui.lua',
	'miscbadges.lua', 
	'modtabs.lua',
}

for k, v in ipairs(may.libs) do
	assert(SMODS.load_file("lib/"..v))()
	print('MAYHEM: LIB '..v..' loaded!')
end

may.items = {
	'audio.lua',
	'attribute.lua',
	'atlas.lua', 
	'consumabletype.lua',
	'rarity.lua',
	'hand.lua',
	'shader.lua',
	'edition.lua',
	'enhancement.lua',
	'seal.lua', 
	'dynatext.lua',
	
	'consumable/upsidedown.lua',
	--'consumable/ascended.lua',
	'consumable/tarot.lua', 
	'consumable/planet.lua',
	'consumable/spectral.lua', 
	'consumable/yotta.lua',
	'consumable/modifier.lua',
	'consumable/retro.lua',
	
	'blind.lua',
	'taintedblind.lua',
	
	'voucher/tier1_2.lua', 
	'voucher/tier3.lua',
	'voucher/tier4.lua',
	'voucher/bundle.lua',
	'voucher/special.lua',
	
	'joker/common.lua',
	'joker/uncommon.lua',
	'joker/rare.lua',
	'joker/epic.lua',
	'joker/legendary.lua', 
	'joker/paradoxical.lua',
    'joker/mythic.lua',
	'joker/ethereal.lua',
	'joker/prismatic.lua',
	'joker/demiurgic.lua', 
	--'joker/opalescent.lua',
	'joker/transcendent.lua',
	
	'vanillatweaks.lua',
	'debug.lua',
	'tag.lua',
	'deck.lua',
	'scoreoperator.lua',
    'pack.lua', 
	'consumable/misc.lua',
	--'stake.lua',
}

-- Cross-mod
may.cross_mod = {
	'enf',
	'Fitxes',
	--'Cryptid', 
	'cartomancer', 
	'GRM', 
	'BlindEditions', 
	--'CardSleeves', 
	'Spectrallib',
	'Espazio',
}

for k, v in pairs(may.cross_mod) do
	if #SMODS.find_mod(v) ~= 0 then 
		table.insert(may.items, 'cm/'..v..'.lua')
	end
end

for k, v in ipairs(may.items) do
	assert(SMODS.load_file("items/"..v))()
	print('MAYHEM: ITEM '..v..' loaded!')
end