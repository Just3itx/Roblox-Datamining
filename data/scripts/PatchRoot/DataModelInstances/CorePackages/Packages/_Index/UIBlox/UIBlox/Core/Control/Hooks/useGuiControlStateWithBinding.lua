-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)

local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)
local useGuiControlState = require(scriptParentParentParent.Control.Hooks.useGuiControlState)

local function useGuiControlStateWithBinding(arg1, callback, bool1: boolean)
    local var1, var2 = React.useBinding(ControlState.Initialize)
    local var3 = React.useCallback(function(arg2, arg3)
        var2(tostring(arg3))
        if callback then
            callback(arg2, arg3)
        end
    end, {})

    local var4, _ = useGuiControlState(arg1, var3, bool1)

    return var4, var1
end

return useGuiControlStateWithBinding
