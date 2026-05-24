extends Node

signal on_game_win
signal on_game_lose
signal parry_slowdown
#used by Block_parry



var game_is_over: bool

func reset_game():
	game_is_over = false

func emit_on_game_win():
	if game_is_over == true:
		return
	game_is_over = true
	on_game_win.emit()
	print("Nice Job!")
	
func emit_on_game_lose():
	if game_is_over == true:
		return

	game_is_over = true
	on_game_lose.emit()
	print("You lose!")
