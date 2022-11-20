extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://Node2D.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://Options.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_Start_mouse_entered():
	$VBoxContainer/Start.grab_focus()

func _on_Options_mouse_entered():
	$VBoxContainer/Options.grab_focus()

func _on_Exit_mouse_entered():
	$VBoxContainer/Exit.grab_focus()
