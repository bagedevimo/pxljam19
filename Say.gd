extends Node2D

func play_speech(txt):
	$Say.text = txt
	find_node("AnimationPlayer").play("Speak")
