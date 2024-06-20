-- == PEGASO
-- == Gaining and manipulating money

local stuffToAdd = {}

-- Thunder Pawn
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "thunderPawn",
	key = "thunderPawn",
	config = {extra = {profit = 2}},
	pos = {x = 1, y = 5},
	loc_txt = {
		name = 'Thunder Pawn',
		text = {
			"Gain {C:money}$#1#{} each round",
			"{C:attention}+1{} card slot in shop"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.profit}}
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.profit
	end
})

-- Lightning Rook
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lightningRook",
	key = "lightningRook",
	config = {extra = {sellGain = 5}},
	pos = {x = 2, y = 5},
	loc_txt = {
		name = 'Lightning Rook',
		text = {
			"Gains {C:money}$#1#{} of sell",
			"value whenever an",
			"{C:attention}Ace{} is scored"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.sellGain}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() == 14
		and context.cardarea == G.play then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.sellGain
			card:set_cost()
			card_eval_status_text(card, 'extra', nil, nil, nil, {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			})
		end
	end
})

-- Excalibur
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "excalibur",
	key = "excalibur",
	config = {extra = {newPrice = 1}},
	pos = {x = 3, y = 5},
	loc_txt = {
		name = 'Excalibur',
		text = {
			"Set the price of",
			"{C:dark_edition}everything{} in the",
			"shop to {C:money}$#1#{}",
			"{C:inactive}(Except for rerolls){}"
		}
	},
	rarity = 3,
	cost = 10,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.newPrice}}
	end,
	calculate = function(self, card, context)
		
	end
})

return{stuffToAdd = stuffToAdd}