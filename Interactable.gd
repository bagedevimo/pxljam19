extends Node2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_focusable(get_parent())

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		body.remove_focusable(get_parent())

func set_focused():
	$Attention.visible = true
	
func set_unfocused():
	$Attention.visible = false