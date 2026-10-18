extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var crossed_point: Area2D = $"../CrossedPoint"
@onready var crossed_point_2: Area2D = $"../CrossedPoint2"
@onready var crossed_point_3: Area2D = $"../CrossedPoint3"
@onready var crossed_point_4: Area2D = $"../CrossedPoint4"
@onready var game_manager: Node = %GameManager
@onready var main_menu: CanvasLayer = $"../GameManager/MainMenu/CanvasLayer"

@export var speed: float = 300.0

var isDead = false
var canMove = false

var friend_body = null

var animSpeed = 0.0

var total: int = 0

func _ready() -> void:
	crossed_point.crossed.connect(_sprite_update)
	crossed_point_2.crossed.connect(_sprite_update)
	crossed_point_3.crossed.connect(_sprite_update)
	crossed_point_4.crossed.connect(_sprite_normal)
	main_menu.start.connect(start_game)

func _physics_process(delta: float) -> void:
	
	if isDead or !canMove:
		return
	
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	direction = direction.normalized()
	
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	
	velocity = direction * speed
	
	if friend_body!=null and Input.is_action_just_pressed("interact"):
		game_manager.add_count()
		game_manager.add_score(100)
		Collect.play()
		friend_body.queue_free()
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Vehicles") and !isDead:
		animated_sprite.play("dead")
		BackgroundMusic.stop()
		BackgroundMusic1.stop()
		BackgroundMusic2.stop()
		BackgroundMusic3.stop()
		BackgroundMusic4.stop()
		Break.play()
		isDead = true
		await Break.finished
		game_manager.player_dead()
	if body.is_in_group("Friends"):
		friend_body = body
	if body.is_in_group("Floppy"):
		game_manager.show_save()
	if body.is_in_group("Safehaven"):
		hide()
		isDead = true
		game_manager.player_won()
		
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	friend_body = null
	game_manager.hide_save()
	
func _sprite_update():
	animSpeed+=1.0
	animated_sprite.sprite_frames.set_animation_speed("default", animSpeed)
	total += 100
	game_manager.add_score(total)

func _sprite_normal():
	total += 100
	game_manager.add_score(total)
	animated_sprite.sprite_frames.set_animation_speed("default", 1.0)

func start_game():
	canMove = true
