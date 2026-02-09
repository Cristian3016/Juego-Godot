extends ConditionLeaf

@export var keys : BlackboardKeys

func tick(p_actor: Node, p_blackboard: Blackboard):
	var hit_data = p_blackboard.get_value(GlobalNames.keys.hit_data) 
	
	if hit_data && hit_data.knockback:
		return SUCCESS
	else:
		return FAILURE
 
