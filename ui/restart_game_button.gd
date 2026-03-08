extends Button

@export_file() var restart_scene : String
@export var audio_player : AudioStreamPlayer

func _ready() -> void:
	pressed.connect(_on_pressed)

	if not restart_scene:
		push_error("No restart scene set on loading [RestartGameButton]")

func _on_pressed():
	if not ArcadeManager.can_restart():
		print("No lives or continues left")
		return
		
	if ArcadeManager.lives <= 0:
		ArcadeManager.use_continue()

	if audio_player:
		audio_player.play()
		
	get_tree().change_scene_to_file(restart_scene)
