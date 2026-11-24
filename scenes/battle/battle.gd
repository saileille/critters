class_name BattleScene
extends Node2D

@export var critter1: Critter
@export var critter2: Critter

var _battle_over: bool:
	get:
		return critter1.is_alive and critter2.is_alive


func _ready() -> void:
	_simulate()


func _simulate() -> void:
	var turns: int = 0
	while !_battle_over:
		_simulate_round()
		turns += 1

	print(critter1.info() + "\n" + critter2.info())
	print("Turns: {0}".format([turns]))


func _simulate_round() -> void:
	var critter1_next: bool = _critter1_next()
	_simulate_turn(critter1_next)
	if !_battle_over:
		critter1_next = !critter1_next
		_simulate_turn(critter1_next)


func _simulate_turn(critter1_next: bool) -> void:
	if critter1_next:
		critter1.attack_opponent(critter2)
	else:
		critter2.attack_opponent(critter1)


func _critter1_next() -> bool:
	var likelihood: float = critter1._speed / float(critter1._speed + critter2._speed)
	if RandomExt.rand_float() < likelihood:
		return true
	else:
		return false
