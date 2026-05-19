extends Area2D
class_name Parry




var is_active: bool = false
@export var visuals: Node2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	toggle_parry(is_active)

func _on_body_entered(body: Node2D):
	if is_active ==false:
		return
	_try_bounce_ball(body)

func toggle_parry(value:bool):
	is_active = value
	visuals.visible = value
	
	if is_active:
		var overlappingbodies = get_overlapping_bodies()
		for body in overlappingbodies:
			_try_bounce_ball(body) 


func _try_bounce_ball(body: Node2D):
	if body is Ball:
		var bounce_direction = Vector2.UP.rotated(global_rotation)
		var new_velocity = bounce_direction * body.speed
		body.ball_bounce(new_velocity)
		
		if GameManager.ball_speed > 1000:
			SignalManager.parry_slowdown.emit()


#func destroy():
	#await get_tree().create_timer(1).timeout
	#queue_free()
