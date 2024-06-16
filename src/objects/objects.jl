module Objects

using GLMakie, FileIO

abstract type Object end
abstract type GroundObject <: Object end
abstract type Tank <: GroundObject end
abstract type AtomicObject <: Object end
abstract type TemporaryAtomicObject <: AtomicObject end
abstract type Projectile <: TemporaryAtomicObject end

export Object, GroundObject, Tank, AtomicObject, TemporaryAtomicObject, Projectile

include("general_objects.jl")
export Turret, TankHull, ComposedObject, StraightPropelling

include("simple_tank.jl")
export SimpleTank

include("big_tank.jl")
export BigTank

end