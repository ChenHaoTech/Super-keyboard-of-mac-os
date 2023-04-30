-- hs.console.darkMode(false)
-- open -g hammerspoon://clearConsole
hs.urlevent.bind("clearConsole", function(eventName, params)
    -- hs.alert.show("Received someAlert")
    hs.console.clearConsole()
end)

