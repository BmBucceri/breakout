### LEVEL MANAGER ###
extends Node

signal all_boards_completed

var current_board: PackedScene
var next_index: int :
	set(value):
		if value > available_boards.size():
			value = 0
#var current_index = available_boards.find(current_board)
var change_to_level

enum available_boards {
	BOARD_1_YEAH_WHATEVER,
	BOARD_2_BIG_CRABBIN_IN_THE_CITY,
	BOARD_3_ZIG_ZAG,
	BOARD_4_SPRONGUS,
	BOARD_5_GREAT_TIME}

const B1 = preload("uid://dt00th4b8utvc")
const B2= preload("uid://coivw1qfolpl3")
const B3 = preload("uid://lpdjyvd8wulw")
const B4 = preload("uid://cfidyogtjo45s")
const B5 = preload("uid://cjc6cykvd5el5")

@onready var board_scenes = {
	available_boards.BOARD_1_YEAH_WHATEVER: B1,
	available_boards.BOARD_2_BIG_CRABBIN_IN_THE_CITY: B2,
	available_boards.BOARD_3_ZIG_ZAG: B3,
	available_boards.BOARD_4_SPRONGUS: B4,
	available_boards.BOARD_5_GREAT_TIME: B5
}

func _ready() -> void:
	pass

#func set_current_index():
	#current_index = available_boards.find(current_board)
	#pass
#
func get_board_path(board_enum: available_boards) -> String:
	var _scene = board_scenes.get(board_enum)
	if _scene:
		return _scene.resource_path
	return ""


func all_boards_complete():
		all_boards_completed.emit()
		print("You win!!!!!")
	# this resets the levels back to the start
		#next_index == 0
