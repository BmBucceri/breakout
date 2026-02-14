extends Camera2D

@export var decay: float = .3  # How quickly the shaking stops [0 to 1]
@export var max_offset: Vector2 = Vector2(100, 75)  # Maximum shake distance
@export var max_roll: float = .1  # Maximum rotation

var trauma: float = 0.0  # Current shake strength [0 to 1]
var trauma_power: int = 2  # Trauma exponential (2 or 3 works best)

func _ready() -> void:
	GameManager.camera_trauma.connect(add_trauma)

func _process(delta: float) -> void:
	if trauma > 0:
		trauma = max(trauma - decay * delta, 0)
		_shake()
	else:
		# Reset camera to center when shake is done
		offset = Vector2.ZERO
		rotation = 0

func _shake() -> void:
	# We square the trauma for a smoother "settling" feel
	var amount = pow(trauma, trauma_power)
	
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

## Call this function from anywhere to shake the screen
## e.g., Camera.add_trauma(0.5)
func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount, 0.3)
