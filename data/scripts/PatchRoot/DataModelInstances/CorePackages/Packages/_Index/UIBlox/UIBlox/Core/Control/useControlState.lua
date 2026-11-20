-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local ControlState = require(scriptParentParent.Control.Enum.ControlState)

local function useControlState()
    local var1, var2 = React.useState(ControlState.Initialize)

    return var1, (React.useCallback(function(_, arg1)
        var2(arg1)
    end, {}))
end

return useControlState
