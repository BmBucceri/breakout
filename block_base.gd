extends StaticBody2D
class_name Block

@export var min_break_speed: float
@export var block_score: float = 10
@export var next_brick: PackedScene
var special_score: float = 1

signal block_destroyed(score: int)

func destroy_brick():
	block_destroyed.emit(block_score)
	GameManager.hit_stop(.1)
	self.queue_free()


func on_hit(speed: float):
	#speed gate is modified to compensate for starting speed (200)
	if speed < min_break_speed + Ball.starting_speed:
		return
	
	if next_brick == null:
		destroy_brick()
		
	else:
		await get_tree().process_frame
		
		var new_brick = next_brick.instantiate()
		
		add_sibling(new_brick)
		new_brick.global_position = global_position
		destroy_brick()
