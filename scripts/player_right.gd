extends CharacterBody2D

signal update
signal died

const BULLET = preload("res://scenes/bullet.tscn")

const SPEED = 500
const ARENA_SIZE = Vector2(290, 296) 

var health = 100;
var has_super_power = false

func _ready() -> void:
	emitUpdates()

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("r_left", "r_right", "r_up", "r_down")
	velocity = direction * SPEED
	move_and_slide()
	
	position.x = clamp(position.x, 320, 310+ARENA_SIZE.x)
	position.y = clamp(position.y, 10, ARENA_SIZE.y)
	
	if Input.is_action_just_pressed("r_shoot"):
		shoot()
	
	if Input.is_action_just_pressed("rsp1"):
		if has_super_power:
			superPower()


func shoot():
	var bullet = BULLET.instantiate()
	bullet.global_position = %RShootingPoint.global_position
	bullet.shooter = self
	bullet.rotation_degrees = 180
	get_tree().current_scene.add_child(bullet)

	
func superPower():
	if !has_super_power:
		return
	
	print('Right SUPER POWER');
	has_super_power = false;

func take_damage(amount = 10):
	decrease_health(amount)
	if health <= 0:
		die()

func increase_health(amount = 10):
	health += amount
	emitUpdates()

func decrease_health(amount = 10):
	health -= amount
	emitUpdates()

func die():
	died.emit()
	queue_free()

func emitUpdates():
	update.emit({'health': health})
