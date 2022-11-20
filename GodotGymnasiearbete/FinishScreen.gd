extends CanvasLayer

func _ready():
	$Restart.grab_focus()

func _on_Restart_pressed():
	$".".hide()
	get_tree().paused = false
	get_tree().change_scene("res://Node2D.tscn")

func _on_Exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")

func _on_Restart_mouse_entered():
	$Restart.grab_focus()

func _on_Exit_mouse_entered():
	$Exit.grab_focus()
