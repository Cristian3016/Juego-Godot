class_name Player
extends PlatformerCharacter2D

func _physics_process(delta: float) -> void:
	walk()
	super._physics_process(delta)

func walk():
	if stats:
		if direction.x != 0:
			velocity.x = stats.walk_speed * direction.x
		else:
			velocity.x = 0
