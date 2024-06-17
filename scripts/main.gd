extends Node

var game_time = 0
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO send signal to hud to update xp?
	#Events.give_xp.connect(update_score)
	place_player()


func _physics_process(delta):
	pass
	
func place_player():
	$Player.position = $PlayerStart.position


func _on_game_timer_timeout():
	game_time +=1
	

func update_score(amount):
	score += amount
	$HUD.update_score_label(score)
