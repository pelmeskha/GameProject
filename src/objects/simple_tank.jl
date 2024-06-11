struct SimpleTank <: GroundObject
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
    SimpleTank(x, y, vx, vy, angle, angle_speed, acceleration, max_speed, friction) = 
        new(
            x, y, vx, vy, angle, angle_speed, acceleration, max_speed, friction,
            load("src/textures/simple_tank/pixil-frame-0.png"), 9.0, 9.0,
        )
    SimpleTank(x, y, vx, vy, angle) = SimpleTank(
        x, y, vx, vy, angle,
        0.03,  # angle_speed
        0.02, # acceleration
        1.0,   # max_speed
        0.98,  # friction
    )
    SimpleTank(x, y) = SimpleTank(x, y, Observable(0.0), Observable(0.0), Observable(0.0))
    SimpleTank() = SimpleTank(Observable(0.0), Observable(0.0))
end

