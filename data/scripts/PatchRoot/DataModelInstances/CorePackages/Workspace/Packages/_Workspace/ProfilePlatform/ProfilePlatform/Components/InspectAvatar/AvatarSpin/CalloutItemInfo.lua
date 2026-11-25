-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local AvatarExperienceInspectAndBuy = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy)
local _Foundation = require(ProfilePlatformParent.Foundation)
local _Types = require(ProfilePlatform.Common.Types)
local InspectAvatarUtils = require(script.Parent.Parent.InspectAvatarUtils)
local _CalloutScoring = require(script.Parent.CalloutScoring)

local getPriceLineContent = AvatarExperienceInspectAndBuy.Utils.getPriceLineContent
local isItemPurchasable = InspectAvatarUtils.isItemPurchasable
local getPriceStatus = InspectAvatarUtils.getPriceStatus
local PriceStatusEnum = InspectAvatarUtils.PriceStatusEnum

local module = {}

function module.getStatusKind(arg1): string
    local priceStatus = getPriceStatus(arg1)

    if arg1.isOwned or priceStatus == PriceStatusEnum.Owned then
        return "owned"
    end

    if isItemPurchasable(arg1) then
        if priceStatus == PriceStatusEnum.PurchaseFromResale then
            return "resale"
        end

        return "purchasable"
    end

    return "unavailable"
end

function module.getCurrentPriceLine(arg1, arg2, tbl1)
    local priceLineContent = getPriceLineContent(arg1, arg2, tbl1, { isShopContext = true })
    if not priceLineContent then
        return nil
    end
    for i = #priceLineContent, 1, -1 do
        local var1 = priceLineContent[i]
        if var1.strikethrough then
            continue
        end
        if var1.type == "price" then
            return {
                type = "price",
                price = var1.price,
                colorStyle = var1.colorStyle
            }
        end

        if var1.type ~= "text" then
            continue
        end

        return {
            type = "text",
            text = var1.text,
            colorStyle = var1.colorStyle
        }
    end

    return nil
end

return module
