-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local Signals = require(CoreGuiCommonParent.Signals)

return function()
    local getVisibility, setVisibility = Signals.createSignal(false)

    return { getVisibility = getVisibility, setVisibility = setVisibility }
end
