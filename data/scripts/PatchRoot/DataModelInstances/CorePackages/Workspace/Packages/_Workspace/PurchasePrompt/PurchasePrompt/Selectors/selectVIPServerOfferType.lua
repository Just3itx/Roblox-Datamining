-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local selectProductPrice = require(script.Parent.selectProductPrice)
local _types = require(PurchasePrompt.types)

local function selectVIPServerOfferType(tbl1): string
    return if tbl1.productInfo.isFreeWithRobloxPlus then "plus_included" elseif selectProductPrice(tbl1) == 0 then "free" else "paid"
end

return selectVIPServerOfferType
