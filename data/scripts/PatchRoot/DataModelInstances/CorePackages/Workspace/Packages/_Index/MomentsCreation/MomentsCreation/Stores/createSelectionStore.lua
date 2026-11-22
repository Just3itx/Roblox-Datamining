-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local createSignal = require(MomentsCreationParent.Signals).createSignal

local function createSelectionStore()
    local getSelectedCapture, setSelectedCapture = createSignal(nil)

    return { getSelectedCapture = getSelectedCapture, setSelectedCapture = setSelectedCapture }
end

return createSelectionStore
