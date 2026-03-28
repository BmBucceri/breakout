extends Area2D

#@onready var block_base: BlockBase = $".."
@export var block_base: Block
@export var next_brick: PackedScene
#if block hits with speed >700, then the block get destroyed, otherwise, bounce off unaffected

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D):
	if area is BallHitbox:
		block_base.on_hit(area.ball.speed)
	
	#print("you done did it")
