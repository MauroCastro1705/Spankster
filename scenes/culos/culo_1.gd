extends Node2D

@onready var game_manager: Node = $GameManager
@onready var zona_1: Area2D = $zona1
@onready var zona_2: Area2D = $zona2


func _ready() -> void:
	pass



func _on_zona_1_mouse_entered() -> void:
	game_manager.zona1_act()


func _on_zona_1_mouse_exited() -> void:
	game_manager.reset_spank()


func _on_zona_2_mouse_entered() -> void:
	game_manager.zona2_act()


func _on_zona_2_mouse_exited() -> void:
	game_manager.reset_spank()
