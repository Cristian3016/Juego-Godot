class_name Hitbox2D
extends Area2D
## Area where on enter, can do damage to a hurtbox 

signal hit(hit_data : HitData)

@export var weapon_stats : WeaponStats

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(p_area : Area2D) -> void:
	var hurtbox = p_area as Hurtbox2D
	
	if not hurtbox || not hurtbox.get_hittable():
		return
		
	var hit_data = HitData.new(self, hurtbox, weapon_stats.damage)
	var dealt = hurtbox.hit(hit_data)
	hit.emit(hit_data)


	
