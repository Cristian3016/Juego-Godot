class_name HandAnchor
extends Node2D

## Rotates the node to face the mouse cursor

func _process(_delta: float) -> void:
	var cursor_position = get_global_mouse_position()
	var rotation_angle = global_position.angle_to_point(cursor_position)
	rotation = -rotation_angle
