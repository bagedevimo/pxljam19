extends Node2D

func interact(actor):
	var storage = actor.get_node_or_null("Storage")
	
	if storage == null:
		return
		
	storage.store("logs", 1)
	queue_free()