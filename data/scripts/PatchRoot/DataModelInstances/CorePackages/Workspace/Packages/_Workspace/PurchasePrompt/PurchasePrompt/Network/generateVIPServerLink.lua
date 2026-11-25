-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Promise = require(PurchasePrompt.Promise)

local function generateVIPServerLink(arg1, num1: number)
    return arg1.updateVIPServer(num1, { newJoinCode = true }):andThen(function(arg2)
        if type(arg2) ~= "table" or type(arg2.link) ~= "string" then
            return Promise.reject(PurchaseError.UnknownFailure)
        end

        return arg2.link
    end)
end

return generateVIPServerLink
