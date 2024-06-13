struct Displacement
    x::Float64
    y::Float64
end
struct Turret <: AtomicObject
    x::Observable{Float64}
    y::Observable{Float64}
    angle::Observable{Float64}
    angle_speed::Real
    image
    pic_width::Real
    pic_height::Real
    displacement::Displacement
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
    image
    pic_width::Real
    pic_height::Real
    displacement::Displacement
    TankHull(
        x, y, vx, vy, angle, angle_speed, acceleration, max_speed, forward_friction, side_friction, image, pic_width, pic_height
    ) = new(
        x, y, vx, vy, angle, angle_speed, acceleration, max_speed, forward_friction, side_friction, image, pic_width, pic_height
    )
end
