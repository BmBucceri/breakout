extends Node2D
class_name Level

@export var score_target: int = 10
@export var starting_lives: int = 5
@export_category("Music")
@export var autoplay_music: bool = false
@export var music_to_play: MusicManager.available_songs
@export_group("References")
@export var killbox: Killbox
@export var gutters: Gutters

var current_lives: int
var current_score: float = 0
signal score_update
signal on_lives_changed(remaining: int)




func _ready() -> void:
	LevelManager.set_current_index()
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
	on_lives_changed.emit()
	gutters.spawn_block_gutter()
	print("current lives: " +str(current_lives))
	if current_lives <= 0:
		out_of_lives()

func increment_score(score_value: float):
	current_score += score_value
	print()
	score_update.emit()
	if current_score >= score_target:
		_on_game_win()

func out_of_lives():
	_on_game_lose()

func _on_game_win():
	SignalManager.emit_on_game_win()
	print_debug("youre winner")
	pass

func _on_game_lose():
	SignalManager.emit_on_game_lose()
	print_debug("rip bozo")
	pass
