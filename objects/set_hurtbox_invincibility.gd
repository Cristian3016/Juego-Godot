class_name SetHurtboxInvincibility
extends ActionLeaf

@export var hurtboxes  : Array[Hurtbox2D]
@export var invincible : bool

func before_run(_p_actor: Node, _p_blackboard: Blackboard) -> void:
	for hurtbox in hurtboxes:
		hurtbox.invincible = invincible
		
func tick(_p_actor: Node, _p_blackboard: Blackboard) -> int:
	return SUCCESS
