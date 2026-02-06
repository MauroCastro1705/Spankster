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

#barras de stats
@export var Dolor:Control
@export var Placer:Control
@export var Tolerancia:Control
@export var herramienta:Control

#sprite
@export var butt_1:Sprite2D

@onready var colorInicial
var colorZona1 := Color(0, 1, 0.5)
var colorZona2 := Color(1, 0.084, 0.08)
var colorSpank
var zona1_multi:float = 1.0
var zona2_multi:float = 1.25
var spank_multi

var arma_elegida

func _ready() -> void:
	colorInicial = butt_1.modulate
	print(colorInicial)
	spank.connect(se_hizo_spank)
	hit_cooldown.wait_time = Global.spank_timer
	Dolor.set_value()
	Placer.set_value()
	Tolerancia.set_value()
	arma_elegida = FLOGGER
	Global.player_score = 0
	
	

func hitCulo():
	if canSpankTimer and canSpankZona:
		butt_1.modulate = colorSpank
		hit_timer.start()
		hit_cooldown.start()
		canSpankTimer = false
		emit_signal("spank")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("golpe"):
		hitCulo()
	elegir_arma()
	

func se_hizo_spank():
	print("spank hecho")
	calcular_dmg()

func zona1_act():
	colorSpank = colorZona1
	canSpankZona = true
	spank_multi = zona1_multi
	print("zona1")

func zona2_act():
	colorSpank = colorZona2
	canSpankZona = true
	spank_multi = zona2_multi
	print("zona2")

func reset_spank():
	canSpankZona = false
	colorSpank = colorInicial
	spank_multi = 1
	print("spank reset")

func _on_hit_cooldown_timeout() -> void:
	canSpankTimer = true

func _on_hit_timer_timeout() -> void:
	butt_1.modulate = colorInicial

func elegir_arma():
	if Input.is_action_just_pressed("arma1"):
		activar_arma(FLOGGER)
	if  Input.is_action_just_pressed("arma2"):
		activar_arma(MANO)
	if  Input.is_action_just_pressed("arma3"):
		activar_arma(PALMETA)
	if  Input.is_action_just_pressed("arma4"):
		activar_arma(VARILLA)

func activar_arma(arma):
	arma_elegida = arma
	print(arma_elegida.name)
	herramienta.select_tool(arma)
	herramienta.set_tool()

func calcular_dmg():
	if arma_elegida:
		update_global_var()
		game_over_check()
		Dolor.update_dolor(arma_elegida.dolor * spank_multi)
		Placer.update_placer(arma_elegida.placer * spank_multi)
		Tolerancia.disminuir_tolerancia(arma_elegida.tolerancia * spank_multi)
		print("dolor: " , arma_elegida.dolor * spank_multi)
		print("placer: " , arma_elegida.placer * spank_multi)
		print("tolerancia: " , arma_elegida.tolerancia * spank_multi)

func update_global_var():
	Global.dolor += arma_elegida.dolor * spank_multi
	Global.placer += arma_elegida.placer * spank_multi
	Global.tolerancia -= arma_elegida.tolerancia * spank_multi

func game_over_check():
	if Global.tolerancia <= 0:
		canSpankZona = false
		Global.gameOver.emit()
		return
