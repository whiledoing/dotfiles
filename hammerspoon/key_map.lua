-- call evernote switch to menu
function focusEvernoteAndSwitchTo()
    hs.application.launchOrFocus("Evernote")
    hs.eventtap.keyStroke({"cmd"}, "j")
end

local hyper_key_map = {
    -- most often
    ["1"] = "Google Chrome",
    ["2"] = "iTerm",

    -- editor
    ["3"] = "Visual Studio Code",
    ["4"] = "印象笔记",
    ["8"] = "Microsoft OneNote",

    -- browser
    ["9"] = "Lark",
    ["0"] = "Safari",
}

function toggleFullSreen()
    hs.window.focusedWindow():toggleFullScreen()
end

local hyper_key_func_map = {
    ["/"] = focusEvernoteAndSwitchTo,
    ["space"] = toggleFullSreen
}

local alt_ctrl_key_map = {
}

local cmd_ctrl_key_map = {
    ["1"] = "GoLand",
    ["2"] = "PyCharm Professional",
    ["0"] = "Firefox",
}

-- return multipy result [ref](https://stackoverflow.com/questions/9470498/can-luas-require-function-return-multiple-results)
return function() return hyper_key_map, hyper_key_func_map, alt_ctrl_key_map, cmd_ctrl_key_map end