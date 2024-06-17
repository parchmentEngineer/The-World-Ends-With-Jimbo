--- STEAMODDED HEADER
--- MOD_NAME: The World Ends With Jimbo
--- MOD_ID: TWEWY
--- PREFIX: twewy
--- MOD_AUTHOR: [parchmentEngineer]
--- MOD_DESCRIPTION: Adds jokers inspired by the brands and pins of The World Ends With You
--- BADGE_COLOUR: 814BA8

----------------------------------------------
------------MOD CODE -------------------------

local mod_path = ''..SMODS.current_mod.path
local stuffToAdd = {}

table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "blank",
	key = "blank",
	config = {extra = {}},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = 'Name',
		text = {
			"Text"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)

	end
})

-- Testing card back
table.insert(stuffToAdd, {
	object_type = "Back",
	name = "testing",
	key = "testing",
	config = {twetyTesting = true, consumables = {'c_lovers', 'c_fool'}},
	pos = {x = 0, y = 2},
	loc_txt = {
		name = "Testing",
		text = {
			"Testing"
		}
	},
	atlas = "jokers"
})

-- Sprite Atlas
table.insert(stuffToAdd, {
	object_type = "Atlas",
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
})

--== MUS RATTUS

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
			"{C:chips}+#1#{} Chips when any card",
			"is sold, {C:attention}resets{} when",
			"any card is bought",
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
		elseif context.buying_card and not context.blueprint and card.ability.extra.chips > 0 then
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
					G.E_MANAGER:add_event(Event({
						func = function()
							v:set_edition({foil = true}, nil, true)
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

--== WILD BOAR

-- Kewl Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "kewlLine",
	key = "kewlLine",
	config = {extra = {handSize = -2, mult = 24}},
	pos = {x = 1, y = 1},
	loc_txt = {
		name = 'Kewl Line',
		text = {
			"{C:attention}#1#{} hand size",
			"Scored {C:attention}8s{} give {C:mult}+#2#{} Mult",
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSize, center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() == 8
		and context.cardarea == G.play then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end
})

-- Dope Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "dopeLine",
	key = "dopeLine",
	config = {extra = {}},
	pos = {x = 2, y = 1},
	loc_txt = {
		name = 'Dope Line',
		text = {
			"At end of round, {C:attention}destroy{}",
			"this joker and all cards held",
			"in hand become {C:attention}Mult Cards{}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			for k, v in ipairs(G.hand.cards) do
				v:set_ability(G.P_CENTERS.m_mult, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
			end
			destroyCard(card)
			return {
				message = 'Dope!',
				colour = G.C.RED,
				delay = 1
			}
		end
	end
})

-- Wild Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "wildLine",
	key = "wildLine",
	config = {extra = {}},
	pos = {x = 3, y = 1},
	loc_txt = {
		name = 'Wild Line',
		text = {
			"Retrigger all",
			"{C:attention}Mult Cards{}"
		}
	},
	rarity = 2,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.other_card.ability.effect == "Mult Card"
		and context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
	end
})

-- Fly Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "flyLine",
	key = "flyLine",
	config = {extra = {mult = 0, multGain = 15, progress = "_ _ _ _", 
		progressList = {spades = false, clubs = false, hearts = false, diamonds = false}
	}},
	pos = {x = 4, y = 1},
	loc_txt = {
		name = 'Fly Line',
		text = {
			"Gains {C:mult}+#1#{} Mult after playing",
			"{C:attention}flushes{} in all four suits",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
			"{C:inactive}(Progress: {V:1}#3# {V:2}#4# {V:3}#5# {V:4}#6#{C:inactive}){}",
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {
			center.ability.extra.multGain,
			center.ability.extra.mult,
			center.ability.extra.progressList.spades and "S" or "_",
			center.ability.extra.progressList.hearts and "H" or "_",
			center.ability.extra.progressList.clubs and "C" or "_",
			center.ability.extra.progressList.diamonds and "D" or "_",
			colours = {
				center.ability.extra.progressList.spades and G.C.BLACK or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.hearts and G.C.RED or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.clubs and G.C.BLACK or G.C.UI.TEXT_INACTIVE,
				center.ability.extra.progressList.diamonds and G.C.RED or G.C.UI.TEXT_INACTIVE,
			}
		}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Flush']) and not context.blueprint then
			local suit = ""
			for k, v in ipairs(context.scoring_hand) do
				if v.ability.effect ~= "Wild Card" then 
					if v:is_suit('Spades') then card.ability.extra.progressList.spades = true end
					if v:is_suit('Clubs') then card.ability.extra.progressList.clubs = true end
					if v:is_suit('Hearts') then card.ability.extra.progressList.hearts = true end
					if v:is_suit('Diamonds') then card.ability.extra.progressList.diamonds = true end
				end
			end
			local newProgress = ""
			local pList = card.ability.extra.progressList
			if pList.spades then newProgress = newProgress.."S " else newProgress = newProgress.."_ " end
			if pList.hearts then newProgress = newProgress.."H " else newProgress = newProgress.."_ " end
			if pList.clubs then newProgress = newProgress.."C " else newProgress = newProgress.."_ " end
			if pList.diamonds then newProgress = newProgress.."D" else newProgress = newProgress.."_" end
			local sendMessage = newProgress ~= card.ability.extra.progress
			card.ability.extra.progress = newProgress
			if pList.spades and pList.hearts and pList.clubs and pList.diamonds then
				card.ability.extra.progress = "_ _ _ _"
				card.ability.extra.progressList.spades = false
				card.ability.extra.progressList.clubs = false
				card.ability.extra.progressList.hearts = false
				card.ability.extra.progressList.diamonds = false
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
				return {
					message = "Upgrade!",
					color = G.C.MULT,
					card = self
				}
			elseif sendMessage then 
				return {
					message = "Progress!",
					card = self
				}
			end
		end
	end
})

-- Fresh Line
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "freshLine",
	key = "freshLine",
	config = {extra = {upgrades = 2}},
	pos = {x = 5, y = 1},
	loc_txt = {
		name = 'Fresh Line',
		text = {
			"Playing a {C:attention}poker hand{}",
			"you have not played this",
			"game upgrades it {C:attention}#1#{} times"
		}
	},
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.upgrades}}
	end,
