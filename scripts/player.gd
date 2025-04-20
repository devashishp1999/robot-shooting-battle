extends CharacterBody2D

const SPEED = 500
const BULLET_SPEED = 2000
var arena_size = Vector2(284, 284) 

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var motion = Vector2()
	
	if Input.is_action_just_pressed("move_up"):
		motion.y -= 1
	if Input.is_action_just_pressed("move_down"):
		motion.y += 1
	if Input.is_action_just_pressed("move_right"):
		motion.x += 1
	if Input.is_action_just_pressed("move_left"):
		motion.x -= 1
		
	velocity = motion.normalized() * SPEED
	move_and_slide()
	
	position.x = clamp(position.x, -arena_size.x/2, arena_size.x/2)
	position.y = clamp(position.y, -arena_size.y/2, arena_size.y/2)
	
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
