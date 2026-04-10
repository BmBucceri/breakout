extends RichTextLabel

func _process(_delta: float) -> void:
	update_speed()
	
func update_speed():
	self.text = "Speed: " +str(roundi(GameManager.ball_speed))
