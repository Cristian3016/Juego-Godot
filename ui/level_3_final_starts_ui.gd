
class_name Level3FinalStartUI
extends Control


func _ready():
	hide()


func _on_start_button_pressed():
	# Detener sonido de introducción
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

		# Música exclusiva del Level 3 FINAL
		gameplay.change_level_music("res://audio/music main menu and levels/Level3_Funk_Pump.ogg")

		print("Música del Level 3 FINAL iniciada")
	else:
		push_warning("No se encontró Gameplay")
