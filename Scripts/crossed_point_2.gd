extends Area2D

var hasCrossed = false
signal crossed

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and !hasCrossed:
		BackgroundMusic1.stop()
		BackgroundMusic2.play()
		emit_signal("crossed")
		hasCrossed = true
