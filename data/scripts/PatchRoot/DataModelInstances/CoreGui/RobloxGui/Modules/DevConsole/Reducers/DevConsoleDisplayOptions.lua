-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)
local Constants = require(script.Parent.Parent.Constants)

local SetDevConsoleVisibility = require(script.Parent.Parent.Actions.SetDevConsoleVisibility)
local SetDevConsoleMinimized = require(script.Parent.Parent.Actions.SetDevConsoleMinimized)
local ChangeDevConsoleSize = require(script.Parent.Parent.Actions.ChangeDevConsoleSize)
local SetDevConsolePosition = require(script.Parent.Parent.Actions.SetDevConsolePosition)
local SetActiveTab = require(script.Parent.Parent.Actions.SetActiveTab)

return function(tbl1, tbl2)
    local var1 = tbl1
        or {
            formFactor = Constants.FormFactor.Large,
            isVisible = false,
            isMinimized = false,
            position = Constants.MainWindowInit.Position,
            size = Constants.MainWindowInit.Size,
            visibleStartTime = 0
        }

    if tbl2.type == SetDevConsoleVisibility.name then
        local tbl3 = {
            isVisible = tbl2.isVisible
        }

        if tbl3.isVisible then
            tbl3.isMinimized = false
            tbl3.visibleStartTime = tick()
        end
        return Immutable.JoinDictionaries(var1, tbl3)
    end
    if tbl2.type == SetDevConsolePosition.name then
        return (Immutable.Set(var1, "position", tbl2.position))
    end
    if tbl2.type == SetDevConsoleMinimized.name then
        return (Immutable.Set(var1, "isMinimized", tbl2.isMinimized))
    end
    if tbl2.type == ChangeDevConsoleSize.name then
        if var1.formFactor == Constants.FormFactor.Large then
            return (Immutable.Set(var1, "size", tbl2.newSize))
        end
    elseif tbl2.type == SetActiveTab.name then
        return (Immutable.Set(var1, "isMinimized", false))
    end

    return var1
end
