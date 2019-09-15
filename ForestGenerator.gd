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
	randomize()
	
	var children = get_parent().get_children()
	var tree_child_count = 0
	
	for tree in children:
		if tree.has_method("is_in_group") && tree.is_in_group("tree" + String(get_instance_id())):
			tree_child_count += 1
	
	var required_trees = number_of_trees - tree_child_count
	print("Generating ", required_trees, " trees")
	
	for i in required_trees:
		var tries_left = 3

		while tries_left > 0:
			var rand_x = randi() % int($Area.shape.radius)
			var rand_y = randi() % int($Area.shape.radius)
			var new_pos = Vector2(rand_x, rand_y)

			var alone = true
			for tree in get_parent().get_children():
				if tree.is_in_group("tree" + String(get_instance_id())) && tree.position.distance_to(new_pos) < min_distance:
					alone = false
					break

			if alone:
				var tree : Node2D = trees[randi() % trees.size()].instance()
				tree.position = new_pos + get_position()
				tree.add_to_group("tree" + String(get_instance_id()))
				get_parent().call_deferred("add_child",tree)

				break

			tries_left -= 1
