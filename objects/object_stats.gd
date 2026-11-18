class_name ObjectStats
extends Resource


@export var max_health : int = 150
@export var knockback_multiplier : float = 1.0
@export var types : Array[GameObjectType] :
	set(value):
		if value.is_empty():
			return

		types = value
