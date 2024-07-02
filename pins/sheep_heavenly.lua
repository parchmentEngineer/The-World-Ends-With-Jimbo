-- SHEEP HEAVENLY
-- Card retrigger effects

local stuffToAdd = {}

-- Gimme Dat Hippo
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "gimmeDatHippo",
	key = "gimmeDatHippo",
	config = {extra = {dollars = -1}},
	pos = {x = 1, y = 10},
	loc_txt = {
		name = 'Gimme Dat Hippo',
		text = {
			"{C:diamonds}Diamonds{} give {C:money}#1#${} when scored",
			"Retrigger all {C:diamonds}Diamonds{} twice"
		}
	},
	rarity = 2,
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.dollars}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.other_card:is_suit("Diamonds")
		and context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = 2,
				card = card
			}
		end
	
		if context.individual
		and context.other_card:is_suit("Diamonds")
		and context.cardarea == G.play then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
			G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			return {
				dollars = card.ability.extra.dollars,
				card = card
			}
		end
	end
})

-- Vacu Squeeze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "vacuSqueeze",
	key = "vacuSqueeze",
	config = {extra = {retriggers = 1, lastPlayed = 0, lastPlayedValue = 0}},
	pos = {x = 2, y = 10},
	loc_txt = {
		name = 'Vacu Squeeze',
		text = {
			"Cards with the same rank",
			"as your last played {C:attention}High{}",
			"{C:attention}Card{} are retriggered once",
			"{C:inactive}(Currently: {C:attention}#1#{C:inactive}){}"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.lastPlayed > 0 and center.ability.extra.lastPlayedValue or "None"}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.scoring_name == "High Card" then
				card.ability.extra.lastPlayed = context.other_card:get_id()
				card.ability.extra.lastPlayedValue = context.other_card.base.value
				--G.GAME.twewy_playmate_beam = context.other_card.base.value
			end
		end
		
		if context.repetition
		and context.other_card:get_id() == card.ability.extra.lastPlayed
		and context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra.retriggers,
				card = card
			}
		end
	end
})

-- Whirlygig Juggle
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "whirlygigJuggle",
	key = "whirlygigJuggle",
	config = {extra = {retriggers = 5}},
	pos = {x = 3, y = 10},
	loc_txt = {
		name = 'Whirlygig Juggle',
		text = {
			"When you play a {C:attention}Straight{},",
			"retrigger the lowest value",
			"card {C:attention}#1#{} times"
		}
	},
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.retriggers, center.ability.extra.retriggers == 1 and '' or 's'}}
	end,
	calculate = function(self, card, context)
		if context.repetition
		and context.cardarea == G.play
		and next(context.poker_hands['Straight']) then
			print("Test")
			local lowestVal = 99
			local lowestId = -1
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() <= lowestVal then
					lowestVal = v:get_id()
					lowestId = v.unique_val
					print(lowestVal.." has ID "..lowestId)
				end
			end
			if context.other_card.unique_val == lowestId then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.retriggers-1,
					card = card
				}
			end
		end
	end
})

return {stuffToAdd = stuffToAdd}