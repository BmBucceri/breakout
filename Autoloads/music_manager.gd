extends Node

@onready var recess: AudioStreamPlayer = %Recess

func track_start():
	recess.play()
	pass
