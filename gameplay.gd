extends Node

@export var combat_state : CombatState

func _ready() -> void:
	new_game()

func new_game():
	combat_state.enemies_died = 0
