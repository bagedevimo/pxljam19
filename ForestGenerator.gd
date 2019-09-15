extends Area2D

export (int) var number_of_trees = 10
export (int) var min_distance = 30

var trees = [
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
		
		var tries_left = 3

		while tries_left > 0:
			var rand_x = randi() % int($Area.shape.radius)
			var rand_y = randi() % int($Area.shape.radius)
			var new_pos = Vector2(rand_x, rand_y)

			var alone = true
			for tree in $YSort.get_children():
				if tree.position.distance_to(new_pos) < min_distance:
					alone = false
					break

			if alone:
				var tree = trees[randi() % trees.size()].instance()
				tree.position = new_pos
				$YSort.add_child(tree)
				break

			tries_left -= 1
