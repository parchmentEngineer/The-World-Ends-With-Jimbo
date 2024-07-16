-- == D+B
-- == Manipulation of number of hands or discards

local stuffToAdd = {}

-- Ice Blow
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "iceBlow",
	key = "iceBlow",
	config = {extra = {triggered = false}},
	pos = {x = 1, y = 11},
	loc_txt = {
		name = 'Ice Blow',
		text = {
			"The first time each round",
			"you play a hand with {C:attention}3{} or",
			"more scoring {C:attention}face cards{},",
			"gain {C:red}+3{} discards this round"
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
		if context.cardarea == G.jokers and context.after then
			local faces = 0
			for _,v in ipairs(context.scoring_hand) do
				if v:is_face() then
					faces = faces + 1
				end
			end
			if faces >= 3 and not card.ability.extra.triggered then
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.ability.extra.triggered = true
						ease_discard(3)
						return true
					end)
				}))
				return {
					message = "+3 Discards!"
				}
				
			end
		end
		
		if context.first_hand_drawn then
			card.ability.extra.triggered = false
		end
	end
})

-- Ice Risers
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "iceRisers",
	key = "iceRisers",
	config = {extra = {}},
	pos = {x = 2, y = 11},
	loc_txt = {
		name = 'Ice Risers',
		text = {
			"When you discard a hand",
			"containing any {C:attention}face cards{},",
			"gain {C:blue}+1{} hand this round"
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
		if context.pre_discard then
			local hasFace = false
			for _,v in ipairs(context.full_hand) do
				if v:is_face() then
					hasFace = true
				end
			end
			if hasFace then
				G.E_MANAGER:add_event(Event({
					func = (function()
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Hand!"})
						ease_hands_played(1)
						return true
					end)
				}))
			end
		end
	end
})

-- Earthshake
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "earthshake",
	key = "earthshake",
	config = {extra = {discards = 0}},
	pos = {x = 3, y = 11},
	loc_txt = {
		name = 'Earthshake',
		text = {
			"Unused discards in non-Boss rounds",
			"carry over to next round",
			"{C:inactive}(Currently {C:red}+#1#{C:inactive} discard#2#)",
		}
	},
	rarity = 2,
	cost = 5,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.discards, 
			card.ability.extra.discards ~= 1 and "s" or ""}}
	end,
	-- Effect injected into G.FUNCS.cash_out
})

table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "straitjacket",
	key = "straitjacket",
	config = {extra = {usesLeft = 6}},
	pos = {x = 4, y = 11},
	loc_txt = {
		name = 'Straitjacket',
		text = {
			"When you play a {C:attention}Straight{}",
			"gain {C:blue}+1{} hand this round",
			"{C:inactive}({C:attention}#1#{C:inactive} uses left)"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.usesLeft}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Straight']) then
			if card.ability.extra.usesLeft > 0 then
				card.ability.extra.usesLeft = card.ability.extra.usesLeft - 1
				ease_hands_played(1)
				if card.ability.extra.usesLeft == 0 then
					destroyCard(card)
					return {
						message = "Used Up!",
						colour = G.C.BLUE
					}
				end
				return {
					message = "+1 Hand!",
					colour = G.C.BLUE
				}
			end
		end
	end
})

return {stuffToAdd = stuffToAdd}