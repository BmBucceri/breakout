extends Node
class_name GameOverState

@export var game_over_win: Control
@export var game_over_lose: Control

var _game_has_ended: bool = false

func _ready() -> void:
	call_deferred("_deferred_ready")

func _deferred_ready():
	SignalManager.on_game_win.connect(reveal_game_win)
	SignalManager.on_game_lose.connect(reveal_game_lose)
	print("connected!")
	game_over_win.hide()
	game_over_lose.hide()



func reveal_game_win():
	if _game_has_ended == true:
		return
	game_over_win.show()
	game_over_lose.hide()
	_game_has_ended = true

func reveal_game_lose():
	if _game_has_ended == true:
		return
	game_over_lose.show()
	game_over_win.hide()
	_game_has_ended = true
