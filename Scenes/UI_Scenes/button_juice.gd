@tool
extends Node
class_name ButtonJuice

@export var scale_pressed: Vector2 = Vector2(0.92, 0.92)
@export var scale_hover: Vector2 = Vector2(1.05, 1.05)
@export var duration: float = 0.1

@export_group("References")
@export var hover: AudioStreamPlayer
@export var pressed: AudioStreamPlayer

var button_parent: BaseButton
var original_scale: Vector2
var new_tween: Tween

func _ready() -> void:
	# In the editor, we don't want the tween logic to actually run
	if Engine.is_editor_hint():
		return
		
	button_parent = get_parent() as BaseButton
	if button_parent:
		original_scale = button_parent.scale
		_setup()

# This function defines the warning in the Scene Tree dock
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	
	if not get_parent() is BaseButton:
		warnings.append("This node must be a child of a BaseButton (Button, TextureButton, etc.) to function.")
		warnings.append("Also, you a bitch.")

	return warnings

func _setup() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Update pivot if size changes (helpful for containers)
	button_parent.pivot_offset = button_parent.size / 2
	button_parent.resized.connect(func(): button_parent.pivot_offset = button_parent.size / 2)
	
	button_parent.mouse_entered.connect(_on_hover)
	button_parent.mouse_exited.connect(_on_exit)
	button_parent.button_down.connect(_on_pressed)
	button_parent.button_up.connect(_on_hover)
	button_parent.focus_entered.connect(_on_hover)
	button_parent.focus_exited.connect(_on_exit)

func _on_hover() -> void:
	_tween_scale.call_deferred(scale_hover, duration)
	hover.play()

func _on_exit() -> void:
	_tween_scale.call_deferred(original_scale, duration)

func _on_pressed() -> void:
	_tween_scale.call_deferred(scale_pressed, duration * 0.5)
	pressed.play()

func _tween_scale(target_scale: Vector2, time: float) -> void:
	if new_tween:
		new_tween.kill()
	
	new_tween = create_tween()
	#tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	new_tween.tween_property(button_parent, "scale", target_scale, time)
