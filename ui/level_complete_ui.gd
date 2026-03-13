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
	var world = get_tree().get_first_node_in_group("world")
	
	world.get_node("Level1").queue_free()
	
	var level2 = preload("res://levels/level_2.tscn").instantiate()
	world.add_child(level2)
	
	hide()
