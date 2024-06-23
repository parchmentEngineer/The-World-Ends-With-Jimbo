-- == PAVO REAL
-- == Joker buffing and manipulation

local stuffToAdd = {}

-- Top Gear
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "topGear",
	key = "topGear",
	config = {extra = {}},
	pos = {x = 1, y = 8},
	loc_txt = {
		name = 'Top Gear',
		text = {
			"{C:blue}Common{} {C:attention}Jokers{} in the",
			"shop are {C:dark_edition}Polychrome{}"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.twewy_top_gear = true
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.twewy_top_gear = false
	end
})

-- Supply Factor
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "supplyFactor",
	key = "supplyFactor",
	config = {extra = {readyToUse = true}},
	pos = {x = 2, y = 8},
	loc_txt = {
		name = 'Supply Factor',
		text = {
			"The next time you gain an",
			"{C:green}Uncommon{} {C:attention}Joker{}, destroy this",
			"and make a copy of that {C:attention}Joker{}"
		}
	},
	rarity = 1,
	cost = 6,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		
	end
})

-- Strong Heart
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "strongHeart",
	key = "strongHeart",
	config = {extra = {heartsLeft = 26}},
	pos = {x = 3, y = 8},
	loc_txt = {
		name = 'Strong Heart',
		text = {
			"After scoring {C:attention}#1#{} more",
			"{C:hearts}Hearts{}, destroy this and",
			"create a random {C:red}Rare{} {C:attention}Joker{}"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.heartsLeft}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:is_suit("Hearts")
		and context.cardarea == G.play then
			card.ability.extra.heartsLeft = card.ability.extra.heartsLeft - 1
			if card.ability.extra.heartsLeft == 0 then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Joker!"})
				destroyCard(card)
				G.E_MANAGER:add_event(Event({func = function()
					local newCard = create_card('Joker', G.jokers, nil, 2, nil, nil, nil, 'strongHeart')
					newCard:add_to_deck()
					G.jokers:emplace(newCard)
					return true end }))
				return {}
			end
			if card.ability.extra.heartsLeft > 0 then
				return { 
					extra = {
						message = card.ability.extra.heartsLeft.." left",
					},
					card = card
				}
			end
		end
	end
})

return {stuffToAdd = stuffToAdd}