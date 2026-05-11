extends CanvasLayer

@onready var panel: Panel = %Panel


var tween: Tween

func _ready() -> void:
	# set tween to transparent
	panel.modulate.a = 0


func change_to_scene(path: String):
	#tween blackpanel up 
	#then load newscene
	#then back down
	await _fade_in()
	_change_scene(path)
	await _fade_out()
	pass

func change_to_level(path: LevelManager.available_boards):
	await _fade_in()
	var level_path = LevelManager.get_board_path(path)
	LevelManager.next_index = path + 1
	_change_scene(level_path)
	await _fade_out()
	pass

func reload_scene():
	await _fade_in()
	get_tree().reload_current_scene()
	await _fade_out()

func _fade_in():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1, .5)
	await tween.finished

func _change_scene(path):
	get_tree().change_scene_to_file(path)

func _fade_out():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(panel, "modulate:a", 0, 1)
	await tween.finished
