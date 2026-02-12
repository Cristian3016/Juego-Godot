@tool
class_name PlayDeathAction
extends ActionLeaf
## Reproduce una animación de muerte y devuelve el éxito cuando termina.

@export var sprite : AnimatedSprite2D

var actor : Node 

func before_run(p_actor: Node, _p_blackboard: Blackboard) -> void:
	actor = p_actor
	actor.velocity = Vector2.ZERO
	sprite.play(GlobalNames.animations.death)
	sprite.animation_finished.connect(_on_animation_finished)

func tick(_p_actor: Node, _blackboard: Blackboard) -> int:
	return RUNNING 
	
func _on_animation_finished():
	actor.queue_free()
