class_name Projectile
extends RigidBody2D
## Objeto en movimiento lanzado desde alguna fuente que puede colisionar con otros objetos dentro de la escena
@export var remove_on_hit : bool = true
@export_range(0, 300, .2, "or_greater") var initial_velocity : float = 300.0

var shooter : Node = null

@export var hitbox : Hitbox2D :
	set(value):
		if is_instance_valid(hitbox):
			hitbox.hit.disconnect(_on_hit)

		hitbox = value

		if is_instance_valid(hitbox):
			hitbox.hit.connect(_on_hit)

func launch(p_move_direction : Vector2):
	linear_velocity = initial_velocity * p_move_direction

func _on_hit(p_hit_data : HitData):
	var target = p_hit_data.hurtbox.get_parent()
	if target == shooter:
		return
	queue_free()
