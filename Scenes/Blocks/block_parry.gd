extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	destroy()

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		var bounce_direction = Vector2.UP.rotated(global_rotation)
		var new_velocity = bounce_direction * body.speed
		
		body.ball_bounce(new_velocity)

func destroy():
	await get_tree().create_timer(1).timeout
	queue_free()
