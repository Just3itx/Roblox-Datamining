-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local Network = require(PurchasePrompt.Services.Network)
local Thunk = require(PurchasePrompt.Thunk)
local generateVIPServerLink = require(PurchasePrompt.Network.generateVIPServerLink)

local tbl1 = { Network }

local function generateVIPServerLink2()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        return generateVIPServerLink(arg2[Network], arg1:getState().promptRequest.vipServerId)
    end)
end

return generateVIPServerLink2
