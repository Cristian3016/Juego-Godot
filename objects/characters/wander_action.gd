class_name WanterAction
extends ActionLeaf
## Randoly move character left and right after as set timer
@export var timer : Timer

@onready var random_gen = RandomNumberGenerator.new()
var character : PlatformerCharacter2D

func before_run(p_actor: Node, blackboard: Blackboard) -> void:
	character= p_actor as PlatformerCharacter2D
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	randomizer_wandering()

func tick(p_actor: Node, blackboard: Blackboard) -> int:
		return RUNNING
		
func randomizer_wandering():
	var randi = random_gen.randi()
	
	if randi % 2 == 1:
		character.direction = Vector2.LEFT
	else:
		character.direction = Vector2.RIGHT
	
	character.velocity = character.direction * character.stats.walk_speed
		
func _on_timer_timeout():
	randomizer_wandering() 
	timer.start()
