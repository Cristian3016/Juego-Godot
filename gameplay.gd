extends Node

@export var combat_state : CombatState

@onready var level_music = $LevelMusic

func _ready() -> void:
	new_game()

func new_game():
	combat_state.enemies_died = 0

func start_level_music():
	level_music.play()
