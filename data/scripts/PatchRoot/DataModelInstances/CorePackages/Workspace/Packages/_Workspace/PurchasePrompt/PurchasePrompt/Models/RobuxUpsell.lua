-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _scriptParentParent = script.Parent.Parent

local module = {}

function module.new(id: number, providerId: string, productName: string, robuxAmount: number, price: string?)
    return {
        id = id,
        providerId = providerId,
        productName = productName,
        robuxAmount = robuxAmount,
        price = price
    }
end

function module.fromJson(tbl1)
    return {
        id = tbl1.roblox_product_id,
        providerId = tbl1.provider_product_id,
        productName = tbl1.roblox_product_name,
        robuxAmount = tbl1.robux_amount,
        robuxAmountBeforeBonus = tbl1.robux_amount_before_bonus,
        price = tbl1.price
    }
end

return module