calculate = function(self, card, context)
	if context.cardarea == G.jokers and context.before and G.GAME.hands[context.scoring_name].played == 1 then
		--for k, v in pairs(G.GAME.hands) do
		--	if next(context.poker_hands[k]) then
				level_up_hand(card, context.scoring_name, false, card.ability.extra.upgrades)
		--	end
		--end
	end
end
})

-- == DRAGON COUTURE

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
	config = {extra = {toDraw = 4, inRound = true}},
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
		if context.cardarea == G.jokers and context.joker_main then
			if G.GAME.current_round.hands_left == 1 then
				card.ability.extra.handSize = card.ability.extra.handSizeBuff
				G.hand:change_size(card.ability.extra.handSize)
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

for k,v in pairs(stuffToAdd) do
	if v.name ~= "blank" and v.name ~= "testing" then
		SMODS[v.object_type](v)
	end
end


local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.twetyTesting then 
		G.E_MANAGER:add_event(Event({
			func = function()
				for _,tempName in ipairs({"flamesApart", "swiftStorm", "oneStroke", "oneGrain", "freshLine"}) do
					local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_twewy_'..tempName, nil)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
				return true
			end
		}))
	end
end

local Original_ease_dollars = ease_dollars
function ease_dollars(mod, instant)
	Original_ease_dollars(mod, instant)
	for k,v in ipairs(SMODS.find_card("j_twety_oneStroke", true)) do
		local oldMax = v.ability.extra.handSize
		v.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars + mod) / v.ability.extra.perDollar), v.ability.extra.handSizeMax))
		if v.ability.extra.handSize ~= oldMax then
			G.hand:change_size(v.ability.extra.handSize - oldMax)
		end
	end
end

local Card_add_to_deck_ref = Card.add_to_deck 
function Card.add_to_deck(self, from_debuff)
	if not self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' or self.ability.name == 'swiftStorm' then
			G.hand:change_size(self.ability.extra.handSize)
		end
		if self.ability.name == 'oneStroke' then
			self.ability.extra.handSize = math.max(0, math.min(math.floor((G.GAME.dollars) / self.ability.extra.perDollar), self.ability.extra.handSizeMax))
			G.hand:change_size(self.ability.extra.handSize)
		end
	end
	Card_add_to_deck_ref(self, from_debuff)
