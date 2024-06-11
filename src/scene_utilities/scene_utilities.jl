module SceneUtilities

using GLMakie
using ...Objects

include("keyboard_input.jl")
export init_keyboard_input

include("update_scene.jl")
export update_scene, init_keyboard_input, display_object

end