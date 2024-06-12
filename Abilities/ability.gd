extends Node2D
class_name Ability
@export var cooldown = 2.0
@export var damage = 1
var ability_index


signal deal_damage
signal cooldown_ready
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

