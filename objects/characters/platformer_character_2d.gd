class_name PlatformerCharacter2D
extends CharacterBody2D

signal direction_changed(direction : Vector2)

@export var stats : CharacterStats
@export var sprite : CanvasItem
@export var health : Health :
	set(value):
		if is_instance_valid(health) and health.is_alive_changed.is_connected(_on_is_alive_changed):
			health.is_alive_changed.disconnect(_on_is_alive_changed)
			
		health = value
		
		if is_instance_valid(health):
			health.is_alive_changed.connect(_on_is_alive_changed)
			
@export var combat_state : CombatState

var _direction : Vector2

var direction : Vector2: 
	set(value):
		if _direction == value:
			return
		_direction = value
		direction_changed.emit(_direction)
	get:
		return _direction
		
func _ready() -> void:
	if stats and stats.types.is_empty():
		push_warning("No game object type assigned to %s stats." % name)

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	move_and_slide()

## Intenta hacer que el personaje salte si está en el suelo
func try_jump() -> bool:	 
	if stats and stats.can_ground_jump and is_on_floor():
		_jump()
		return true
	return false

## Aplica el salto al personaje
func _jump():
	if stats:
		velocity.y = -stats.jump_force  

## Aplica la gravedad
var gravity = ProjectSettings.get("physics/2d/default_gravity")

func _apply_gravity(delta : float):
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_is_alive_changed(p_is_alive : bool):
	if not p_is_alive and combat_state:
		combat_state.report_death(self)
