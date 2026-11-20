-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local createEffect = require(scriptParentParent.Signals).createEffect

local function useSignalBinding(arg1)
    local var1, var2 = React.useBinding(arg1(false))

    React.useLayoutEffect(function()
        var2(arg1(false))
        return createEffect(function(arg2)
            var2(arg1(arg2))
        end)
    end, { arg1 })

    return var1
end

return useSignalBinding
