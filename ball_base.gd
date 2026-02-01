extends CharacterBody2D
class_name Ball

@export var speed: float = 200
@export var sprite_2d: Sprite2D
const TRAIL_2D = preload("uid://6bd6r2wmtxl5")
const RICOCHET_PARTICLES = preload("uid://bywffmt2v53jh")

var direction: Vector2
var current_direction: Vector2
var collision = KinematicCollision2D
var offset: float = deg_to_rad(90)
var increase_speed_percent: float = .05
var squash_and_stretch_tween: Tween
var default_sprite_scale: Vector2

func _ready() -> void:
	GameManager.add_ball(self)
	InputManager.left_click_pressed.connect(_try_ricochet)
	default_sprite_scale = sprite_2d.scale
	_add_trail()

func _add_trail():
	var _new_trail = TRAIL_2D.instantiate()
	_new_trail._assign_ball(self)
	add_sibling(_new_trail)
	
	pass

func _physics_process(delta: float) -> void:
	_move_and_rotate(delta)
	
func _move_and_rotate(delta: float):
	collision = move_and_collide(velocity * delta)
	
	if collision:
		_ball_bounce()

	## Safety code, IGNORE
	#if(velocity.y > 0 and velocity.y < 100):
		#velocity.y = -200
	#if velocity.x == 0:
		#velocity.x = -200
	self.rotation =velocity.angle() + offset

func _ball_bounce():
	velocity = velocity.bounce(collision.get_normal())
	_increase_speed(increase_speed_percent)
	_squash_and_stretch()

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
	speed += speed * value
	velocity = velocity.normalized() * speed
	print(speed)

# called by cannon
func set_direction(new_direction: Vector2):
	self.velocity = new_direction

func _adjust_velocity(new_vector: Vector2):
	velocity = velocity.bounce(new_vector)

func destroy_ball():
	GameManager.remove_ball(self)
	self.queue_free()
	
