-- call evernote switch to menu
function focusEvernoteAndSwitchTo()
    hs.application.launchOrFocus("Evernote")
    hs.eventtap.keyStroke({"cmd"}, "j")
end

local key_map = {
    ["1"] = "Google Chrome",
    ["2"] = "iTerm",
    ["3"] = "Visual Studio Code",
    ["4"] = "Wiznote",
    ["0"] = "MacVim",
    ["9"] = "Safari",
    ["8"] = "Cmd Markdown",
    ["c"] = "Wechat",
    -- ["m"] = "NeteaseMusic",
}

function toggleFullSreen()
    hs.window.focusedWindow():toggleFullScreen()
end

local key_func_map = {
    -- ["/"] = focusEvernoteAndSwitchTo,
    ["space"] = toggleFullSreen
}

-- return multipy result [ref](https://stackoverflow.com/questions/9470498/can-luas-require-function-return-multiple-results)
return function() return key_map, key_func_map end