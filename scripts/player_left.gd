extends CharacterBody2D

signal update
signal super_power
signal died

const BULLET = preload("res://scenes/bullet.tscn")
const SPEED = 500
const ARENA_SIZE = Vector2(290, 296) 


var health = 100;
var can_use_superpower := false
var superpower_fill_time := 5.0  # seconds
var superpower_timer_progress := 0.0


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
		superPower()


func shoot():
	var bullet = BULLET.instantiate()
	bullet.global_position = %LShootingPoint.global_position
	bullet.shooter = self
	get_tree().current_scene.add_child(bullet)

func superPower():
	if !can_use_superpower:
		return
	
	super_power.emit()
	can_use_superpower = false
	superpower_timer_progress = 0.0

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
