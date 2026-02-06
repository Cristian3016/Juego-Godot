class_name PlayDeathAction
extends ActionLeaf
## Plays a death animation and returns success when it is finished

@export var sprite : AnimatedSprite2D

var actor : Node 

func before_run(p_actor: Node, blackboard: Blackboard) -> void:
	actor = p_actor
	sprite.play(GlobalNames.animations.death)
	sprite.animation_finished.connect(_on_animation_finished)

func tick(p_actor: Node, blackboard: Blackboard) -> int:
	return RUNNING 
	
func _on_animation_finished():
	actor.queue_free()
