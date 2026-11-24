class_name Critter
extends Resource

## The default critter sprite.
static var DEFAULT_SPRITE: Texture2D = preload("uid://cuirshtlt8tfc")

@export var name: String
@export var sprite: Texture2D
@export_range(1, 10, 1, "or_greater") var _attack: int = 1
@export_range(1, 10, 1, "or_greater") var defence: int = 1
@export_range(1, 10, 1, "or_greater") var speed: int = 1

var max_hp: int = 100
var hp: int = max_hp

var is_alive: bool:
	get:
		return hp > 0


func _get_attack_power(card: Card) -> float:
	return float(_attack) * card._attack_modifier * 10


func info() -> String:
	return "{0}: {1} HP".format([name, hp])
