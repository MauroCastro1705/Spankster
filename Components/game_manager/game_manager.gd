extends Node
class_name GameManager
const FLOGGER = preload("uid://d4jmi1wtnawp0")
const MANO = preload("uid://diboyf6rdn73n")
const PALMETA = preload("uid://bqg0mxbtf6ldd")
const VARILLA = preload("uid://xgad24r2eaci")
@export var hit_vfx_scene: PackedScene
var hit_vfx_parent



@onready var hit_timer: Timer = $hit_timer
signal spank
@onready var hit_cooldown: Timer = $hit_cooldown
var can_spank_timer := true
var can_spank_zone := false

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

var weapon = null
var arma_elegida
var weapon_by_action := {}

func _ready() -> void:
	colorInicial = butt_1.modulate
	print(colorInicial)
	spank.connect(se_hizo_spank)
	hit_cooldown.wait_time = Global.spank_timer
	set_ui_values()
	arma_elegida = FLOGGER
	Global.player_score = 0
	weapon_by_action = {
		"arma1": FLOGGER,
		"arma2": MANO,
		"arma3": PALMETA,
		"arma4": VARILLA,
	}
	weapon = FLOGGER
	
func set_ui_values():
	Dolor.set_value()
	Placer.set_value()
	Tolerancia.set_value()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("golpe"):
		hitCulo()
		return

	# weapon selection
	for action in weapon_by_action.keys():
		if event.is_action_pressed(action):
			set_weapon(weapon_by_action[action])
			return

func set_weapon(new_weapon) -> void:
	weapon = new_weapon
	
func hitCulo():
	if can_spank_timer and can_spank_zone:
		butt_1.modulate = colorSpank
		_spawn_hit_vfx_at_mouse()
		hit_timer.start()
		hit_cooldown.start()
		can_spank_timer = false
		emit_signal("spank")
		
func _spawn_hit_vfx_at_mouse() -> void:
	if hit_vfx_scene == null:
		return

	var vfx := hit_vfx_scene.instantiate() as Node2D
	if vfx == null:
		push_warning("hit_vfx_scene root is not Node2D")
		return

	vfx.global_position = get_viewport().get_mouse_position()

	var parent = hit_vfx_parent
	if parent == null:
		parent = get_tree().current_scene
	parent.add_child(vfx)


func _process(_delta: float) -> void:
	elegir_arma()
	

func se_hizo_spank():
	print("spank hecho")
	_apply_damage()

func zona1_act():
	colorSpank = colorZona1
	can_spank_zone = true
	spank_multi = zona1_multi
	print("zona1")

func zona2_act():
	colorSpank = colorZona2
	can_spank_zone = true
	spank_multi = zona2_multi
	print("zona2")

func reset_spank():
	can_spank_zone = false
	colorSpank = colorInicial
	spank_multi = 1
	print("spank reset")

func _on_hit_cooldown_timeout() -> void:
	can_spank_timer = true

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

func _apply_damage() -> void:
	update_global_var()
	game_over_check()
	# Apply to UI
	Dolor.update_dolor(weapon.dolor * spank_multi)
	Placer.update_placer(weapon.placer * spank_multi)
	Tolerancia.disminuir_tolerancia(weapon.tolerancia * spank_multi)


func update_global_var():
	Global.dolor += arma_elegida.dolor * spank_multi
	Global.placer += arma_elegida.placer * spank_multi
	Global.tolerancia -= arma_elegida.tolerancia * spank_multi

func game_over_check():
	if Global.tolerancia <= 0:
		can_spank_zone = false
		Global.gameOver.emit()
		SceneChanger.change_to("res://scenes/score_scene/score_screen.tscn", true)
		return
