local canvas = require("hs.canvas")

-- 创建一个画布
myCanvas = canvas.new {x = 100, y = 100, w = 300, h = 200}

-- 绘制一个矩形
local elements = {
    {
        type = "rectangle",
        action = "fill",
        fillColor = {red = 0, green = 1, blue = 0, alpha = 1},
        frame = {x = 50, y = 50, w = 1000, h = 30}
    }, {

        type = "text",
        text = "Hello World!",
        textSize =15,
        textColor = {red = 1},
        textAlignment = "left",
        frame = {x = 50, y = 50, w = 1000, h = 30}
    }
}

-- 在矩形上添加一段文本
myCanvas:appendElements(elements)
-- 创建一个定时器，每秒钟加1
timer = hs.timer.new(0.1, function()
    local pos = hs.mouse.getAbsolutePosition()
    elements[2].text = "(" .. pos.x .. "," .. pos.y .. ")"
    myCanvas:replaceElements(elements)    
end)


-- 显示画布
-- myCanvas:show()
-- 启动定时器
-- timer:start()
