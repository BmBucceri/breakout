extends CanvasLayer

func _ready() -> void:
	GameManager.on_game_win.connect(reveal_game_over)
	self.hide()
	

func reveal_game_over():
	self.show()
