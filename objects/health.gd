class_name Health
extends Node2D

signal is_alive_changed(value : bool)
signal health_changed(new : int, amount : int)

@export var stats : ObjectStats
@export var combat_state : CombatState

var _current_health : int = 0

@export var current_health : int :
	set(value):
		if _current_health == value:
			return
		
		var old = _current_health
		_current_health = min(value, stats.max_health)
		var amount_changed = _current_health - old
		
		if ready_done:
			health_changed.emit(_current_health, amount_changed)
			combat_state.health_changed.emit(self, current_health, amount_changed)
	get:
		return _current_health
		
var is_alive = true :
	set(value):
		if value == is_alive:
			return
			
		is_alive = value
		is_alive_changed.emit(is_alive)
		
var ready_done = false 
		
func _ready():
	current_health = stats.max_health
	health_changed.connect(_on_health_changed)
	ready.connect(_on_ready)
	
func _on_health_changed(_p_new : int, _p_amount : int):
	is_alive = current_health > 0
	
func _on_ready():
	ready_done = true 
