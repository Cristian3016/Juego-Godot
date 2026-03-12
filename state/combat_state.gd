class_name CombatState
extends Resource

signal health_changed(health : Health, new : int, amount : int)
signal player_deaths_changed(count : int)
signal enemies_died_changed(count  : int)
signal game_over
signal level_complete

@export var total_enemies : int = 0

@export var player_deaths : int = 0 :
	set(value):
		if player_deaths == value:
			return
			
		player_deaths = value
		player_deaths_changed.emit(player_deaths)
		
@export var enemies_died : int = 0 :
	set(value):
		if enemies_died == value:
			return
			
		enemies_died = value
		enemies_died_changed.emit(enemies_died)

func report_death(p_node : Node):
	var types : Array[GameObjectType] = p_node.stats.types
	
	var handled = false
	
	if types.has(GlobalObjectTypes.enemy):

		if p_node.has_meta("death_reported"):
			return
		p_node.set_meta("death_reported", true)

		enemies_died += 1
		ArcadeManager.add_score(100)

		if enemies_died >= total_enemies:
			level_complete.emit()

		handled = true

	elif types.has(GlobalObjectTypes.player):
		player_deaths += 1
		handled = true
		game_over.emit()
		
	if not handled:
		push_warning("Tried to report death on node %s but no matching type was found" % p_node.name)
