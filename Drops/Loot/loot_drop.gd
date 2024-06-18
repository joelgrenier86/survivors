extends Area2D
var loot_quality
var loot_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func generate_loot(enemy_drop_modifier):
	var random = randi_range(1,1000)
	#TODO create loot bundles for drop pools for different ranges
	loot_name = "fireball"
		
	


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.add_ability(loot_name)
