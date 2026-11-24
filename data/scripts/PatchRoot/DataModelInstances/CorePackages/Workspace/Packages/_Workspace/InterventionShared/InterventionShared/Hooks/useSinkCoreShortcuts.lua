-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local ContextActionService = game:GetService("ContextActionService")

local React = require(InterventionSharedParent.React)

local var1 = Enum.ContextActionPriority.High.Value + 1

local function useSinkCoreShortcuts(bool1: boolean, arg1)
    local var2 = arg1 or ContextActionService

    React.useEffect(function()
        if not bool1 then
            return nil
        end

        var2:BindCoreActionAtPriority("InterventionDialogSinkCoreShortcuts", function(): Enum.ContextActionResult
            return Enum.ContextActionResult.Sink
        end, false, var1, Enum.KeyCode.Escape, Enum.KeyCode.Tab, Enum.KeyCode.ButtonStart)

        return function()
            var2:UnbindCoreAction("InterventionDialogSinkCoreShortcuts")
        end
    end, { bool1, var2 })
end

return useSinkCoreShortcuts
