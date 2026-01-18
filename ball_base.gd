extends CharacterBody2D
class_name Ball

@export var speed: float = 200
var dir = Vector2.DOWN
var collision = KinematicCollision2D

func _ready() -> void:
	InputManager.left_click_pressed.connect(_on_left_click_pressed)

func _on_left_click_pressed():
	adjust_velocity(Vector2.UP)
	pass

func set_direction(new_dir: Vector2):
	self.velocity = new_dir
	pass

func _physics_process(delta: float) -> void:
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	pass
	
	if(velocity.y > 0 and velocity.y < 100):
		velocity.y = -200
	if velocity.x == 0:
		velocity.x = -200

func adjust_velocity(new_vector: Vector2):
	velocity = velocity.bounce(new_vector)
	pass
