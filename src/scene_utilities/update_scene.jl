function display_object(ax, object::Object)
    img = image!(
        ax,
        (-(object.pic_width / 2), (object.pic_width / 2)),
        (-(object.pic_height / 2), (object.pic_height / 2)),
        object.image,
        transformation=Transformation(
            translation=lift((x_pos, y_pos) -> Vec3f(x_pos, y_pos, 0), object.x, object.y),
            rotation=lift(a -> Quaternion(0, 0, cos(a/2-pi/4), sin(a/2-pi/4)), object.angle),
        )
    )
    return img
end
function display_object(ax, object::AtomicObject)
    img = image!(
        ax,
        (-(object.pic_width / 2), (object.pic_width / 2)),
        (-(object.pic_height / 2), (object.pic_height / 2)),
        object.image,
        transformation= Transformation(
            translation=lift((x_pos, y_pos) -> Vec3f(x_pos, y_pos, 0), object.x, object.y),
            rotation=lift(a -> Quaternion(0, 0, cos(a/2-pi/4), sin(a/2-pi/4)), object.angle),
        ),
        interpolate=false,
    )
    return img
end
function display_object(ax, object::Tank)
    img1, img2 = display_object(ax, object.hull), display_object(ax, object.turret)
    return img1, img2
end
function update_position(object::Tank, input)
    w_pressed, a_pressed, s_pressed, d_pressed = input
    if w_pressed[]
        object.hull.vx[] += object.hull.acceleration * sin(object.hull.angle[])
        object.hull.vy[] += object.hull.acceleration * cos(object.hull.angle[])
    end
    if a_pressed[]
        object.hull.angle[] -= object.hull.angle_speed
        object.turret.angle[] -= object.hull.angle_speed
    end
    if s_pressed[]
        object.hull.vx[] -= object.hull.acceleration * sin(object.hull.angle[])
        object.hull.vy[] -= object.hull.acceleration * cos(object.hull.angle[])
    end
    if d_pressed[]
        object.hull.angle[] += object.hull.angle_speed
        object.turret.angle[] += object.hull.angle_speed
    end

    #= object.hull.vx[] *= object.hull.friction
    object.hull.vy[] *= object.hull.friction =#
    # Вычисление проекций скорости на оси танка
    forward_speed = object.hull.vx[] * sin(object.hull.angle[]) + object.hull.vy[] * cos(object.hull.angle[])
    side_speed = object.hull.vx[] * cos(object.hull.angle[]) - object.hull.vy[] * sin(object.hull.angle[])

    # Применение коэффициентов трения
    forward_friction = object.hull.forward_friction
    side_friction = object.hull.side_friction

    forward_speed *= forward_friction
    side_speed *= side_friction

    # Преобразование скоростей обратно в глобальные координаты
    object.hull.vx[] = forward_speed * sin(object.hull.angle[]) + side_speed * cos(object.hull.angle[])
    object.hull.vy[] = forward_speed * cos(object.hull.angle[]) - side_speed * sin(object.hull.angle[])
    
    speed = sqrt(object.hull.vx[]^2 + object.hull.vy[]^2)
    if speed > object.hull.max_speed
        object.hull.vx[] *= object.hull.max_speed / speed
        object.hull.vy[] *= object.hull.max_speed / speed
    end
    object.hull.x[] += object.hull.vx[]
    object.hull.y[] += object.hull.vy[]
end
function update_scene(fig, ax, objects, input)
    while isopen(fig.scene)
        for object in objects
            update_position(object, input)
        end
        sleep(0.001)
    end
end