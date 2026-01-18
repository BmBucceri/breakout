extends Node2D
class_name Cannon

@export var spawn_marker: Marker2D
@export var rotation_offset: float = 90

const BALL = preload("uid://d1ogb0eean0hi")

func _ready() -> void:
	InputManager.left_click_pressed.connect(shoot_ball)
	
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	self.rotation_degrees += rotation_offset


func shoot_ball():
	var new_ball = BALL.instantiate()
	new_ball.global_position = spawn_marker.global_position
	
	var fire_direction = Vector2.UP.rotated(self.global_rotation)
	new_ball.set_direction(fire_direction * new_ball.speed)
	#new_ball.set_direction(Vector2((self.global_rotation),10))
	spawn_marker.add_child(new_ball)
	new_ball.top_level = true
	pass
