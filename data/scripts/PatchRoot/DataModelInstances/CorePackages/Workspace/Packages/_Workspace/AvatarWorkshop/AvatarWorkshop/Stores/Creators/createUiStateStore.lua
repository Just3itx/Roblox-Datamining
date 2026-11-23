-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local createSignal = require(AvatarWorkshopParent.Signals).createSignal

local function createUiStateStore()
    local getLastMeasuredGridWidth, setLastMeasuredGridWidth = createSignal(0)

    return {
        getLastMeasuredGridWidth = getLastMeasuredGridWidth,
        setLastMeasuredGridWidth = setLastMeasuredGridWidth
    }
end

return createUiStateStore
