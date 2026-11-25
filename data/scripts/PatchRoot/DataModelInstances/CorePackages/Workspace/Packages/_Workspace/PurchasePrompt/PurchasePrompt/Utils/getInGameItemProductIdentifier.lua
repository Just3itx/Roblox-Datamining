-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _types = require(PurchasePrompt.types)

local tbl1 = {
    [Enum.InfoType.GamePass] = "GamePass",
    [Enum.InfoType.Product] = "DeveloperProduct"
}

local function getInGameItemProductIdentifier(arg1, arg2)
    local namespace = tbl1[arg1]
    if namespace == nil then
        return nil
    end
    if arg2 == nil then
        return nil
    end

    local targetIdentifier = tostring(arg2)
    return if targetIdentifier == "" then nil else {
        namespace = namespace,
        targetIdentifier = targetIdentifier
    }
end

return getInGameItemProductIdentifier
