@tool
class_name IsHitCondition
extends ConditionLeaf

func tick(_actor: Node, p_blackboard: Blackboard) -> int:
	var hit_data = p_blackboard.get_value(GlobalNames.keys.hit_data)
	
	if hit_data:
		return SUCCESS
	else:
		return FAILURE
