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
			"{C:chips}+30{} Chips when any card",
			"is sold, {C:attention}resets{} when",
			"any card is bought",
			"{C:inactive}(Currently {C:chips}+0{C:inactive} Chips)"
		],
		image_url: "site/img/tile005.png",
		rarity: "Common"
	},
	{
		name: 'Candle Service',
		text: [
			"Every eighth scoring",
			"{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{} gives",
			"you {C:chips}+250{} Chips",
			"{C:inactive}(Currently 0/8){}"
		],
		image_url: "site/img/tile001.png",
		rarity: "Common"
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
		rarity: "Uncommon"
	},
	{
		name: 'Aqua Ghost',
		text: [
			"All scoring cards become",
			"{C:dark_edition}Foil Cards{} if played hand",
			"contains a {C:attention}Three of a Kind{}"
		],
		image_url: "site/img/tile003.png",
		rarity: "Rare"
	},
	{
		name: 'Aqua Demon',
		text: [
			"{C:chips}+666{} Chips if played",
			"hand contains",
			"a {C:attention}Three of a Kind{}"
		],
		image_url: "site/img/tile004.png",
		rarity: "Rare"
	},
	{
		name: 'Kewl Line',
		text: [
			"{C:attention}-2{} hand size",
			"Scored {C:attention}8s{} give {C:mult}+24{} Mult",
		],
		image_url: "site/img/tile007.png",
		rarity: "Common"
	},
	{
		name: 'Dope Line',
		text: [
			"At end of round, {C:attention}destroy{}",
			"this joker and all cards",
			"held in hand become {C:attention}Mult Cards{}"
		],
		image_url: "site/img/tile008.png",
		rarity: "Common"
	},
	{
		name: 'Wild Line',
		text: [
			"Retrigger all",
			"{C:attention}Mult Cards{}"
		],
		image_url: "site/img/tile009.png",
		rarity: "Uncommon"
	},
	{
		name: 'Fly Line',
		text: [
			"Gains {C:mult}+25{} Mult after",
			"playing {C:attention}flushes{} of all",
			"four suits",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)",
			"{C:inactive}(Progress: _ _ _ _){}",
		],
		image_url: "site/img/tile010.png",
		rarity: "Uncommon"
	},
	{
		name: 'Fresh Line',
		text: [
			"{C:mult}+8{} Mult for each",
			"discarded {C:attention}face{} card,",
			"resets each round",
			"{C:inactive}(Currently {C:mult}+0{C:inactive} Mult)"
		],
		image_url: "site/img/tile011.png",
		rarity: "Uncommon"
	},
	{
		name: 'Self Found, Others Lost',
		text: [
			"Gain {C:attention}+2{} hand size",
			"next round whenever",
			"you {C:attention}reroll{} the shop",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
		],
		image_url: "site/img/tile013.png",
		rarity: "Common"
	},
	{
		name: 'One Grain, Infinite Promise',
		text: [
			"Whenever you use a",
			"{C:attention}consumable{} during a round, draw {C:attention}4{} cards"
		],
		image_url: "site/img/tile014.png",
		rarity: "Common"
	},
	{
		name: 'One Stroke,<br>Vast Wealth',
		text: [
			"{C:attention}+1{} hand size for every",
			"{C:money}$20{} you have, to a maximum of {C:attention}+10{}",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} hand size)"
		],
		image_url: "site/img/tile015.png",
		rarity: "Uncommon"
	},
	{
		name: 'Swift Storm, Swift End',
		text: [
			"{C:attention}+7{} hand size on the",
			"{C:attention}final hand{} of each round"
		],
		image_url: "site/img/tile016.png",
		rarity: "Uncommon"
	},
	{
		name: 'Flames Apart, Foes Aflame',
		text: [
			"When you play a {C:attention}Straight{}",
			"{C:attention}Flush{} or a {C:attention}secret hand{}, draw your {C:dark_edition}entire deck{}"
		],
		image_url: "site/img/tile017.png",
		rarity: "Rare"
	},
	{
		name: 'Spider\'s Silk',
		text: [
			"Played {C:attention}Steel{} cards become {C:attention}Glass{}, and held {C:attention}Glass{}",
			"cards become {C:attention}Steel{}"
		],
		image_url: "site/img/tile025.png",
		rarity: "Common"
	},
	{
		name: 'Lolita Bat',
		text: [
			"{X:mult,C:white}X3.5{} Mult for the",
			"next {C:attention}8{} hands after",
			"using a {C:spectral}Spectral{} card",
			"{C:inactive}(Inactive!){}"
		],
		image_url: "site/img/tile026.png",
		rarity: "Uncommon"
	},
	{
		name: 'Skull Rabbit',
		text: [
			"Gains {X:mult,C:white}x0.1{} Mult",
			"when hand is played",
			"with {C:money}$4{} or less",
			"{C:inactive}(Currently {X:mult,C:white}x1{C:inactive} Mult){}"
		],
		image_url: "site/img/tile027.png",
		rarity: "Rare"
	},
	{
		name: 'Thunder Pawn',
		text: [
			"Gain {C:money}$2{} each round",
			"{C:attention}+1{} card slot in shop"
		],
		image_url: "site/img/tile031.png",
		rarity: "Common"
	},
	{
		name: 'Lightning Rook',
		text: [
			"Gains {C:money}$5{} of sell",
			"value whenever an",
			"{C:attention}Ace{} is scored"
		],
		image_url: "site/img/tile032.png",
		rarity: "Uncommon"
	},
	{
		name: 'Excalibur',
		text: [
			"Set the price of",
			"{C:dark_edition}everything{} in the",
			"shop to {C:money}$1{}",
			"{C:inactive}(Except for rerolls){}"
		],
		image_url: "site/img/tile033.png",
		rarity: "Rare"
	},
	{
		name: 'Zantestu',
		text: [
			"When you play a {C:attention}Straight{}",
			"with all four suits, gain",
			"a {C:tarot}Tarot{} and a {C:planet}Planet{}"
		],
		image_url: "site/img/tile020.png",
		rarity: "Common"
	},
	{
		name: 'Unjo',
		text: [
			"After skipping {C:attention}3{}",
			"{C:purple}Arcana Packs{}, gain",
			"a {C:spectral}Spectral Tag{}",
			"{C:inactive}(3 remaining){}"
		],
		image_url: "site/img/tile019.png",
		rarity: "Common"
	},
	{
		name: 'Mitama',
		text: [
			"Playing a {C:attention}poker hand{}",
			"you have not played this",
			"game upgrades it {C:attention}2{} times"
		],
		image_url: "site/img/tile021.png",
		rarity: "Uncommon"
	},
	{
		name: 'Long Live<br>The Ice',
		text: [
			"When you play a hand,",
			"Active: {C:chips}+50{} chips{}",
			"{C:inactive}Inactive: Gain {C:money}$2{}",
			"Swap effects on skip"
		],
		image_url: "site/img/tile037.png",
		rarity: "Common"
	},
	{
		name: 'Sizzling Gaze',
		text: [
			"If your hand is a {C:attention}Pair{}",
			"of {C:attention}Aces{} and no other",
			"cards, destroy them and",
			"gain {C:attention}5{} random tags"
		],
		image_url: "site/img/tile038.png",
		rarity: "Common"
	},
	{
		name: 'Eyes Full<br>of Hope',
		text: [
			"When you skip a {C:attention}Blind{},",
			"gain a {C:tarot}Tarot{} card and",
			"{C:attention}+1{} consumable slot",
			"{C:inactive}(Currently {C:attention}+0{C:inactive} slots){}"
		],
		image_url: "site/img/tile039.png",
		rarity: "Uncommon"
	},
	{
		name: 'Thanx',
		text: [
			"Destroy all scored",
			"{C:attention}face{} cards"
		],
		image_url: "site/img/tile043.png",
		rarity: "Common"
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
		image_url: "site/img/tile044.png",
		rarity: "Common"
	},
	{
		name: 'LIVE!',
		text: [
			"After destroying {C:attention}4{} more",
			"cards, all scoring cards in",
			"your next played hand become {C:dark_edition}Holographic{}"
		],
		image_url: "site/img/tile045.png",
		rarity: "Rare"
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