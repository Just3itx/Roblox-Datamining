-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local Signals = require(scriptParentParentParent.Signals)

local _CoreScriptsRoactCommon = require(scriptParentParentParent.CoreScriptsRoactCommon)

local function useSignalMapState(arg1)
    local var1, var2 = React.useState(arg1)

    React.useLayoutEffect(function()
        var2(arg1)
        return Signals.createEffect(function(arg2)
            arg1.getCount(arg2)
            var2(arg1)
        end)
    end, { arg1 })

    return var1
end

return useSignalMapState
