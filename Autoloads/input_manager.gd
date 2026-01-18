### INPUT MANAGER ###
extends Node

signal left_click_pressed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		left_click_pressed.emit()
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		##print("yippie")
		#shoot_ball()
	#pass
