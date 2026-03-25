extends Button

@export_file() var menu_scene : String :
	set(value):
		if value == null:
			return
			
		menu_scene = value

@export var audio_player : AudioStreamPlayer


func _ready() -> void:
	pressed.connect(_on_pressed)

	if not menu_scene:
		push_error("No menu scene set on loading [ExitGameButton]")


func _on_pressed():
	if audio_player:
		audio_player.play()
	var arcade = get_tree().get_first_node_in_group("arcade_manager")
	if arcade:
		arcade.reset_game()

	var gameplay = get_tree().get_first_node_in_group("gameplay")
	if gameplay:
		gameplay.new_game()

	get_tree().change_scene_to_file(menu_scene)
