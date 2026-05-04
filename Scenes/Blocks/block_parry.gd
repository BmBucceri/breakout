extends Area2D
class_name Parry

var is_active: bool = false
@export var visuals: Node2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	toggle_parry(is_active)
	#destroy()

func _on_body_entered(body: Node2D) -> void:
	if is_active == false:
		return
	if body is Ball:
		var bounce_direction = Vector2.UP.rotated(global_rotation)
		var new_velocity = bounce_direction * body.speed

		body.ball_bounce(new_velocity)

func toggle_parry(value:bool):
	is_active = value
	visuals.visible = value

#func destroy():
	#await get_tree().create_timer(1).timeout
	#queue_free()
