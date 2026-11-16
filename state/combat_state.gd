
class_name CombatState
extends Resource

signal health_changed(health : Health, new : int, amount : int)
signal player_deaths_changed(count : int)
signal enemies_died_changed(count : int)
signal game_over
signal level_complete

@export var total_enemies : int = 0

@export var player_deaths : int = 0:
	set(value):
		if player_deaths == value:
			return

		player_deaths = value
		player_deaths_changed.emit(player_deaths)


@export var enemies_died : int = 0:
	set(value):
		if enemies_died == value:
			return

		enemies_died = value
		enemies_died_changed.emit(enemies_died)


func report_death(p_node : Node):
	if not is_instance_valid(p_node):
		return

	# Evitar contar dos veces la misma muerte
	if p_node.has_meta("death_reported"):
		return

	p_node.set_meta("death_reported", true)

	var types : Array[GameObjectType] = p_node.stats.types

	if types.has(GlobalObjectTypes.enemy):

		enemies_died += 1

		# Puntos por enemigo
		ArcadeManager.add_score(200)

		print("Enemigos eliminados: ", enemies_died, "/", total_enemies)

		if total_enemies > 0 and enemies_died == total_enemies:
			print("LEVEL COMPLETE")
			level_complete.emit()

	elif types.has(GlobalObjectTypes.player):

		# Guardar la muerte en ArcadeManager
		ArcadeManager.total_player_deaths += 1

		# Actualizar el contador de CombatState y el HUD
		player_deaths = ArcadeManager.total_player_deaths

		# Descontar una vida
		ArcadeManager.lose_life()

		print("Player Deaths: ", player_deaths)
		print("Vidas restantes: ", ArcadeManager.lives)

		game_over.emit()

	else:
		push_warning(
			"Tried to report death on node %s but no matching type was found" % p_node.name)
