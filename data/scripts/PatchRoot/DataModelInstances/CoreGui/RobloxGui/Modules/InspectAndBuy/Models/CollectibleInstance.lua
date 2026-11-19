-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new()
    return {}
end

function module.fromGetCollectibleItemInstances(arg1)
    return {
        collectibleInstanceId = arg1.collectibleInstanceId,
        collectibleItemId = arg1.collectibleItemId,
        collectibleProductId = arg1.collectibleProductId,
        serialNumber = arg1.serialNumber,
        instanceState = arg1.instanceState,
        saleState = arg1.saleState,
        price = arg1.price
    }
end
return module
