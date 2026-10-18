extends CanvasLayer
@onready var final_score: Label = $Final_Score
@onready var friends_saved: Label = $Friends_Saved
@onready var canvas_layer: CanvasLayer = $"../../../CanvasLayer"
@onready var game_manager: Node = $"../.."


func _ready() -> void:
	visible = false
	
func show_game_over():
	visible = true
	canvas_layer.visible = false
	friends_saved.text = "Friends saved: "+str(game_manager.get_count())
	final_score.text = "Score: "+str(game_manager.get_score())
	


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	BackgroundMusic.play()
