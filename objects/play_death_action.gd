class_name PlayDeathAction
extends ActionLeaf

## Reproduce una animación de muerte y devuelve el éxito cuando termina.

var actor : Node 

func before_run(p_actor: Node, _p_blackboard: Blackboard) -> void:
	if Engine.is_editor_hint():
		return

	if not is_instance_valid(p_actor):
		return

	actor = p_actor

	actor.velocity = Vector2.ZERO
	actor.set_physics_process(false)

	if is_instance_valid(actor.sprite):
		actor.sprite.play(GlobalNames.animations.death)

		if not actor.sprite.animation_finished.is_connected(_on_animation_finished):
			actor.sprite.animation_finished.connect(_on_animation_finished)

func tick(_p_actor: Node, _blackboard: Blackboard) -> int:
	return RUNNING 
	
func _on_animation_finished():
	if not is_instance_valid(actor):
		return

	if is_instance_valid(actor.sprite):
		if actor.sprite.animation_finished.is_connected(_on_animation_finished):
			actor.sprite.animation_finished.disconnect(_on_animation_finished)

	if actor.combat_state:
		actor.combat_state.report_death(actor)

	actor.queue_free()
