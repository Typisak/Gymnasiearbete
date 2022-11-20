extends CanvasLayer

func _on_Player_death():
	$".".show()
	$CountDown.start()


func _on_Player_respawn():
	$".".hide()

func _physics_process(delta):
	$Label2.text = "Respawning in: " + str(round($CountDown.time_left))
