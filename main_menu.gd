class_name MainMenu
extends Control

@export var gameplay_scene : PackedScene

func _on_start_game_button_pressed():
	get_tree().change_scene_to_packed(gameplay_scene)

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
