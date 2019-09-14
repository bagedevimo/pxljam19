extends Node2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.set_focus(get_parent())
		$Attention.visible = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		body.clear_focus_where(get_parent())
		$Attention.visible = false
