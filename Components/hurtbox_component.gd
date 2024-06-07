extends Node2D
@export var collision_area: Node2D
@export var health_component: Node2D
@onready var enemy = get_parent()
signal change_health
signal knock_back

var collision_count

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass	
	
func handle_hit(hit):
	change_health.emit(hit)
	knock_back.emit()
		

	
