-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Signals = require(scriptParentParentParentParent.Signals)

local InputMode = require(scriptParentParentParent.InputMode)

return function()
    local getLastInputType, var2 = Signals.createSignal((InputMode.last()))
    local getPreferredInputType, var4 = Signals.createSignal((InputMode.preferred()))

    InputMode.connect(function()
        var2((InputMode.last()))
        var4((InputMode.preferred()))
    end)

    return { getLastInputType = getLastInputType, getPreferredInputType = getPreferredInputType }
end
