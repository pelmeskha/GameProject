module SceneUtilities

using GLMakie, Random, ColorTypes, FileIO
using ...Objects
using ...Geometry

const  global_dt = 0.006

include("background.jl")
export display_background!, generate_background

include("keyboard_input.jl")
export init_keyboard_input

include("mark_1.jl")
export init_input, display_object, remove_object_from_scene

include("spawn_functions.jl")
export big_tank_shot, spawn_straight_propelling

include("mark_2.jl")
export update_scene!

end