extends Node2D
class_name Cannon

@export var spawn_marker: Marker2D
@export var rotation_offset: float = 90
@export var total_balls_can_shoot: int = 1

var can_shoot: bool = true

const BALL = preload("uid://d1ogb0eean0hi")

func _ready() -> void:
	InputManager.left_click_pressed.connect(shoot_ball)
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	self.rotation_degrees += rotation_offset

func shoot_ball():
	#if can_shoot == false:
		#return
# check if cannon is active
	if GameManager.ball_array.size() > total_balls_can_shoot - 1:
		return

	var new_ball = BALL.instantiate()
	new_ball.global_position = spawn_marker.global_position
	
	var fire_direction = Vector2.UP.rotated(self.global_rotation)
	#ball inherits the angle of the cannon
	new_ball.set_direction(fire_direction * new_ball.speed)
	#spawn_marker.add_child(new_ball)
	GameManager.ball_root.add_child(new_ball)
	
	new_ball.top_level = true
