extends AnimatedSprite2D
class_name CountdownLabel

@export var countdown_bounce_sprite_2d: AnimatedSprite2D

func _process(_delta: float) -> void:
	ricochet_update()
	pass


# get info, attach to animated sprite, update every frame, draw behind everything


#func _draw():
	#var texture = sprite_frames.get_frame_texture("countdown_bounce_sprite_2d", GameManager.ricochet_left)
	#draw_texture(texture, Vector2.ZERO)

func ricochet_update():
	countdown_bounce_sprite_2d.set_frame(GameManager.ricochet_left)
