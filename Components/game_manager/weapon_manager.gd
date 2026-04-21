extends Node
class_name WeaponManager

var weapon_by_action := {}
var weapon_paths := {
    "arma1": "res://resources/flogger.tres",
    "arma2": "res://resources/mano.tres",
    "arma3": "res://resources/palmeta.tres",
    "arma4": "res://resources/varilla.tres",
}

func load_weapon_registry() -> void:
    weapon_by_action.clear()
    for action in weapon_paths.keys():
        var path = weapon_paths[action]
        var res = ResourceLoader.load(path)
        if res == null:
            push_warning("Failed to load weapon resource: %s" % path)
        else:
            weapon_by_action[action] = res

func get_weapon(action: String):
    return weapon_by_action.get(action, null)

func get_default_weapon():
    return get_weapon("arma1")
