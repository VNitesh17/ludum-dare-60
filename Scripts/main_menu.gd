extends CanvasLayer

signal start
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	BackgroundMusic.stop()
	MainMenuMusic.play()



func _on_play_button_pressed() -> void:
	visible = false
	MainMenuMusic.stop()
	BackgroundMusic.play()
	emit_signal("start")
