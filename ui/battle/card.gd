class_name BattleCard
extends PanelContainer

@export var _name: RichTextLabel

var _card: Card


func initialise(card: Card) -> void:
	_card = card
	_name.text = card._name
