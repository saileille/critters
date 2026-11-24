class_name BattleScene
extends Node2D

var critter1: CritterTest
var critter2: CritterTest

class CritterTest:
	var name: String
	var attack: int
	var defence: int
	var hp: int = 100
	
	var _is_alive: bool:
		get:
			return hp > 0
	
	static func _create(n: String, a: int, d: int) -> CritterTest:
		var critter: CritterTest = CritterTest.new()
		critter.name = n
		critter.attack = a
		critter.defence = d
		return critter
	
	func _attack(opponent: CritterTest) -> void:
		@warning_ignore("integer_division")
		opponent.hp -= attack * 10 / opponent.defence
	
	func _info() -> String:
		return "{0}: {1} HP".format([name, hp])


func _ready() -> void:
	critter1 = CritterTest._create("Squig", 2, 2)
	critter2 = CritterTest._create("Jooj", 1, 1)
	_simulate()


func _simulate() -> void:
	var turns: int = 0
	while critter1._is_alive and critter2._is_alive:
		critter1._attack(critter2)
		critter2._attack(critter1)
		turns += 1
	
	print(critter1._info() + "\n" + critter2._info())
	print("Turns: {0}".format([turns]))
