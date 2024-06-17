big_tank_shot = (x, y, angle) ->  StraightPropelling(
    Observable(x), Observable(y), angle, 3.0, 0.3, load("src/textures/big_tank/shell.png"), 2, 1)

function spawn_straight_propelling(ax,shot)
    img = display_object(ax, shot)
    return ComposedObject(shot, img)
end