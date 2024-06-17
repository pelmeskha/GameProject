using Revise, GLMakie, FileIO
using GameProject.SceneUtilities:
    init_input,
    update_scene!,
    display_object,
    generate_background,
    display_background!,
    remove_object_from_scene,
    big_tank_shot,
    spawn_straight_propelling
using GameProject.Objects

# Создание сцены и отрисовка изображения
fig = Figure(; size = (1920, 1080), fps = 144)
N_x, N_y = 200, 200
ax =
    fig[1, 1] =
        Axis(fig, aspect = DataAspect(), limits = (-N_x / 2, N_x / 2, -N_y / 2, N_y / 2))
deactivate_interaction!(ax, :rectanglezoom)

image = generate_background(
    N_x,
    N_y,
    300;
    min_color = (1.0, 1.0, 1.0),
    max_color = (0.7, 0.8, 0.7),
)
display_background!(ax, image)

display(fig)

tank_1 = BigTank(0.0, 0.0)
t1 = display_object(ax, tank_1)

tank_2 = SimpleTank(30.0, 0.0)
display_object(ax, tank_2)

tank_3 = SimpleTank(20.0, 20.0, 0.0, 0.0, 1.0)
display_object(ax, tank_3)

tank_4 = SimpleTank(-30.0, 20.0)
display_object(ax, tank_4)

temp_objects = Observable([])

input = init_input(fig, ax)

display(fig)
@async update_scene!(fig, ax, [tank_4], temp_objects, input)
