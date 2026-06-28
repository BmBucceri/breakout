extends HSlider

# The name of the audio bus (must match the name in the Audio tab)
@export var bus_name: String = "Master"

var bus_index: int

func _ready() -> void:
	# Get the index of the bus once so we don't have to look it up every frame
	bus_index = AudioServer.get_bus_index(bus_name)
	
	# Connect the slider's value_changed signal to our function
	value_changed.connect(_on_value_changed)
	
	# Optional: Sync the slider's starting position with the current bus volume
	var current_db = AudioServer.get_bus_volume_db(bus_index)
	
	value = db_to_linear(current_db)

func _on_value_changed(new_value: float) -> void:
	# Convert the 0.0-1.0 slider value to the appropriate decibel level
	# linear_to_db(0) results in -80dB (silence in Godot)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
