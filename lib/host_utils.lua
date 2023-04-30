local host = require("hs.host")

local period = 1

local function cpuCallback(cpuTable)
    print("fuck")
    -- 获取 CPU 使用率的各个部分
    local active = cpuTable["overall"]["active"]
    local idle = cpuTable["overall"]["idle"]
    local nice = cpuTable["overall"]["nice"]
    local system = cpuTable["overall"]["system"]
    local user = cpuTable["overall"]["user"]

    -- 计算总的 CPU 使用率
    local cpuUsage = user + system

    -- 发出警告
    hs.alert.show("CPU 使用率: " .. cpuUsage .. "%")
end

-- local monitor = host.cpuUsage(period, cpuCallback)

-- host.cpuUsage(period, cpuCallback)
--[[ 

function showNotification()
    hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end

-- 每 5 秒钟执行一次 showNotification 函数
hs.timer.doEvery(5, showNotification)
 ]]

--[[ local style = {
  "radius": 27,
  "atScreenEdge": 0,
  "fadeInDuration": 0.14999999999999999,
  "textFont": ".AppleSystemUIFont",
  "fillColor": { "alpha": 0.75, "white": 0 },
  "fadeOutDuration": 0.14999999999999999,
  "textSize": 27,
  "strokeColor": { "alpha": 1, "white": 1 },
  "strokeWidth": 2,
  "textColor": { "alpha": 1, "white": 1 }
} ]]
