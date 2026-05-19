extends CharacterBody2D
class_name Ball

@export var speed: float = 200
@export var sprite_2d: Sprite2D
@export var speed_cap: float = 7000
@export var pitch_curve: Curve
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

static var starting_speed = 200

const TRAIL_2D = preload("uid://6bd6r2wmtxl5")
const RICOCHET_PARTICLES = preload("uid://bywffmt2v53jh")


var direction: Vector2
var current_direction: Vector2
var collision = KinematicCollision2D
var offset: float = deg_to_rad(90)
var increase_speed_percent: float = .05
var squash_and_stretch_tween: Tween
var default_sprite_scale: Vector2
var new_trail: Line2D

signal ball_destroyed


func _ready() -> void:
	GameManager.add_ball(self)
	InputManager.flip.connect(_try_ricochet)
	default_sprite_scale = sprite_2d.scale
	_add_trail()
	SignalManager.parry_slowdown.connect(parry_speed_reduction)

func _add_trail():
	new_trail = TRAIL_2D.instantiate()
	new_trail._assign_ball(self)
	add_sibling(new_trail)


func _physics_process(delta: float) -> void:
	_move_and_rotate(delta)
	
	GameManager.ball_speed = speed - 200
	
	
func _move_and_rotate(delta: float):
	collision = move_and_collide(velocity * delta)
	
	if collision:
		_wall_bounce()

	# Safety code, IGNORE
	if(velocity.y > 0 and velocity.y < 100):
		velocity.y = -200
	if velocity.x == 0:
		velocity.x = -200
		
		
	self.rotation =velocity.angle() + offset

func _wall_bounce():
	var wall_velocity: Vector2 = velocity.bounce(collision.get_normal())
	ball_bounce(wall_velocity)

func ball_bounce(new_velocity: Vector2):
	velocity = new_velocity
	_increase_speed(increase_speed_percent)
	_squash_and_stretch()
	GameManager.emit_camera_trauma(1)
	adjust_sfx_pitch()
	audio_stream_player.play()

func adjust_sfx_pitch():
	var curve_sample:float = pitch_curve.sample(speed / speed_cap)
	audio_stream_player.pitch_scale = curve_sample

func _squash_and_stretch():
	if squash_and_stretch_tween != null:
		squash_and_stretch_tween.kill()
	squash_and_stretch_tween = get_tree().create_tween()
	## tween squash = scale.x = 1.5, scale.y = .75 over .1 seconds
	squash_and_stretch_tween.tween_property(sprite_2d, "scale",Vector2(default_sprite_scale.x * 1.5,default_sprite_scale.y * .75),.1)
	## tween stretch = scale.x = .75, scale.y = 1.5 over .1 seconds
	squash_and_stretch_tween.tween_property(sprite_2d, "scale",Vector2(default_sprite_scale.x * .75,default_sprite_scale.y * 1.5),.1)
	## tween return to scale	
	squash_and_stretch_tween.tween_property(sprite_2d, "scale",default_sprite_scale,.1)


func _try_ricochet():
	if GameManager.ricochet_left > 0:
		_ricochet()
		#SPAWN PARTICLES AT BALL POSITION
		var new_particle = RICOCHET_PARTICLES.instantiate()
		self.add_child(new_particle)
		_squash_and_stretch()

func _ricochet():
	_adjust_velocity(Vector2.UP)
	GameManager.increment_ricochet(-1)

func _increase_speed(value: float):
	if speed > speed_cap:
		return
	speed += speed * value
	velocity = velocity.normalized() * speed

# called by cannon
func set_direction(new_direction: Vector2):
	self.velocity = new_direction

func _adjust_velocity(new_vector: Vector2):
	velocity = velocity.bounce(new_vector)

func parry_speed_reduction():
	speed = (speed * .5)

func destroy_ball():
	GameManager.remove_ball(self)
	new_trail.destroy_trail()
	ball_destroyed.emit()
	self.queue_free()
