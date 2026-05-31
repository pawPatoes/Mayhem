-- Joker Pools
-- Pools in G.P_CENTER_POOLS are created in lib/menu.lua

-- Deprecated
function may.is_food(card)
	--[[local center = type(card) == "string" and G.P_CENTERS[card] or (card.config and card.config.center)
	if not center then return false end
	if center.pools and center.pools.Food then
		return true
	end
	if center.key == 'j_gros_michel' or
	center.key == 'j_egg' or
	center.key == 'j_ice_cream' or
	center.key == 'j_cavendish' or
	center.key == 'j_turtle_bean' or
	center.key == 'j_diet_cola' or
	center.key == 'j_popcorn' or
	center.key == 'j_ramen' or
	center.key == 'j_selzer' then
		return true 
	end]] 
	return card:may_is_pool('Food')
end

function may.is_pool_center(center, pool)
	if pool == 'Food' then
		if center.pools and center.pools.Food then
			return true
		end
		if center.key == 'j_gros_michel' or
	    center.key == 'j_egg' or
		center.key == 'j_ice_cream' or
		center.key == 'j_cavendish' or
		center.key == 'j_turtle_bean' or
		center.key == 'j_diet_cola' or
		center.key == 'j_popcorn' or
		center.key == 'j_ramen' or
		center.key == 'j_selzer' then
			return true 
		end
	elseif pool == 'HandSpecific' then
		return center.config and ((not (not center.config.hand_type)) or center.pools and (not (not center.pools.HandSpecific)))
	elseif pool == 'Fusable' then
		return may.is_fusable(center) and not may.is_fusion(center)
	elseif pool == 'Fusable_NOBP' then
		return may.is_fusable(center) and (not may.is_fusion(center)) and center.key ~= 'j_blueprint'
    else
	    if center.pools then
			return not (not center.pools[pool])
		end 
	end 
end

function Card:may_is_pool(key)
	return self.gc and may.is_pool_center(self:gc(), key)
end