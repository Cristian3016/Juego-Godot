extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		if ArcadeManager.lives < ArcadeManager.max_lives:
			ArcadeManager.add_life()
			
			$CollisionShape2D.set_deferred("disabled", true)
			$AudioStreamPlayer2D.play()
			visible = false
			
			await $AudioStreamPlayer2D.finished
			queue_free()
