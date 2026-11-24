class_name BattleUI
extends CanvasLayer

@onready var _player_name: RichTextLabel = %PlayerName
@onready var _opponent_name: RichTextLabel = %OpponentName
@onready var _player_critters: HBoxContainer = %PlayerCritters
@onready var _opponent_critters: HBoxContainer = %OpponentCritters
@onready var _cards: HBoxContainer = %Cards


func initialise(teams: Array[TrainerBattleState]) -> void:
	_player_name.text = teams[0].trainer._name
	_opponent_name.text = teams[1].trainer._name
	
	_populate_critters(_player_critters, teams[0])
	_populate_critters(_opponent_critters, teams[1])
	_populate_cards(teams[0])


func _populate_critters(hbox: HBoxContainer, team: TrainerBattleState) -> void:
	for critter: CritterBattleState in team._critters:
		var scene: PackedScene = load("uid://dj68h3ubpjebi")
		var critter_card: BattleCritterCard = scene.instantiate()
		critter_card.initialise(critter)
		hbox.add_child(critter_card)


func _populate_cards(team: TrainerBattleState) -> void:
	for card: Card in team._card_hand:
		var scene: PackedScene = load("uid://h71k0capt38r")
		var card_panel: BattleCard = scene.instantiate()
		card_panel.initialise(card)
		_cards.add_child(card_panel)
