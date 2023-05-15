-- chooser = hs.chooser.new(function(choice)
--     if choice then
--         print("用户选择了：" .. choice.text)
--         win = hs.window.get(choice.id)
--         if (win ~= nil) then win:focus() end
--     end
-- end)

-- chooser:placeholderText("请输入一些文本")

-- local choices = {}
-- for i, win in ipairs(hs.window.allWindows()) do
--     if win:title() == "" then
--         print("win:title() is nil")
--         goto continue
--     end
--     table.insert(choices, {text = win:title(), id = win:id()})
--     ::continue::
-- end
-- chooser:choices(choices)

-- -- chooser:show()

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