extends Node2D
class_name Cannon

@export var spawn_marker: Marker2D
@export var rotation_offset: float = 90
@export var total_balls_can_shoot: int = 1
@export var block_base: PackedScene

var total_balls_onscreen : int = 0
var can_shoot: bool = true
var parry
var parry_active: bool = false


const BALL = preload("uid://d1ogb0eean0hi")
const BLOCK = preload("uid://cyoixg7484f5d")

func _ready() -> void:
	InputManager.left_click_pressed.connect(shoot_ball)
	InputManager.right_click_pressed.connect(parry_activate)

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	self.rotation_degrees += rotation_offset

func shoot_ball():
	#if can_shoot == false:
		#return
#Check for total balls on screen
	if total_balls_onscreen >= total_balls_can_shoot:
		return

	total_balls_onscreen += 1
	var new_ball = BALL.instantiate()
	new_ball.global_position = spawn_marker.global_position
	new_ball.ball_destroyed.connect(ball_is_destroyed)
	
	var fire_direction = Vector2.UP.rotated(self.global_rotation)
	#ball inherits the angle of the cannon
	new_ball.set_direction(fire_direction * new_ball.speed)
	#spawn_marker.add_child(new_ball)
	GameManager.ball_root.add_child(new_ball)
	new_ball.top_level = true
	
func ball_is_destroyed():	
		total_balls_onscreen -= 1


func parry_activate():
	parry = BLOCK.instantiate()
	parry.top_level = true
	print("made")
	parry.global_position = spawn_marker.global_position
	#add_child(parry)
	GameManager.add_child(parry)
	
	
	await get_tree().create_timer(.5).timeout
	print_debug("unmade")
	parry.queue_free()
