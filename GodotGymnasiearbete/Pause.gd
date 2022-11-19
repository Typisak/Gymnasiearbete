extends CanvasLayer

func _ready():
	$Continue.grab_focus()

func _on_Continue_pressed():
	$".".hide()
	get_tree().paused = false

func _on_Exit_to_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")



func _on_Continue_mouse_entered():
	$Continue.grab_focus()


func _on_Exit_to_main_menu_mouse_entered():
	$"Exit to main menu".grab_focus()
