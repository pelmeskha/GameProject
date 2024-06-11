function display_object(ax, object)
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
function update_ground_object_position(object::GroundObject, input)
    w_pressed, a_pressed, s_pressed, d_pressed = input
    if w_pressed[]
        object.vx[] += object.acceleration * sin(object.angle[])
        object.vy[] += object.acceleration * cos(object.angle[])
    end
    if a_pressed[]
        object.angle[] -= object.angle_speed
    end
    if s_pressed[]
        object.vx[] -= object.acceleration * sin(object.angle[])
        object.vy[] -= object.acceleration * cos(object.angle[])
    end
    if d_pressed[]
        object.angle[] += object.angle_speed
    end
    object.vx[] *= object.friction
    object.vy[] *= object.friction
    speed = sqrt(object.vx[]^2 + object.vy[]^2)
    if speed > object.max_speed
        object.vx[] *= object.max_speed / speed
        object.vy[] *= object.max_speed / speed
    end
    object.x[] += object.vx[]
    object.y[] += object.vy[]
end
function update_scene(fig, ax, ground_objects, input)
    while isopen(fig.scene)
        for object in ground_objects
            update_ground_object_position(object::GroundObject, input)
        end
        sleep(0.001)
    end
end