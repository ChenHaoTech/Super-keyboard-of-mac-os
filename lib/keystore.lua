 function keyStroke(modifiers, character)
    local event = hs.eventtap.event.newKeyEvent(modifiers,
        string.lower(character), true)
    event.post(event)
end