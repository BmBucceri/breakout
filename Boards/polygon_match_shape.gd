extends Polygon2D
class_name PolygonMatchShape

func _ready() -> void:
	call_deferred("setup_collision")

func setup_collision():
	var new_collision = CollisionPolygon2D.new()
	new_collision.transform = self.transform
	add_sibling(new_collision)
	new_collision.polygon = self.polygon
