-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _PurchaseItemsTypes = require(script.Parent.Parent.Types.PurchaseItemsTypes)

local function getIsInsufficientRobuxError(arg1)
    local success, result = pcall(function(): boolean
        local message = HttpService:JSONDecode(arg1.Body).message or ""
        return string.find(message, "InsufficientTotalBalance") ~= nil
    end)
    return if success then result else false
end

return getIsInsufficientRobuxError
