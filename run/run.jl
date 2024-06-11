using Revise, GLMakie, FileIO
using GameProject.SceneUtilities: init_keyboard_input, update_scene, display_object
using GameProject.Objects

fig = Figure(; size = (1920, 1080))
ax1 = fig[1, 1] = Axis(fig, aspect=DataAspect(), limits = (-100, 100, -100, 100))

tank_1 = BigTank(0.0,0.0)
display_object(ax1,tank_1)

tank_2 = SimpleTank(3.0,0.0)
display_object(ax1,tank_2)

input = init_keyboard_input(fig)

display(fig)
@async update_scene(fig, ax1, [tank_1, tank_2], input)
