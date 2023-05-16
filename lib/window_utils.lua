require("lib.keystore")
require("lib.data")

WindowDict = {}

-- 获取所有应用程序对象
-- local apps = hs.application.runningApplications()

-- 遍历所有应用程序对象timer.secondsSinceEpoch()
-- for i, app in ipairs(apps) do
--     local windows = app:allWindows()
--     -- 遍历应用程序的所有窗口
--     for j, win in ipairs(windows) do
--         local winId = win:id()
--         -- 将窗口对象和窗口 ID 存入字典
--         WindowDict[app] = WindowDict[app] or {}
--         WindowDict[app][winId] = win
--     end
-- end

-- 要想生效, 不能走 local, local 要审慎
function ApplicationActiveWatcherFunc(appName, eventType, appObject)
    -- hs.alert.show(
    --     string.format("hahaa, %s,%s,%s", appName, eventType, appObject))
    if (eventType ~= hs.application.watcher.launched or eventType ~=
        hs.application.watcher.terminated) then return end
    for k, win in pairs(appObject:allWindows()) do
        local winId = win:id()
        WindowDict[appObject:path()] = WindowDict[appObject:path()] or {}
        WindowDict[appObject:path()][winId] = win
    end

end
AppWindowActiveWatcher = hs.application.watcher
                             .new(ApplicationActiveWatcherFunc)
AppWindowActiveWatcher:start()

function RecordFuncInvoke(func, key, needRecord)
    if needRecord ~= nil and needRecord == false then return func() end
    local timer = require("hs.timer")

    -- 开始计时
    local startT = timer.secondsSinceEpoch()

    -- 执行 API 请求
    local res = func();
    -- 结束计时
    local endT = timer.secondsSinceEpoch()

    -- 计算 API 调用的时间
    local duration = endT - startT

    -- 打印 API 调用的时间
    duration = duration * 1000;
    if duration >= 10 then
        print(key .. "API 调用的时间为：" .. duration .. " 毫秒")
    end
    return res;
end

-- keyStroke({}, "A") -- 模拟按下并释放 A 键
function ActivateWindow(idx)
    print("===> begin ")
    local appId = Windows_preferences[idx .. "_app"]
    local winId = Windows_preferences[idx .. "_id"]
    local path = Windows_preferences[idx .. "_path"]
    if appId == nil or winId == nil then
        hs.alert.show("No record for idx: " .. idx)
        return
    end
    --  hs.window.focusedWindow()  性能比较查, 先关掉
    -- local curWin = RecordFuncInvoke(function() hs.window.focusedWindow() end,
    --                                 "get focused window")
    -- if curWin ~= nil and curWin:id() == winId then
    --     curWin:application():hide()
    --     -- curWin:sendToBack() -- 特效太多
    --     -- keyStroke({"cmd"}, "tab")
    --     -- curWin:minimize()
    --     return
    -- end
    -- 获取应用程序对象
    local win = (WindowDict[path] or {})[winId]
    if (win ~= nil) then
        print("hint cache path" .. path .. "win" .. win:title())
        win:focus()
        return
    end
    local apps = RecordFuncInvoke(function()
        return hs.application.applicationsForBundleID(appId)
    end, "get app by bundle id")

    if #apps ~= 1 then
        if #apps > 1 then
            -- hs.alert.show("apps is multi")
        else
            hs.alert.show("apps is not running")
        end
        -- return
    end
    hs.fnutils.each(apps, function(app)
        -- 如果找到了应用程序对象，获取窗口对象
        if app ~= nil then
            local allWindow = WindowDict[app:path()] or
                                  RecordFuncInvoke(function()
                    print("get all window snc, app" .. app:name())
                    local res = {}
                    for index, value in ipairs(app:allWindows()) do
                        res[value:id()] = value;
                    end
                    return res;
                end, "get all windows")
            -- pt(WindowDict[app:path()])
            -- pt(allWindow)
            WindowDict[app:path()] = allWindow
            -- pt(WindowDict[app:path()])
            local win = WindowDict[app:path()][winId]
            -- 如果找到了窗口对象，激活窗口；否则提示未找到窗口对象
            if win ~= nil then
                -- win:becomeMain()
                win:focus()
                return
            else
                hs.alert.show("Window not found for title: " .. winId ..
                                  ",acitve app" .. app:name())
                win = hs.window.find(winId)
                if (win ~= nil) then
                    win:focus()
                    Windows_preferences[idx .. "_id"] = win:id()
                else
                    app:activate()
                    win = app:focusedWindow()
                    Windows_preferences[idx .. "_id"] = win:id();
                end
                WindowDict[app:path()][winId] = win;
                return
            end
        else
            hs.alert.show("Application not found: " .. appId)
        end
    end)
end

function UpdateWindowsPrefFromFrontmostWindow(idx)
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
            Windows_preferences[idx .. "_path"] = frontmostApp:path()

            -- 在弹窗中显示窗口标题，并将更新后的 windows_preferences 变量写入文件
            hs.alert.show(string.format("record Window,id:%s\napp:%s,title:%s",
                                        wid, frontmostApp:name(), win:title()),
                          nil, nil, 2)
            hs.plist.write(windows_preferences_path, Windows_preferences)

            -- 打印更新后的 windows_preferences 变量
            PrintTable(Windows_preferences)
        else
            hs.alert.show("No focused window found")
        end
    else
        hs.alert.show("No frontmost application found")
    end
end

function SmartCloseWindow()
    local frontmostApp = hs.application.frontmostApplication()
    local frontmosWin = frontmostApp:focusedWindow()
    if frontmosWin == nil then return end
    frontmosWin:close()
end
