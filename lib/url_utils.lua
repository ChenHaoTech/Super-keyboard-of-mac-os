-- 配置一个带参数的URL事件处理器
-- 事件名为 ha_toast, 参数为 value
hs.urlevent.bind("ha_toast", function(eventName, params)
    -- 直接显示传入的value参数内容
    -- hs.alert.show(string.format("%s %s", params.value, params.name))
    hs.alert.show(params.value)
end)

-- 使用案例:
-- 在终端执行:
-- open -g "hammerspoon://ha_toast?value=1好&name=12"
-- 将会弹出提示: nihao

-- 也可以传入多个参数:
-- open -g hammerspoon://ha_toast?value=nihao&name=张三
-- 此时 params 表中会包含 value 和 name 两个参数
