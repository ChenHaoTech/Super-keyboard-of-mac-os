-- [Hammerspoon docs: hs.notify --- Hammerspoon 文档：hs.notify](https://www.hammerspoon.org/docs/hs.notify.html#withdrawAll)
local notification = hs.notify.new({
    title = "这是一条通知",
    subTitle = "这是副标题",
    informativeText = "这是详细信息",
    autoWithdraw = true,
})
-- notification:send()