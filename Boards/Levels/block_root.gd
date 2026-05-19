extends Node2D
class_name BlockRoot

@export var rootlevel: Level
var block_array: Array[Block]

func _ready() -> void:
	self.child_entered_tree.connect(_setup_child)
	_setup()

func _setup():
	for child in get_children():
		_setup_child(child)

func _on_block_destroyed(score: int):
	rootlevel.increment_score(score)
	pass
	
func add_block(new_block: Block):
	block_array.append(new_block)

func remove_block(block_to_remove: Block):
	var block_to_remove_index = block_array.find(block_to_remove)
	
	if block_to_remove_index != -1:
		block_array.remove_at(block_to_remove_index)
	_check_block_status()
	
func _check_block_status():
	if block_array.size() == 0:
		pass
		
func _setup_child(child: Node):
	if child is Block:
		child.block_destroyed.connect(_on_block_destroyed)
