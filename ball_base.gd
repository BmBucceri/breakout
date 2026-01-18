extends CharacterBody2D
class_name Ball

@export var speed: float = 200
var dir = Vector2.DOWN


func _ready() -> void:
	self.velocity = Vector2(speed * -1, speed)
	pass
	
func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	pass
	
	if(velocity.y > 0 and velocity.y < 100):
		velocity.y = -200
	
	if velocity.x == 0:
		velocity.x = -200
