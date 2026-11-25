-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local Signals = require(scriptParentParentParent.Signals)

local function useLegacyVisibilityMirror(bool1: boolean)
    local var1, var2 = React.useMemo(function()
        return Signals.createSignal(bool1)
    end, {})

    React.useEffect(function()
        var2(bool1)
    end, { bool1 })

    return var1
end

return useLegacyVisibilityMirror
