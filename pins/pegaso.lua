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
			"Earn {C:money}$#1#{} each round",
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
			"This joker gains {C:money}$#1#{} of",
			"sell value whenever",
			"an {C:attention}Ace{} is scored"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
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
			return {
				message = "Value up!",
				colour = G.C.MONEY
			}
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
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true end 
		}))
	end
})

-- Her Royal Highness
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "herRoyalHighness",
	key = "herRoyalHighness",
	config = {extra = {}},
	pos = {x = 4, y = 5},
	loc_txt = {
		name = 'Her Royal Highness',
		text = {
			"Duplicate {C:money}Gold{} cards held",
			"in hand at end of round",
			"{C:inactive}(Triggers after they pay out){}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.individual and context.cardarea == G.hand then
			if context.other_card.ability.effect == 'Gold Card' then
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local _card = copy_card(context.other_card, nil, nil, G.playing_card)
				_card:add_to_deck()
				table.insert(G.playing_cards, _card)
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				_card.states.visible = nil
				G.hand:emplace(_card)
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:start_materialize()
						return true
					end
				})) 
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Copied!"})
			end
		end
	end
})

-- Aqua Pawn
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaPawn",
	key = "aquaPawn",
	config = {extra = {readyToUse = true}},
	pos = {x = 5, y = 5},
	loc_txt = {
		name = 'Aqua Pawn',
		text = {
			"Earn {C:money}${} equal to",
			"the level of the first",
			"hand played each round"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			card.ability.extra.readyToUse = true
		end
		
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.readyToUse then
			card.ability.extra.readyToUse = false
			local moneyToAdd = G.GAME.hands[context.scoring_name].level * 1
			ease_dollars(moneyToAdd)
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + moneyToAdd
			G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			return {
				message = localize('$')..moneyToAdd,
				dollars = moneyToAdd,
				colour = G.C.MONEY
			}
		end
	end
})

-- Jack's Knight
-- table.insert(stuffToAdd, {
	-- object_type = "Joker",
	-- name = "jacksKnight",
	-- key = "jacksKnight",
	-- config = {extra = {profit = 2}},
	-- pos = {x = 6, y = 5},
	-- loc_txt = {
		-- name = 'Jack\'s Knight',
		-- text = {
			-- "Earn {C:money}$#1#{} whenever",
			-- "you discard a {C:attention}Jack{}"
		-- }
	-- },
	-- rarity = 1,
	-- cost = 4,
	-- discovered = true,
	-- blueprint_compat = true,
	-- atlas = "jokers",
	-- loc_vars = function(self, info_queue, center)
		-- return {vars = {center.ability.extra.profit}}
	-- end,
	-- calculate = function(self, card, context)
		-- if context.discard and context.other_card:get_id() == 11 then
			-- ease_dollars(card.ability.extra.profit)
			-- G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.profit
			-- G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			-- card_eval_status_text(card, 'extra', nil, nil, nil, {
				-- message = localize('$')..card.ability.extra.profit,
				-- colour = G.C.MONEY
			-- })
		-- end
	-- end
-- })

return{stuffToAdd = stuffToAdd}