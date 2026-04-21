extends Node
class_name DamageCalculator

func apply_damage(selected, spank_multi: float, Dolor, Placer, Tolerancia) -> bool:
    if selected == null:
        push_warning("No weapon provided to DamageCalculator.apply_damage")
        return false

    Global.add_dolor(selected.dolor * spank_multi)
    Global.add_placer(selected.placer * spank_multi)
    Global.reduce_tolerancia(selected.tolerancia * spank_multi)

    # Update UI
    if Dolor:
        Dolor.update_dolor(selected.dolor * spank_multi)
    if Placer:
        Placer.update_placer(selected.placer * spank_multi)
    if Tolerancia:
        Tolerancia.disminuir_tolerancia(selected.tolerancia * spank_multi)

    # Return whether game over occurred
    return Global.get_tolerancia() <= 0
