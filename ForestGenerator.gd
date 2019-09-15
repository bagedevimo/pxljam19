extends Area2D

export (int) var number_of_trees = 10

var treeObjs = [
	preload("res://Tree.tscn"),
	preload("res://TreeRed.tscn"),
	preload("res://TreeBlue.tscn")
]

func _ready():
	EventBus.register_listener(self, EventBus.ON_BIRTH)
	handle_on_birth(null)

func handle_on_birth(args):
	print("Generating ", number_of_trees, " trees")
	randomize()
	for i in (number_of_trees - $YSort.get_child_count()):
		var rand_x = randi() % int($Area.shape.radius)
		var rand_y = randi() % int($Area.shape.radius)
		
		var tree = treeObjs[randi() % treeObjs.size()].instance()
		tree.position = Vector2(rand_x, rand_y)
		$YSort.add_child(tree)