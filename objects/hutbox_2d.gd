class_name Hurtbox2D
extends Area2D
## Where an object can take damage 

signal was_hit(damage_dealt : int)

## Stats of the active object that damage can be dealt to on hit 
@export var health : Health

func get_hittable() -> bool:
	return health.current_health > 0

func hit(p_damage : int ) -> int:
	var old = health.current_health
	health.current_health -= p_damage
	var damage_dealt = old - health.current_health
	was_hit.emit(damage_dealt)
	return damage_dealt 
	
