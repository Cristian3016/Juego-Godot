class_name Level2StartUI
extends Control

func _ready():
	hide()

func _on_start_button_pressed():

	var sfx = get_node_or_null("IntroSFX")
	if sfx:
		sfx.stop()

	hide()

	get_tree().paused = false

	var gameplay = get_tree().get_first_node_in_group("gameplay")
	if gameplay:
		gameplay.start_level_music()
