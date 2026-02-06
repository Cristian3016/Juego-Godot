class_name ObjectStats
extends Resource
## Statistics about an object

@warning_ignore("unused_signal")
signal death

@export var max_health : int = 100
			
func _init() -> void:
	if not resource_local_to_scene:
		push_warning("Resource not local to scene %s" % resource_path)
