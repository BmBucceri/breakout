extends StaticBody2D
class_name Block

@export var min_break_speed: float
@export var block_score: float = 10
@export var next_brick: PackedScene
var special_score: float = 1

func _ready() -> void:
	GameManager.add_block(self)

func destroy_brick():
	ScoreManager.increment_score(block_score)
	GameManager.remove_block(self)
	self.queue_free()


func on_hit(speed: float):
	if speed < min_break_speed:
		return
	
	if next_brick == null:
		destroy_brick()
		
	else:
		await get_tree().process_frame
		
		var new_brick = next_brick.instantiate()
		
		add_sibling(new_brick)
		#print("are you on phone")
		new_brick.global_position = global_position
		destroy_brick()
