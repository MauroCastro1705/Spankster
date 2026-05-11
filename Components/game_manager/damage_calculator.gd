extends Node
class_name DamageCalculator
var Dolor = null
var Placer = null
var Tolerancia = null

func setup(dolor_node=null, placer_node=null, tolerancia_node=null) -> void:
	Dolor = dolor_node
	Placer = placer_node
	Tolerancia = tolerancia_node

func apply_damage(selected, spank_multi: float) -> bool:
	if selected == null:
		push_warning("No weapon provided to DamageCalculator.apply_damage")
		return false

	var amount_dolor = selected.dolor * spank_multi
	var amount_placer = selected.placer * spank_multi
	var amount_tolerancia = selected.tolerancia * spank_multi

	# Update UI bars (if provided) instead of touching globals
	if Dolor:
		Dolor.update_dolor(amount_dolor)
	if Placer:
		Placer.update_placer(amount_placer)
	if Tolerancia:
		Tolerancia.disminuir_tolerancia(amount_tolerancia)

	# Determine game over from the tolerance bar (GameManager persists to Global)
	if Tolerancia:
		return Tolerancia.current_value <= 0
	return false
