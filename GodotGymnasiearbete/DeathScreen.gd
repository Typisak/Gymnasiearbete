extends CanvasLayer

func _on_Player_death():
	$".".show()


func _on_Player_respawn():
	$".".hide()
