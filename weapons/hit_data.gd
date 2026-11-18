class_name HitData
extends Object


var hitbox             : Hitbox2D


var hurtbox            : Hurtbox2D


var amount             : int


var actual_change      : int


var knockback : Knockback


func _init(p_hitbox : Hitbox2D, p_hurtbox : Hurtbox2D, p_weapon_stats : WeaponStats) -> void:
		hitbox = p_hitbox
		hurtbox = p_hurtbox
		amount = p_weapon_stats.damage

		if p_weapon_stats.knockback_stats:
			var hit_direction = hitbox.global_position.direction_to(hurtbox.body.global_position)
			knockback = Knockback.new(p_hurtbox.body,hit_direction,p_weapon_stats.knockback_stats)
