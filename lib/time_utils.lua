--[[ function showNotification()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end

-- 每 5 秒钟执行一次 showNotification 函数
hs.timer.doEvery(5, showNotification)
 ]]