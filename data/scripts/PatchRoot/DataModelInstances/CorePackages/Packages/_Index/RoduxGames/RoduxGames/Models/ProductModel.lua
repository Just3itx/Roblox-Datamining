-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGamesParent = script:FindFirstAncestor("RoduxGames").Parent
local t = require(RoduxGamesParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    local var1 = arg1 or {}

    return (module.new({
        productId = var1.productId or "productId",
        sellerId = var1.sellerId or "sellerId",
        price = var1.price or 666,
        isForSale = var1.isForSale or true
    }))
end

function module.format(arg1)
    return (module.new({
        productId = tostring(arg1.productId),
        sellerId = tostring(arg1.sellerId),
        isForSale = arg1.isForSale or false,
        price = arg1.price or 0
    }))
end
module.isValid = t.strictInterface({ productId = t.string, sellerId = t.string, price = t.number, isForSale = t.boolean })

return module
