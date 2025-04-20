extends Node2D

signal updated

@onready var player_left: CharacterBody2D = $PlayerLeft
@onready var player_right: CharacterBody2D = $PlayerRight


# updates health-bar value and color
func updateHealthBar(healthBar: ProgressBar, health: int):
	healthBar.value = health
	var fill_style := StyleBoxFlat.new()
	
	if health > 50:
		fill_style.bg_color = Color("#00b487")  # Green
	elif health > 20:
		fill_style.bg_color = Color("#ffa500")  # Orange
	else:
		fill_style.bg_color = Color("#f66156")  # Red
	
	healthBar.add_theme_stylebox_override('fill', fill_style)

func _on_player_left_update(update) -> void:
	var healthBar: ProgressBar = get_parent().get_node("%LHealthBar")
	updateHealthBar(healthBar, update.health)


func _on_player_right_update(update) -> void:
	var healthBar: ProgressBar = get_parent().get_node("%RHealthBar")
	updateHealthBar(healthBar, update.health)
	


func _on_player_left_died() -> void:
	print('left died')
	get_tree().paused = true


func _on_player_right_died() -> void:
	print('right died')
	get_tree().paused = true
