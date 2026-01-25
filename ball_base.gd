extends CharacterBody2D
class_name Ball

@export var speed: float = 200
var dir = Vector2.DOWN
var collision = KinematicCollision2D

func _ready() -> void:
	GameManager.add_ball(self)
	InputManager.left_click_pressed.connect(_on_left_click_pressed)

func _on_left_click_pressed():
	if GameManager.bounces_left > 0:
		bounce()

func bounce():
	adjust_velocity(Vector2.UP)
	GameManager.increment_bounces(-1)

func set_direction(new_dir: Vector2):
	self.velocity = new_dir

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

func destroy_ball():
	GameManager.remove_ball(self)
	self.queue_free()
	
