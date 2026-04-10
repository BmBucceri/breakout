### INPUT MANAGER ###
extends Node

signal left_click_pressed
signal right_click_pressed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Input_Cannon_Interact"):
		#print("boink!")
		left_click_pressed.emit()

#func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Input_Cannon_Parry"):
		right_click_pressed.emit()
	
