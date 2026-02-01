### GAME MANAGER ###
extends Node

var ball_array: Array[Ball]
var ball_root: BallRoot

var ricochet_max: int = 3
var ricochet_left: int
var ricochet_cooldown: float = 3



func _ready() -> void:
	ricochet_left = ricochet_max

func add_ball(new_ball: Ball):
	ball_array.append(new_ball)


func remove_ball(ball_to_remove: Ball):
	var ball_to_remove_index = ball_array.find(ball_to_remove)
	
	if ball_to_remove_index != -1:
		ball_array.remove_at(ball_to_remove_index)

func increment_ricochet(value:int):
	ricochet_left += value

func assign_ball_root(new_root: BallRoot):
	ball_root = new_root
	pass
	
