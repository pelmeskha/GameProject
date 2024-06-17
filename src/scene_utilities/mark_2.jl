function proceed_interactions(object::Tank, input, ax, temporary_objects)
    _, _, _, _, _, left_mouse_pressed_continuous, left_mouse_pressed_single = input
    if left_mouse_pressed_single[]
        push!(temporary_objects[],spawn_straight_propelling(ax,big_tank_shot(object.turret.x[],object.turret.y[],object.turret.angle[])))
        left_mouse_pressed_single[]=false
    end
end
function update_scene!(fig, ax, objects, temporary_objects, input)
    while isopen(fig.scene)
        for object in objects
            update_position(object, input)
            proceed_interactions(object, input, ax, temporary_objects)
        end
        filter!(composed_object -> begin #TODO
            kill = update_position(composed_object.object)
            if kill
                remove_object_from_scene(ax, composed_object.scene_instance)
                composed_object.scene_instance = nothing
                composed_object.object = nothing
                return false
            end
            return true
        end, temporary_objects[])
        sleep(global_dt)
    end
end

