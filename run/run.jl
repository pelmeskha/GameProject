using Revise, GLMakie, FileIO
using GameProject.SceneUtilities: init_input, update_scene, display_object
using GameProject.Objects

fig = Figure(; size = (1920, 1080), fps=144)
ax = fig[1, 1] = Axis(fig, aspect=DataAspect(), limits = (-100, 100, -100, 100))

tank_1 = BigTank(0.0,0.0)
display_object(ax,tank_1)

tank_2 = SimpleTank(30.0,0.0)
display_object(ax,tank_2)

tank_3 = SimpleTank(20.0,20.0)
display_object(ax,tank_3)

tank_4 = SimpleTank(-30.0,20.0)
display_object(ax,tank_4)

input = init_input(fig, ax)

display(fig)
@async update_scene(fig, ax, [tank_1, tank_2, tank_3, tank_4], input)
