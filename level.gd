extends Node2D
class_name Level

func _ready() -> void:
	game_start()
	pass

func game_start():
	MusicManager.track_start()
	pass
