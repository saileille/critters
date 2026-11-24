class_name TrainerBattleState

static var INITIAL_HAND_SIZE: int = 5
static var MAX_HAND_SIZE: int = 5
static var NEW_CARDS_PER_TURN: int = 1

var trainer: Trainer
var _critters: Array[CritterBattleState]

var _team: int

var _card_hand: Array[Card]
var _draw_pile: Array[Card]

## Get critters that can act right now.
var available_critters: Array[CritterBattleState]:
	get:
		var available: Array[CritterBattleState] = _critters.filter(func(c: CritterBattleState) -> bool:
			return !_card_hand.is_empty() and c.critter.is_alive and c.is_ready
		)
		return available

## The critters in party that are alive at the moment.
var alive_critters: Array[CritterBattleState]:
	get:
		var alive: Array[CritterBattleState] = _critters.filter(func(c: CritterBattleState) -> bool:
			return c.critter.is_alive
		)
		return alive


static func create(t: Trainer, team: int) -> TrainerBattleState:
	var battle_state: TrainerBattleState = TrainerBattleState.new()
	battle_state._initialise(t, team)
	return battle_state


func _initialise(t: Trainer, team: int) -> void:
	trainer = t
	_team = team
	
	for critter: Critter in t.critters:
		_critters.append(CritterBattleState.create(critter, team))
	
	_draw_pile = trainer.cards.duplicate()
	for n: int in range(0, INITIAL_HAND_SIZE):
		_draw_card()


## Choose a card to use for this critter.
func choose_card(_critter: CritterBattleState) -> Card:
	var card: Card = _card_hand.pop_at(randi_range(0, _card_hand.size() - 1))
	assert(card != null)
	return card


## Choose a hostile target for the given critter and card.
func choose_hostile_target(critter: CritterBattleState, _card: Card, critters: Array[CritterBattleState]) -> CritterBattleState:
	critters.shuffle()
	for c: CritterBattleState in critters:
		if c.critter.is_alive and c.team != critter.team:
			return c
	
	assert(false)
	return null


## Do stuff for the next turn.
func next_turn() -> void:
	for critter: CritterBattleState in _critters:
		critter.turn_cooldown -= 1
	
	var cards_drawn: int = 0
	while _card_hand.size() < MAX_HAND_SIZE and cards_drawn < NEW_CARDS_PER_TURN:
		_draw_card()
		cards_drawn += 1


func _draw_card() -> void:
	_card_hand.append(_draw_pile.pop_at(randi_range(0, _draw_pile.size() - 1)))