end

local Card_remove_from_deck_ref = Card.remove_from_deck 
function Card.remove_from_deck(self, from_debuff)
	if self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' 
		or self.ability.name == 'oneStroke' or self.ability.name == 'swiftStorm' then
			G.hand:change_size(-self.ability.extra.handSize)
		end
	end
	Card_remove_from_deck_ref(self, from_debuff)
end

function destroyCard(card)
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
end

scrapped = {}

-- Kewl Line
table.insert(scrapped, {
	object_type = "Joker",
	name = "kewlLinescrapped",
	key = "kewlLinescrapped",
	config = {extra = {handSize = -1, mult = 8}},
	pos = {x = 1, y = 1},
	loc_txt = {
		name = 'Kewl Line',
		text = {
			"{C:red}#1#{} hand size, {C:mult}+#2#{} Mult",
			"Scored {C:attention}8s{} double both",
			"values until end of round"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSize, center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.individual
		and context.other_card:get_id() == 8
		and context.cardarea == G.play then
			G.hand:change_size(card.ability.extra.handSize)
			card.ability.extra.mult = card.ability.extra.mult * 2
			card.ability.extra.handSize = card.ability.extra.handSize * 2
			return { 
				extra = {
					message = "Double!",
					colour = G.C.FILTER
				},
				card = card
			}
		end
		
		if context.cardarea == G.jokers and context.joker_main then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint and card.ability.extra.mult > 8 then
			G.hand:change_size(-card.ability.extra.handSize-1)
			card.ability.extra.mult = 8
			card.ability.extra.handSize = -1
			return {
				message = localize('k_reset'),
				colour = G.C.RED
			}
		end
	end
})

-- Dope Line
table.insert(scrapped, {
	object_type = "Joker",
	name = "dopeLinescrapped",
	key = "dopeLinescrapped",
	config = {extra = {mult = 1}},
	pos = {x = 2, y = 1},
	loc_txt = {
		name = 'Dope Line',
		text = {
			"If your scoring hand",
			"has an {C:attention}Ace{}, {C:mult}+#1#{} Mult",
			"and {C:red}destroy{} this joker.",
			"Value doubles every round"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			local aces = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 14 then aces = aces + 1 end
			end
			if aces >= 1 then
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
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
					mult_mod = card.ability.extra.mult
				}
			end
		end
		
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult * 2
			return {
				message = 'Doubled!',
				colour = G.C.RED
			}
		end
	end
})

-- Wild Line
table.insert(scrapped, {
	object_type = "Joker",
	name = "wildLinescrapped",
	key = "wildLinescrapped",
	config = {extra = {mult = 4}},
	pos = {x = 3, y = 1},
	loc_txt = {
		name = 'Wild Line',
		text = {
			"{C:mult}+#1#{} Mult",
			"Doubles when a {C:attention}Mult Card{}",
			"is scored, but breaks after",
			"going over {C:mult}128{} mult"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
	
		if context.individual
		and context.other_card.ability.effect == "Mult Card"
		and context.cardarea == G.play then
			card.ability.extra.mult = card.ability.extra.mult * 2
			if card.ability.extra.mult > 128 then
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
					message = localize('Broken!'),
					colour = G.C.FILTER
				}
			else
				return { 
					extra = {
						message = "Double!",
						colour = G.C.FILTER
					},
					card = card
				}
			end
		end
	
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult <= 128 then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
	end
})

-- Swift Storm, Swift End
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "swiftStormScrapped",
	key = "swiftStormScrapped",
	config = {extra = {handSize = 4, handSizeLoss = 1}},
	pos = {x = 4, y = 2},
	loc_txt = {
		name = 'Swift Storm, Swift End',
		text = {
			"{C:attention}+4{} hand size, permanently drops",
			"to {C:attention}+#2#{} hand size if you don't",
			"skip the {C:attention}Small{} or {C:attention}Big Blind{}",
			"{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.handSize, center.ability.extra.handSizeLoss}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not context.blind.boss and card.ability.extra.handSize == 4 then
			G.hand:change_size(-(card.ability.extra.handSize - card.ability.extra.handSizeLoss))
			card.ability.extra.handSize = card.ability.extra.handSizeLoss
		end
	end
})

