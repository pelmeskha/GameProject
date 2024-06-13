module SceneUtilities

using GLMakie
using ...Objects
using ...Geometry

include("keyboard_input.jl")
export init_keyboard_input

include("update_scene.jl")
export update_scene, init_input, display_object

end