class_name PlatformerCharacter2D
extends CharacterBody2D

signal direction_changed(direction : Vector2)

@export var stats : CharacterStats
@export var sprite : CanvasItem

var direction : Vector2: 
	set(value):
		if direction == value:
			return
		direction = value
		direction_changed.emit(direction)

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	call_deferred(move_and_slide.get_method())
	move_and_slide()

## Intenta hacer que el personaje salte si está en el suelo
func try_jump() -> bool:	 
	if stats.can_ground_jump and is_on_floor():
		_jump()
		return true
	return false

## Aplica el salto al personaje
func _jump():
	velocity.y = -stats.jump_force  

## Aplica la gravedad
func _apply_gravity(delta : float):
	var gravity = ProjectSettings.get("physics/2d/default_gravity")
	if not is_on_floor():
		velocity.y += gravity * delta
		
