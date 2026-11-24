class_name Trainer
extends Resource

@export var _name: String

@export var critters: Array[Critter]

var cards: Array[Card]

var is_alive: bool:
	get:
		for critter: Critter in critters:
			if critter.is_alive:
				return true
		return false
