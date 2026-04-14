extends Node2D
class_name Level

@export var starting_lives: int = 5
@export var autoplay_music: bool = false
@export var music_to_play: MusicManager.available_songs
@export var killbox: Killbox
@export var gutters: Gutters

var current_lives: int

func _ready() -> void:
	game_start()
	killbox.life_lost.connect(_on_life_lost)
	current_lives = starting_lives
	pass

func game_start():
	MusicManager.play_track(music_to_play)
	GameManager.reset_level()	
	
#called by the killbox
func _on_life_lost():
	current_lives -= 1
	gutters.spawn_block_gutter()
	print("current lives: " +str(current_lives))
	if current_lives <= 0:
		out_of_lives()

func out_of_lives():
	GameManager.emit_on_game_lose()
	print_debug("rip bozo")
	pass
