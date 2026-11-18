class_name MissionCompleteUI
extends Control


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	ArcadeManager.reset_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

@onready var score_label: Label = $ScoreLabel
@onready var lives_label: Label = $LivesLabel
@onready var deaths_label: Label = $DeathsLabel
@onready var enemies_label: Label = $EnemiesLabel


func update_score() -> void:
	score_label.text = "FINAL SCORE: %d" % ArcadeManager.score


func update_lives() -> void:
	lives_label.text = "LIVES LEFT: %d" % ArcadeManager.lives


func update_deaths() -> void:
	deaths_label.text = "PLAYER DEATHS: %d" % ArcadeManager.total_player_deaths


func update_enemies(total_enemies: int) -> void:
	enemies_label.text = "ENEMIES SLAIN: %d" % total_enemies
