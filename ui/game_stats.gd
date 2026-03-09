extends Panel

@export var combat_state : CombatState :
	set(value):
		if is_instance_valid(combat_state):
			combat_state.enemies_died_changed.disconnect(_on_enemies_died_changed)
			combat_state.player_deaths_changed.disconnect(_on_player_deaths_changed)
			
		combat_state = value
		 
		if is_instance_valid(combat_state):
			combat_state.enemies_died_changed.connect(_on_enemies_died_changed)
			combat_state.player_deaths_changed.connect(_on_player_deaths_changed)

@export var enemies_slain_label : Label
@export var player_deaths_label : Label
@export var lives_container : HBoxContainer
@export var continues_label : Label
@export var texture_2d : Texture2D
@export var score_label : Label

func _ready():
	set_enemies_slain_label(combat_state.enemies_died)
	set_player_deaths_label(combat_state.player_deaths)
	update_lives(ArcadeManager.lives)
	set_continues_label(ArcadeManager.continues)
	set_score()

	ArcadeManager.score_changed.connect(_on_score_changed)

func set_enemies_slain_label(p_new_count : int):
	enemies_slain_label.text = "Enemies Slain: %d" % p_new_count

func set_player_deaths_label(p_new_count : int):
	player_deaths_label.text = "Player Deaths: %d" % p_new_count

func set_continues_label(p_new_count : int):
	continues_label.text = "Continues: %d" % p_new_count

func set_score():
	score_label.text = "Score: %d" % ArcadeManager.score

func update_lives(p_lives:int):

	for child in lives_container.get_children():
		child.queue_free()
	for i in p_lives:
		var heart = TextureRect.new()
		heart.texture = texture_2d
		heart.custom_minimum_size = Vector2(32,32)
		lives_container.add_child(heart)

func _on_score_changed(new_score):
	score_label.text = "Score: %d" % new_score
	
func _on_enemies_died_changed(p_new_count):
	set_enemies_slain_label(p_new_count)
		
func _on_player_deaths_changed(p_new_count):
	set_player_deaths_label(p_new_count)
