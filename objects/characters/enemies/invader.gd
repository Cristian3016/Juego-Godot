class_name Invader
extends PlatformerCharacter2D

@export var projectile_scene : PackedScene
var player : Node2D = null
var player_detected := false

func _physics_process(delta):

	super._physics_process(delta)

	if player_detected and is_instance_valid(player):
		velocity.x = 0
		
		var dir = sign(player.global_position.x - global_position.x)
		if dir != 0:
			scale.x = dir

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("player"):
		player = body
		player_detected = true

		var timer = get_node_or_null("ShootTimer")
		if timer:
			timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = false
		player = null

		var timer = get_node_or_null("ShootTimer")
		if timer:
			timer.stop()
	
func _on_shoot_timer_timeout() -> void:

	if not is_instance_valid(self):
		return

	if not is_instance_valid(player) or not projectile_scene:
		return

	var parent = get_parent()
	if not is_instance_valid(parent):
		return

	var projectile = projectile_scene.instantiate()
	projectile.shooter = self
	projectile.global_position = $ShootPoint.global_position
	
	var dir = (player.global_position - $ShootPoint.global_position).normalized()
	projectile.launch(dir)
	
	parent.add_child(projectile)
