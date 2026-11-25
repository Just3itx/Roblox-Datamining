-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)

local function meetsBundlePrerequisites(arg1, arg2, robux: number?, arg3, _)
    local collectibleItemDetail = arg1.collectibleItemDetail
    local bool1 = collectibleItemDetail
        and not (collectibleItemDetail.collectibleItemId == nil)
        and collectibleItemDetail.collectibleItemId ~= ""
    local bool2 = collectibleItemDetail
        and not (collectibleItemDetail.collectibleItemType == nil)
        and collectibleItemDetail.collectibleItemType == "Limited"

    if bool1 then
        if not bool2 and arg3 then
            return false, PurchaseError.AlreadyOwn
        end
    elseif arg3 then
        return false, PurchaseError.AlreadyOwn
    end

    local bool3 = if bool1 then collectibleItemDetail.saleStatus == "OnSale" else arg1.product and arg1.product.isForSale

    if bool1 then
        if collectibleItemDetail.lowestAvailableResaleProductId == nil then
            bool1 = false
        else
            bool1 = collectibleItemDetail.lowestAvailableResaleProductId ~= ""
        end
    end

    if not (bool3 or bool1) then
        return false, PurchaseError.NotForSale
    end

    if robux ~= nil and arg2.robux ~= nil and arg2.robux < robux then
        return false, PurchaseError.NotEnoughRobux
    end

    if arg1.itemRestrictions ~= nil then
        for _, itemRestriction in arg1.itemRestrictions do
            if itemRestriction ~= "ThirteenPlus" then
                continue
            end

            if Players.LocalPlayer:GetUnder13() then
                return false, PurchaseError.Under13
            end

            break
        end
    end

    return true, nil
end

return meetsBundlePrerequisites
