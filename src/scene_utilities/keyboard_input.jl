function init_keyboard_input(fig)
    w_pressed = Observable(false)
    a_pressed = Observable(false)
    s_pressed = Observable(false)
    d_pressed = Observable(false)

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
    return (w_pressed, a_pressed, s_pressed, d_pressed)
end
