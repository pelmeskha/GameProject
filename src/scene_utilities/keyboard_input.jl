function init_input(fig, ax)
    w_pressed = Observable(false)
    a_pressed = Observable(false)
    s_pressed = Observable(false)
    d_pressed = Observable(false)
    mouse_position = Observable([Inf,0.0])
    left_mouse_pressed = Observable(false)
    prev_left_mouse_pressed = false
    
    on(events(fig).mouseposition) do pos
		if is_mouseinside(ax)
			mouse_position[] = mouseposition(ax)
		end
    end

    on(events(fig).mousebutton) do event
        if event.button == Mouse.left
            if event.action == Mouse.press
                left_mouse_pressed[] = true
            elseif event.action == Mouse.release
                left_mouse_pressed[] = false
            end
        end
    end

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
    return (w_pressed, a_pressed, s_pressed, d_pressed, mouse_position, left_mouse_pressed)
end
