class_name Knockback
extends Object

var direction : Vector2
var force_vector : Vector2
var stats : KnockbackStats
var body : PhysicsBody2D 

func _init(p_physics_body : PhysicsBody2D,p_direction : Vector2, p_knockback_stats : KnockbackStats) -> void:
	body = p_physics_body
	direction = p_direction
	stats = p_knockback_stats
	force_vector = calculate_force_vector()

func calculate_force_vector() -> Vector2:
	var adjusted_direction = direction
	
	if body is CharacterBody2D and body.is_on_floor():
		var sign_x = sign(direction.x)
		
		if sign_x == 1:
			adjusted_direction = Vector2.RIGHT
		elif sign_x == -1:
			adjusted_direction = Vector2.LEFT
			
	var force_vector = adjusted_direction * stats.force
	
	
	
	return force_vector
