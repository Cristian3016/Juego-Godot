class_name Gameplay
extends Node

@export var combat_state : CombatState

@onready var level_music = $LevelMusic
@onready var ui = $CanvasLayer/UI
@onready var world = $World
@onready var pause_ui = $CanvasLayer/UI/PauseUI

const LEVEL_2 = preload("res://levels/level_2.tscn")
const LEVEL_3 = preload("res://levels/level_3_final.tscn")

var is_game_started = false
var changing_level = false
var current_level = 1
var total_enemies_slain := 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	if not combat_state:
		push_error("combat_state no asignado")
		return

	if not ui:
		push_error("UI no encontrada")
		return


	combat_state.enemies_died = 0


	combat_state.player_deaths = ArcadeManager.total_player_deaths

	if ArcadeManager.reset_deaths_on_continue:
		ArcadeManager.reset_deaths_on_continue = false

	await get_tree().process_frame


	combat_state.total_enemies = get_tree().get_nodes_in_group("invader").size()

	if not combat_state.level_complete.is_connected(_on_level_complete):
		combat_state.level_complete.connect(_on_level_complete)

	var level2_ui = ui.get_node_or_null("Level2StartsUI")
	if level2_ui:
		level2_ui.hide()

	var level3_ui = ui.get_node_or_null("Level3FinalStartsUI")
	if level3_ui:
		level3_ui.hide()

	pause_ui.hide_pause()


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
	ArcadeManager.total_player_deaths = 0
	combat_state.player_deaths = 0
	combat_state.enemies_died = 0


func start_level_music():
	level_music.play()


func stop_level_music():
	level_music.stop()


func _on_level_complete():
	if changing_level:
		return

	if combat_state.total_enemies <= 0:
		return

	if combat_state.enemies_died < combat_state.total_enemies:
		return


	if current_level == 3:


		stop_level_music()


		var mission_ui = ui.get_node_or_null("MissionCompleteUI")

		if mission_ui:

			mission_ui.update_score()
			mission_ui.update_lives()
			mission_ui.update_deaths()


			mission_ui.update_enemies(
				total_enemies_slain + combat_state.enemies_died
			)


			mission_ui.show()


			is_game_started = false
			get_tree().paused = true

		else:
			push_error("No se encontró MissionCompleteUI")

		return


	var level_complete = ui.get_node_or_null("LevelCompleteUI")
	if level_complete:
		level_complete.show()


func change_level_music(path):

	if not ResourceLoader.exists(path):
		push_error("La canción no existe: " + path)
		return

	var audio = load(path) as AudioStream

	if audio == null:
		push_error("El archivo no es un AudioStream válido")
		return

	level_music.stop()
	level_music.stream = audio
	level_music.play()


func change_to_next_level():
	if changing_level:
		return

	if current_level >= 3:
		return

	changing_level = true
	is_game_started = false

	stop_level_music()

	var level_complete = ui.get_node_or_null("LevelCompleteUI")
	if level_complete:
		level_complete.hide()

	if current_level == 1:
		await load_level2()
		show_level2_ui()

	elif current_level == 2:
		await load_level3()
		show_level3_ui()

	changing_level = false


func change_to_level2():
	await change_to_next_level()


func change_to_level3():
	if current_level == 2:
		await change_to_next_level()


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


func show_level3_ui():
	get_tree().paused = true
	is_game_started = false

	var level2_ui = ui.get_node_or_null("Level2StartsUI")
	if level2_ui:
		level2_ui.hide()

	var level3_ui = ui.get_node_or_null("Level3FinalStartsUI")
	if level3_ui:
		level3_ui.show()

		var sfx = level3_ui.get_node_or_null("IntroSFX")
		if sfx:
			sfx.play()
	else:
		push_warning("No se encontró Level3FinalStartsUI")


func load_level2():
	await load_level_scene(LEVEL_2, 2)


func load_level3():
	await load_level_scene(LEVEL_3, 3)


func load_level_scene(level_scene: PackedScene, level_number: int):
	var saved_hp := -1
	var old_health = get_tree().get_first_node_in_group("player_health") as Health

	if old_health:
		saved_hp = old_health.current_health
	else:
		push_warning("No se encontró Health del nivel anterior")


	total_enemies_slain += combat_state.enemies_died


	combat_state.total_enemies = 0

	for child in world.get_children():
		child.queue_free()

	await get_tree().process_frame

	combat_state.enemies_died = 0


	var new_level = level_scene.instantiate()
	world.add_child(new_level)

	await get_tree().process_frame


	var new_health = get_tree().get_first_node_in_group("player_health") as Health

	if new_health:
		if saved_hp >= 0:
			new_health.current_health = clampi(
				saved_hp,
				0,
				new_health.stats.max_health
			)

	else:
		push_warning("No se encontró Health del nuevo nivel")


	current_level = level_number


	combat_state.total_enemies = get_tree().get_nodes_in_group("invader").size()


	refresh_level2_hud()


func refresh_level2_hud():
	var game_stats = ui.get_node_or_null("GameStats")

	if game_stats == null:
		push_warning("No se encontró GameStats dentro de UI")
		return

	if game_stats.has_method("refresh_player_health"):
		game_stats.refresh_player_health()
	else:
		push_warning("GameStats no tiene refresh_player_health()")


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed or event.echo:
			return

		if changing_level:
			return


		if event.keycode == KEY_F2 and current_level == 1:
			change_to_next_level()


		elif event.keycode == KEY_F3 and current_level == 2:
			change_to_next_level()
