class_name Player
extends PlatformerCharacter2D

func _physics_process(delta: float) -> void:
	velocity.x = stats.walk_speed * direction.x
	super(delta)
