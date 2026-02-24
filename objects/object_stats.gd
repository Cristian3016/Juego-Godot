class_name ObjectStats
extends Resource
## Estadísticas sobre un objeto

@export var max_health : int = 100
@export var knockback_multiplier : float = 1.0

#func _init() -> void:
#	if not resource_local_to_scene:
#		push_warning("Resource not local to scene %s" % resource_path)
