class_name PlayHitAction
extends ActionLeaf

@export var sprite          : AnimatedSprite2D
@export var animation_names : AnimationNames
@export var blackboard_keys : BlackboardKeys

var is_playing = false 

func before_run(p_actor: Node, blackboard: Blackboard) -> void:
	sprite.play(animation_names.death)
	sprite.animation_finished.connect(_on_animation_finished)
	is_playing = true 

func tick(p_actor: Node, blackboard: Blackboard) -> int:
	if is_playing:
		return RUNNING
	else:
		blackboard.set_value(blackboard_keys.is_hit, false)
		return SUCCESS
	
func _on_animation_finished():
	is_playing = false 
	sprite.animation_finished.disconnect(_on_animation_finished)
