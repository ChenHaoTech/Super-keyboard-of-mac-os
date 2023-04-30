local function _demo_menu()
    local caffeine = hs.menubar.new()
    caffeine:setTitle("HELLO")
    caffeine:setTooltip("FUCK")
    local function caffeineClicked() hs.alert.show("FUCK") end
    caffeine:setClickCallback(caffeineClicked)
end


-- hs.hotkey.bind({"cmd", "alt", "shift", "ctrl"}, "0", _demo_menu)