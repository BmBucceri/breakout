extends HSlider

@export var cannon: Cannon
@export var fill: Panel
var parry_meter_min: int = 0
var parry_meter_max: int = 1

func _process(delta: float) -> void:


	value = cannon.parry_meter
