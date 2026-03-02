extends Node

@onready var recess: AudioStreamPlayer = %Recess
@onready var cheesy_street: AudioStreamPlayer = %CheesyStreet
@onready var tracks: Node = %Tracks
@onready var song_map: Dictionary = {
	available_songs.RECESS : recess,
	available_songs.CHEESYSTREET : cheesy_street,
}  
enum available_songs {RECESS, CHEESYSTREET}


#func play_recess():
	#stop_music()
	#recess.play()

#func play_cheesystreet():
	#stop_music()
	#cheesy_street.play()

func play_track(level_track: available_songs):
	stop_music()
	var current_player = song_map[level_track]
	current_player.play()

func stop_music():
	for music in tracks.get_children():
		music.stop()
