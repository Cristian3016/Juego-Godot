class_name Knockback
extends Object

var direction : Vector2
var stats : KnockbackStats

func _init(p_direction : Vector2, p_knockback_stats : KnockbackStats) -> void:
	direction = p_direction
	stats = p_knockback_stats

func get_force_vector() -> Vector2:
	var force_vector = direction * stats.force
	return force_vector
