extends Node2D
@onready var butt_1: Sprite2D = $Butt1
@onready var colorInicial
@onready var hit_timer: Timer = $hit_timer
signal spank
@onready var hit_cooldown: Timer = $hit_cooldown
@onready var canSpankTimer:bool = true
@onready var canSpankZona:bool = false
@onready var spankeableZone:bool = false
@onready var zona_1: Area2D = $zona1
@onready var zona_2: Area2D = $zona2

var colorZona1 := Color(0, 1, 0.5)
var colorZona2 := Color(1, 0.084, 0.08)
var colorSpank


func _ready() -> void:
	colorInicial = butt_1.modulate
	print(colorInicial)
	spank.connect(se_hizo_spank)
	hit_cooldown.wait_time = Global.spank_timer
	


func hitCulo():
	if canSpankTimer and canSpankZona:
		butt_1.modulate = colorSpank
		hit_timer.start()
		hit_cooldown.start()
		canSpankTimer = false
		emit_signal("spank")
	

func _on_hit_timer_timeout() -> void:
	butt_1.modulate = colorInicial
	
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("golpe"):
		hitCulo()


func se_hizo_spank():
	print("spank hecho")


func _on_hit_cooldown_timeout() -> void:
	canSpankTimer = true


func zona1_act():
	colorSpank = colorZona1
	canSpankZona = true
	print("zona1")

func zona2_act():
	colorSpank = colorZona2
	canSpankZona = true
	print("zona2")

func reset_spank():
	canSpankZona = false
	colorSpank = colorInicial
	print("spank reset")

func _on_zona_1_mouse_entered() -> void:
	zona1_act()


func _on_zona_1_mouse_exited() -> void:
	reset_spank()


func _on_zona_2_mouse_entered() -> void:
	zona2_act()


func _on_zona_2_mouse_exited() -> void:
	reset_spank()
