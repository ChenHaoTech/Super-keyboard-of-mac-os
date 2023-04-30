-- 要想生效, 不能走 local, local 要审慎
function applicationWatcher(appName, eventType, appObject)
    hs.alert.show(
        string.format("hahaa, %s,%s,%s", appName, eventType, appObject))
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            hs.alert.show("hahaa")
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()

-- 尝试自定义 数据
-- local cases = {
--     [1] = function() print("One") end,
--     [2] = function() print("Two") end,
--     [3] = function() print("Three") end,
-- }

function frontmostApplication() return hs.application.frontmostApplication() end

function focusedWindow() return hs.window.focusedWindow() end
