extends Area2D

@export var heal_amount := 20
	
func _on_body_entered(body: Node2D) -> void:
	print("colision con:", body.name)

	if body.is_in_group("player"):

		var health = body.get_node_or_null("Health")

		if health:
			health.current_health += heal_amount

		$CollisionShape2D.set_deferred("disabled", true)
		visible = false
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished

		queue_free()
