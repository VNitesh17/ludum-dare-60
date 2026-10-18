extends AudioStreamPlayer

func _ready():
	play()



func _on_finished() -> void:
	play()
