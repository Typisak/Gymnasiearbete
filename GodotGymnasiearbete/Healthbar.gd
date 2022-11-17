extends CanvasLayer

func _on_Player_health_updated(health):
	$ProgressBar.value = health
