let jokers = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Common"
  // }
	{
		name: 'Storm Warning',
		text: [
			"This joker gains {C:chips}+40{} Chips",
			"when any card is sold.",
			"{C:attention}Resets{} when any card",
			"is bought",
			"{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
		],
		image_url: "site/img/tile005.png",
		rarity: "Uncommon",
		brand: "Mus Rattus"
	},
	{
		name: 'Candle Service',
		text: [
			"Every fourth scoring",
			"{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{} gives",
			"you {C:chips}+125{} Chips",
			"{C:inactive}(Currently 0/4){}"
		],
		image_url: "site/img/tile001.png",
		rarity: "Common",
		brand: "Mus Rattus"
	},
	{
		name: 'Aqua Monster',
		text: [
			"All scoring cards become",
			"{C:attention}Bonus Cards{} if played",
			"hand contains a {C:attention}Three",
			"{C:attention}of a Kind{}"
		],
		image_url: "site/img/tile002.png",
		rarity: "Uncommon",
		brand: "Mus Rattus"
	},
	{
		name: 'Aqua Ghost',
		text: [
			"All scoring cards become",
			"{C:dark_edition}Foil Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		],
		image_url: "site/img/tile003.png",
		rarity: "Rare",
		brand: "Mus Rattus"
	},
	{
		name: 'Aqua Demon',
		text: [
			"{C:chips}+666{} Chips if played",
			"hand contains",
			"a {C:attention}Three of a Kind{}"
		],
		image_url: "site/img/tile004.png",
		rarity: "Rare",
		brand: "Mus Rattus"
	},
	{
		name: 'Lightning Moon',
		text: [
			"{C:chips}+30{} Chips for each",
			"Club held in hand",
		],
		image_url: "site/img/tile006.png",
		rarity: "Common",
		brand: "Mus Rattus"
	},
	{
		name: 'Burning Cherry',
		text: [
			"{C:chips}+200{} Chips",
			"{C:chips}-25{} Chips when you play a",
			"hand that isn't {C:attention}High Card{}",
			"{C:inactive}(Hand changes each round){}"
		],
		image_url: "site/img/tile007.png",
		rarity: "Common",
		brand: "Mus Rattus"
	},
	{
		name: 'Impact Warning',
		text: [
			"This joker gains {C:chips}+25{} Chips",
			"when a {C:planet}Planet{} card is",
			"used. {C:attention}Resets{} on using the",
			"same {C:planet}Planet{} twice in a row",
			"{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)",
			"{C:inactive}(Last used: {C:planet}None{C:inactive}){}"
		],
		image_url: "site/img/tile008.png",
		rarity: "Uncommon",
		brand: "Mus Rattus"
	},
	{
		name: 'Shout!',
		text: [
			"{C:chips}+100{} Chips if your last {C:attention}3{}",
			"hands contained a scoring face card",
			"{C:inactive}(Current streak: {C:attention}0{C:inactive}){}"
		],
		image_url: "site/img/tile009.png",
		rarity: "Common",
		brand: "Mus Rattus"
	},
	{
		name: 'Burning Melon',
		text: [
			"{C:chips}+80{} Chips, {C:chips}-10{} per round",
			"On the final hand of the",
			"round, gives {C:chips}+200{} extra",
			"chips and destroy this joker"
		],
		image_url: "site/img/tile010.png",
		rarity: "Common",
		brand: "Mus Rattus"
	},
	{
		name: 'Kewl Line',
		text: [
			"{C:attention}-2{} hand size",
			"Scored {C:attention}8s{} give {C:mult}+24{} Mult",
		],
		image_url: "site/img/tile018.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Dope Line',
		text: [
			"At end of round, {C:attention}destroy{}",
			"this joker and all cards",
			"held in hand become {C:attention}Mult Cards{}"
		],
		image_url: "site/img/tile019.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Wild Line',
		text: [
			"Retrigger all",
			"{C:attention}Mult Cards{}"
		],
		image_url: "site/img/tile020.png",
		rarity: "Uncommon",
		brand: "Wild Boar"
	},
	{
		name: 'Fly Line',
		text: [
			"This joker gains {C:mult}+25{} Mult after playing a {C:spades}Spades Flush{}, a {C:hearts}Hearts Flush{}, a {C:clubs}Clubs Flush{}, and a {C:diamonds}Diamonds Flush{}",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)",
			"{C:inactive}(Progress: _ _ _ _){}",
		],
		image_url: "site/img/tile021.png",
		rarity: "Uncommon",
		brand: "Wild Boar"
	},
	{
		name: 'Fresh Line',
		text: [
			"{C:mult}+8{} Mult for each",
			"discarded {C:attention}face{} card,",
			"resets each round",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
		],
		image_url: "site/img/tile022.png",
		rarity: "Uncommon",
		brand: "Wild Boar"
	},
	{
		name: 'Microcosmic Pull',
		text: [
			"If you play a hand with",
			"exactly {C:attention}1{} card, {C:mult}+20{} Mult",
			"and {C:attention}+1{} to cards needed",
			"to trigger this effect",
			"{C:inactive}(Rolls over after 5){}"
		],
		image_url: "site/img/tile023.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Lazy Bomber',
		text: [
			"When you use a {C:tarot}Tarot{}",
			"card, starts a countdown",
			"for {C:attention}3{} hands. {C:mult}+40{} Mult on the hand it ends",
			"{C:inactive}(Inactive!){}"
		],
		image_url: "site/img/tile025.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Diss',
		text: [
			"This joker gains {C:mult}+30{} Mult",
			"if played hand triggers",
			"the {C:attention}Boss Blind{} effect",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
		],
		image_url: "site/img/tile024.png",
		rarity: "Rare",
		brand: "Wild Boar"
	},
	{
		name: 'Flower of Fire',
		text: [
			"{C:mult}+15{} Mult",
			"{C:green}1 in 4{} chance to set",
			"this joker's Mult to {C:mult}0{}",
			"until you play {C:attention}Full House{}"
		],
		image_url: "site/img/tile026.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Cosmic Pull',
		text: [
			"This joker gains {C:mult}+1{} Mult",
			"for each {C:attention}face card{}",
			"held in hand",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
		],
		image_url: "site/img/tile027.png",
		rarity: "Common",
		brand: "Wild Boar"
	},
	{
		name: 'Self Found, Others Lost',
		text: [
			"Gain {C:attention}+2{} hand size",
			"next round whenever",
			"you {C:attention}reroll{} the shop",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
		],
		image_url: "site/img/tile035.png",
		rarity: "Uncommon",
		brand: "Dragon Couture"
	},
	{
		name: 'One Grain, Infinite Promise',
		text: [
			"Whenever you use a",
			"{C:attention}consumable{} during a round, draw {C:attention}4{} cards"
		],
		image_url: "site/img/tile036.png",
		rarity: "Common",
		brand: "Dragon Couture"
	},
	{
		name: 'One Stroke,<br>Vast Wealth',
		text: [
			"{C:attention}+1{} hand size for every",
			"{C:money}$20{} you have, to a maximum of {C:attention}+10{}",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
		],
		image_url: "site/img/tile037.png",
		rarity: "Uncommon",
		brand: "Dragon Couture"
	},
	{
		name: 'Swift Storm, Swift End',
		text: [
			"{C:attention}+7{} hand size on the",
			"{C:attention}final hand{} of each round"
		],
		image_url: "site/img/tile038.png",
		rarity: "Uncommon",
		brand: "Dragon Couture"
	},
	{
		name: 'Flames Apart, Foes Aflame',
		text: [
			"When you play a {C:attention}Straight{}",
			"{C:attention}Flush{} or a {C:attention}secret hand{}, draw your {C:dark_edition}entire deck{}"
		],
		image_url: "site/img/tile039.png",
		rarity: "Rare",
		brand: "Dragon Couture"
	},
	{
		name: 'Black Sky, White Bolt',
		text: [
			"{C:attention}+3{} hand size",
			"Debuff all {C:attention}Spades{} and {C:attention}Clubs{}"
		],
		image_url: "site/img/tile040.png",
		rarity: "Uncommon",
		brand: "Dragon Couture"
	},
	{
		name: 'Spider\'s Silk',
		text: [
			"Played {C:attention}Steel{} cards become {C:attention}Glass{}, and held {C:attention}Glass{}",
			"cards become {C:attention}Steel{}"
		],
		image_url: "site/img/tile069.png",
		rarity: "Common",
		brand: "Lapin Angelique"
	},
	{
		name: 'Lolita Bat',
		text: [
			"{X:mult,C:white}X3.5{} Mult for the",
			"next {C:attention}8{} hands after",
			"using a {C:spectral}Spectral{} card",
			"{C:inactive}(Inactive!){}"
		],
		image_url: "site/img/tile070.png",
		rarity: "Uncommon",
		brand: "Lapin Angelique"
	},
	{
		name: 'Skull Rabbit',
		text: [
			"This joker gains {X:mult,C:white}X0.1{}",
			"Mult when hand is played",
			"with {C:money}$4{} or less",
			"{C:inactive}(Currently {X:mult,C:white}X1{C:inactive} Mult){}"
		],
		image_url: "site/img/tile071.png",
		rarity: "Rare",
		brand: "Lapin Angelique"
	},
	{
		name: 'Web Spider',
		text: [
			"{X:mult,C:white}X2.5{} Mult if the played",
			"hand is exactly {C:attention}Level 2{}"
		],
		image_url: "site/img/tile072.png",
		rarity: "Uncommon",
		brand: "Lapin Angelique"
	},
	{
		name: 'Lolita Skull',
		text: [
			"{X:mult,C:white}X4{} Mult if you have",
			"{C:attention}4{} or more {C:hearts}Hearts{}",
			"held in hand"
		],
		image_url: "site/img/tile073.png",
		rarity: "Rare",
		brand: "Lapin Angelique"
	},
	{
		name: 'Lolita Mic',
		text: [
			"{X:mult,C:white}X2{} Mult if you play",
			"your recently discarded",
			"hand type",
			"{C:inactive}(Currently: {C:attention}None{C:inactive}){}",
		],
		image_url: "site/img/tile074.png",
		rarity: "Common",
		brand: "Lapin Angelique"
	},
	{
		name: 'Kaleidoscope',
		text: [
			"Cards that are not the ",
			"same suit as any cards in",
			"your most recently played hand give {X:mult,C:white}X1.5{} Mult",
			"{C:inactive}(Currently: {C:attention}None{C:inactive}){}"
		],
		image_url: "site/img/tile075.png",
		rarity: "Uncommon",
		brand: "Lapin Angelique"
	},
	{
		name: 'Thunder Pawn',
		text: [
			"Gain {C:money}$2{} each round",
			"{C:attention}+1{} card slot in shop"
		],
		image_url: "site/img/tile086.png",
		rarity: "Common",
		brand: "Pegaso"
	},
	{
		name: 'Lightning Rook',
		text: [
			"Gains {C:money}$5{} of sell",
			"value whenever an",
			"{C:attention}Ace{} is scored"
		],
		image_url: "site/img/tile087.png",
		rarity: "Uncommon",
		brand: "Pegaso"
	},
	{
		name: 'Excalibur',
		text: [
			"Set the price of",
			"{C:dark_edition}everything{} in the",
			"shop to {C:money}$1{}",
			"{C:inactive}(Except for rerolls){}"
		],
		image_url: "site/img/tile088.png",
		rarity: "Rare",
		brand: "Pegaso"
	},
	{
		name: 'Her Royal Highness',
		text: [
			"Duplicate {C:money}Gold{} cards held",
			"in hand at end of round",
			"{C:inactive}(Triggers after they pay out){}"
		],
		image_url: "site/img/tile089.png",
		rarity: "Uncommon",
		brand: "Pegaso"
	},
	{
		name: 'Zantestu',
		text: [
			"When you play a {C:attention}Straight{}",
			"with all four suits, gain",
			"a {C:tarot}Tarot{} and a {C:planet}Planet{}"
		],
		image_url: "site/img/tile053.png",
		rarity: "Common",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Unjo',
		text: [
			"The next {C:attention}3{} times",
			"you skip an {C:tarot}Arcana Pack{},",
			"open a {C:spectral}Spectral Pack{}"
		],
		image_url: "site/img/tile052.png",
		rarity: "Common",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Mitama',
		text: [
			"Playing a {C:attention}poker hand{}",
			"you have not played this",
			"game upgrades it {C:attention}2{} times"
		],
		image_url: "site/img/tile054.png",
		rarity: "Common",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Izanagi',
		text: [
			"Apply a {C:red}Red Seal{} to",
			"the leftmost card of the",
			"first hand each round"
		],
		image_url: "site/img/tile055.png",
		rarity: "Rare",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Masamune',
		text: [
			"Gain a {C:tarot}Tarot{} card when",
			"you score an {C:attention}Enhanced Card{}"
		],
		image_url: "site/img/tile056.png",
		rarity: "Rare",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Onikiri',
		text: [
			"{C:attention}+3{} consumable slots"
		],
		image_url: "site/img/tile057.png",
		rarity: "Common",
		brand: "Jupiter of the Monkey"
	},
	{
		name: 'Rakuyo',
		text: [
			"All booster packs have",
			"{C:attention}3{} extra options"
		],
		image_url: "site/img/tile058.png",
		rarity: "Uncommon",
		brand: "Jupiter of the Monkey"
	},
	/*{
		name: 'Long Live<br>The Ice',
		text: [
			"When you play a hand,",
			"Active: {C:chips}+50{} chips{}",
			"{C:inactive}Inactive: Gain {C:money}$2{}",
			"Swap effects on skip"
		],
		image_url: "site/img/tile103.png",
		rarity: "Common",
		brand: "Hip Snake"
	},
	{
		name: 'Sizzling Gaze',
		text: [
			"If your hand is a {C:attention}Pair{}",
			"of {C:attention}Aces{} and no other",
			"cards, destroy them and",
			"gain {C:attention}5{} random tags"
		],
		image_url: "site/img/tile104.png",
		rarity: "Common",
		brand: "Hip Snake"
	},
	{
		name: 'Eyes Full<br>of Hope',
		text: [
			"When you skip a {C:attention}Blind{},",
			"gain a {C:tarot}Tarot{} card and",
			"{C:attention}+1{} consumable slot",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} slots){}"
		],
		image_url: "site/img/tile105.png",
		rarity: "Uncommon",
		brand: "Hip Snake"
	},*/
	{
		name: 'Thanx',
		text: [
			"Destroy all scored",
			"{C:attention}face{} cards"
		],
		image_url: "site/img/tile120.png",
		rarity: "Common",
		brand: "Tigre Punks"
	},
	{
		name: 'Demon\'s Hatred',
		text: [
			"Gains {C:mult}+3{} Mult per hand",
			"Destroys a random joker",
			"on blind selection if this",
			"has {C:mult}24{} or more Mult",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
		],
		image_url: "site/img/tile121.png",
		rarity: "Common",
		brand: "Tigre Punks"
	},
	{
		name: 'LIVE!',
		text: [
			"After destroying {C:attention}3{} playing",
			"cards, all scoring cards in",
			"your next played hand become {C:dark_edition}Holographic{}"
		],
		image_url: "site/img/tile122.png",
		rarity: "Rare",
		brand: "Tigre Punks"
	},
	{
		name: 'Distortion',
		text: [
			"At the end of the round,",
			"destroy all {C:blue}Common{} {C:attention}Jokers{}",
			"and gain {C:money}$15{} for each{}"
		],
		image_url: "site/img/tile123.png",
		rarity: "Uncommon",
		brand: "Tigre Punks"
	},
	{
		name: 'Top Gear',
		text: [
			"{C:blue}Common{} {C:attention}Jokers{} in the",
			"shop are {C:dark_edition}Polychrome{}"
		],
		image_url: "site/img/tile137.png",
		rarity: "Uncommon",
		brand: "Pavo Real"
	},
	{
		name: 'Supply Factor',
		text: [
			"The next time you gain an",
			"{C:green}Uncommon{} {C:attention}Joker{}, destroy",
			"this and make a copy of that {C:attention}Joker{}"
		],
		image_url: "site/img/tile138.png",
		rarity: "Common",
		brand: "Pavo Real"
	},
	{
		name: 'Strong Heart',
		text: [
			"After scoring {C:attention}26{} more",
			"{C:hearts}Hearts{}, destroy this and",
			"create a random {C:red}Rare{} {C:attention}Joker{}"
		],
		image_url: "site/img/tile139.png",
		rarity: "Common",
		brand: "Pavo Real"
	},
	{
		name: 'Chaos',
		text: [
			"If you exit the shop with",
			"{C:money}$50{} or more, lose all {C:money}${} and turn a random joker {C:dark_edition}Negative{}"
		],
		image_url: "site/img/tile140.png",
		rarity: "Uncommon",
		brand: "Pavo Real"
	},
	{
		name: 'Gimme Dat Hippo',
		text: [
			"{C:diamonds}Diamonds{} give {C:money}-1${} when scored. Retrigger all {C:diamonds}Diamonds{} twice"
		],
		image_url: "site/img/tile171.png",
		rarity: "Uncommon",
		brand: "Sheep Heavenly"
	},
	{
		name: 'Vacu Squeeze',
		text: [
			"Cards with the same rank",
			"as your last played {C:attention}High{}",
			"{C:attention}Card{} are retriggered twice",
			"{C:inactive}(Currently: {C:attention}None{C:inactive}){}"
		],
		image_url: "site/img/tile172.png",
		rarity: "Common",
		brand: "Sheep Heavenly"
	},
	{
		name: 'Whirlygig Juggle',
		text: [
			"When you play a {C:attention}Straight{},",
			"retrigger the lowest value card {C:attention}1{} time and increase the number of retriggers by {C:attention}1{}"
		],
		image_url: "site/img/tile173.png",
		rarity: "Uncommon",
		brand: "Sheep Heavenly"
	},
	{
		name: 'Cutie Beam',
		text: [
			"Played {C:attention}Wild Cards{} become {C:dark_edition}Polychrome{}. When you gain this joker, gain two {C:dark_edition}Negative{} {C:attention}Lovers{} cards"
		],
		image_url: "site/img/tile154.png",
		rarity: "Uncommon",
		brand: "Natural Puppy"
	},
	{
		name: 'Playmate Beam',
		text: [
			"Cards in {C:attention}Standard Packs{}",
			"are the same rank as",
			"your last played {C:attention}High Card{}",
			"{C:inactive}(Currently: {C:attention}None{C:inactive}){}"
		],
		image_url: "site/img/tile155.png",
		rarity: "Common",
		brand: "Natural Puppy"
	},
	{
		name: 'Wonder Magnum',
		text: [
			"The first time you score",
			"a {C:attention}3{} each round, create",
			"{C:attention}3{} temporary copies of it"
		],
		image_url: "site/img/tile156.png",
		rarity: "Common",
		brand: "Natural Puppy"
	},
	{
		name: 'Innocence Beam',
		text: [
			"When you score an {C:attention}unenhanced{} card, create a temporary copy of it with a random {C:attention}enhancement{}"
		],
		image_url: "site/img/tile158.png",
		rarity: "Uncommon",
		brand: "Natural Puppy"
	},
	{
		name: 'Natural Magnum',
		text: [
			"The next {C:attention}4{} times you",
			"score a {C:attention}face card{}, make a permanent copy of that card"
		],
		image_url: "site/img/tile157.png",
		rarity: "Uncommon",
		brand: "Natural Puppy"
	},
]

