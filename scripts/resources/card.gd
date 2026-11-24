class_name Card
extends Resource

@export var _name: String
@export var _attack_modifier: float = 1.0


## Get all cards there are.
static func get_all() -> Array[Card]:
	var cards: Array[Card]
	for card: Card in ResourceCrawler.get_all("Card"):
		cards.append(card)
	return cards
