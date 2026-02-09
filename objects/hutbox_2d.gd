class_name Hurtbox2D
extends Area2D
## Dónde puede sufrir daños un objeto

signal was_hit(hit_data : HitData)

## Estadísticas del objeto activo al que se le puede infligir daño al impactar 
@export var health : Health
@export var body : CharacterBody2D

func get_hittable() -> bool:
	return health.current_health > 0
	
## Cambia el valor de salud en el componente Salud, y
## agrega el valor de salud real a p_hit_data, a la cual
## devuelve la cantidad del valor real modificado.
func hit(p_hit_data : HitData) -> int:
	var old = health.current_health
	health.current_health -= p_hit_data.amount 
	var actual_change = -1 * (old - health.current_health)
	p_hit_data.actual_change = -1 * actual_change
	was_hit.emit(p_hit_data)
	return actual_change 
	
