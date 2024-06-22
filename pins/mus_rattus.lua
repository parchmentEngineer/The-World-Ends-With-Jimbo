-- == MUS RATTUS
-- == Chips and bonus cards

local stuffToAdd = {}

-- Storm Warning
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "stormWarning",
	key = "stormWarning",
	config = {extra = {chips = 0, chipGain = 30}},
	pos = {x = 5, y = 0},
	loc_txt = {
		name = 'Storm Warning',
		text = {
			"This joker gains {C:chips}+#1#{} Chips",
			"when any card is sold. {C:attention}Resets{}",
			"when any card is bought",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chipGain, center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipGain
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
		elseif context.buying_card and not context.blueprint and card.ability.extra.chips > 0 and context.card.ability.set ~= "Voucher" then
			card.ability.extra.chips = 0
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset!"})
		elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
	end
})

-- Candle Service
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "candleService",
	key = "candleService",
	config = {extra = {chips = 250, played = 0, req = 8}},
	pos = {x = 1, y = 0},
	loc_txt = {
		name = 'Candle Service',
		text = {
			"Every eighth scoring",
			"{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{} gives",
			"you {C:chips}+#1#{} Chips",
			"{C:inactive}(Currently #2#/#3#){}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips, center.ability.extra.played, center.ability.extra.req}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() <= 5
		and context.other_card:get_id() >= 2
		and context.cardarea == G.play then
			if card.ability.extra.played >= card.ability.extra.req-1 then
				card.ability.extra.played = 0
				return {
					chips = card.ability.extra.chips,
					card = card
				}
			else
				card.ability.extra.played = card.ability.extra.played + 1
				return { 
					extra = {
						message = card.ability.extra.played.."/"..card.ability.extra.req,
						colour = G.C.FILTER
					},
					card = card
				}
			end
		end
	end
})

-- Aqua Monster
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaMonster",
	key = "aquaMonster",
	config = {extra = {}},
	pos = {x = 2, y = 0},
	loc_txt = {
		name = 'Aqua Monster',
		text = {
			"All scoring cards become",
			"{C:attention}Bonus Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if true then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_bonus, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			if #faces > 0 then 
				return {
					message = "Splash!",
					colour = G.C.CHIPS,
					card = self
				}
			end
		end
	end
})

-- Aqua Ghost
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaGhost",
	key = "aquaGhost",
	config = {extra = {}},
	pos = {x = 3, y = 0},
	loc_txt = {
		name = 'Aqua Ghost',
		text = {
			"All scoring cards become",
			"{C:dark_edition}Foil Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if true then 
					faces[#faces+1] = v
					v:set_edition({foil = true}, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			if #faces > 0 then 
				return {
					message = "Splash!",
					colour = G.C.CHIPS,
					card = self
				}
			end
		end
	end
})

-- Aqua Demon
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "aquaDemon",
	key = "aquaDemon",
	config = {extra = {chips = 666}},
	pos = {x = 4, y = 0},
	loc_txt = {
		name = 'Aqua Demon',
		text = {
			"{C:chips}+#1#{} Chips if played",
			"hand contains",
			"a {C:attention}Three of a Kind{}"
		}
	},
	rarity = 3,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and next(context.poker_hands['Three of a Kind']) then 
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
	end
})

-- Lightning Moon
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lightningMoon",
	key = "lightningMoon",
	config = {extra = {cardsNeeded = 4, chips = 30}},
	pos = {x = 6, y = 0},
	loc_txt = {
		name = 'Lightning Moon',
		text = {
			"{C:chips}+#1#{} Chips for each",
			"{C:clubs}Club{} held in hand",
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips, center.ability.extra.cardsNeeded}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.individual and not context.end_of_round
		--and #context.full_hand == card.ability.extra.cardsNeeded 
		and context.other_card:is_suit("Clubs") then
			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED,
					card = self,
				}
			else
				return {
					h_chips = card.ability.extra.chips
				}
			end
		end
	end
})

-- Burning Cherry
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "burningCherry",
	key = "burningCherry",
	config = {extra = {chips = 200, chipsGain = -25, handReq = "High Card"}},
	pos = {x = 7, y = 0},
	loc_txt = {
		name = 'Burning Cherry',
		text = {
			"{C:chips}+#1#{} Chips",
			"{C:chips}#2#{} Chips when you play a",
			"hand that isn't {C:attention}#3#{}",
			"{C:inactive}(Hand changes each round){}"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chips, center.ability.extra.chipsGain, center.ability.extra.handReq}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and context.scoring_name ~= card.ability.extra.handReq and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipsGain
			if card.ability.extra.chips <= 0 then 
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = "Eaten!",
					colour = G.C.CHIPS
				}
			end
			return {
				message = "Downgrade!",
				colour = G.C.CHIPS,
				card = card
			}
		end
		
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
		
		if context.end_of_round and not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.handReq then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.extra.handReq = pseudorandom_element(_poker_hands, pseudoseed('to_do'))
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible and k ~= card.ability.extra.handReq then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.extra.handReq = pseudorandom_element(_poker_hands, pseudoseed('to_do'))
	end
})

-- Impact Warning
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "impactWarning",
	key = "impactWarning",
	config = {extra = {chips = 0, chipsGain = 50}},
	pos = {x = 8, y = 0},
	loc_txt = {
		name = 'Impact Warning',
		text = {
			"This joker gains {C:chips}+#1#{} Chips",
			"when a {C:planet}Planet{} card is used",
			"{C:attention}Resets{} on playing a {C:attention}Level 1{} hand",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.chipsGain, center.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and G.GAME.hands[context.scoring_name].level == 1 and card.ability.extra.chips > 0 then
			card.ability.extra.chips = 0
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset!"})
		end
		
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
			}
		end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == "Planet" then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chipsGain
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
					chip_mod = card.ability.extra.chips,
				})
			end
		end
	end
})

return{stuffToAdd = stuffToAdd}