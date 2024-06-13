module Objects

using GLMakie, FileIO

abstract type Object end
abstract type GroundObject <: Object end
abstract type Tank <: GroundObject end
abstract type AtomicObject <: Object end

export Object, GroundObject, Tank, AtomicObject

include("general_objects.jl")
export Turret, TankHull, Displacement

include("simple_tank.jl")
export SimpleTank

include("big_tank.jl")
export BigTank

end