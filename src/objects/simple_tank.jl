struct SimpleTank <: Tank
    hull::TankHull
    turret::Turret
    function SimpleTank(
        x::Observable{Float64},
        y::Observable{Float64},
        vx::Observable{Float64},
        vy::Observable{Float64},
        angle::Observable{Float64},
    )
        turret_disolacement_x = 0.0
        turret_disolacement_y = 0.0
        hull = TankHull(
            x, y, vx, vy, angle,
            0.03, # angle_speed
            0.02, # acceleration
            1.0,  # max_speed
            0.98, # forward_friction
            0.8,  # side_friction
            load("src/textures/simple_tank/hull.png"),
            9.0, 9.0, # hull size
        )
        turret = Turret(
            lift((x_pos, a) -> (turret_disolacement_x*sin(a) + turret_disolacement_y*cos(a) + x_pos), x, angle),
            lift((y_pos, a) -> (-turret_disolacement_x*cos(a) + turret_disolacement_y*sin(a) + y_pos), y, angle),
            Observable(angle[]),
            0.03, # turret angular speed
            load("src/textures/simple_tank/turret.png"),
            9.0, 9.0, # turret size
        )
        new(hull, turret)
    end
end

SimpleTank(x::Real,y::Real,vx::Real,vy::Real,angle::Real) = 
    SimpleTank(Observable(x),Observable(y),Observable(vx),Observable(vy),Observable(angle))

SimpleTank(x::Real, y::Real) = SimpleTank(Observable(x), Observable(y))

SimpleTank(x::Observable{Float64}, y::Observable{Float64}) = SimpleTank(
    x, y,
    Observable(0.0),
    Observable(0.0),
    Observable(0.0),
)

SimpleTank() = SimpleTank(Observable(0.0), Observable(0.0))