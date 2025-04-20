extends Area2D

const SPEED = 2000
const BULLET_RANGE = 1200
var travelled_distance = 0;
var shooter: CharacterBody2D

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta 
	
	if travelled_distance > BULLET_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body != shooter and body.has_method("take_damage"):
		body.take_damage(10)
		queue_free()



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets") and area != self:
		queue_free()
		area.queue_free()
