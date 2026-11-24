class_name BattleCritterCard
extends PanelContainer

@export var _critter_name: RichTextLabel

var _critter: CritterBattleState


func initialise(c: CritterBattleState) -> void:
	_critter = c
	_critter_name.text = _critter.critter.name
