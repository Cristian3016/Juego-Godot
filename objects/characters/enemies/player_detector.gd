extends Area2D

@export var blackboard : Blackboard
@export var keys : BlackboardKeys

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and blackboard.get_value(keys.target) == null:
		blackboard.set_value(keys.target, body)
		print("Jugador detectado")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		blackboard.erase_value(keys.target)
		print("Jugador salió")
