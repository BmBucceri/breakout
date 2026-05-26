extends Area2D
class_name Parry

@onready var parry_sound: AudioStreamPlayer = $ParrySound
@export var invert_impact: Sprite2D

var hitstop_duration: float = .5
var is_active: bool = false
@export var visuals: Node2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	invert_impact.scale = Vector2.ZERO
	invert_impact.modulate.a = 0
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
			## TODO tie hitstop duration to speed
			GameManager.hit_stop(hitstop_duration)
			animate_impact()
			parry_sound.play()

func animate_impact():
	invert_impact.scale = Vector2(.5,.5)
	invert_impact.modulate.a = 1
	
	var impact_tween: Tween = get_tree().create_tween()
	impact_tween.set_parallel()
	impact_tween.tween_property(invert_impact, "scale", Vector2(1.5,1.5), hitstop_duration)
	impact_tween.tween_property(invert_impact, "modulate:a", 0, hitstop_duration)
	pass
