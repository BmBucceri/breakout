extends Button

@export var path: String
@export var reload_scene: bool = false


func _ready() -> void:
	pressed.connect(_on_button_pressed)


func _on_button_pressed():
	if reload_scene == true:
		TransitionManager.reload_scene()
	else: 
		TransitionManager.change_to_scene(path)
	pass
 