// works the same. 
let consumables = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Tarot"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Planet"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Spectral"
  // },
]

let card_modifications = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Enhancement"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Edition"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Seal"
  // },
]

let decks = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Deck"
  // },
]

let stickers = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Sticker"
  // },
]

let blinds = [
  // {
  //   name: "The Wall",
  //   text: [
  //     "Extra large blind",
  //     "{C:inactive}({C:red}4x{C:inactive} Base for {C:attention}$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 2)"
  //   ],
  //   image_url: "img/the_wall.png",
  //   rarity: "Boss Blind"
  // },
  // {
  //   name: "Violet Vessel",
  //   text: [
  //     "Very large blind",
  //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 8)"
  //   ],
  //   image_url: "img/violet_vessel.png",
  //   rarity: "Showdown"
  // },
]

let shop_items = [

]

let cols = {
  
  MULT: "#FE5F55",
  CHIPS: "#009dff",
  MONEY: "#f3b958",
  XMULT: "#FE5F55",
  FILTER: "#ff9a00",
  ATTENTION: "#ff9a00",
  BLUE: "#009dff",
  RED: "#FE5F55",
  GREEN: "#4BC292",
  PALE_GREEN: "#56a887",
  ORANGE: "#fda200",
  IMPORTANT: "#ff9a00",
  GOLD: "#eac058",
  YELLOW: "#ffff00",
  CLEAR: "#00000000", 
  WHITE: "#ffffff",
  PURPLE: "#8867a5",
  BLACK: "#374244",
  L_BLACK: "#4f6367",
  GREY: "#5f7377",
  CHANCE: "#4BC292",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#5d5dff",
  ETERNAL: "#c75985",
  INACTIVE: "#ffffff99",
  HEARTS: "#f03464",
  DIAMONDS: "#f06b3f",
  SPADES: "#403995",
  CLUBS: "#235955",
  ENHANCED: "#8389DD",
  JOKER: "#708b91",
  TAROT: "#a782d1",
  PLANET: "#13afce",
  SPECTRAL: "#4584fa",
  VOUCHER: "#fd682b",
  EDITION: "#4ca893",
}

