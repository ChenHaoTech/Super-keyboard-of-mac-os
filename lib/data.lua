windows_preferences_path = "/Users/apple/.hammerspoon/db/window_config.plist"
Windows_preferences = hs.plist.read(windows_preferences_path)
BindFlag = false; -- 是否开启 bind flag

PrintTable(Windows_preferences)