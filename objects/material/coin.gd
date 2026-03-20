extends Area2D

const HEALTH_LABEL_SCENE = preload("res://ui/health_changed_label.tscn")

@export var points := 100

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):

		ArcadeManager.add_score(points)

		var label = HEALTH_LABEL_SCENE.instantiate()
		label.set_score_text(points)
		label.global_position = global_position + Vector2(0, -10)
		get_tree().current_scene.add_child(label)

		$CollisionShape2D.set_deferred("disabled", true)
		visible = false
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished

		queue_free()