let rarities = {
  "Common": "#009dff", 
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Joker": "#708b91",
  "Tarot": "#a782d1",
  "Planet": "#13afce",
  "Spectral": "#4584fa",
  "Voucher": "#fd682b",
  "Pack": "#9bb6bd",
  "Enhancement": "#8389DD",
  "Edition": "#4ca893",
  "Seal": "#4584fa",
  "Deck": "#9bb6bd",
  "Sticker": "#5d5dff",
  "Boss Blind": "#5d5dff",
  "Showdown": "#4584fa",
}

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
  for (let joker of jokers) {
    console.log("adding joker", joker.name);
  
    joker.text = joker.text.map((line) => { return line + "{}"});
  
    joker.text = joker.text.join("<br/>");
    joker.text = joker.text.replaceAll("{}", "</span>");
    joker.text = joker.text.replace(regex, function replacer(match, p1, offset, string, groups) {
      let classes = p1.split(",");
  
      let css_styling = "";
  
      for (let i = 0; i < classes.length; i++) {
        let parts = classes[i].split(":");
        if (parts[0] === "C") {
          css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
        } else if (parts[0] === "X") {
          css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
        }
      }
  
      return `</span><span style='${css_styling}'>`;
    });
  
    let joker_div = document.createElement("div");
    joker_div.classList.add("joker");
    if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="hasback" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else if (joker.soul) {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    }
  
    jokers_div.appendChild(joker_div);
  }
}

if (jokers.length === 0) {
  document.querySelector(".jokersfull").style.display = "none"
} else {
  let jokers_div = document.querySelector(".jokers");
  add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
  document.querySelector(".consumablesfull").style.display = "none"
} else {
  let consumables_div = document.querySelector(".consumables");
  add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
  document.querySelector(".cardmodsfull").style.display = "none"
} else {
  let cardmods_div = document.querySelector(".cardmods");
  add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
  document.querySelector(".decksfull").style.display = "none"
} else {
  let decks_div = document.querySelector(".decks");
  add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
  document.querySelector(".stickersfull").style.display = "none"
} else {
  let stickers_div = document.querySelector(".stickers");
  add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
  document.querySelector(".blindsfull").style.display = "none"
} else {
  let blinds_div = document.querySelector(".blinds");
  add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
  document.querySelector(".shopitemsfull").style.display = "none"
} else {
  let shopitems_div = document.querySelector(".shopitems");
  add_cards_to_div(shop_items, shopitems_div);
}