extends Label

func _process(_delta: float) -> void:
	self.text = "Bounces left: " + str(GameManager.ricochet_left)
