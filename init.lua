-- 启用 Spotlight 支持
hs.application.enableSpotlightForNameSearches(true)

windows_preferences_path = "/Users/apple/.hammerspoon/window_config.plist"
windows_preferences = hs.plist.read(windows_preferences_path)

function printTable(tbl)
    for k, v in pairs(tbl) do
        print(k .. ": " .. tostring(v))
    end
end

function activateWindow(idx)
    local appName = windows_preferences[idx .. "_app"]
    local winTitle = windows_preferences[idx .. "_title"]
    if appName == nil or winTitle == nil then
        hs.alert.show("No record for idx: " .. idx)
        return
    end
    -- 获取应用程序对象
    local app = hs.application.get(appName)

    -- 如果找到了应用程序对象，获取窗口对象
    if app then
        local win = app:findWindow(winTitle)

        -- 如果找到了窗口对象，激活窗口；否则提示未找到窗口对象
        if win then
            win:becomeMain()
            win:focus()
        else
            -- hs.alert.show("Window not found for title: " .. winTitle .. ",acitve app")
            app:activate()
            windows_preferences[idx .. "_title"] = app:focusedWindow():title()
        end
    else
        hs.alert.show("Application not found: " .. appName)
    end
end

function updateWindowsPrefFromFrontmostWindow(idx)
    -- 获取当前位于前台的应用程序对象
    local frontmostApp = hs.application.frontmostApplication()

    -- 如果找到了应用程序对象，获取应用程序名称；否则提示未找到应用程序对象
    if frontmostApp then
        local appName = frontmostApp:name()

        -- 获取当前获取焦点的窗口对象
        local win = frontmostApp:focusedWindow()

        -- 如果找到了窗口对象，获取窗口标题；否则提示未找到窗口对象
        if win then
            local wid = win:id()

            -- 更新 windows_preferences 变量
            windows_preferences[idx .. "_app"] = appName
            windows_preferences[idx .. "_title"] = wid

            -- 在弹窗中显示窗口标题，并将更新后的 windows_preferences 变量写入文件
            hs.alert.show("record Window: " .. wid)
            hs.plist.write(windows_preferences_path, windows_preferences)

            -- 打印更新后的 windows_preferences 变量
            printTable(windows_preferences)
        else
            hs.alert.show("No focused window found")
        end
    else
        hs.alert.show("No frontmost application found")
    end
end

hs.hotkey.bind({"cmd", "alt", "ctrl", "fn"}, "1", function()
    updateWindowsPrefFromFrontmostWindow(1)
end)

bindFlag = false;

hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "0", function()
    bindFlag = true;
    hs.alert.show("bind mode")
end)

for i = 1, 9 do
    hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, tostring(i), function()
        if bindFlag then
            updateWindowsPrefFromFrontmostWindow(i)
        else
            activateWindow(i)
        end
        bindFlag = false;
    end)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)

-- -- 实现alert当前按键
-- eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
--     hs.alert.show("Pressed key: " .. hs.keycodes.map[event:getKeyCode()])
-- end):start()
-- 启用trail模式
-- hs.eventtap.event.types.keyDown = true

-- -- 建立键码和按键名称之间的对应关系表
-- keyNameMap = {}
-- for key, value in pairs(hs.keycodes.map) do
--     keyNameMap[value] = key
-- end

-- -- -- 监听CTRL + ALT + T快捷键，开启/关闭试吃模式
-- tastingMode = false
-- eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
--     if event:getKeyCode() == hs.keycodes.map.t and event:getFlags()['ctrl'] and event:getFlags()['alt'] then
--         tastingMode = not tastingMode
--         if tastingMode then
--             hs.alert.show("Tasting Mode Enabled!")
--         else
--             hs.alert.show("Tasting Mode Disabled.")
--         end
--         return true, {}
--     elseif tastingMode then
--         local keyName = keyNameMap[event:getKeyCode()]
--         if keyName ~= nil then
--             hs.alert.show("Tasting: " .. keyName)
--         end
--     end
-- end):start()

