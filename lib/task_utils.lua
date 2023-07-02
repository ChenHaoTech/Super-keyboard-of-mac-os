-- [Hammerspoon docs: hs.task --- Hammerspoon 文档：hs.task](https://www.hammerspoon.org/docs/hs.task.html#new)
-- hs.task.new(launchPath, callbackFn[, streamCallbackFn][, arguments]) -> hs.task object
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