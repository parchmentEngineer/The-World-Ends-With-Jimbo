--- STEAMODDED HEADER
--- MOD_NAME: The World Ends With Jimbo
--- MOD_ID: TWEWY
--- PREFIX: twewy
--- MOD_AUTHOR: [parchmentEngineer]
--- MOD_DESCRIPTION: Adds jokers inspired by the brands and pins of The World Ends With You
--- BADGE_COLOUR: 3333CC
--- DISPLAY_NAME: TWEWJ
--- VERSION: 0.4.0

----------------------------------------------
------------MOD CODE -------------------------

local mod_path = ''..SMODS.current_mod.path
local stuffToAdd = {}

--JokerDisplay mod integration
if SMODS.Mods["JokerDisplay"] then
	JOKER_DISPLAY = NFS.load(mod_path .. "/JokerDisplayIntegration.lua")()
end

-- G.localization.descriptions["Other"]["p_twewy_gatitoPack"] = {
  -- name = "Colour Pack",
  -- text = {
      -- "Choose {C:attention}1{} of up to",
      -- "{C:attention}2{C:colourcard} Colour{} cards to",
      -- "add to your consumeables"
  -- }
-- }

-- table.insert(stuffToAdd, {
	-- object_type = "Center",
    -- prefix = 'p',
    -- key = 'gatitoPack',
    -- name = "Gatito Pack",
    -- weight = 3000,
    -- kind = "Gatito",
    -- cost = 1,
    -- discovered = true,
    -- alerted = true,
    -- set = "Booster",
    -- atlas = "jokers",
    -- config = {extra = 5, choose = 1},
	-- loc_text = {
		-- name = "Gatito Pack",
		-- text = {
			-- "Choose {C:attention}4{} of up to",
			-- "{C:attention}1{C:joker} Gatito{} cards"
		-- }
	-- }
-- })

--table.insert(G.P_JOKER_RARITY_POOLS, {})
--table.insert(G.C.RARITY, HEX("CC9977"))
local gatitoRarity = 'gatitoRarity'
G.P_JOKER_RARITY_POOLS.gatitoRarity = {}
G.C.RARITY.gatitoRarity = HEX("745C56")
loc_colour("mult", nil)
G.ARGS.LOC_COLOURS["gatito"] = G.C.RARITY[gatitoRarity]
G.gatitoRarity = gatitoRarity
G.gatitoOdds = 0.3


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
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	atlas = "jokers",
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.name}}
	end,
	calculate = function(self, card, context)

	end
})

local debugMode = false
local testingJokers = {'mitama'}
local vanillaJokers = {}
local testingConsumables = {'c_empress', 'c_pluto'}

-- here's an example booster pack
-- SMODS.Booster {
    -- key = 'test_booster_pack_2',
    -- weight = 0,
	-- pos = {x = 0, y = 0},
    -- loc_txt = {
        -- name = "Gatito Pack",
        -- text = {
            -- "This is a test Booster Pack"
        -- },
        -- group_name = "Gatito Pack",
    -- },
    -- create_card = function(self, card)
        -- local _card = create_card("Joker", G.pack_cards, nil, gatitoRarity, true, true, nil, 'gatito')
		-- return _card
    -- end,
    -- config = {extra = 4, choose = 1},
	-- atlas = 'packs',
    -- draw_hand = false,
    -- sparkles = {
        -- colours = {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
        -- lifespan = 1
    -- }
-- }


-- Testing card back
table.insert(stuffToAdd, {
	object_type = "Back",
	name = "testing",
	key = "testing",
	config = {twetyTesting = true, consumables = testingConsumables},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = "Testing",
		text = {
			"Testing"
		}
	},
	atlas = "jokers"
})

-- table.insert(stuffToAdd, {
	-- object_type = "Back",
	-- name = "juptierOfTheMonkey",
	-- key = "juptierOfTheMonkey",
	-- config = {},
	-- pos = {x = 0, y = 4},
	-- loc_txt = {
		-- name = "Jupiter of the Monkey",
		-- text = {
			-- "At the end of each round",
			-- "transform all held {C:tarot}Tarots{}",
			-- "into other random {C:tarot}Tarots{}"
		-- }
	-- },
	-- atlas = "jokers"
-- })

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
	key = "packs",
	path = "packs.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
    key = "modifiers",
    path = "modifiers.png",
    px = 71,
    py = 95
})


-- SMODS.Shader({key = 'glitter', path = 'glitter.fs'})
-- SMODS.Sound({key = 'rhinestone', path = 'glitter.ogg'})

-- SMODS.Edition{
    -- key = 'rhinestone',
	-- loc_txt = {
		-- name = "Rhinestone",
		-- text = {
			-- "{X:mult,C:white} X#1# {} Mult if this is the",
			-- "third {C:dark_edition}Rhinestone{} card",
			-- "triggered this hand"
		-- }
	-- },

    -- config = {xMult = 3},
    -- loc_vars = function(self, info_queue)
        -- return {vars = {self.config.xMult}}
    -- end,

    -- sound = {sound = 'twewy_rhinestone', per = 1.2, vol = 0.4},
    -- in_shop = true,
    -- weight = 9,
    -- get_weight = function(self)
        -- return G.GAME.edition_rate * self.weight
    -- end,

    -- shader = 'glitter'
-- }

