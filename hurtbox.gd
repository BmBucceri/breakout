extends Area2D

#@onready var block_base: BlockBase = $".."
@export var block_base: BlockBase

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D):
	block_base.destroy_brick()
	print("you done did it")
	pass
