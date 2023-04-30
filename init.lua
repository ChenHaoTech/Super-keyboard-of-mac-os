require("lib.print_utils")
require("lib.data")
require("lib.window_utils")

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

-- -- 更新鼠标位置显示文本
-- function updateMousePosition()
--     -- 创建鼠标位置显示文本
--     local mouseText = hs.drawing.text(hs.geometry.point(100, 100), "")
--     mouseText:setTextColor({red = 1, blue = 0, green = 0, alpha = 1})
--     mouseText:setTextSize(20)
--     local mousePoint = hs.mouse:absolutePosition()
--     mouseText:setString("(" .. mousePoint.x .. ", " .. mousePoint.y .. ")")
--     mouseText:show()
-- end


-- -- -- 监控鼠标位置变化
-- -- hs.timer.doEvery(1, showMousePosition)

-- -- hs.timer.doEvery(1, function() print("fuck") end)

-- local function _debug()
--     hs.alert.show("debug demo")
--     hs.timer.doEvery(1, updateMousePosition)
-- end
-- hs.hotkey.new({"cmd"}, "F12", function() _debug() end):enable()
