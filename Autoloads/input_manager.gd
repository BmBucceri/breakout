### INPUT MANAGER ###
extends Node

signal shoot_ball
signal parry_start
signal parry_end(value:bool)
signal flip

func _input(event: InputEvent) -> void:
	if SignalManager.game_is_over == true:
		return
	
	if event.is_action_pressed("Shoot"):
		#print("boink!")
		shoot_ball.emit()

	if event.is_action_pressed("Parry"):
		parry_start.emit()
	if event.is_action_released("Parry"):
		parry_end.emit(false)
	
	if event.is_action_pressed("Flip"):
		flip.emit()
		
