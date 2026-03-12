extends Area2D

@export var heal_amount := 20
	
func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):

		var health = body.get_node_or_null("Health")

		if health:
			health.current_health += heal_amount

		$CollisionShape2D.set_deferred("disabled", true)
		visible = false
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished

		queue_free()
