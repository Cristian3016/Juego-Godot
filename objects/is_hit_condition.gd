class_name IsHitCondition
extends ConditionLeaf

@export var keys : BlackboardKeys

func tick(p_actor: Node, p_blackboard: Blackboard):
	var is_hit = p_blackboard.get_value(keys.is_hit, false)
	
	if is_hit:
		return SUCCESS
	else:
		return FAILURE
