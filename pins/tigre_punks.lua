-- == Tigre Punks
-- == Card destruction and sacrifice

local stuffToAdd = {}

-- Thanx
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "thanx",
	key = "thanx",
	config = {extra = {showMessage = true}},
	pos = {x = 1, y = 7},
	loc_txt = {
		name = 'Thanx',
		text = {
			"Destroy all scored",
			"{C:attention}face{} cards"
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
		if context.destroying_card and not context.blueprint and context.destroying_card:is_face() then
			if card.ability.extra.showMessage then
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Thanx"})
				card.ability.extra.showMessage = false
			end
			return true
		end
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			card.ability.extra.showMessage = true
		end
	end
})

-- Demon's Hatred
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "demonsHatred",
	key = "demonsHatred",
	config = {extra = {mult = 0, multGain = 3, multMax = 24}},
	pos = {x = 2, y = 7},
	loc_txt = {
		name = "Demon's Hatred",
		text = {
			"This joker gains {C:mult}+#1#{} Mult per hand",
			"Destroys a random joker",
			"on blind selection if this",
			"has {C:mult}#3#{} or more Mult",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	rarity = 1,
	cost = 4,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.multGain, center.ability.extra.mult, center.ability.extra.multMax}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multGain
			if card.ability.extra.mult >= card.ability.extra.multMax then
				local eval = function(card) return (true) end
				juice_card_until(card, eval, true)
			end
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult,
			}
		end
		
		if context.setting_blind and not card.getting_sliced and not context.blueprint and card.ability.extra.mult >= card.ability.extra.multMax then
			local destructable_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
			end
			local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('madness')) or nil

			if joker_to_destroy and not (context.blueprint_card or card).getting_sliced then 
				joker_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({func = function()
					(context.blueprint_card or card):juice_up(0.8, 0.8)
					joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
				return true end }))
			end
			if not (context.blueprint_card or card).getting_sliced then
				card_eval_status_text((context.blueprint_card or card), 'extra', nil, nil, nil, {message = "Hatred!"})
			end
		end
	end
})

-- LIVE!
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "live",
	key = "live",
	config = {extra = {countdown = 3, countdownMax = 3}},
	pos = {x = 3, y = 7},
	loc_txt = {
		name = "LIVE!",
		text = {
			"After destroying {C:attention}#1#{} more playing",
			"cards, all scoring cards in your",
			"next hand become {C:dark_edition}Holographic{}"
		}
	},
	rarity = 3,
	cost = 9,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.countdown}}
	end,
	calculate = function(self, card, context)
		if context.cards_destroyed and not context.blueprint then
			local removed = 0
			for k, v in ipairs(context.glass_shattered) do
				removed = removed + 1
			end
			for k, v in ipairs(context.removed) do
				removed = removed + 1
			end
			if removed > 0 then
				card.ability.extra.countdown = card.ability.extra.countdown - removed
				if card.ability.extra.countdown < 0 then
					card.ability.extra.countdown = 0
				end
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.countdown.." left"})
				if card.ability.extra.countdown == 0 then
					local eval = function(card) return (card.ability.extra.countdown == 0) and not G.RESET_JIGGLES end
					juice_card_until(card, eval, true)
				end
			end

			return
		end
		
		if context.remove_playing_cards and not context.blueprint then
            local removed = 0
			for k, v in ipairs(context.removed) do
				removed = removed + 1
			end
			if removed > 0 then
				card.ability.extra.countdown = card.ability.extra.countdown - removed
				if card.ability.extra.countdown < 0 then
					card.ability.extra.countdown = 0
				end
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = card.ability.extra.countdown.." left"})
				if card.ability.extra.countdown == 0 then
					local eval = function(card) return (card.ability.extra.countdown == 0) end
					juice_card_until(card, eval, true)
				end
			end
			return
		end
	
		if context.cardarea == G.jokers and context.before and card.ability.extra.countdown == 0 and not context.blueprint then
			card.ability.extra.countdown = card.ability.extra.countdownMax
			for k, v in ipairs(context.scoring_hand) do
				v:set_edition({holo = true}, nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
			end
			return {
				message = "LIVE!",
				colour = G.C.MULT,
				card = self
			}
		end
	end
})

-- Distortion
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "distortion",
	key = "distortion",
	config = {extra = {dollars = 15}},
	pos = {x = 4, y = 7},
	loc_txt = {
		name = 'Distortion',
		text = {
			"At the end of the round,",
			"destroy all {C:blue}Common{} {C:attention}Jokers{}",
			"and gain {C:money}$#1#{} for each{}"
		}
	},
	rarity = 2,
	cost = 4,
	discovered = true,
	blueprint_compat = false,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.dollars}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition
		and not context.blueprint then
			for k,v in pairs(G.jokers.cards) do
				if v.config.center.rarity == 1 and not v.ability.eternal then
					destroyCard(v)
					ease_dollars(card.ability.extra.dollars)
					G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
					G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
					card_eval_status_text(card, 'extra', nil, nil, nil, {
						message = "+"..card.ability.extra.dollars.."$",
						colour = G.C.MONEY
					})
				end
			end
		end
	end
})

return {stuffToAdd = stuffToAdd}