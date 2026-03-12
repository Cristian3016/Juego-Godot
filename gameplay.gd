extends Node

@export var combat_state : CombatState

@onready var level_music = $LevelMusic

func _ready() -> void:
	new_game()

	combat_state.total_enemies = get_tree().get_nodes_in_group("invader").size()
	combat_state.level_complete.connect(_on_level_complete)

func new_game():
	combat_state.enemies_died = 0

func start_level_music():
	level_music.play()

func _on_level_complete():
	$CanvasLayer/UI/LevelCompleteUI.visible = true
