extends Node2D
class_name BallRoot

func _ready() -> void:
	GameManager.assign_ball_root(self)
