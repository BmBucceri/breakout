extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animate_impact()

func animate_impact():
	animation_player.play("parry_impact")
