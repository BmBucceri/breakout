extends Area2D

const KILLBOX_BOOM = preload("uid://b8ps3wt8s5vpp")

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is Ball: 
		var boom = KILLBOX_BOOM.instantiate()
		add_child(boom)
		boom.transform = body.transform
		body.destroy_ball()
