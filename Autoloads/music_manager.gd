extends Node

@onready var recess: AudioStreamPlayer = %Recess
@onready var cheesy_street: AudioStreamPlayer = %CheesyStreet
@onready var rush_hour: AudioStreamPlayer = %RushHour
@onready var traffic_jam: AudioStreamPlayer = $Tracks/TrafficJam
@onready var bug_club: AudioStreamPlayer = $Tracks/BugClub

@onready var tracks: Node = %Tracks
@onready var song_map: Dictionary = {
	available_songs.RECESS : recess,
	available_songs.CHEESYSTREET : cheesy_street,
	available_songs.RUSHHOUR: rush_hour,
	available_songs.TRAFFICJAM: traffic_jam,
	available_songs.BUGCLUB: bug_club,

}  
enum available_songs {RECESS, CHEESYSTREET, RUSHHOUR, TRAFFICJAM, BUGCLUB}


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
