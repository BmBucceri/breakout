extends Label

func _process(delta: float) -> void:
	self.text = "Bounces left: " + str(GameManager.ricochet_left)
