### GAME MANAGER ###
extends Node

var ball_array: Array[Ball]
var ball_root: BallRoot

var ball_speed: float
var ricochet_max: int = 3
var ricochet_left: int
var ricochet_cooldown: float = 3
var hit_stop_tween: Tween
signal camera_trauma(amount: float)


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

func increment_ricochet(value:int):
	ricochet_left += value

func emit_camera_trauma(amount: float):
	camera_trauma.emit(amount)

func reset_level():
	ball_array = []

func hit_stop(duration: float):
	if hit_stop_tween:
		hit_stop_tween.kill()
	hit_stop_tween = get_tree().create_tween()
	hit_stop_tween.set_ignore_time_scale()
	hit_stop_tween.set_ease(Tween.EASE_OUT)
	Engine.time_scale = .01
	hit_stop_tween.tween_property(Engine,"time_scale",1,duration)
	
#func add_block(new_block: Block):
	#block_array.append(new_block)
#
#func remove_block(block_to_remove: Block):
	#var block_to_remove_index = block_array.find(block_to_remove)
	#
	#if block_to_remove_index != -1:
		#block_array.remove_at(block_to_remove_index)
	#_check_block_status()
