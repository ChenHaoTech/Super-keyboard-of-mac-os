-- [Hammerspoon docs: hs.task --- Hammerspoon 文档：hs.task](https://www.hammerspoon.org/docs/hs.task.html#new)
-- hs.task.new(launchPath, callbackFn[, streamCallbackFn][, arguments]) -> hs.task object
--[[ 

Execute processes in the background and capture their output
在后台执行进程并捕获它们的输出

Notes:  笔记：

This is not intended to be used for processes which never exit.
这不适用于永不退出的进程。
While it is possible to run such things with hs.task, it is not possible to read their output while they run and if they produce significant output, eventually the internal OS buffers will fill up and the task will be suspended.
虽然可以使用 hs.task 运行此类任务，但在它们运行时无法读取它们的输出，并且如果它们产生大量输出，最终内部操作系统缓冲区将填满并且任务将被挂起。
An hs.task object can only be used once
一个 hs.task 对象只能使用一次


]]
GlobalTask = hs.task.new("/opt/homebrew/bin/sgpt", function(exitCode, stdOut, stdErr)
    if exitCode == 0 then
        hs.alert.show("Command executed successfully!")
        hs.alert.show("Output:\n" .. stdOut)
    else
        hs.alert.show("Command failed!")
        hs.alert.show("Error:\n" .. stdErr)
    end
end,{"hi"})
-- GlobalTask:start()