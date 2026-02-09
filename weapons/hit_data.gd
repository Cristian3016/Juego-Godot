class_name HitData
extends Object
## Propiedades de datos relacionadas con cuando una hurtbox es golpeada por un movimiento, ataque o acción de una hitbox

## La hitbox que golpeó a la hurtbox con un movimiento o ataque
var hitbox             : Hitbox2D

## La hurtbox que recibe el movimiento o ataque
var hurtbox            : Hurtbox2D

## La cantidad de cambio de vida esperada en el objetivo
var amount             : int

## La cantidad real de cambio de vida que resultó en el objetivo
var actual_change      : int 

## La fuerza y ​​duración de un retroceso esperado en el personaje de la caja de daño  
var knockback : Knockback

func _init(p_hitbox : Hitbox2D, p_hurtbox : Hurtbox2D, p_weapon_stats : WeaponStats) -> void:
		hitbox = p_hitbox
		hurtbox = p_hurtbox
		amount = p_weapon_stats.damage
		
		if p_weapon_stats.knockback_stats:
			var hit_direction = hitbox.global_position.direction_to(hurtbox.global_position)
			knockback = Knockback.new(hit_direction,p_weapon_stats.knockback_stats)
