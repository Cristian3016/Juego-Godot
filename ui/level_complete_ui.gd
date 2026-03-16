extends Control

@export var visible_ui : Control
@export var animation_player : AnimationPlayer
@export var combat_state : CombatState

func _ready():
	hide()
	combat_state.level_complete.connect(_on_level_complete)

func _on_level_complete():
	visible_ui.show()
	animation_player.play("show")

func _on_next_level_button_pressed() -> void:
	get_node("/root/Gameplay").change_to_level2()

	hide()
