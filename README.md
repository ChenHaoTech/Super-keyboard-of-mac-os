chenhao's  Hammerspoon Script Library
# Features
窗口快捷键映射工具
Window Shortcut Key Mapping Tool
# Usage
长按 cmd+shift+option+control + 0-9 绑定窗口, 之后再次短按 cmd+shift+option+control + 0-9 就可以激活绑定的窗口。相关的键盘映射配置在 init.lua 文件里

Long press cmd+shift+option+control + 0-9 to bind windows, then short press cmd+shift+option+control + 0-9 again to activate the bound window. The relevant keyboard mapping configuration is in the init.lua file.
# Motivation
之前在 window 系统使用 autohotkey 开发了一套的 键盘激活工具, 但是在 mac os 上没有找到合适的工具, 于是就有了这个项目
Before, I developed a set of keyboard activation tools using autohotkey in window system, but I didn't find a suitable tool on mac OS, so I had this project.

ps: [chenhaoaixuexi/supper-keyboard: in order to use vim editor , i need a script to optimize my keyboard --- chenhaoaixuexi/supper-keyboard：为了使用vim编辑器，我需要一个脚本来优化我的键盘](https://github.com/chenhaoaixuexi/supper-keyboard)
# Q & A
## what is Hammerspoon ?
autohotkey in mac os 👍
## Hammerspoon sdk
[Hammerspoon/hammerspoon: Staggeringly powerful macOS desktop automation with Lua --- Hammerspoon/hammerspoon：使用 Lua 的惊人强大的 macOS 桌面自动化](https://github.com/Hammerspoon/hammerspoon)
# TODO
- [x] 实现 capslock+0,1~9 的窗口绑定, 相关源码在window_utils.lua
- [ ]  整理文件目录