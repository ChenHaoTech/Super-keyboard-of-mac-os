--[[ -- 显示文本输入对话框，获取用户输入的文本内容
local result, text = hs.dialog.textPrompt("请输入一段文本", "这是默认文本")

-- 如果用户输入了文本，打印文本内容
if result == "OK" then
    print(text)
end

-- 显示文件选择对话框，获取用户选择的文件或文件夹路径
local result, files = hs.dialog.chooseFileOrFolder("请选择文件或文件夹", "~/Documents", false, true, false)

-- 如果用户选择了文件或文件夹，打印路径
if result == "OK" then
    print(files[1])
end

local alert = hs.dialog.blockAlert("Title", "Message", "Button 1", "Button 2")
print(alert) -- 打印用户点击的按钮的索引
 ]]