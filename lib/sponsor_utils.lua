hs.loadSpoon("AClock")
spoon.AClock:init()
function toggleShowAClock()
    spoon.AClock:toggleShow()
end
-- open -g hammerspoon://toggleShowAClock
hs.urlevent.bind("toggleShowAClock", function(eventName, params)
    toggleShowAClock()
end);
-- showAClock()