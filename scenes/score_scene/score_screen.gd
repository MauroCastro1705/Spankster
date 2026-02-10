extends Node2D
@onready var puntaje: Label = $HBoxContainer/puntaje

func _ready() -> void:
	puntaje.text = str(Global.player_score)


func _on_button_pressed() -> void:
	SceneChanger.change_to("res://scenes/main_menu/menu.tscn", true)
