@tool
class_name IsDeadCondition
extends ConditionLeaf

func tick(_p_actor: Node, blackboard: Blackboard):
	var is_dead = not blackboard.get_value(GlobalNames.keys.is_alive, true)
	
	if is_dead:
		return SUCCESS
	else:
		return FAILURE
