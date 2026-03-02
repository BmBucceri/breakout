extends Node2D
class_name Level

@export var autoplay_music: bool = false
@export var music_to_play: MusicManager.available_songs


func _ready() -> void:
	game_start()
	pass

func game_start():
	MusicManager.play_track(music_to_play)
	
