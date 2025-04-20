extends CharacterBody2D

signal update
signal died

const BULLET = preload("res://scenes/bullet.tscn")
const SPEED = 500
const ARENA_SIZE = Vector2(290, 296) 


var health = 100;
var super_power = false

func _ready() -> void:
	emitUpdates()

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("l_left", "l_right", "l_up", "l_down")
	velocity = direction * SPEED
	move_and_slide()
	
	position.x = clamp(position.x, 10, ARENA_SIZE.x)
	position.y = clamp(position.y, 10, ARENA_SIZE.y)
	
	if Input.is_action_just_pressed("l_shoot"):
		shoot()
	
	if Input.is_action_just_pressed("lsp1"):
		super_power = true;


func shoot():
	var bullet = BULLET.instantiate()
	bullet.global_position = %LShootingPoint.global_position
	bullet.shooter = self
	get_tree().current_scene.add_child(bullet)


func take_damage(amount = 10):
	decrease_health(amount)
	if health <= 0:
		die()
		
func increase_health(num = 10):
	health += num
	emitUpdates()

func decrease_health(num = 10):
	health -= num
	emitUpdates()

func die():
	died.emit()
	queue_free()

func emitUpdates():
	update.emit({'health': health})
