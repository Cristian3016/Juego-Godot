extends Control

func _ready():
	hide()

func _on_start_button_pressed():

	if has_node("IntroSFX"):
		$IntroSFX.stop()

	hide()

	get_tree().paused = false

	get_node("/root/Gameplay").start_level_music()
