extends RichTextLabel

@export var rootlevel: Level

func _ready() -> void:
	rootlevel.score_update.connect(update_text)
	update_text()

func update_text():
	self.text = "Current Score: " +str(rootlevel.current_score)
