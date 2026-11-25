-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Promise = require(PurchasePrompt.Promise)
local _types = require(PurchasePrompt.types)

local function searchUsers(arg1, str1: string)
    return arg1.searchUsers(str1):andThen(function(arg2)
        if type(arg2) ~= "table" or type(arg2.data) ~= "table" then
            return Promise.reject(PurchaseError.UnknownFailure)
        end

        local result = {}
        for _, value in arg2.data do
            table.insert(result, { userId = value.id, displayName = value.displayName or value.name })
        end

        return result
    end)
end

return searchUsers
