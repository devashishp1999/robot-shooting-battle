extends Node2D

@onready var player_areas: Node2D = $PlayerAreas
@onready var lsp_bar: ProgressBar = %LSPBar
@onready var lsp_timer: Timer = %LSPTimer

func _ready() -> void:
	pass


func _on_lsp_timer_timeout() -> void:
	var LPlayer: CharacterBody2D = player_areas.player_left
	
	if LPlayer.superpower_timer_progress < LPlayer.superpower_fill_time:
		LPlayer.superpower_timer_progress += 0.1
		var progress = (LPlayer.superpower_timer_progress / LPlayer.superpower_fill_time) * 100.0
		lsp_bar.value = progress
	else:
		LPlayer.can_use_superpower = true
		lsp_bar.value = 100
		lsp_timer.stop()
