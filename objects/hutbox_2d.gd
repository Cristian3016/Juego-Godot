class_name Hurtbox2D
extends Area2D


signal was_hit(hit_data : HitData)


@export var health : Health
@export var body : CharacterBody2D
@export var invincible : bool
@export var hit_player : AudioStreamPlayer2D


func get_hittable() -> bool:
	return health.current_health > 0 && not invincible


func hit(p_hit_data : HitData) -> int:
	var old = health.current_health
	health.current_health -= p_hit_data.amount
	var actual_change = -1 * (old - health.current_health)
	p_hit_data.actual_change = -1 * actual_change
	was_hit.emit(p_hit_data)

	if hit_player:
		hit_player.play()
	return actual_change
