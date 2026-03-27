extends Control

@onready var label = $CenterContainer/PauseLabel
var blinking = false

func show_pause():
	visible = true
	start_blink()

func hide_pause():
	visible = false
	blinking = false
	label.visible = true

func start_blink():
	if blinking:
		return
	
	blinking = true
	
	while blinking:
		label.visible = !label.visible
		await get_tree().create_timer(0.5).timeout
