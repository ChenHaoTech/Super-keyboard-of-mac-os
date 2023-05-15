windows_preferences_path = "/Users/apple/.hammerspoon/db/window_config.plist"
Windows_preferences = hs.plist.read(windows_preferences_path)
PrintTable(Windows_preferences)