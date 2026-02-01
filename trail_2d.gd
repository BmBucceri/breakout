extends Line2D

@export var trail_length = 50
var _start_point: Vector2
var ball: Ball
#var _ball_assigned: bool = false

func _assign_ball(new_ball: Ball):
	ball = new_ball
	#_ball_assigned = true

func _process(delta: float) -> void:
	if ball == null:
		
		return
	global_position = Vector2(0,0)
	global_rotation = 0

	_start_point = ball.global_position
	add_point(_start_point)
	while get_point_count()>trail_length:
		remove_point(0)
