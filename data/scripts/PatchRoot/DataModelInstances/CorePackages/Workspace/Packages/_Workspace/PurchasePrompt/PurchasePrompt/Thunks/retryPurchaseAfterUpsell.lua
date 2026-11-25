-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local Thunk = require(PurchasePrompt.Thunk)
local dispatchPurchaseForProductPayload = require(PurchasePrompt.Utils.dispatchPurchaseForProductPayload)

local tbl1 = {}

local function retryPurchaseAfterUpsell()
    return Thunk.new(script.Name, tbl1, function(arg1, _)
        local productPayload = arg1:getState().productPayload

        dispatchPurchaseForProductPayload(function(arg2)
            arg1:dispatch(arg2)
        end, productPayload, nil, true)
    end)
end

return retryPurchaseAfterUpsell
