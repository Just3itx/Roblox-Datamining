-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local Network = require(PurchasePrompt.Services.Network)
local Thunk = require(PurchasePrompt.Thunk)
local searchUsers = require(PurchasePrompt.Network.searchUsers)

local tbl1 = { Network }

local function searchUsers2(str1: string)
    return Thunk.new(script.Name, tbl1, function(_, arg1)
        return searchUsers(arg1[Network], str1)
    end)
end

return searchUsers2
