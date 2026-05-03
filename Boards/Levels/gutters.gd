extends StaticBody2D
class_name Gutters

@export var has_gutter_block: bool = false

const BLOCK_GUTTER = preload("uid://m7ejcqlv54cj")
@export var gutter_spawn_marker: Marker2D

func _ready() -> void:
	spawn_block_gutter()


func spawn_block_gutter():
	if has_gutter_block: 
		return # Don't spawn if one already exists
		
	var new_gutter = BLOCK_GUTTER.instantiate()
	new_gutter.block_destroyed.connect(_on_gutter_destroyed)
	gutter_spawn_marker.add_child.call_deferred(new_gutter)
	has_gutter_block = true

func _on_gutter_destroyed():
	has_gutter_block = false
