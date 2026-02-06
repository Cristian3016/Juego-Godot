class_name Hitbox2D
extends Area2D
## Area where on enter, can do damage to a hurtbox 

signal hit(target : Hurtbox2D, health_change : int)

@export var weapon_stats : WeaponStats

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(p_area : Area2D) -> void:
	var hurtbox = p_area as Hurtbox2D
	
	if not hurtbox || not hurtbox.get_hittable():
		return
		
	var dealt = hurtbox.hit(weapon_stats.damage)
	hit.emit(hurtbox, dealt)


	
