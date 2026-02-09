class_name PlayHitAction
extends ActionLeaf

@export var sprite : AnimatedSprite2D
@onready var hit_timer: Timer = Timer.new() 
		
var is_playing = false
var hit_data : HitData

func _ready() -> void:
	add_child(hit_timer)
	hit_timer.timeout.connect(_on_timeout)

func before_run(p_actor: Node, p_blackboard: Blackboard) -> void:
	hit_data = p_blackboard.get_value(GlobalNames.keys.hit_data)
	assert(is_instance_valid(hit_data), "Hit data must be set for the play hit action to run")
	
	if hit_data.knockback.duration > 0.0:
		sprite.play(GlobalNames.animations.hit)
		hit_timer.start(hit_data.knockback.duration)
		is_playing = true
	else:
		is_playing = false	

func after_run(p_actor: Node, p_blackboard: Blackboard) -> void:
	hit_timer.stop()
	p_blackboard.set_value(GlobalNames.keys.hit_data, null)

func tick(_p_actor: Node, _p_blackboard: Blackboard) -> int:
	if is_playing:
		return RUNNING
	else:
		return SUCCESS
		
func _on_timeout() -> void:
	is_playing = false
