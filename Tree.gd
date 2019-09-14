extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var requiredInteracts = 5
var interacts = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interact(actor):
	$AnimationPlayer.play("Shake")
	
	self.interacts += 1
	
	if self.interacts >= self.requiredInteracts:
		var logs = load("res://Logs.tscn").instance()
		logs.position = self.position
		get_tree().get_root().add_child(logs)
		self.queue_free()