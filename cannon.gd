extends Node2D
class_name Cannon

@export_range(0.0,1.0) var parry_meter: float = 1.0
@export var total_balls_can_shoot: int = 1
@export_group("References")
@export var spawn_marker: Marker2D
@export var block_parry: Parry
@export var rootlevel: Level

var rotation_offset: float = 90
var total_balls_onscreen : int = 0
var can_shoot: bool = true
var parry_active: bool = false
var parry_drain: float = .5
var parry_refill: float = .35
var follow_speed: float = 8.0

const BALL = preload("uid://d1ogb0eean0hi")
const BLOCK = preload("uid://cyoixg7484f5d")

func _ready() -> void:
	InputManager.shoot_ball.connect(_on_shoot_ball)
	InputManager.parry_start.connect(attempt_parry)
	InputManager.parry_end.connect(parry_toggle)

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("Input_Cannon_Interact"):
		#_on_shoot_ball()
	#elif event.is_action_pressed("Input_Cannon_Parry"):
		#attempt_parry()
	#elif event.is_action_released("Input_Cannon_Parry"):
		#parry_toggle(false)

func _process(delta: float) -> void:
	if SignalManager.game_is_over == true:
		return
	var _direction_to_mouse:Vector2 = get_global_mouse_position() - self.global_position
	var _target_angle = _direction_to_mouse.angle() + deg_to_rad(rotation_offset)
	self.rotation =lerp(rotation, _target_angle, delta * follow_speed)
	
	
	#look_at(get_global_mouse_position())
	#self.rotation_degrees += rotation_offset

	if parry_active == true:
		if parry_meter <= 0:
			parry_toggle(false)
			return
		parry_meter -= (parry_drain * delta)
			
	else:
		if parry_meter >= 1:
			return
		parry_meter += (parry_refill * delta)

func _on_shoot_ball():
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
	GameManager.ball_root.add_child(new_ball)
	new_ball.top_level = true
	
func ball_is_destroyed():	
		total_balls_onscreen -= 1


func parry_toggle(value: bool):
	parry_active = value
	block_parry.toggle_parry(value)

func attempt_parry():
	if parry_meter > 0.2:
		parry_toggle(true)
	pass


#func parry_tracking():
	## function for process function to call every frame to keep the Parry cube attached to the Spawn Marker
	##parry.global_position = spawn_marker.global_position
	#pass
