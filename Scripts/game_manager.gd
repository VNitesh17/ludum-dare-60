extends Node
@onready var score_hud: Label = $"../CanvasLayer/Control/HBoxContainer/Score/Label"

var score = 0

func _ready():
	update_score()
	
func update_score():
	score_hud.text = "Score: " + str(score)

func add_score(amount: int):
	score += amount
	update_score()
