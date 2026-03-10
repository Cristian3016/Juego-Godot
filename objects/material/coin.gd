extends Area2D

@export var points := 50

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):

		ArcadeManager.add_score(points)

		$CollisionShape2D.set_deferred("disabled", true)
		visible = false

		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished

		queue_free()
