extends RichTextLabel

func update_text():
	self.text = "Current Score: " +str(ScoreManager.current_score)


func _ready() -> void:
	update_text()
