extends Node

signal on_game_win
signal on_game_lose

func emit_on_game_win():
	print("Nice Job!")
	on_game_win.emit()
	
func emit_on_game_lose():
	print("You blow!")
	on_game_lose.emit()
