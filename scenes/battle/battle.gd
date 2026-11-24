class_name BattleScene
extends Node2D

@export var _trainers: Array[Trainer]

var teams: Array[TrainerBattleState]

var _battle_over: bool:
	get:
		for team: TrainerBattleState in teams:
			if !team.trainer.is_alive:
				return true
		return false


func _ready() -> void:
	for i: int in range(0, _trainers.size()):
		var trainer: Trainer = _trainers[i]
		for n: int in range(0, 40):
			trainer.cards.append(load("uid://bmf5nmclkkk18"))
		
		teams.append(TrainerBattleState.create(trainer, i))
	
	_simulate()


func _simulate() -> void:
	var turns: int = 0
	while !_battle_over:
		_simulate_round()
		turns += 1

	print("Turns: {0}".format([turns]))


func _simulate_round() -> void:
	while _active_critters():
		_simulate_turn()
	
	for team: TrainerBattleState in teams:
		team.next_turn()


## Simulate a single critter's action.
func _simulate_turn() -> void:
	var critter: CritterBattleState = _draw_next_acting_critter()
	var trainer: TrainerBattleState = teams[critter.team]
	var card: Card = trainer.choose_card(critter)
	var target: CritterBattleState = trainer.choose_hostile_target(critter, card, _alive_critters())
	
	critter.attack_opponent(target, card)


## Get all critters that can act.
func _active_critters() -> Array[CritterBattleState]:
	var critters: Array[CritterBattleState] = []
	for team: TrainerBattleState in teams:
		critters.append_array(team.available_critters)
	return critters


## Get all critters that are still alive.
func _alive_critters() -> Array[CritterBattleState]:
	var critters: Array[CritterBattleState] = []
	for team: TrainerBattleState in teams:
		critters.append_array(team.alive_critters)
	return critters


## Draw the next critter that acts.
func _draw_next_acting_critter() -> CritterBattleState:
	var critters: Array[CritterBattleState] = _active_critters()
	var speeds: PackedFloat32Array = critters.map(func(c: CritterBattleState) -> float:
		return c.critter.speed
	)
	
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	return critters[rng.rand_weighted(speeds)]
