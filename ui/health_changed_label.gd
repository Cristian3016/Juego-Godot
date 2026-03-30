class_name HealthChangedLabel
extends Label

@export var timer : Timer
@export var move_speed = Vector2(0, -75)
@export var game_colors : GameColors

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
 		
func _process(delta: float) -> void:
	position += move_speed * delta
	
func set_health_text(p_health_change : int):

	if p_health_change == 1:
		text = "1UP!"
		self.modulate = game_colors.extra_life	

	elif p_health_change < 0:
		text = str(p_health_change)
		self.modulate = game_colors.negative_health	

	else:
		text = "+" + str(p_health_change)
		self.modulate = game_colors.positive_health
		
func set_score_text(points: int):
	text = "+" + str(points)
	self.modulate = game_colors.coin_color
		
func _on_timeout():
	queue_free()
