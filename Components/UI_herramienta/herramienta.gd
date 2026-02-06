extends Control
@onready var icono: TextureRect = %texture
@onready var nombre_label: Label = %Label
@onready var dolor_label: Label = %dolor
@onready var placer_label: Label = %placer
@onready var tolerancia_label: Label = %tolerancia
const FLOGGER = preload("uid://d4jmi1wtnawp0")

var choosen_tool

func set_tool():
	icono.texture = choosen_tool.icono
	nombre_label.text = choosen_tool.name
	dolor_label.text = "Dolor: " + str(choosen_tool.dolor)
	placer_label.text = "Placer: " + str(choosen_tool.placer)
	tolerancia_label.text = "Tolerancia: " + str(choosen_tool.tolerancia)
	print("tool seted")

func select_tool(tool:Resource):
	choosen_tool = tool
	
func _ready() -> void:
	select_tool(FLOGGER)
	set_tool()
