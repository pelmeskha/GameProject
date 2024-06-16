struct BigTank <: Tank
    hull::TankHull
    turret::Turret
    function BigTank(
        x::Observable{Float64},
        y::Observable{Float64},
        vx::Observable{Float64},
        vy::Observable{Float64},
        angle::Observable{Float64},
    )
        turret_disolacement_x = 0.0
        turret_disolacement_y = -1.0
        hull = TankHull(
            x, y, vx, vy, angle, 
            0.02, # angle_speed
            0.01, # acceleration
            0.6,  # max_speed
            0.99, # forward_friction
            0.95, # side_friction
            load("src/textures/big_tank/hull.png"),
            13.0, 13.0, # hull size
        )
        turret = Turret(
            lift((x_pos, a) -> (turret_disolacement_x*sin(a) + turret_disolacement_y*cos(a) + x_pos), x, angle),
            lift((y_pos, a) -> (-turret_disolacement_x*cos(a) + turret_disolacement_y*sin(a) + y_pos), y, angle),
            Observable(angle[]),
            0.015, # turret angular speed
            load("src/textures/big_tank/turret.png"),
            17.0, 7.0, # turret size
        )
        new(hull, turret)
    end
end

BigTank(x::Real,y::Real,vx::Real,vy::Real,angle::Real) = 
    BigTank(Observable(x),Observable(y),Observable(vx),Observable(vy),Observable(angle))

BigTank(x::Real, y::Real) = BigTank(Observable(x), Observable(y))

BigTank(x::Observable{Float64}, y::Observable{Float64}) = BigTank(
    x, y,
    Observable(0.0),
    Observable(0.0),
    Observable(0.0),
)

BigTank() = BigTank(Observable(0.0), Observable(0.0))