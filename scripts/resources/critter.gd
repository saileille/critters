class_name Critter
extends Resource

@export var name: String
@export_range(1, 10, 1, "or_greater") var _attack: int = 1
@export_range(1, 10, 1, "or_greater") var defence: int = 1
@export_range(1, 10, 1, "or_greater") var speed: int = 1

var hp: int = 100

var is_alive: bool:
	get:
		return hp > 0


func _get_attack_power(card: Card) -> float:
	return float(_attack) * card._attack_modifier * 10

func info() -> String:
	return "{0}: {1} HP".format([name, hp])
