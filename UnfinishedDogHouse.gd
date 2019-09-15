extends Node2D

func interact(actor):
	var storage = actor.get_node_or_null("Storage")
	
	if storage == null:
		return
		
	var logs_retrieved = storage.retrieve("logs", 2)

	if logs_retrieved:
		var finished_dog_house = load("res://FinishedDogHouse.tscn").instance()
		finished_dog_house.position = position
		get_parent().add_child(finished_dog_house)
		queue_free()
	else:
		actor.find_node("Say").play_speech("I need few logs to finish this")