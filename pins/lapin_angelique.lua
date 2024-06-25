-- == LAPIN ANGELIQUE
-- == xMult, Steel and Glass cards

local stuffToAdd = {}

-- Spider's Silk
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "spiderSilk",
	key = "spiderSilk",
	config = {extra = {}},
	pos = {x = 1, y = 4},
	loc_txt = {
		name = "Spider's Silk",
		text = {
			"Played {C:attention}Steel{} cards become {C:attention}Glass{}",
			"Held {C:attention}Glass{} cards become {C:attention}Steel{}"
		}
	},
	rarity = 1,
	cost = 3,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local faces = {}
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect == "Steel Card" then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_glass, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			for k, v in ipairs(G.hand.cards) do
				if v.ability.effect == "Glass Card" then 
					faces[#faces+1] = v
					v:set_ability(G.P_CENTERS.m_steel, nil, true)
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
					message = "Woven",
					card = self
				}
			end
		end
	end
})

-- Lolita Bat
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lolitaBat",
	key = "lolitaBat",
	config = {extra = {timer = 0, timerMax = 8, xMult = 3.5}},
	pos = {x = 2, y = 4},
	loc_txt = {
		name = 'Lolita Bat',
		text = {
			"{X:mult,C:white} X#1# {} Mult for the",
			"next {C:attention}#2#{} hands after",
			"using a {C:spectral}Spectral{} card",
			"{C:inactive}(#3#){}"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMult, center.ability.extra.timerMax, center.ability.extra.timer == 0 and "Inactive!" or center.ability.extra.timer.." hands remaining" }}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.timer > 0 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
		
		if context.cardarea == G.jokers and context.after and card.ability.extra.timer > 0 and not context.blueprint then
			card.ability.extra.timer = card.ability.extra.timer - 1
			return {
				message = card.ability.extra.timer.." remaining"
			}
		end
		
		if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == "Spectral" then
				card.ability.extra.timer = card.ability.extra.timerMax
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Active!"})
			end
		end
	end
})

-- Skull Rabbit
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "skullRabbit",
	key = "skullRabbit",
	config = {extra = {xMult = 1, xMultGain = 0.1}},
	pos = {x = 3, y = 4},
	loc_txt = {
		name = 'Skull Rabbit',
		text = {
			"This joker gains {X:mult,C:white} X#1# {} Mult",
			"when hand is played",
			"with {C:money}$4{} or less",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult){}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMultGain, center.ability.extra.xMult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			if G.GAME.dollars <= 4 then
				card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMultGain
			end
			return {
				message = "Upgrade!"
			}
		end
	
		if context.cardarea == G.jokers and context.joker_main then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
	end
})

-- Web Spider
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "webSpider",
	key = "webSpider",
	config = {extra = {xMult = 2}},
	pos = {x = 4, y = 4},
	loc_txt = {
		name = 'Web Spider',
		text = {
			"{X:mult,C:white} X#1# {} Mult if the played",
			"hand is exactly {C:attention}Level 2{}"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and G.GAME.hands[context.scoring_name].level == 2 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
	end
})

-- Lolita Skull
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lolitaSkull",
	key = "lolitaSkull",
	config = {extra = {xMult = 4}},
	pos = {x = 5, y = 4},
	loc_txt = {
		name = 'Lolita Skull',
		text = {
			"{X:mult,C:white} X#1# {} Mult if you have",
			"{C:attention}4{} or more {C:hearts}Hearts{}",
			"held in hand"
		}
	},
	rarity = 3,
	cost = 10,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			local hearts = 0
			for _, v in ipairs(G.hand.cards) do
				if v:is_suit("Hearts") then
					hearts = hearts + 1
				end
			end
			if hearts >= 4 then
				for _, v in ipairs(G.hand.cards) do
					if v:is_suit("Hearts") then
						G.E_MANAGER:add_event(Event({
							func = function()
								v:juice_up()
								return true
							end
						})) 
					end
				end
				return {
					message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
					Xmult_mod = card.ability.extra.xMult,
				}
			end
		end
	end
})

-- Lolita Mic
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "lolitaMic",
	key = "lolitaMic",
	config = {extra = {xMult = 2, lastDiscard = "None"}},
	pos = {x = 6, y = 4},
	loc_txt = {
		name = 'Lolita Mic',
		text = {
			"{X:mult,C:white} X#1# {} Mult if you play your most",
			"recently discarded hand type",
			"{C:inactive}(Currently: {C:attention}#2#{C:inactive}){}",
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.xMult, center.ability.extra.lastDiscard}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_name == card.ability.extra.lastDiscard then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xMult}},
				Xmult_mod = card.ability.extra.xMult,
			}
		end
		
		if context.pre_discard then
			card.ability.extra.lastDiscard = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		end
	end
})

-- Kaleidoscope
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "kaleidoscope",
	key = "kaleidoscope",
	config = {extra = {xMult = 1.25, progressList = {Spades = false, Clubs = false, Hearts = false, Diamonds = false}}},
	pos = {x = 7, y = 4},
	loc_txt = {
		name = 'Kaleidoscope',
		text = {
			"Cards that are not the same",
			"suit as any cards in your most",
			"recently played hand give {X:mult,C:white} X#1# {} Mult",
			"{C:inactive}(Currently: {C:attention}#2#{C:inactive}){}"
		}
	},
	rarity = 2,
	cost = 9,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		local lastSuits = ""
		for k,v in pairs(center.ability.extra.progressList) do
			if v then
				lastSuits = lastSuits..k..", "
			end
		end
		if lastSuits == "" then lastSuits = "None" else
		lastSuits = lastSuits:sub(1, #lastSuits-2) end
		return {vars = {center.ability.extra.xMult, lastSuits}}
	end,
	calculate = function(self, card, context)
	
		if context.cardarea == G.jokers and context.after and not context.blueprint then
			for k,v in pairs(card.ability.extra.progressList) do
				card.ability.extra.progressList[k] = false
				for k2, v2 in pairs(G.play.cards) do
					if v2:is_suit(k.."") then
						card.ability.extra.progressList[k] = true
					end
				end
			end
		end
		
		if context.individual and context.cardarea == G.play then
			local giveMult = true
			for k,v in pairs(card.ability.extra.progressList) do
				if context.other_card:is_suit(k.."") and v then
					giveMult = false
				end
			end
			if giveMult then
				return {
					x_mult = card.ability.extra.xMult,
					card = card
				}
			end
		end
	end
})


return {stuffToAdd = stuffToAdd}