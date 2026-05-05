### LEVEL MANAGER ###
extends Node

func _ready() -> void:
	print(available_boards)


var loaded_board: String
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
