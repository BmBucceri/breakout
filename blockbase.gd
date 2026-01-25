extends StaticBody2D
class_name BlockBase

@export var block_score: float = 10
@export var next_brick: PackedScene
var special_score: float = 50

func destroy_brick():
	ScoreManager.increment_score(block_score)
	self.queue_free()


func _on_hit():
	if next_brick == null:
		destroy_brick()
		
	else:
		await get_tree().process_frame
		
		var new_brick = next_brick.instantiate()
		
		add_sibling(new_brick)
		print("are you on phone")
		new_brick.global_position = global_position
		destroy_brick()
