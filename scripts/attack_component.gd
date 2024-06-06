extends Node2D
enum Tags  {MELEE, ATTACK, SPELL, PROJECTILE, FIRE,ICE,LIGHTNING,POISON, AREA} 
@export var speed = 1
@export var base_damage = 1
@export var cooldown = $CooldownTimer




var tags = [Tags.PROJECTILE, Tags.FIRE]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cooldown_timer_timeout():
	use_ability()
	
func use_ability():
	 # Replace with function body.
	pass
