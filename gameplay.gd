extends Node

@export var combat_state : CombatState

@onready var level_music = $LevelMusic
@onready var ui = $CanvasLayer/UI
@onready var world = $World

func _ready() -> void:
	new_game()
	combat_state.total_enemies = get_tree().get_nodes_in_group("invader").size()
	combat_state.level_complete.connect(_on_level_complete)
	ui.get_node("Level2StartsUI").hide()

func new_game():
	combat_state.enemies_died = 0

func start_level_music():
	level_music.play()
	
func stop_level_music():
	level_music.stop()
	
func _on_level_complete():
	ui.get_node("LevelCompleteUI").visible = true

func change_level_music(path):
	level_music.stop()
	level_music.stream = load(path)
	level_music.play()

func change_to_level2():
	stop_level_music()
	ui.get_node("LevelCompleteUI").hide()
	load_level2()
	show_level2_ui()

func show_level2_ui():
	get_tree().paused = true

	var level1_ui = ui.get_node_or_null("Level1StartsUI")
	if level1_ui:
		level1_ui.hide()

	var level2_ui = ui.get_node_or_null("Level2StartsUI")
	if level2_ui:
		level2_ui.show()

		if level2_ui.has_node("IntroSFX"):
			level2_ui.get_node("IntroSFX").play()
func load_level2():

	if world.has_node("Level1"):
		world.get_node("Level1").queue_free()

	var level2 = preload("res://levels/level_2.tscn").instantiate()
	world.add_child(level2)

	change_level_music("res://audio/sound/sound main menu and levels/Level2Sound.ogg")
