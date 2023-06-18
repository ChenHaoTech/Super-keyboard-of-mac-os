--[[ 
typedef enum _event_t {
    launching = 0,
    launched,//1
    terminated,//2
    hidden,//3
    unhidden,//4
    activated //5,
    deactivated//6

 ]]

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
    if func ~= nil then
        print(string.format("ApplicationActiveWatcherFunc, %s,%s,%s", appName,
                            eventType, appObject))
        func(eventType, appObject)
    end
end
OnXXApplicationWatch = hs.application.watcher.new(ApplicationActiveWatcherFunc)
OnXXApplicationWatch:start()
