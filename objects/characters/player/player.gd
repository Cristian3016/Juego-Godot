class_name Player
extends PlatformerCharacter2D

func _physics_process(delta: float) -> void:
	walk()
	super._physics_process(delta)

func walk():
	if stats:

		var current_speed = stats.walk_speed

		if Input.is_action_pressed("run"):
			current_speed = stats.run_speed

		if direction.x != 0:
			velocity.x = current_speed * direction.x
		else:
			velocity.x = 0
