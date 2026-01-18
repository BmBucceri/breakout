extends StaticBody2D
class_name BlockBase

@export var block_score: float = 10
var special_score: float = 50

func destroy_brick():
	ScoreManager.increment_score(block_score)
	self.queue_free()
