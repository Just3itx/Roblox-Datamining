-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isScreenSpaceGuiObject(arg1): boolean
    local layerCollector = arg1:FindFirstAncestorWhichIsA("LayerCollector")
    return not (layerCollector == nil) and layerCollector:IsA("ScreenGui")
end

return isScreenSpaceGuiObject
