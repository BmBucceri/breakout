extends RichTextLabel

func _ready() -> void:
	ScoreManager.score_update.connect(update_text)
	update_text()
	
func update_text():
	self.text = "Current Score: " +str(ScoreManager.current_score)
