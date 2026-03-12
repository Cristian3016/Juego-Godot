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
