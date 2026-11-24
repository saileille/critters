class_name CritterBattleState

var critter: Critter

## The amount of time this [Critter] must wait for the next turn.
var turn_cooldown: int:
	set(value):
		turn_cooldown = max(0, value)

## Used to prevent friendly fire.
var team: int

var is_ready: bool:
	get:
		return turn_cooldown == 0


static func create(c: Critter, t: int) -> CritterBattleState:
	var battle_state: CritterBattleState = CritterBattleState.new()
	battle_state._initialise(c, t)
	return battle_state


func _initialise(c: Critter, t: int) -> void:
	critter = c
	team = t


func attack_opponent(opponent: CritterBattleState, card: Card) -> void:
	@warning_ignore("integer_division", "narrowing_conversion")
	var damage: float = critter._get_attack_power(card)
	
	damage=float(damage) * (100.0 / (100.0 + float(opponent.critter.defence)))

	opponent.critter.hp -= damage
	turn_cooldown += 1
	print("{0} attacks {1} with {2} damage. {1} has {3} HP left...".format([
		critter.name, opponent.critter.name, damage, opponent.critter.hp
	]))
