class_name Invaderd
extends PlatformerCharacter2D

@export var projectile_scene : PackedScene
var player : Node2D = null
var player_detected := false

func _physics_process(delta):

	super._physics_process(delta)

	if player_detected:
		velocity.x = 0
		
		if player:
			var dir = sign(player.global_position.x - global_position.x)
			scale.x = dir
			print("Mirando hacia:", dir)

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		player = body
		player_detected = true
		$ShootTimer.start()
		print("Player detectado")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = false
		player = null
		$ShootTimer.stop()
		print("Player perdido")
	
func _on_shoot_timer_timeout() -> void:

	if player and projectile_scene:
			var projectile = projectile_scene.instantiate()
			projectile.shooter = self
			projectile.global_position = $ShootPoint.global_position
			var dir = (player.global_position - $ShootPoint.global_position).normalized()
			projectile.launch(dir)
			get_tree().current_scene.add_child(projectile)
