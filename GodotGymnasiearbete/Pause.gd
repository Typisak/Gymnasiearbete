extends CanvasLayer

func _on_Continue_pressed():
	$".".hide()
	get_tree().paused = false

func _on_ExitMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")

func _on_Continue_mouse_entered():
	$Continue.grab_focus()

func _on_ExitMenu_mouse_entered():
	$ExitMenu.grab_focus()

func _on_Node2D_pause():
	$Continue.grab_focus()
