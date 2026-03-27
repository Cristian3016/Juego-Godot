class_name LevelStartsUI
extends Control

@onready var label = $RichTextLabel
@onready var intro_sfx = $IntroSFX

func _ready():
	get_tree().paused = true
	
	label.bbcode_text = "[center][outline_size=8][outline_color=black][color=#ff1a1a]LEVEL 1[/color][/outline_color][/outline_size]\nDead Sector Facility[/center]"
	
	intro_sfx.play()

func _on_start_button_pressed():
	intro_sfx.stop()

	get_tree().paused = false
	
	var gameplay = get_tree().get_first_node_in_group("gameplay")
	gameplay.is_game_started = true
	gameplay.pause_ui.hide_pause()
	gameplay.start_level_music()
	
	queue_free()
