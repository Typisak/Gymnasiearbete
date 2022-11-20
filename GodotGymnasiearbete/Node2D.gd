extends Node2D

signal pause()

func _physics_process(_delta):
	if Input.is_action_just_pressed("character_reset"):
		get_tree().reload_current_scene()
	
	elif Input.is_action_just_pressed("Pause"):
		$PauseMenu.show()
		emit_signal("pause")
		get_tree().paused = true
