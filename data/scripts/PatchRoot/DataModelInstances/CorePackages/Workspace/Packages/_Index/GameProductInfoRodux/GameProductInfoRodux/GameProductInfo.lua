-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRoduxParent = script:FindFirstAncestor("GameProductInfoRodux").Parent
local Result = require(GameProductInfoRoduxParent.Result)

local module = {}

function module.new()
    return {}
end

function module.mock(universeId)
    local module2 = module.new()
    module2.universeId = universeId
    module2.isForSale = true
    module2.productId = 12345
    module2.price = 5
    module2.sellerId = 6789
    return module2
end

function module.fromJsonData(arg1)
    local universeId = arg1.universeId
    local bool1 = type(universeId) == "number"
        and type(arg1.isForSale) == "boolean"
        and type(arg1.productId) == "number"
        and type(arg1.price) == "number"
        and type(arg1.sellerId) == "number"
    local bool2 = not (arg1.fiatPurchaseData == nil or type(arg1.universeId) ~= "number") and type(arg1.isForSale) == "boolean"

    if not (bool1 or bool2) then
        return Result.error("invalid data type")
    end

    local module2 = module.new()
    module2.universeId = tostring(arg1.universeId)
    module2.isForSale = arg1.isForSale
    module2.productId = arg1.productId
    module2.price = arg1.price
    module2.sellerId = arg1.sellerId

    if arg1.fiatPurchaseData then
        module2.localizedFiatPrice = arg1.fiatPurchaseData.localizedFiatPrice
        module2.fiatBasePriceId = arg1.fiatPurchaseData.basePriceId
    end

    return Result.success(module2)
end

return module
