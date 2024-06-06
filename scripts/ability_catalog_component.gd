extends Node2D


var ability_list = []
var melee_target = Vector2.ZERO
var ranged_target = Vector2.ZERO
var parent = get_parent()
signal melee_attack_ready
# Called when the node enters the scene tree for the first time.
func _ready():
	## create a new sword_attack instance, add it as a child and use its execute function
	pass
	
	#ability_list.append(sword_attack)
	#ability_list.append(projectile)
	##isntantiate all abilities and use their contained execute() function
	#for ability in ability_list:
		#var current_ability = ability.new() 
		#add_child(current_ability)
		#Events.melee_attack_ready.emit()
		#current_ability.execute(self, melee_target)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func get_abilities():
	return ability_list


func _on_sword_attack_timer_timeout():
	# Replace with function body.
	
	Events.melee_attack_ready.emit()

	
func set_melee_target(new_target):
	melee_target = new_target
func set_ranged_target(new_target):
	ranged_target = new_target
	


func _on_projectile_timer_timeout():
	# var ability = projectile.instantiate() 
	# Events.projectile_ready.emit()
	# ability.target = ranged_target
	# add_child(ability)
	pass
func add_new_ability(ability_name): 
	print ("res://" + ability_name + ".tscn")
	var ability = load("res://" + ability_name + ".tscn")
	var new_ability = ability.instantiate()
	var caster = get_parent()
	melee_attack_ready.emit()
	new_ability.global_position = caster.global_position
	
	var grandparent = caster.get_parent()
	grandparent.add_child(new_ability)
	new_ability.execute(caster, melee_target)
	ability_list.append(new_ability)
