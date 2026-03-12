extends Node

const HEALTH_LABEL_SCENE = preload("res://ui/health_changed_label.tscn")

signal score_changed(new_score)
signal lives_changed(new_lives)

var coins := 0
var lives := 3
var max_lives := 5
var continues := 2
var score := 0
var next_life_score := 5000

func add_score(point : int):
	score += point

	if score >= next_life_score:
		add_life()
		next_life_score += 5000

	score_changed.emit(score)

func add_life():
	if lives < max_lives:
		lives += 1
		lives_changed.emit(lives)
		show_1up()

func lose_life():
	lives -= 1
	lives_changed.emit(lives)

func can_restart():
	return lives > 0 or continues > 0

func can_continue():
	return continues > 0

func use_continue():
	if continues > 0:
		continues -= 1		
		lives = 3
		lives_changed.emit(lives)
		score = 0
		next_life_score = 5000
		score_changed.emit(score)

func show_1up():
	var label = HEALTH_LABEL_SCENE.instantiate()
	label.set_health_text(1)

	var player = get_tree().get_first_node_in_group("player")

	if player:
		label.global_position = player.global_position + Vector2(0, -20)
		get_tree().current_scene.add_child(label)
