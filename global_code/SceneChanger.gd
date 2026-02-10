extends Node

##como usar
#func _on_play_pressed() -> void:
#	SceneChanger.change_to("res://scenes/game.tscn", true)
##

var _busy := false

# Change to a scene by file path (recommended).
func change_to(path: String, fade: bool = false, fade_time: float = 0.2) -> void:
	if _busy:
		return
	_busy = true

	if fade:
		await _fade_out(fade_time)

	var err := get_tree().change_scene_to_file(path)
	if err != OK:
		push_error("SceneChanger: failed to change scene to '%s' (err=%s)" % [path, str(err)])

	if fade:
		await _fade_in(fade_time)

	_busy = false


# Change to a PackedScene (useful if you preload scenes).
func change_to_packed(scene: PackedScene, fade: bool = false, fade_time: float = 0.2) -> void:
	if _busy:
		return
	_busy = true

	if fade:
		await _fade_out(fade_time)

	var err := get_tree().change_scene_to_packed(scene)
	if err != OK:
		push_error("SceneChanger: failed to change scene (err=%s)" % str(err))

	if fade:
		await _fade_in(fade_time)

	_busy = false


# --- Optional fade (no extra nodes needed) ---
func _fade_out(t: float) -> void:
	var vp := get_tree().root
	var rect := _ensure_fade_rect(vp)
	rect.visible = true
	rect.modulate.a = 0.0

	var tw := create_tween()
	tw.tween_property(rect, "modulate:a", 1.0, t)
	await tw.finished

func _fade_in(t: float) -> void:
	var vp := get_tree().root
	var rect := _ensure_fade_rect(vp)
	rect.visible = true
	rect.modulate.a = 1.0

	var tw := create_tween()
	tw.tween_property(rect, "modulate:a", 0.0, t)
	await tw.finished
	rect.visible = false

func _ensure_fade_rect(vp: Window) -> ColorRect:
	var nombre := "__SceneChangerFade__"
	var rect := vp.get_node_or_null(nombre) as ColorRect
	if rect:
		return rect

	rect = ColorRect.new()
	rect.name = nombre
	rect.color = Color.BLACK
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.visible = false
	rect.modulate.a = 0.0
	vp.add_child(rect)
	vp.move_child(rect, vp.get_child_count() - 1) # keep on top

	return rect
