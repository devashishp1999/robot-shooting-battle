extends Node2D

@onready var player_areas: Node2D = $PlayerAreas

@onready var lsp_bar: ProgressBar = %LSPBar
@onready var lsp_timer: Timer = %LSPTimer

@onready var rsp_bar: ProgressBar = %RSPBar
@onready var rsp_timer: Timer = %RSPTimer

func _ready() -> void:
	set_health_bars()
	set_player_names()



func set_health_bars():
	lsp_bar.value = 0 
	rsp_bar.value = 0
	lsp_timer.start()
	rsp_timer.start()

func set_player_names():
	%LPlayerName.text = Global.l_player_name
	%RPlayerName.text = Global.r_player_name

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

func _on_rsp_timer_timeout() -> void:
	var RPlayer: CharacterBody2D = player_areas.player_right
	
	if RPlayer.superpower_timer_progress < RPlayer.superpower_fill_time:
		RPlayer.superpower_timer_progress += 0.1
		var progress = (RPlayer.superpower_timer_progress / RPlayer.superpower_fill_time) * 100.0
		rsp_bar.value = progress
	else:
		RPlayer.can_use_superpower = true
		rsp_bar.value = 100
		rsp_timer.stop()


func _on_player_areas_lsp() -> void:
	lsp_timer.start()


func _on_player_areas_rsp() -> void:
	rsp_timer.start()
