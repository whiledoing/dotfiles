hs.alert.closeAll()

local ignored = require 'ignored'

-- key define
local hyper = {'cmd', 'shift'}
local hyperShift = {'cmd', 'shift', 'ctrl'}

-- disable animation
hs.window.animationDuration = 0

-- hide window shadows
hs.window.setShadows(false)

-- cli
if not hs.ipc.cliStatus() then hs.ipc.cliInstall() end

-- App shortcuts
local key_map, key_func_map = require 'key_map' ()
for key, app_name in pairs(key_map) do
    hs.hotkey.bind(hyper, key, function() hs.application.launchOrFocus(app_name) end)
end
for key, func in pairs(key_func_map) do
    hs.hotkey.bind(hyper, key, func)
end

-- Hints
hs.hotkey.bind(hyper, ';', function() hs.hints.windowHints() end)
-- will show parent parent process name
-- hs.hints.style = "vimperator"

-- undo
local undo = require 'undo'
hs.hotkey.bind(hyper, 'j', function() undo:undo() end)

-- Grids
hs.grid.GRIDWIDTH = 8
hs.grid.GRIDHEIGHT = 2
hs.grid.MARGINX = 0
hs.grid.MARGINY  = 0

local moveMaxWidth = hs.grid.GRIDWIDTH / 2 + 1
local moveMinWidth = hs.grid.GRIDWIDTH / 2 - 1

local hyperUp = hs.hotkey.bind(hyper, 'k', function()
    undo:addToStack()
    hs.grid.maximizeWindow()
end)

-- Move Window
function horizontalMove(direction)
    local w = hs.window.focusedWindow()
    if not w or not w:isStandard() then return end
    local s = w:screen()
    if not s then return end
    if ignored(w) then return end
    local g = hs.grid.get(w)
    g.y = 0
    g.h = hs.grid.GRIDHEIGHT
    direction = direction / math.abs(direction)

    if g.x + g.w == hs.grid.GRIDWIDTH and g.x == 0 then
        if direction < 0 then
            g.w = g.w - direction
            g.x = hs.grid.GRIDWIDTH - g.w
        else
            g.w = g.w + direction
        end
        undo:addToStack()
        hs.grid.set(w, g, s)
    end

    if g.x + g.w == hs.grid.GRIDWIDTH then
        g.w = g.w - direction
        local toMove = false
        if g.w > moveMaxWidth then
            g.w = moveMaxWidth
            g.x = 0
            toMove = true
        elseif g.w >= moveMinWidth then
            g.x = hs.grid.GRIDWIDTH - g.w
            toMove = true
        end
        if toMove then
            undo:addToStack()
            hs.grid.set(w, g, s)
            if direction > 0 and g.x + g.w >= hs.grid.GRIDWIDTH then
                w:ensureIsInScreenBounds()
            end
        end
        return
    end

    if g.x == 0 then
        g.w = g.w + direction
        local toMove = false
        if g.w > moveMaxWidth then
            g.w = moveMaxWidth
            g.x = hs.grid.GRIDWIDTH - moveMaxWidth
            toMove = true
            elseif g.w >= moveMinWidth then
                toMove = true
            end
            if toMove then
                undo:addToStack()
                hs.grid.set(w, g, s)
            end
            return
    end

    g.w = hs.grid.GRIDWIDTH / 2
    g.x = direction > 0 and hs.grid.GRIDWIDTH / 2 or 0
    undo:addToStack()
    hs.grid.set(w, g, s)
end

local hyperLeft = hs.hotkey.bind(hyper, 'h', function() horizontalMove(-1) end)
local hyperRight = hs.hotkey.bind(hyper, 'l', function() horizontalMove(1) end)

-- Move Screen
hs.hotkey.bind(hyperShift, 'h', function()
    local w = hs.window.focusedWindow()
    if not w then
        return
    end
    if ignored(w) then return end

    local s = w:screen():toWest()
    if s then
        undo:addToStack()
        w:moveToScreen(s)
    end
end)

hs.hotkey.bind(hyperShift, 'l', function()
    local w = hs.window.focusedWindow()
    if not w then
        return
    end
    if ignored(w) then return end

    local s = w:screen():toEast()
    if s then
        undo:addToStack()
        w:moveToScreen(s)
    end
end)

-- split view
SplitModal = require 'split_modal'
local splitModal = SplitModal.new(hyper, 's', undo)

function splitModal:hotkeysToDisable()
    return {hyperUp, hyperRight, hyperLeft}
end

-- console
hs.hotkey.bind(hyperShift, 'c', hs.openConsole)

-- reload
hs.hotkey.bind(hyper, 'escape', function() hs.reload() end )

-- Auto-reload config
function reloadConfig(files)
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            return hs.reload()
        end
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- reload success alert
hs.alert('Hammerspoon reload success', 0.6)
