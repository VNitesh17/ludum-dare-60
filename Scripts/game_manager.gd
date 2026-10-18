extends Node
@onready var score_hud: Label = $"../CanvasLayer/Control/HBoxContainer/Score/Label"
@onready var friends_count: Label = $"../CanvasLayer/Control2/HBoxContainer/Friends_Count/Label"
@onready var floppy_text: Label = $"../CanvasLayer/Control3/HBoxContainer/floppy_text/Label"

var score = 0
var count = 0

func _ready():
	update_score()
	update_count()
	hide_save()
	
func update_score():
	score_hud.text = "Score: " + str(score)
	
func update_count():
	friends_count.text = "Friends Saved: " + str(count) + "/4 "

func add_score(amount: int):
	score += amount
	update_score()

func add_count():
	count += 1
	update_count()
	
func show_save():
	floppy_text.text = "He's beyond saving"
	
func hide_save():
	floppy_text.text = ""
