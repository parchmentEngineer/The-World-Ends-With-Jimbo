-- == DRAGON COUTURE
-- == Card draw and hand size

local stuffToAdd = {}

-- Self Found, Others Lost
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "selfFound",
	key = "selfFound",
	config = {extra = {handSize = 0, handSizeBuff = 2}},
	pos = {x = 1, y = 2},
	loc_txt = {
		name = 'Self Found, Others Lost',
		text = {
			"Gain {C:attention}+#1#{} hand size next round",
			"whenever you {C:attention}reroll{} the shop",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} hand size)"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSizeBuff, center.ability.extra.handSize}}
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			card.ability.extra.handSize = card.ability.extra.handSize + card.ability.extra.handSizeBuff
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
		end
		
		if context.ending_shop and not context.blueprint then
			G.hand:change_size(card.ability.extra.handSize)
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			G.hand:change_size(-card.ability.extra.handSize)
			card.ability.extra.handSize = 0
		end
	end
})

-- One Grain, Infinite Promise
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "oneGrain",
	key = "oneGrain",
	config = {extra = {toDraw = 4, inRound = false}},
	pos = {x = 3, y = 2},
	loc_txt = {
		name = 'One Grain, Infinite Promise',
		text = {
			"Whenever you use a {C:attention}consumable{}",
			"during a round, draw {C:attention}#1#{} cards"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.toDraw}}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and #G.hand.cards>0 and card.ability.extra.inRound then
			local card_count = card.ability.extra.toDraw
			for i=1, card_count do
				draw_card(G.deck,G.hand, i*100/card_count,nil, nil , nil, 0.07)
				G.E_MANAGER:add_event(Event({func = function() G.hand:sort() return true end}))
			end
		end
		
		if context.first_hand_drawn and not context.blueprint then
			card.ability.extra.inRound = true
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			card.ability.extra.inRound = false
		end
	end
})

-- One Stroke, Vast Wealth
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "oneStroke",
	key = "oneStroke",
	config = {extra = {perDollar = 20, handSize = 0, handSizeMax = 10}},
	pos = {x = 2, y = 2},
	loc_txt = {
		name = 'One Stroke, Vast Wealth',
		text = {
			"{C:attention}+1{} hand size for every {C:money}$#1#{}",
			"you have, to a maximum of {C:attention}+#3#{}",
			"{C:inactive}(Currently {C:attention}+#2#{C:inactive} hand size)"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.perDollar, center.ability.extra.handSize, center.ability.extra.handSizeMax}}
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local oldMax = card.ability.extra.handSize
			card.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars) / card.ability.extra.perDollar), card.ability.extra.handSizeMax))
			if card.ability.extra.handSize ~= oldMax then
				G.hand:change_size(card.ability.extra.handSize - oldMax)
			end
		end
	end
})

-- Swift Storm, Swift End
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "swiftStorm",
	key = "swiftStorm",
	config = {extra = {handSize = 0, handSizeBuff = 7}},
	pos = {x = 4, y = 2},
	loc_txt = {
		name = 'Swift Storm, Swift End',
		text = {
			"{C:attention}+#1#{} hand size on the",
			"{C:attention}final hand{} of each round"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSizeBuff}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main or context.debuffed_hand then
			if G.GAME.current_round.hands_left == 1 then
				if card.ability.extra.handSize == 0 then
					card.ability.extra.handSize = card.ability.extra.handSizeBuff
					G.hand:change_size(card.ability.extra.handSize)
				end
			else
				G.hand:change_size(-card.ability.extra.handSize)
				card.ability.extra.handSize = 0
			end
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			G.hand:change_size(-card.ability.extra.handSize)
			card.ability.extra.handSize = 0
		end
	end
})

-- Flames Apart, Foes Aflame
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "flamesApart",
	key = "flamesApart",
	config = {extra = {}},
	pos = {x = 5, y = 2},
	loc_txt = {
		name = 'Flames Apart, Foes Aflame',
		text = {
			"When you play a {C:attention}Straight Flush{} or",
			"a {C:attention}secret hand{}, draw your {C:dark_edition}entire deck{}"
		}
	},
	rarity = 3,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint and 
		(next(context.poker_hands['Straight Flush']) or next(context.poker_hands['Five of a Kind']) or
		next(context.poker_hands['Flush House']) or next(context.poker_hands['Flush Five']))  then
			local toDraw = #G.deck.cards
			for i=1, toDraw do
				draw_card(G.deck,G.hand, i*100/toDraw ,true, card , nil, 0.07)
				G.E_MANAGER:add_event(Event({func = function() card:juice_up(0.3, 0.4) return true end}))
				G.E_MANAGER:add_event(Event({func = function() G.hand:sort() return true end}))
			end
		end
	end
})

return{stuffToAdd = stuffToAdd}