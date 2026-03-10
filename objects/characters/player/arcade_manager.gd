extends Node

signal score_changed(new_score)
signal lives_changed(new_lives)

var lives := 3
var max_lives := 5
var continues := 2
var score := 0

func add_score(point : int):
	score += point
	score_changed.emit(score)

func add_life():
	if lives < max_lives:
		lives += 1
		print("Nueva vida:", lives)
		lives_changed.emit(lives)

func lose_life():
	lives -= 1
	lives_changed.emit(lives)
	print("Lives left: ", lives)

func can_restart():
	return lives > 0 or continues > 0

func can_continue():
	return continues > 0

func use_continue():
	if continues > 0:
		continues -= 1
		lives = max_lives
		lives_changed.emit(lives)
		print("Continue used! Lives:", lives, " Continues:", continues)
