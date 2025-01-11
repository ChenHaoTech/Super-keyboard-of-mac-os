-- ref https://www.hammerspoon.org/docs/hs.chooser.html

--[[ 
## choose 方法
The table of choices (be it provided statically, or returned by the callback) must contain at least the following keys for each choice:
选择表（无论是静态提供的，还是由回调返回的）必须至少包含每个选择的以下键：
text - A string or hs.styledtext object that will be shown as the main text of the choice
text - 将显示为选择的主要文本的字符串或 hs.styledtext 对象
Each choice may also optionally contain the following keys:
每个选择还可以选择包含以下键：
subText - A string or hs.styledtext object that will be shown underneath the main text of the choice
subText - 将显示在所选主文本下方的字符串或 hs.styledtext 对象
image - An hs.image image object that will be displayed next to the choice
image - 将显示在选项旁边的hs.image图像对象
valid - A boolean that defaults to true, if set to false selecting the choice will invoke the invalidCallback method instead of dismissing the chooser
valid - 默认为true的布尔值，如果设置为false选择选项将调用invalidCallback方法而不是关闭选择器
Any other keys/values in each choice table will be retained by the chooser and returned to the completion callback when a choice is made.
每个选择表中的任何其他键/值将由选择器保留，并在做出选择时返回到完成回调。
This is useful for storing UUIDs or other non-user-facing information, however, it is important to note that you should not store userdata objects in the table - it is run through internal conversion functions, so only basic Lua types should be stored.
这对于存储 UUID 或其他非面向用户的信息很有用，但是，需要注意的是，您不应该在表中存储 userdata 对象 - 它是通过内部转换函数运行的，因此只应存储基本的 Lua 类型。
If a function is given, it will be called once, when the chooser window is displayed. The results are then cached until this method is called again, or hs.chooser:refreshChoicesCallback() is called.
如果给出了一个函数，当显示选择器窗口时，它将被调用一次。然后将结果缓存起来，直到再次调用此方法，或者 hs.chooser:refreshChoicesCallback() 被称为。
If you're using a hs.styledtext object for text or subText choices, make sure you specify a color, otherwise your text could appear transparent depending on the bgDark setting.
如果您使用 hs.styledtext 对象来选择文本或子文本，请确保您指定了一种颜色，否则您的文本可能会显示为透明，具体取决于 bgDark 设置。

]]

function custom_choose(
    placeholderText,
    choices,
    callback
)
    local chooser = hs.chooser.new(function(choice)
        if choice and callback then
            callback(choice)
        end
    end)

    -- 设置暗色主题
    chooser:bgDark(true)
    -- 设置暗色主题下的文字颜色
    chooser:fgColor({hex="#FFFFFF"})
    chooser:subTextColor({hex="#999999"})

    chooser:placeholderText(placeholderText or "请输入搜索内容")
    chooser:choices(choices or {})
    chooser:show()

    return chooser
end

function choose_window()
    local choices = {}
    for i, win in ipairs(hs.window.allWindows()) do
        if win:title() == "" then
            print("win:title() is nil")
            goto continue
        end
        -- 添加应用名称作为subText
        local app = win:application()
        local subText = app and app:name() or ""
        -- 添加应用图标
        local icon = app and hs.image.imageFromAppBundle(app:bundleID()) or nil
        
        table.insert(choices, {
            text = win:title(),
            subText = subText,
            image = icon,
            id = win:id()
        })
        ::continue::
    end

    custom_choose("请输入窗口名称", choices, function(choice)
        if choice then
            print("用户选择了：" .. choice.text)
            local win = hs.window.get(choice.id)
            if (win ~= nil) then win:focus() end
        end
    end)
end


choose_window()

-- 参考: @url_utils.lua 实现绑定一个url，传入


-- hs.window.allWindows()


-- 如何获取 win 的 app icon
-- icon=hs.image.imageFromAppBundle(focusedWindow():application(): bundleID())
-- canvas = hs.canvas.new({x = 0, y = 0, w = 100, h = 100})
-- canvas[1] = {
--     type = "image",
--     image = icon,
--     frame = {x = 0, y = 0, w = 100, h = 100},
-- }
-- canvas:show()