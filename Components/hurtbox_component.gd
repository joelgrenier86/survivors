extends Node2D
@export var collision_area: Node2D
@export var health_component: Node2D

signal change_health
signal knock_back

var collision_count

# Called when the node enters the scene tree for the first time.
func _ready():
	var type
	if is_in_group("enemies"):
		type = "enemy"
	elif is_in_group("player"):
		print ("player dmg")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass	
	
func handle_hit(hit):

	change_health.emit(hit)
	knock_back.emit()
		

	
