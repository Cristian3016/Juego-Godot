class_name HealthChangedLabel
extends Label

@export var game_colors : GameColors

func set_health_text(p_health_change : int):
	text = str(p_health_change)
	
	if p_health_change < 0:
		self.modulate = game_colors.negative_health
	else:
		self_modulate = game_colors.positive_health
