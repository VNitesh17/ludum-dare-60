extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var crossed_point: Area2D = $"../CrossedPoint"
@onready var crossed_point_2: Area2D = $"../CrossedPoint2"
@onready var crossed_point_3: Area2D = $"../CrossedPoint3"
@onready var crossed_point_4: Area2D = $"../CrossedPoint4"

@export var speed: float = 300.0

var isDead = false

var friend_body = null

var animSpeed = 0.0

func _ready() -> void:
	crossed_point.crossed.connect(_sprite_update)
	crossed_point_2.crossed.connect(_sprite_update)
	crossed_point_3.crossed.connect(_sprite_update)
	crossed_point_4.crossed.connect(_sprite_normal)

func _physics_process(delta: float) -> void:
	
	if isDead:
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
		#add score and count
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
	if body.is_in_group("Friends"):
		friend_body = body
	if body.is_in_group("Safehaven"):
		hide()
		isDead = true
		#gameover
		
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	friend_body = null
	
func _sprite_update():
	animSpeed+=1.0
	animated_sprite.sprite_frames.set_animation_speed("default", animSpeed)

func _sprite_normal():
	animated_sprite.sprite_frames.set_animation_speed("default", 1.0)
