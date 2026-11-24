-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent
local createSignal = require(CoreGuiCommonParent.Signals).createSignal

return function()
    local getInspectAndBuyOpen, setInspectAndBuyOpen = createSignal(false)

    return {
        getInspectAndBuyOpen = getInspectAndBuyOpen,
        setInspectAndBuyOpen = setInspectAndBuyOpen
    }
end
