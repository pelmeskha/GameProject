module Objects

using GLMakie, FileIO

abstract type Object end
abstract type GroundObject <: Object end
export Object, GroundObject

include("simple_tank.jl")
export SimpleTank

include("big_tank.jl")
export BigTank

end