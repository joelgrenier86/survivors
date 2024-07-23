extends CanvasLayer
var score = 0
var max_xp= 0
var current_xp = 0
var level = 1
func _ready():
	Events.player_level_up.connect(player_level_up)
	Events.set_max_xp.connect(set_max_xp)
	Events.update_xp_bar.connect(update_xp_bar)
	Events.update_player_stats.connect(update_stat_labels)
	$ScoreLabel.text = 'score: %s' %str(score)
	$XpBar.value = 0
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)
	$XpBar/LevelText.text = "level: " + str(level)
	$SpeedLabel.text  = "Speed = 0"
	$CDRLabel.text = "CDR = 0"
func update_stat_labels(player_stats):
	if player_stats.has("speed"):
		$SpeedLabel.text  = "Speed = " + str(player_stats.speed.value)
	if player_stats.has("cooldown_reduction"):
		$CDRLabel.text = "CDR = " + str(player_stats.cooldown_reduction.value)
func update_score_label(new_score):
	score = new_score
	$ScoreLabel.text = 'score: %s' %str(score)
func set_max_xp(new_max_xp,new_current_xp):
	max_xp = new_max_xp
	$XpBar.max_value = max_xp
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)
	$XpBar/LevelText.text  = "level: " + str(level)
func update_xp_bar(new_current_xp):
	current_xp = new_current_xp
	$XpBar.value = current_xp
	$XpBar/ProgressText.text = str(current_xp) + "/" + str(max_xp)
func player_level_up(new_max_xp, new_current_xp, new_level):
	level = new_level
	set_max_xp(new_max_xp,new_current_xp)
	update_xp_bar(new_current_xp)
	$XpBar/LevelText.text = "level: " + str(level)
