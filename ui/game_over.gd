extends Control

@export var visible_ui : Control
@export var animation_player : AnimationPlayer
@export var death_sound : AudioStreamPlayer

@export var combat_state : CombatState :
	set(value):
		if is_instance_valid(combat_state):
			combat_state.game_over.disconnect(_on_game_over)

		combat_state = value
		
		if is_instance_valid(combat_state):
			combat_state.game_over.connect(_on_game_over)

@onready var level_music = $"../../../LevelMusic"

func _ready() -> void:
	visible_ui.hide()

func _on_game_over():

	visible_ui.show()
	animation_player.play("show")

	level_music.stop()
	death_sound.play()
