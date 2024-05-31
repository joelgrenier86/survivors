extends Node
@export var enemy_scene = preload("res://enemy.tscn")
var game_time = 0
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.score_points.connect(update_score)
	place_player()
	spawn_monsters()

func _physics_process(delta):
	pass
	
func place_player():
	$Player.position = $PlayerStart.position


func _on_game_timer_timeout():
	game_time +=1
	
func spawn_monsters():
	pass	
	#var enemy = enemy_scene.instantiate()
	#var spawn_point = $Player/EnemySpawnPath/EnemySpawnPoint
	#spawn_point.progress_ratio= randf()
	#enemy.position = spawn_point.position
#
	#add_child(enemy)


func _on_enemy_spawner_spawn_monsters(num):
	for i in range(0,num):
		var enemy = enemy_scene.instantiate()
		var spawn_point = $Player/EnemySpawnPath/EnemySpawnPoint
		spawn_point.progress_ratio= randf()
		enemy.position = spawn_point.position

		add_child(enemy)
func update_score(amount):
	score += amount
	$HUD.update_score_label(score)
