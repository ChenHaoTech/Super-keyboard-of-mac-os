-- ax = require("hs.axuielement")
-- pid=frontmostApplication():pid()

-- -- 创建一个观察器
-- observer = ax.observer.new(pid)
-- observer:callback(function(element, event, observer, userData)
--     print("UI元素发生了变化:")
--     print("Element: ", element)
--     print("Event: ", event)
--     print("Observer: ", observer)
--     print("UserData: ", userData)
-- end)

-- -- 指定要观察的UI元素和事件类型
-- local element = ax.systemWideElement()
-- local eventType = ax.observer.notifications.VALUE_CHANGED
-- observer:addWatcher(element, tostring(eventType))

-- -- 启动观察器
-- observer:start()

-- -- 启动观察器
-- observer:start()

-- -- -- 停止观察器
-- -- observer:stop()
