--- STEAMODDED HEADER
--- MOD_NAME: The World Ends With Jimbo
--- MOD_ID: TWEWY
--- PREFIX: twewy
--- MOD_AUTHOR: [parchmentEngineer]
--- MOD_DESCRIPTION: Adds jokers inspired by the brands and pins of The World Ends With You
--- BADGE_COLOUR: 3333CC
--- DISPLAY_NAME: TWEWJ

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
	config = {twetyTesting = true, consumables = {'c_devil', 'c_magician'}},
	pos = {x = 0, y = 0},
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

table.insert(stuffToAdd, {
	object_type = "Atlas",
	key = "modicon",
	path = "icon.png",
	px = 32,
	py = 32
})

-- File loading based on Relic-Jokers
local files = NFS.getDirectoryItems(mod_path.."pins")
for _, file in ipairs(files) do
    print("Loading file "..file)
    local f, err = NFS.load(mod_path.."pins/"..file)
    if err then print("Error loading file: "..err) else
      local curr_obj = f()
      if true then
          if curr_obj.init then curr_obj:init() end
          for _, item in ipairs(curr_obj.stuffToAdd) do
              if SMODS[item.object_type] then
                SMODS[item.object_type](item)
              else
                print("Error loading item "..item.key.." of unknown type "..item.object_type)
              end
          end
      end
    end
end


-- == Set up testing deck

for k,v in pairs(stuffToAdd) do
	local addTestingDeck = false
	if v.name ~= "blank" and (v.name ~= "testing" or addTestingDeck) then
		SMODS[v.object_type](v)
	end
end


local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.twetyTesting then 
		G.E_MANAGER:add_event(Event({
			func = function()
				for _,tempName in ipairs({"diss", "izanagi", "excalibur", "mitama"}) do
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
	for k,v in ipairs(SMODS.find_card("j_twewy_oneStroke", true)) do
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
		
		if self.ability.name == 'thunderPawn' then
			G.E_MANAGER:add_event(Event({func = function()
				change_shop_size(1)
				return true end }))
		end
		
		if self.ability.name == 'eyesFullOfHope' then
			G.E_MANAGER:add_event(Event({func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.ability.extra.bonusConsumable
				return true end }))
		end

	end
	Card_add_to_deck_ref(self, from_debuff)
	for k,v in ipairs(SMODS.find_card("j_twewy_supplyFactor", true)) do
		if self.config.center.rarity == 2 and v.ability.extra.readyToUse then
			v.ability.extra.readyToUse = false
			card_eval_status_text(v, 'extra', nil, nil, nil, {message = "Duped!"})
			destroyCard(v)
			G.E_MANAGER:add_event(Event({func = function()
				local copied = copy_card(self, nil, nil, nil, self.edition and self.edition.negative)
				copied:add_to_deck()
				G.jokers:emplace(copied)
				return true end }))
		end
	end
end

local Card_remove_from_deck_ref = Card.remove_from_deck 
function Card.remove_from_deck(self, from_debuff)
	if self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' 
		or self.ability.name == 'oneStroke' or self.ability.name == 'swiftStorm' then
			G.hand:change_size(-self.ability.extra.handSize)
		end
		
		if self.ability.name == 'thunderPawn' then
			G.GAME.twewy_thunderPawn_resetShop = true
		end

		if self.ability.name == 'eyesFullOfHope' then
			G.E_MANAGER:add_event(Event({func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.ability.extra.bonusConsumable
				return true end }))
		end


	end
	Card_remove_from_deck_ref(self, from_debuff)
end

local G_FUNCS_reroll_shop = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_reroll_shop(e)
end

local G_FUNCS_toggle_shop = G.FUNCS.toggle_shop
function G.FUNCS.toggle_shop(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_toggle_shop(e)
end

local G_FUNCS_cash_out = G.FUNCS.cash_out
function G.FUNCS.cash_out(e)
	if G.GAME.twewy_thunderPawn_resetShop then
		G.GAME.twewy_thunderPawn_resetShop = false
		G.E_MANAGER:add_event(Event({func = function()
			change_shop_size(-1)
			return true end }))
	end
	G_FUNCS_cash_out(e)
end

local Card_set_cost = Card.set_cost
function Card.set_cost(self)
	Card_set_cost(self)
	for k,v in ipairs(SMODS.find_card("j_twewy_excalibur")) do
		self.cost = v.ability.extra.newPrice
	end
	
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

-- == Scrapped Ideas
-- == Most still work, they're just not good ideas

-- Kewl Line
table.insert(stuffToAdd, {
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
table.insert(stuffToAdd, {
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
table.insert(stuffToAdd, {
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

-- Sizzling Gaze
table.insert(stuffToAdd, {
	object_type = "Joker",
	name = "sizzlingGazeScrapped",
	key = "sizzlingGaze",
	config = {extra = {payouts = 4}},
	pos = {x = 2, y = 6},
	loc_txt = {
		name = 'Sizzling Gaze',
		text = {
			"The next {C:attention}#1#{} times you",
			"play a {C:attention}Full House{}, gain",
			"the {C:attention}tag{} for this blind",
			"{C:inactive}(Currently: #2#){}",
			"{C:inactive}Not actually 100% implemented{}"
		}
	},
	rarity = 1,
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.payouts, "Uncommon Tag"}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and next(context.poker_hands['Full House']) then
			local _tag = Tag('tag_uncommon')
            add_tag(_tag)
			if not context.blueprint then
				card.ability.extra.payouts = card.ability.extra.payouts - 1
			end
		end
	end
})

