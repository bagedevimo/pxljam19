extends Node2D

func interact(actor):
	actor.find_node("Say").play_speech("It feels empty")