-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local Signals = require(scriptParentParentParent.Signals)

local GetLatestCaptureStore = require(scriptParentParent.Stores.GetLatestCaptureStore)
local _Types = require(scriptParentParent.Types)

local function useLatestCapture()
    local var1, var2 = React.useState(function()
        return GetLatestCaptureStore(false).getLatestCapture(false)
    end)

    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            var2(GetLatestCaptureStore(arg1).getLatestCapture(arg1))
        end)
    end, {})

    return var1
end

return useLatestCapture
