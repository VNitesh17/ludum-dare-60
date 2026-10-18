extends Area2D

var hasCrossed = false
signal crossed

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and !hasCrossed:
		BackgroundMusic3.stop()
		BackgroundMusic4.play()
		emit_signal("crossed")
		hasCrossed = true