table.insert(stuffToAdd, {
	object_type = "Atlas",
	key = "modicon",
	path = "icon.png",
	px = 34,
	py = 34
})

-- local card_h_popupref = G.UIDEF.card_h_popup
-- function G.UIDEF.card_h_popup(card)
    -- local retval = card_h_popupref(card)
    -- if not card.config.center or -- no center
	-- (card.config.center.unlocked == false and not card.bypass_lock) or -- locked card
	-- card.debuff or -- debuffed card
	-- (not card.config.center.discovered and ((card.area ~= G.jokers and card.area ~= G.consumeables and card.area) or not card.area)) -- undiscovered card
	-- then return retval end

	-- if card.config.center.rarity == gatitoRarity and false then
		-- retval.nodes[1].nodes[1].nodes[1].nodes[3].nodes[1].nodes[1].nodes[2].config.object:remove()
		-- retval.nodes[1].nodes[1].nodes[1].nodes[3].nodes[1] = create_badge("Gatito", loc_colour("gatito", nil), nil, 1.2)
	-- end

	-- return retval
-- end

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
				if item.object_type == "Joker" and not debugMode then
					item.discovered = false
				end
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
	if v.name ~= "blank" and (v.name ~= "testing" or debugMode) then
		SMODS[v.object_type](v)
	end
end


local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.twetyTesting then 
		G.E_MANAGER:add_event(Event({
			func = function()
				for _,tempName in ipairs(testingJokers) do
					local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_twewy_'..tempName, nil)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			func = function()
				for _,tempName in ipairs(vanillaJokers) do
					local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_'..tempName, nil)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
				return true
			end
		}))
	end
end

local Card_set_ability = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)
	Card_set_ability(self, center, initial, delay_sprites)
	if self.ability.name == 'burningCherry' or self.ability.name == 'lazyBomber' then
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible and k ~= self.ability.extra.handReq then _poker_hands[#_poker_hands+1] = k end
		end
		self.ability.extra.handReq = pseudorandom_element(_poker_hands, pseudoseed(self.ability.name))
	end
	if not initial and G.GAME and G.GAME.twewy_playmate_beam == 1 and self.playing_card and self:is_suit("Spades")then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local edition = poll_edition('playmateBeam', nil, true, true)
            local aura_card = self
            aura_card:set_edition(edition, true)
        return true end }))
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
	if G.GAME.twewy_dBDeck and self.ability.set == "Joker" then
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_played(-1)
	end
	if not self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' or self.ability.name == 'swiftStorm'
		or self.ability.name == 'blackSky' or self.ability.name == 'fierySpirit' then
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
	if G.GAME.twewy_dBDeck and self.ability.set == "Joker" then
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_played(1)
	end
	for k,v in ipairs(SMODS.find_card("j_twewy_live", true)) do
		if self.getting_sliced then
			--print("Removing a "..self.ability.name)
			v.ability.extra.countdown = v.ability.extra.countdown - 1
			if v.ability.extra.countdown < 0 then
				v.ability.extra.countdown = 0
			end
			card_eval_status_text(v, 'extra', nil, nil, nil, {message = v.ability.extra.countdown.." left"})
			if v.ability.extra.countdown == 0 then
				local eval = function(v) return (v.ability.extra.countdown == 0) and not G.RESET_JIGGLES end
				juice_card_until(v, eval, true)
			end
		end
	end
	if self.added_to_deck then
		if self.ability.name == 'kewlLine' or self.ability.name == 'selfFound' or self.ability.name == 'blackSky'
		or self.ability.name == 'oneStroke' or self.ability.name == 'swiftStorm' or self.ability.name == 'fierySpirit' then
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

function SMODS.current_mod.set_debuff(card)
	if (next(SMODS.find_card('j_twewy_blackSky')) and (card:is_suit('Spades', true) or card:is_suit('Clubs', true))) then
		return true
	end
end

--Code copied from Codex Arcanum
local update_round_evalref = Game.update_round_eval
function Game:update_round_eval(dt)
	update_round_evalref(self, dt)
	if G.deck.config.wonderMagnum then
    local _first_dissolve = false
    for _, wax_id in ipairs(G.deck.config.wonderMagnum) do
      for k, card in ipairs(G.playing_cards) do
        if card.unique_val == wax_id then
          card:start_dissolve(nil, _first_dissolve)
          _first_dissolve = true
        end
      end
    end
    G.deck.config.wonderMagnum = {}
  end
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

local Card_get_h_x_mult = Card.get_chip_h_x_mult
function Card.get_chip_h_x_mult(self)
	local retVal = Card_get_h_x_mult(self)
	if retVal and retVal > 0 and G.GAME.twewy_lapinAngelique then
		self.ability.h_x_mult = self.ability.h_x_mult + 0.1
	end
	return retVal
end

local Card_get_x_mult = Card.get_chip_x_mult
function Card.get_chip_x_mult(self)
	local retVal = Card_get_x_mult(self)
	if retVal and retVal > 0 and G.GAME.twewy_lapinAngelique then
		self.ability.x_mult = self.ability.x_mult + 0.1
	end
	return retVal
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

function evalMessage(card, message, colour)
	card_eval_status_text(card, 'extra', nil, nil, nil, {message = message, colour = colour})
end