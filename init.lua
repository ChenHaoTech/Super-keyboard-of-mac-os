-- https://www.hammerspoon.org/docs/hs.window.html#find
-- 启用 Spotlight 支持

hs.application.enableSpotlightForNameSearches(true)

local windows_preferences_path = "/Users/apple/.hammerspoon/window_config.plist"
Windows_preferences = hs.plist.read(windows_preferences_path)
BindFlag = false; -- 是否开启 bind flag

local function _debug() hs.alert.show("debug demo") end
local function keyStroke(modifiers, character)
  local event = hs.eventtap.event.newKeyEvent(modifiers, string.lower(character), true)
  event.post(event)
end

-- keyStroke({}, "A") -- 模拟按下并释放 A 键

-- DEBUG 代码
DEBUG = false; -- 是否开启 bind flag
local debugHokey = nil;
local function toggleDebug()
    DEBUG = not DEBUG
    if DEBUG then
        hs.alert.show("debug mode on")
        debugHokey =
            hs.hotkey.new({"cmd"}, "F12", function() _debug() end):enable()
    else
        hs.alert.show("debug mode off")
        if debugHokey ~= nil then debugHokey:disable() end
    end
end

local function printTable(tbl)
    for k, v in pairs(tbl) do print(k .. ": " .. tostring(v)) end
end

local function activateWindow(idx)
    local appId = Windows_preferences[idx .. "_app"]
    local winId = Windows_preferences[idx .. "_id"]
    if appId == nil or winId == nil then
        hs.alert.show("No record for idx: " .. idx)
        return
    end

    local curWin = hs.window.focusedWindow()
    if curWin:id() == winId then
        keyStroke({"cmd"},"H")
        return
    end
    -- 获取应用程序对象
    local apps = hs.application.applicationsForBundleID(appId)
    if #apps ~= 1 then
        if #apps >1 then
            hs.alert.show("apps is multi")
        else
            hs.alert.show("apps is not running")
        end
        return
    end
    hs.fnutils.each(apps, function(app)
        -- 如果找到了应用程序对象，获取窗口对象
        if app ~= nil then
            local win = hs.fnutils.find(app:allWindows(), function(win)
                return win:id() == winId
            end)
            -- 如果找到了窗口对象，激活窗口；否则提示未找到窗口对象
            if win ~= nil then
                -- win:becomeMain()
                win:focus()
            else
                hs.alert.show("Window not found for title: " .. winId ..
                                  ",acitve app" .. app:name())
                win = hs.window.find(winId)
                if (win ~= nil) then
                    win:focus()
                    Windows_preferences[idx .. "_id"] = win:id()

                else
                    app:activate()
                    Windows_preferences[idx .. "_id"] = app:focusedWindow():id()
                end
            end
        else
            hs.alert.show("Application not found: " .. appId)
        end
    end)
end

local function updateWindowsPrefFromFrontmostWindow(idx)
    -- 获取当前位于前台的应用程序对象
    local frontmostApp = hs.application.frontmostApplication()

    -- 如果找到了应用程序对象，获取应用程序名称；否则提示未找到应用程序对象
    if frontmostApp then
        local appId = frontmostApp:bundleID()

        -- 获取当前获取焦点的窗口对象
        local win = frontmostApp:focusedWindow()

        -- 如果找到了窗口对象，获取窗口标题；否则提示未找到窗口对象
        if win then
            local wid = win:id()

            -- 更新 windows_preferences 变量
            Windows_preferences[idx .. "_app"] = appId
            Windows_preferences[idx .. "_id"] = wid

            -- 在弹窗中显示窗口标题，并将更新后的 windows_preferences 变量写入文件
            hs.alert.show(string.format("record Window,id:%s\napp:%s,title:%s",
                                        wid, frontmostApp:name(), win:title()),
                          nil, nil, 2)
            hs.plist.write(windows_preferences_path, Windows_preferences)

            -- 打印更新后的 windows_preferences 变量
            printTable(Windows_preferences)
        else
            hs.alert.show("No focused window found")
        end
    else
        hs.alert.show("No frontmost application found")
    end
end

-- toggle 
hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "0", function()
    BindFlag = not BindFlag
    if BindFlag then
        hs.alert.show("bind mode")
    else
        hs.alert.show("exit bind mode")
    end
    -- toggleDebug()
end)

for i = 1, 9 do
    hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, tostring(i), function()
        if BindFlag then
            updateWindowsPrefFromFrontmostWindow(i)
        else
            activateWindow(i)
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

-- hs.alert.show("fuck",{
--   fillColor = { white = 0, alpha = 0.8 },
--   textColor = { red = 1 }
-- })