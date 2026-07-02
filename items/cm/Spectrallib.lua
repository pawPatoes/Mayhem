-- Compatibility with Spectrallib
-- Mayhem has seperate functions and cosmetic flare for some stuff in the library

function Spectrallib.x_levels(args)
	if type(args.hands) ~= 'table' then
		args.hands = {args.hands}
	end 
	for k, v in pairs(args.hands) do
		may.level_up_hand_hyper(args.from, v, args.instant, args.level_up, 0)
	end
end