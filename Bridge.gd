extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const NUM_STEPS = 6
export var logs_required = 6.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func interact(actor):
	var storage = actor.get_node_or_null("Storage")
	
	if storage == null:
		return
		
	var logs_retrieved = storage.retrieve("logs")

	if logs_retrieved:
		$Storage.store("logs", logs_retrieved)
		actor.find_node("Say").play_speech("The bridge grows!")
	else:
		actor.find_node("Say").play_speech("I don't have any logs")
		
	var progress = ($Storage.quantity("logs") / logs_required)
	
	var activated_indexes = progress * NUM_STEPS
	
# warning-ignore:integer_division
	var start = -(NUM_STEPS/2)
# warning-ignore:integer_division
	var end = NUM_STEPS/2
	
	var bridge_to = start + activated_indexes
	
	for x in range(start, end): 
		var tile = 10 if x < bridge_to else -1
		
		find_node("CoreBridge").set_cell(x, 0, tile, false, false, false, Vector2(1, 0))
	
	