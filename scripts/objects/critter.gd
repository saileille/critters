class_name Critter
extends Resource

@export var _name: String
@export var _attack: int
@export var _defence: int
@export var _speed: int
var _hp: int = 100

var is_alive: bool:
	get:
		return _hp > 0

static func _create(n: String, a: int, d: int) -> Critter:
	var critter: Critter = Critter.new()
	critter._name = n
	critter._attack = a
	critter._defence = d
	return critter

func attack_opponent(opponent: Critter) -> void:
	@warning_ignore("integer_division")
	opponent._hp -= _attack * 10 / opponent._defence

func info() -> String:
	return "{0}: {1} HP".format([_name, _hp])
