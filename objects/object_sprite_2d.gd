class_name ObjectSprite2D
extends AnimatedSprite2D

@export var stats : CharacterStats


func _ready() -> void:
	if not stats:
		push_warning("[stats] must be assigned in %s" % name)


func _on_death():
	play(GlobalNames.animation.death)
