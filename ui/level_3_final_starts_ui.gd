
class_name Level3FinalStartUI
extends Control

@export_file("*.ogg") var level3_music_path: String = ""


func _ready():
	hide()


func _on_start_button_pressed():
	# Detener el sonido de introducción
	var sfx = get_node_or_null("IntroSFX")
	if sfx:
		sfx.stop()

	# Ocultar presentación
	hide()

	# Reanudar el juego
	get_tree().paused = false

	# Buscar Gameplay
	var gameplay = get_tree().get_first_node_in_group("gameplay")

	if gameplay:
		gameplay.is_game_started = true
		gameplay.pause_ui.hide_pause()

		# Reproducir música del Level 3
		if not level3_music_path.is_empty():
			gameplay.change_level_music(level3_music_path)
	else:
		push_warning("No se encontró Gameplay")
