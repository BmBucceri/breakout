extends Node

var current_score: float = 0

signal score_update


func _ready() -> void:
	pass

func increment_score(score_value: float):
	current_score += score_value
	score_update.emit()
