require("lib.print_utils")
require("lib.data")
require("lib.window_utils")
-- require("lib.alert_utls")

-- https://www.hammerspoon.org/docs/hs.window.html#find
-- 启用 Spotlight 支持
hs.application.enableSpotlightForNameSearches(true)


-- toggle 
hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "0", function()
    BindFlag = not BindFlag
    if BindFlag then
        hs.alert.show("bind mode")
    else
        hs.alert.show("exit bind mode")
    end
end)

for i = 1, 9 do
    hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, tostring(i), function()
        if BindFlag then
            UpdateWindowsPrefFromFrontmostWindow(i)
        else
            ActivateWindow(i)
        end
        BindFlag = false;
    end)
end

-- reload
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    print("config reload ")
    hs.openConsole()
    hs.reload()
end)

require("lib.alert_utls")
require("lib.mouse_utils")
require("lib.caffeine_utils")
require("lib.application_utils")
require("lib.hotkey_utils")
require("lib.url_utils")
require("lib.observer_utils")
require("lib.canvas_utils")