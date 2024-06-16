function interpolate_color(value, min_color, max_color)
    return min_color * (1 - value) + max_color * value
end
function generate_background(n, m, N; min_color=(1.0, 1.0, 1.0), max_color=(0.7, 0.8, 0.7))
    min_color, max_color = RGB(min_color...), RGB(max_color...)
    image = Array{RGB{Float32}}(undef, n, m)
    points = [(rand(1:n), rand(1:m)) for _ in 1:N]
    values = rand(N)
    points = vcat(points, [(0, 0), (0, m+1), (n+1, 0), (n+1, m+1)])
    values = vcat(values, rand(4))
    for i in 1:n
        for j in 1:m
            nearest_point_index = argmin([sqrt((i - x)^2 + (j - y)^2) for (x, y) in points])
            nearest_value = values[nearest_point_index]
            image[i, j] = interpolate_color(nearest_value, min_color, max_color)
        end
    end
    return image
end
function display_background!(ax, image)
    x_size, y_size = size(image)
    img = image!(
        ax,
        (-x_size/2, x_size/2),
        (-y_size/2, y_size/2),
        image,
        interpolate=false,
    )
    return img
end
