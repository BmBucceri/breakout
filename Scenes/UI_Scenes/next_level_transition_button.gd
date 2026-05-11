extends Button

@export var path: String
@export var reload_scene: bool = false


func _ready() -> void:
	pressed.connect(_on_button_pressed)


func _on_button_pressed():
	TransitionManager.change_to_level(LevelManager.next_index)
	print_debug("NextIndex Pressed: " +str(LevelManager.next_index))
	pass
