-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isSelectionOnScreen(selectedCoreObject) -- Luacid: Inlined by compiler; 1 call site recovered
    if selectedCoreObject == nil then
        return false
    end
    local success, result = pcall(function()
        return selectedCoreObject:IsDescendantOf(game)
    end)
    return success and result
end

local function restoreSelectionIfStranded(arg1, selectedCoreObject)
    if selectedCoreObject == nil then
        return
    end

    if not isSelectionOnScreen(arg1.SelectedCoreObject) then
        arg1.SelectedCoreObject = selectedCoreObject
    end
end

return restoreSelectionIfStranded
