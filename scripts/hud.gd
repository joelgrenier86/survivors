extends CanvasLayer
var score = 0

func _ready():
	$ScoreLabel.text = 'score: %s' %str(score)
func update_score_label(new_score):
	score = new_score
	$ScoreLabel.text = 'score: %s' %str(score)
