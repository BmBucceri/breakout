### LEVEL MANAGER ###
extends Node

signal all_boards_completed

var current_board: PackedScene
var next_index: int
var current_index = available_boards.find(current_board)

var available_boards: Array = [
	BOARD_1_YEAH_WHATEVER,
	BOARD_2_BIG_CRABBIN_IN_THE_CITY,
	BOARD_3_ZIG_ZAG,
	BOARD_4_SPRONGUS,
	BOARD_5_GREAT_TIME]

const BOARD_1_YEAH_WHATEVER = preload("uid://dt00th4b8utvc")
const BOARD_2_BIG_CRABBIN_IN_THE_CITY = preload("uid://coivw1qfolpl3")
const BOARD_3_ZIG_ZAG = preload("uid://lpdjyvd8wulw")
const BOARD_4_SPRONGUS = preload("uid://cfidyogtjo45s")
const BOARD_5_GREAT_TIME = preload("uid://cjc6cykvd5el5")

func _ready() -> void:
	set_current_index()
	print_debug(current_board)

func set_current_index():
	current_index = available_boards.find(current_board)


#this doesnt get called
func get_next_board_path() -> String:
	set_current_index()
	next_index = current_index + 1
	if next_index >= available_boards.size():
		all_boards_complete()
#sets the next level
	current_board = available_boards[next_index]

	return current_board.resource_path

func all_boards_complete():
		all_boards_completed.emit()
		print("You win!!!!!")
	# this resets the levels back to the start
		next_index == 0
