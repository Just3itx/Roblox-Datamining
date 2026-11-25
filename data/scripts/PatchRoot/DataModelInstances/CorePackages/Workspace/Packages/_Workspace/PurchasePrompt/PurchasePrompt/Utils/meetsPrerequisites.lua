-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local scriptParentParentParent = scriptParentParent.Parent
local Constants = require(scriptParentParent.Misc.Constants)
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local ProductTypeEnum = require(scriptParentParent.types).ProductTypeEnum
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParentParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local GetFFlagEnableCreatorStorePurchasingCutover = require(scriptParentParent.Flags.GetFFlagEnableCreatorStorePurchasingCutover)

local FFlagPurchasePromptSkipThirdPartyCheckForMissingCreator = require(scriptParentParent.Flags.FFlagPurchasePromptSkipThirdPartyCheckForMissingCreator)

local function meetsPrerequisites(arg1, arg2, arg3, arg4, arg5)
    local bool1 = arg1.ProductType == Constants.ProductType.CollectibleItem
    local isLimited = if arg1.CollectiblesItemDetails then arg1.CollectiblesItemDetails.IsLimited else nil

    if bool1 then
        if not isLimited and arg2 then
            return false, PurchaseError.AlreadyOwn
        end
    elseif arg2 then
        return false, PurchaseError.AlreadyOwn
    end

    if arg5 == nil and not (arg1.IsForSale or arg1.IsPublicDomain) then
        return false, PurchaseError.NotForSale
    end

    if GetFFlagEnableCreatorStorePurchasingCutover() and arg1.IsFiatPriced == true then
        return false, PurchaseError.NotForSale
    end

    if arg5 == nil and arg1.CanBeSoldInThisGame == false then
        return false, PurchaseError.NotForSaleHere
    end

    if arg5 == nil
        and (bool1 and isLimited or arg1.IsLimited or arg1.IsLimitedUnique)
        and (arg1.Remaining == nil or arg1.Remaining == 0)
    then
        return false, PurchaseError.Limited
    end

    if arg1.MinimumMembershipLevel == Enum.MembershipType.Premium.Value
        and Players.LocalPlayer.MembershipType ~= Enum.MembershipType.Premium
    then
        return false, PurchaseError.PremiumOnly
    end

    if arg1.ContentRatingTypeId == 1 and Players.LocalPlayer:GetUnder13() then
        return false, PurchaseError.Under13
    end

    local var1 = if arg4.getLuaUseThirdPartyPermissions() then arg4.isThirdPartyPurchaseAllowed() else Workspace.AllowThirdPartySales
    local var2 = FFlagEnableUnifiedPurchaseFlowForDevSubs and arg1.ProductType == ProductTypeEnum.DeveloperSubscription

    local var3 = FFlagPurchasePromptSkipThirdPartyCheckForMissingCreator and arg1.Creator == nil

    if arg1.ProductType ~= Constants.ProductType.DeveloperProduct and not var2 and not var3 and arg3 and not var1 then
        local bool2 = game.CreatorType == Enum.CreatorType.Group
        local bool3 = arg1.Creator.CreatorType == "Group"
        local var4 = tonumber(arg1.Creator.CreatorTargetId)

        if var4 ~= 1 and (bool2 ~= bool3 or var4 ~= game.CreatorId) then
            warn(
                ("AllowThirdPartySales has blocked the purchase prompt for %d created by %d. To sell this asset made by a different %s, you will need to enable AllowThirdPartySales."):format(
                    arg1.AssetId,
                    var4,
                    if bool2 then "group" else "user"
                )
            )
            return false, PurchaseError.ThirdPartyDisabled
        end
    end

    return true, nil
end

return meetsPrerequisites
