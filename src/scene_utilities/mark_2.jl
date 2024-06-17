function proceed_interactions(object::Tank, input, ax, temporary_objects, current_time)
    _, _, _, _, _, left_mouse_pressed_continuous, left_mouse_pressed_single = input
    if left_mouse_pressed_single[]
        push!(
            temporary_objects[],
            spawn_straight_propelling(
                ax,
                big_tank_shot(
                    object.turret.x[],
                    object.turret.y[],
                    object.turret.angle[],
                    current_time,
                ),
            )
        )
        left_mouse_pressed_single[]=false
    end
end
function update_scene!(fig, ax, objects, temporary_objects, input)
    last_time = time()
    while isopen(fig.scene)
        current_time = time()
        delta_time = current_time - last_time
        if delta_time >= global_dt
            for object in objects
                update_position(object, input, delta_time)
                proceed_interactions(object, input, ax, temporary_objects, current_time)
            end
            filter!(composed_object -> begin
                kill = update_position(composed_object.object, current_time, delta_time)
                if kill
                    remove_object_from_scene(ax, composed_object.scene_instance)
                    composed_object.scene_instance = nothing
                    composed_object.object = nothing
                    return false
                end
                return true
            end, temporary_objects[])
            last_time = current_time
        end
        yield()
    end
end

