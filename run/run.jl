using GLMakie, FileIO, IntervalSets

# Создание фигуры и оси
fig = Figure(; size = (1920, 1080))
ax1 = fig[1, 1] = Axis(fig, aspect=DataAspect(), limits = (-10, 10, -10, 10))

# Создание Observable для координат
x = Observable(0.0)
y = Observable(0.0)
vx = Observable(0.0)
vy = Observable(0.0)
angle = Observable(0.0)

# Загрузка изображения
tank_image = load("src/textures/simple_tank/pixil-frame-0.png")

pic_width, pic_height = 0.5, 0.5

# Создание изображения с использованием Observable для координат
img = image!(
    ax1,
    (-(pic_width / 2), (pic_width / 2)),
    (-(pic_height / 2), (pic_height / 2)),
    tank_image,
    transformation=Transformation(
        translation=lift((x_pos, y_pos) -> Vec3f(x_pos, y_pos, 0), x, y),
        rotation=lift(a -> Quaternion(0, 0, cos(a/2-pi/4), sin(a/2-pi/4)), angle),
    )
)

angle_speed = 0.03
acceleration=0.002
max_speed = 0.1
friction = 0.98
#speed=0.03

w_pressed = Observable(false)
a_pressed = Observable(false)
s_pressed = Observable(false)
d_pressed = Observable(false)

function update_position()
    while true
        if w_pressed[]
            vx[] += acceleration * sin(angle[])
            vy[] += acceleration * cos(angle[])
        end
        if a_pressed[]
            angle[] -= angle_speed
        end
        if s_pressed[]
            vx[] -= acceleration * sin(angle[])
            vy[] -= acceleration * cos(angle[])
        end
        if d_pressed[]
            angle[] += angle_speed
        end
        vx[] *= friction
        vy[] *= friction
        speed = sqrt(vx[]^2 + vy[]^2)
        if speed > max_speed
            vx[] *= max_speed / speed
            vy[] *= max_speed / speed
        end
        x[] += vx[]
        y[] += vy[]
        sleep(0.00694) # Период обновления позиции (10 мс)
    end
end

@async update_position()


on(events(fig).keyboardbutton) do event
    if event.action == Keyboard.press
        if event.key == Keyboard.w
            w_pressed[] = true
        elseif event.key == Keyboard.a
            a_pressed[] = true
        elseif event.key == Keyboard.s
            s_pressed[] = true
        elseif event.key == Keyboard.d
            d_pressed[] = true
        end
    elseif event.action == Keyboard.release
        if event.key == Keyboard.w
            w_pressed[] = false
        elseif event.key == Keyboard.a
            a_pressed[] = false
        elseif event.key == Keyboard.s
            s_pressed[] = false
        elseif event.key == Keyboard.d
            d_pressed[] = false
        end
    end
end

fig

#= rotate!(img, (0, -pi/2, 0)) =#