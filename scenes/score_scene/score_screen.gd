extends Node2D
@onready var puntaje: Label = $HBoxContainer/puntaje

func _ready() -> void:
	var score = Global.player_score
	puntaje.text = str(score)


func _on_button_pressed() -> void:
	SceneChanger.change_to("res://scenes/main_menu/menu.tscn", true)
