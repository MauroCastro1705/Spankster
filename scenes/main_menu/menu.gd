extends Node2D
#MENU

func _on_button_pressed() -> void:
	SceneChanger.change_to("res://scenes/tutorial/tutorial.tscn", true)
