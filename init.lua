require("lib.print_utils")
require("lib.data")
require("lib.window_utils")
-- require("lib.alert_utls")

-- https://www.hammerspoon.org/docs/hs.window.html#find
-- 启用 Spotlight 支持
hs.application.enableSpotlightForNameSearches(true)

-- -- toggle 
-- hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "0", function()
--     BindFlag = not BindFlag
--     if BindFlag then
--         hs.alert.show("bind mode")
--     else
--         hs.alert.show("exit bind mode")
--     end
-- end)

BindFlagMap = {}
for i = 1, 9 do
    local key = tostring(i)
    hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, key, function()
        BindFlagMap[key] = hs.timer.secondsSinceEpoch();
    end, function()
        local last = BindFlagMap[key]
        local now = hs.timer.secondsSinceEpoch();
        if now - last > 0.4 then -- 过长的按住, 直接忽略
            UpdateWindowsPrefFromFrontmostWindow(i)
        else
            ActivateWindow(i)
        end
    end,function ()
        hs.alert.show("repeat")
        -- UpdateWindowsPrefFromFrontmostWindow(i)
    end)
end
for i = 1, 12 do
    local key = "f" .. tostring(i)
    hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, key, function()
        BindFlagMap[key] = hs.timer.secondsSinceEpoch();
    end, function()
        local last = BindFlagMap[key]
        local now = hs.timer.secondsSinceEpoch();
        if now - last > 0.4 then  -- 过长的按住, 直接忽略
            UpdateWindowsPrefFromFrontmostWindow(key)
        else
            ActivateWindow(key)
        end
    end,function ( )
        -- UpdateWindowsPrefFromFrontmostWindow(key)
        hs.alert.show("repeat")
    end)
end

-- reload
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    print("config reload ")
    hs.openConsole()
    hs.reload()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Q",
               function() SmartCloseWindow() end)

RecordFuncInvoke(function()
    require("lib.alert_utls")
    require("lib.mouse_utils")
    require("lib.caffeine_utils")
    require("lib.application_utils")
    require("lib.hotkey_utils")
    require("lib.url_utils")
    require("lib.observer_utils")
    require("lib.canvas_utils")
    require("lib.choose_utils")
    require("lib.image_utils")
    require("lib.console_utils")
    require("lib.hid_utils")
    require("lib.notify_utils")
    require("lib.shortcut_utils")
    require("lib.dialog_utils")
    require("lib.sponsor_utils")
    require("lib.eventtap_utils")
    require("lib.host_utils")
    require("lib.time_utils")
    require("lib.window_watch")
    require("lib.task_utils")
end, "load extension")

-- testCallbackFn = function(result) print("Callback Result: " .. result) end
-- hs.dialog.alert(0,0, testCallbackFn, "Message", "Informative Text", "Button One", "Button Two", "NSCriticalAlertStyle")