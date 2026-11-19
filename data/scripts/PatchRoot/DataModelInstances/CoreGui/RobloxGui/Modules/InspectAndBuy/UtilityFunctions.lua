-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)

local module = {}

function module.getBundleId(arg1)
    return if arg1.parentBundleId == nil then nil else arg1.parentBundleId
end

function module.isCollectibles(arg1)
    return arg1 and arg1.productType and arg1.productType == Constants.ProductType.CollectibleItem
end

function module.hasLimitedQuantity(arg1)
    if not arg1 then
        return nil
    end

    local isLimited = arg1.isLimited
    local isLimitedUnique = if GetFFlagIBEnableCollectiblesSystemSupport() then arg1.isLimitedUnique else nil
    local collectibleIsLimited = arg1.collectibleIsLimited

    return isLimited or isLimitedUnique or collectibleIsLimited
end

function module.isLimited1Point0(arg1)
    if arg1 then
        return arg1.isLimited or arg1.isLimitedUnique
    end

    return nil
end

function module.isLimited1Point0_LimitedUnique(arg1)
    return if arg1 then arg1.isLimitedUnique else nil
end

function module.isLimited2Point0_Or_LimitedCollectible(arg1)
    return if arg1 then arg1.collectibleIsLimited else nil
end

function module.isUnlimitedCollectibleAsset(asset: string?, arg1)
    if not (asset and arg1) then
        return nil
    end

    local bool1 = not module.hasLimitedQuantity(arg1)
    local bool2 = arg1.productType == Constants.ProductType.CollectibleItem
    local bool3 = asset == Constants.ItemType.Asset

    return bool1 and bool2 and bool3
end

function module.isLimitedBundle(bundle: string?, arg1)
    if not (bundle and arg1) then
        return nil
    end

    local collectibleIsLimited = arg1.collectibleIsLimited
    local bool1 = bundle == Constants.ItemType.Bundle

    return collectibleIsLimited and bool1
end

function module.isUnlimitedCollectibleBundle(bundle: string?, arg1)
    if not (bundle and arg1) then
        return nil
    end

    local bool1 = not arg1.collectibleIsLimited
    local bool2 = arg1.productType == Constants.ProductType.CollectibleItem
    local bool3 = bundle == Constants.ItemType.Bundle

    return bool1 and bool2 and bool3
end

function module.isLimitedCollectible(arg1)
    if not arg1 then
        return nil
    end

    local var1 = module.hasLimitedQuantity(arg1)
    local bool1 = arg1.productType == Constants.ProductType.CollectibleItem

    return var1 and bool1
end

return module
