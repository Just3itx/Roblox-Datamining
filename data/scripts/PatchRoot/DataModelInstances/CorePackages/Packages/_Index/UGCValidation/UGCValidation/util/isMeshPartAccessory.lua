-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isMeshPartAccessory(accessory)
    if accessory:IsA("Accessory") then
        local handle = accessory:FindFirstChild("Handle")
        if handle and handle:IsA("MeshPart") then
            return true
        end
    end
    return false
end

return isMeshPartAccessory
