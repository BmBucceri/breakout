### GAME MANAGER ###
extends Node

var ball_array: Array[Ball]
var ball_root: BallRoot

var block_array: Array[Block]


var ball_speed: float
var ricochet_max: int = 3
var ricochet_left: int
var ricochet_cooldown: float = 3
signal camera_trauma(amount: float)
signal on_game_win
signal on_game_lose

func _ready() -> void:
	ricochet_left = ricochet_max

func add_ball(new_ball: Ball):
	ball_array.append(new_ball)

func remove_ball(ball_to_remove: Ball):
	var ball_to_remove_index = ball_array.find(ball_to_remove)
	
	if ball_to_remove_index != -1:
		ball_array.remove_at(ball_to_remove_index)

func assign_ball_root(new_root: BallRoot):
	ball_root = new_root


func add_block(new_block: Block):
	block_array.append(new_block)

func remove_block(block_to_remove: Block):
	var block_to_remove_index = block_array.find(block_to_remove)
	
	if block_to_remove_index != -1:
		block_array.remove_at(block_to_remove_index)
	_check_block_status()


func increment_ricochet(value:int):
	ricochet_left += value

func emit_camera_trauma(amount: float):
	camera_trauma.emit(amount)

func _check_block_status():
	if block_array.size() == 0:
		print("you'r winner")
		on_game_win.emit()

func reset_level():
	ball_array = []
	block_array = []

func emit_on_game_lose():
	on_game_lose.emit()
	print_debug("haha you suck lmaooooooooooooooooooooooooooo")
