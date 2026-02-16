@tool
class_name PlayDeathAction
extends ActionLeaf
## Reproduce una animación de muerte y devuelve el éxito cuando termina.

var actor : Node 

func before_run(p_actor: Node, _p_blackboard: Blackboard) -> void:
	actor = p_actor
	actor.velocity = Vector2.ZERO
	actor.set_physics_process(false)
	actor.sprite.play(GlobalNames.animations.death)
	if not actor.sprite.animation_finished.is_connected(_on_animation_finished):
		actor.sprite.animation_finished.connect(_on_animation_finished)

func tick(_p_actor: Node, _blackboard: Blackboard) -> int:
	return RUNNING 
	
func _on_animation_finished():
	actor.queue_free()
