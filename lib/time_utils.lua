--[[ function showNotification()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end

-- 每 5 秒钟执行一次 showNotification 函数
hs.timer.doEvery(5, showNotification)
 ]]


-- 没用
 --[[ -- open -g hammerspoon://SetTop
hs.urlevent.bind("SetTop", function(eventName, params)
    fw = focusedWindow()
    hs.timer.doEvery(0.1, function() fw:raise() end)
end)
 ]]