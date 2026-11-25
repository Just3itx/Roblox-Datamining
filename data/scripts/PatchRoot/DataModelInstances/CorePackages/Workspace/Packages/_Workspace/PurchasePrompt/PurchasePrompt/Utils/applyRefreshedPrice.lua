-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local RefreshExpectedPrice = require(PurchasePrompt.Actions.RefreshExpectedPrice)
local SetProductPayload = require(PurchasePrompt.Actions.SetProductPayload)

local function applyRefreshedPrice(arg1, expectedPrice: number)
    arg1:dispatch(RefreshExpectedPrice(expectedPrice))

    local productPayload = arg1:getState().productPayload
    if productPayload then
        local var1 = table.clone(productPayload)
        var1.expectedPrice = expectedPrice
        arg1:dispatch(SetProductPayload(var1))
    end
end

return applyRefreshedPrice
