class_name Critter
extends Resource

@export var name: String
@export_range(1, 10, 1, "or_greater") var _attack: int
@export_range(1, 10, 1, "or_greater") var defence: int
@export_range(1, 10, 1, "or_greater") var speed: int

var hp: int = 100

var is_alive: bool:
	get:
		return hp > 0


func _get_attack_power(card: Card) -> float:
	return float(_attack) * card._attack_modifier * 10

func info() -> String:
	return "{0}: {1} HP".format([name, hp])
