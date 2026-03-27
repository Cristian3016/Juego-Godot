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
		gameplay.is_game_started = true
		gameplay.pause_ui.hide_pause()
		
		gameplay.change_level_music("res://audio/sound/sound main menu and levels/Level2Sound.ogg")
