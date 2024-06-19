extends Node

var game_time = 0
var score = 0
var is_paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Events.toggle_pause.connect(toggle_pause)
	#Events.give_xp.connect(update_score)
	place_player()


func _physics_process(delta):
	pass
	
func place_player():
	$Player.position = $PlayerStart.position

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
func _on_game_timer_timeout():
	game_time +=1
	

func update_score(amount):
	score += amount
	$HUD.update_score_label(score)
