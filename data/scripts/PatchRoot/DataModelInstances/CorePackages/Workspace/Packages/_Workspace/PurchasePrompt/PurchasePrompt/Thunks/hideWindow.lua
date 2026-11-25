-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local SetWindowState = require(scriptParentParent.Actions.SetWindowState)
local WindowState = require(scriptParentParent.Enums.WindowState)
local Thunk = require(scriptParentParent.Thunk)

local function hideWindow()
    return Thunk.new(script.Name, {}, function(arg1, _)
        return arg1:dispatch(SetWindowState(WindowState.Hidden))
    end)
end

return hideWindow
