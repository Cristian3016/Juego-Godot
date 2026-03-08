extends Node

var lives := 3
var max_lives := 3
var continues := 2

func lose_life():
	lives -= 1
	print("Lives left: ", lives)

func can_restart():
	return lives > 0 or continues > 0

func can_continue():
	return continues > 0

func use_continue():
	if continues > 0:
		continues -= 1
		lives = max_lives
		print("Continue used! Lives:", lives, " Continues:", continues)
