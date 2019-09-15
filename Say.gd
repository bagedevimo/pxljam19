extends Node2D

func play_speech(txt):
	$Label.text = txt
	find_node("AnimationPlayer").play("Speak")
