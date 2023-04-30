require("lib.keystore")
require("lib.data")

-- keyStroke({}, "A") -- 模拟按下并释放 A 键
function ActivateWindow(idx)
    local appId = Windows_preferences[idx .. "_app"]
    local winId = Windows_preferences[idx .. "_id"]
    if appId == nil or winId == nil then
        hs.alert.show("No record for idx: " .. idx)
        return
    end

    local curWin = hs.window.focusedWindow()
    if curWin:id() == winId then
        keyStroke({"cmd"}, "H")
        return
    end
    -- 获取应用程序对象
    local apps = hs.application.applicationsForBundleID(appId)
    if #apps ~= 1 then
        if #apps > 1 then
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