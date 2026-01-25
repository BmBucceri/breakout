### GAME MANAGER ###
extends Node

var ball_array: Array[Ball]

var bounces_max: int = 3
var bounces_left: int
var bounce_cooldown: float = 3

func _ready() -> void:
	bounces_left = bounces_max

func add_ball(new_ball: Ball):
	ball_array.append(new_ball)
	pass
	
func remove_ball(ball_to_remove: Ball):
	var ball_to_remove_index = ball_array.find(ball_to_remove)
	
	if ball_to_remove_index != -1:
		ball_array.remove_at(ball_to_remove_index)

func increment_bounces(value:int):
	bounces_left += value
	
	
#func cooldown bouce timer
	#restore bounce uses
