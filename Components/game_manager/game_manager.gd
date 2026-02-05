extends Node
const FLOGGER = preload("uid://d4jmi1wtnawp0")
const MANO = preload("uid://diboyf6rdn73n")
const PALMETA = preload("uid://bqg0mxbtf6ldd")
const VARILLA = preload("uid://xgad24r2eaci")



@onready var hit_timer: Timer = $hit_timer
signal spank
@onready var hit_cooldown: Timer = $hit_cooldown
@onready var canSpankTimer:bool = true
@onready var canSpankZona:bool = false
@onready var spankeableZone:bool = false

@export var butt_1:Sprite2D

@onready var colorInicial
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
	
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("golpe"):
		hitCulo()


func se_hizo_spank():
	print("spank hecho")


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



func _on_hit_cooldown_timeout() -> void:
	canSpankTimer = true


func _on_hit_timer_timeout() -> void:
	butt_1.modulate = colorInicial
