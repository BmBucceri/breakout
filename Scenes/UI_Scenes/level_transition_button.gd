extends Button

@export var level: LevelManager.available_boards


func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	TransitionManager.change_to_level(level)
