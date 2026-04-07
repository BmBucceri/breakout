extends CanvasLayer

func _ready() -> void:
	GameManager.on_game_win.connect(reveal_game_win)
	self.hide()
	

func reveal_game_win():
	self.show()
