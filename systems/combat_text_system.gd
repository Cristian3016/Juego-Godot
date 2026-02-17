class_name CombatTextSystem
extends Node
## Show text when health changed on objects in the game

@export var combat_state : CombatState :
	set(value):
		if is_instance_valid(combat_state):
			combat_state.health_changed.disconnect(_on_health_changed)
			
		combat_state = value
		
		if is_instance_valid(combat_state):
			combat_state.health_changed.connect(_on_health_changed)
			
@export var text_templace : PackedScene
@export var ui_parent : Control
			
func _on_health_changed(p_health : Health, p_new : int, p_amount : int):
	var text_instance : HealthChangedLabel = text_templace.instantiate()
	
	if not is_instance_valid(text_instance):
		push_error("Instanced a scene that is NOT a [HealthChangedLabel]")
		text_instance.free()
		return
		
	ui_parent.add_child(text_instance)
	var spawn_position = p_health.global_position
	text_instance.global_position = p_health.global_position
	text_instance.set_health_text(p_amount)
	
	
