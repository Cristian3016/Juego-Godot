class_name Shooter 
extends RayCast2D
##Lanza proyectiles cuando try_shoot es llamado exitosamente.

@export var fireable : Fireable

@export var default_direction := Vector2.RIGHT

var projectiles_parent : Node

func _ready() -> void:
	projectiles_parent = get_tree().get_first_node_in_group(GlobalNames.gruops.projectiles_parent_group)
	assert(projectiles_parent != null, "Projectiles node is required for this script to work.")
	
func try_shoot() -> bool:
	if not is_colliding():
		_shoot()
		return true
		
	return false
		
func _shoot():
	var projectile = fireable.scene.instantiate() as Projectile
	projectiles_parent.add_child(projectile)
	projectile.name = fireable.display_name
	projectile.global_position = global_position
	
	# Quita la dirección predeterminada del tirador y gira la dirección del
	# vector a la misma dirección en la que apunta el cursor del ratón, de modo que
	# el proyectil se lanza en la dirección del cursor.
	
	var launch_direction = -default_direction.rotated(global_rotation)
	projectile.launch(launch_direction)

	
