class_name IsDeadCondition
extends ConditionLeaf

@export var keys : BlackboardKeys

func tick(p_actor: Node, blackboard: Blackboard):
	var is_dead = not blackboard.get_value(keys.is_alive, true)
	
	if is_dead:
		return SUCCESS
	else:
		return FAILURE
