mutable struct ComposedObject
    object::Union{Object,Nothing}
    scene_instance::Any
    hash::UInt64
    ComposedObject(object, scene_instance) = new(object, scene_instance, hash(rand()))
end
struct Turret <: AtomicObject
    x::Observable{Float64}
    y::Observable{Float64}
    angle::Observable{Float64}
    angle_speed::Real
    image::Any
    pic_width::Real
    pic_height::Real
    Turret(x, y, angle, angle_speed, image, pic_width, pic_height) =
        new(x, y, angle, angle_speed, image, pic_width, pic_height)
end
struct TankHull <: AtomicObject
    x::Observable{Float64}
    y::Observable{Float64}
    vx::Observable{Float64}
    vy::Observable{Float64}
    angle::Observable{Float64}
    angle_speed::Real
    acceleration::Real
    max_speed::Real
    forward_friction::Real
    side_friction::Real
    image::Any
    pic_width::Real
    pic_height::Real
    TankHull(
        x,
        y,
        vx,
        vy,
        angle,
        angle_speed,
        acceleration,
        max_speed,
        forward_friction,
        side_friction,
        image,
        pic_width,
        pic_height,
    ) = new(
        x,
        y,
        vx,
        vy,
        angle,
        angle_speed,
        acceleration,
        max_speed,
        forward_friction,
        side_friction,
        image,
        pic_width,
        pic_height,
    )
end
struct StraightPropelling <: Projectile
    x::Observable{Float64}
    y::Observable{Float64}
    angle::Real
    speed::Real
    t_life::Observable{Float64} # unused
    t_end::Real
    image::Any
    pic_width::Real
    pic_height::Real
    StraightPropelling(x, y, angle, speed, t_end, image, pic_width, pic_height) =
        new(x, y, angle, speed, Observable(0.0), t_end, image, pic_width, pic_height)
end
