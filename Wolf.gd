extends KinematicBody2D

export (int) var pats_required = 5
export (int) var motion_speed = 300
export (int) var stop_following_distance = 70
export (int) var following_delay = 3

var pats = 0
var following_player = false
var player = null

func _ready():
	EventBus.register_listener(self, EventBus.ON_DEATH)

func _process(delta):
	if not following_player or player == null:
		return

	var player_pos = player.global_position
	var current_pos = global_position

	if player_pos.distance_to(current_pos) < stop_following_distance:
		$AnimationPlayer.play("idle")
		return

	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()

	var direction = (player_pos - current_pos).normalized()
	move_and_slide(direction * motion_speed)

func interact(actor):
	pats += 1

	if pats < 2:
		$Say.play_speech("Grrrrrr!")
	elif pats < 3:
		$Say.play_speech("Grrr")
	elif pats < 5:
		$Say.play_speech("Woof woof!")
	elif pats > 5:
		$Say.play_speech("Bark!")
		
	if pats == pats_required:
		actor.find_node("Say").play_speech("Follow me friend!")
		following_player = true
		player = actor

func handle_on_death(player):
	pass