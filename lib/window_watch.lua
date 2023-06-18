AppNameActievSwitcher = {
    ["Google Chrome"] = function(eventType, appObject)
        print("Chrome active" .. eventType .. "," .. appObject)
    end,
    ["Obsidian"] = function(eventType, appObject)
        -- active
        if eventType == 5 then print("active") end
        -- active
        if eventType == 6 then print("unactive") end
    end
}

-- 要想生效, 不能走 local, local 要审慎
function ApplicationActiveWatcherFunc(appName, eventType, appObject)
    -- print(string.format("ApplicationActiveWatcherFunc, %s,%s,%s", appName,
    --                     eventType, appObject))
    local func = AppNameActievSwitcher[appName]
    if func ~= nil then func(eventType, appObject) end
end
OnXXApplicationWatch = hs.application.watcher.new(ApplicationActiveWatcherFunc)
OnXXApplicationWatch:start()
