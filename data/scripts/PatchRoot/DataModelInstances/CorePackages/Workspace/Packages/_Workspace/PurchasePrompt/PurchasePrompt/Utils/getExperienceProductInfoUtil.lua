-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.fromProduct(arg1)
    return {
        universeId = arg1.universeId,
        isForSale = arg1.isForSale,
        productId = arg1.productId,
        price = arg1.price,
        sellerId = arg1.sellerId
    }
end
return module
