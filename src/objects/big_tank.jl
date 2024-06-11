struct BigTank <: GroundObject
    x::Observable{Float64}
    y::Observable{Float64}
    vx::Observable{Float64}
    vy::Observable{Float64}
    angle::Observable{Float64}
    angle_speed::Real
    acceleration::Real
    max_speed::Real
    friction::Real
    image
    pic_width::Real
    pic_height::Real
    BigTank(x, y, vx, vy, angle, angle_speed, acceleration, max_speed, friction) = 
        new(
            x, y, vx, vy, angle, angle_speed, acceleration, max_speed, friction,
            load("src/textures/big_tank/pixil-frame-0.png"), 13.0, 13.0,
        )
    BigTank(x, y, vx, vy, angle) = BigTank(
        x, y, vx, vy, angle,
        0.02,  # angle_speed
        0.01, # acceleration
        0.6,   # max_speed
        0.99,  # friction
    )
    BigTank(x, y) = BigTank(x, y, Observable(0.0), Observable(0.0), Observable(0.0))
    BigTank() = BigTank(Observable(0.0), Observable(0.0))
end

