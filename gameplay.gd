class_name Gameplay
extends Node

@export var combat_state : CombatState

@onready var level_music = $LevelMusic
@onready var ui = $CanvasLayer/UI
@onready var world = $World
@onready var pause_ui = $CanvasLayer/UI/PauseUI

const LEVEL_2 = preload("res://levels/level_2.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if not combat_state:
		push_error("combat_state no asignado")
		return

	if not ui:
		push_error("UI no encontrada")
		return

	await get_tree().process_frame

	combat_state.total_enemies = get_tree().get_nodes_in_group("invader").size()

	if not combat_state.level_complete.is_connected(_on_level_complete):
		combat_state.level_complete.connect(_on_level_complete)

	var level2_ui = ui.get_node_or_null("Level2StartsUI")
	if level2_ui:
		level2_ui.hide()
		
	pause_ui.hide_pause()
	
var is_game_started = false
	
func _unhandled_input(event: InputEvent) -> void:
	if not is_game_started:
		return
		
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause():
	var paused = !get_tree().paused
	get_tree().paused = paused

	if paused:
		pause_ui.show_pause()
	else:
		pause_ui.hide_pause()
		
func new_game():
	combat_state.enemies_died = 0
	combat_state.player_deaths = 0

func start_level_music():
	level_music.play()
	
func stop_level_music():
	level_music.stop()
	
func _on_level_complete():
	var level_complete = ui.get_node_or_null("LevelCompleteUI")
	if level_complete:
		level_complete.visible = true

func change_level_music(path):
	level_music.stop()

	var audio = load(path)
	if audio:
		level_music.stream = audio
		level_music.play()
	else:
		push_error("No se pudo cargar audio: " + path)

func change_to_level2():
	stop_level_music()
	
	var level_complete = ui.get_node_or_null("LevelCompleteUI")
	if level_complete:
		level_complete.hide()

	load_level2()
	show_level2_ui()

func show_level2_ui():
	get_tree().paused = true
	
	is_game_started = false

	var level1_ui = ui.get_node_or_null("Level1StartsUI")
	if level1_ui:
		level1_ui.hide()

	var level2_ui = ui.get_node_or_null("Level2StartsUI")
	if level2_ui:
		level2_ui.show()

		var sfx = level2_ui.get_node_or_null("IntroSFX")
		if sfx:
			sfx.play()

func load_level2():
	for child in world.get_children():
		child.queue_free()

	var level2 = LEVEL_2.instantiate()
	world.add_child(level2)
