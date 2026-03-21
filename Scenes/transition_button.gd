extends Button

@export var path: String

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	

func _on_button_pressed():
	TransitionManager.change_to_scene(path)
	pass
 
