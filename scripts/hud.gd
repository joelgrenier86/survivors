extends CanvasLayer
var score = 0
var max_xp= 0
var current_xp = 0
var level = 1
func _ready():
	
	Events.set_max_xp.connect(set_max_xp)
	Events.update_xp_bar.connect(update_xp_bar)
	$ScoreLabel.text = 'score: %s' %str(score)
	$XpBar.value = 0
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)
	$XpBar/LevelText.text = "level: " + str(level)

func update_score_label(new_score):
	score = new_score
	$ScoreLabel.text = 'score: %s' %str(score)
func set_max_xp(new_max_xp, level):
	max_xp = new_max_xp
	$XpBar.max_value = max_xp
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)
	$XpBar/LevelText.text  = "level: " + str(level)
func update_xp_bar(new_xp):
	current_xp = new_xp
	$XpBar.value = current_xp
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)

