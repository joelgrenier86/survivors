extends Node

var game_time = 0
var score = 0
var is_paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Events.toggle_pause.connect(toggle_pause)
	Events.player_level_up.connect(open_loot_menu)
	#Events.give_xp.connect(update_score)
	place_player()
	open_loot_menu(0,9,9)


func _physics_process(delta):
	pass
	
func place_player():
	$Player.position = $PlayerStart.position

func toggle_pause():
	
	is_paused = !is_paused
	get_tree().paused = is_paused
func _on_game_timer_timeout():
	game_time +=1
	
func open_loot_menu(max_xp, current_xp, level):
	get_tree().paused = true
	var loot_select_menu = load("res://UI/loot_select_menu/loot_select_menu.tscn")
	var loot_select_menu_scene = loot_select_menu.instantiate()
	add_child(loot_select_menu_scene)
func update_score(amount):
	score += amount
	$HUD.update_score_label(score)
