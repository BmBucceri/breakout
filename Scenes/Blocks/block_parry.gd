extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	destroy()

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		var bounce_normal = Vector2.UP.rotated(global_rotation)
		body.ball_bounce(bounce_normal)

func destroy():
	await get_tree().create_timer(.5).timeout
	queue_free()
