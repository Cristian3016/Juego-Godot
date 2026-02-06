class_name ObjectSprite2D
extends AnimatedSprite2D

@export var stats : CharacterStats ## :
	# set(value):
		#if is_instance_valid(stats):
		#	stats.death.disconnect(_on_death)
			
		#stats = value
		
		#if is_instance_valid(stats):
		#	stats.death.connect(_on_death)	
			
@export var animation_names : AnimationNames

func _ready() -> void:
	if not stats:
		push_warning("[stats] must be assigned in %s" % name)
		
	if not animation_names:
		push_warning("[animation_names] must be assigned in %s" % name)
			
func _on_death():
	play(animation_names.death)
