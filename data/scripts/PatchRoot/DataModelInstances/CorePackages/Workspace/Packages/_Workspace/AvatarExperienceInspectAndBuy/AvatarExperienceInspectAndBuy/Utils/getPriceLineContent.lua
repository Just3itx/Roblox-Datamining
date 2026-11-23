-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local _Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local FFlagSocialEnableProfileInspectAndBuy = require(AvatarExperienceInspectAndBuyParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy
local FFlagAXIaBDiscountPriceLine = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXIaBDiscountPriceLine
local FFlagAXIaBEnableShopContext = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXIaBEnableShopContext

local var1 = FFlagSocialEnableProfileInspectAndBuy or FFlagAXIaBEnableShopContext
local getPriceStatusInShop = if var1 then require(AvatarExperienceInspectAndBuy.Utils.getPriceStatusInShop) else nil

local function getPriceLineContent(arg1, arg2, tbl1, tbl2)
    local priceLineContent = {}
    local var2

    if var1 and tbl2 and tbl2.isShopContext then
        assert(
            not tbl2.disableResaleWhenStockIsAvailable,
            "disableResaleWhenStockIsAvailable is not applicable when isShopContext is true"
        )

        var2 = getPriceStatusInShop(arg1)
    else
        var2 = getPriceStatus(arg1, true)
    end

    local var3 = nil
    if FFlagAXIaBDiscountPriceLine and arg1.discountInformation then
        local discountInformation = arg1.discountInformation
        if discountInformation.totalDiscountAmount and discountInformation.totalDiscountAmount > 0 then
            var3 = discountInformation
        end
    end

    local tbl3 = {
        [PriceStatus.Owned] = {{
            type = "text",
            text = tbl1[PriceStatus.Owned]
        }},
        [PriceStatus.Free] = {{
            type = "text",
            text = tbl1[PriceStatus.Free]
        }},
        [PriceStatus.QuantityLimitReached] = {{
            type = "text",
            colorStyle = arg2.Color.System.Warning,
            text = tbl1[PriceStatus.QuantityLimitReached]
        }},
        [PriceStatus.InExperienceOnly] = {{
            type = "text",
            text = tbl1[PriceStatus.InExperienceOnly],
            colorStyle = arg2.Color.System.Warning
        }},
        [PriceStatus.PurchaseFromRoblox] = var3
            and {
                {
                    type = "price",
                    price = var3.originalPrice,
                    strikethrough = true,
                    isOriginalPrice = true
                },
                {
                    type = "price",
                    price = arg1.priceInRobux
                }
            }
            or {{
                type = "price",
                price = arg1.priceInRobux
            }},
        [PriceStatus.PurchaseFromResale] = arg1.isOffSale
            and {{
                type = "price",
                price = if arg1.collectibleItemDetails then arg1.collectibleItemDetails.lowestResalePrice else 0
            }}
            or {
                {
                    type = "price",
                    price = arg1.priceInRobux,
                    strikethrough = true
                },
                {
                    type = "price",
                    price = if arg1.collectibleItemDetails then arg1.collectibleItemDetails.lowestResalePrice else 0,
                    colorStyle = arg2.Color.System.Warning
                }
            },
        [PriceStatus.SoldOut] = {{
            type = "text",
            text = tbl1[PriceStatus.SoldOut],
            colorStyle = arg2.Color.System.Warning
        }},
        [PriceStatus.OffSale] = {{
            type = "text",
            text = tbl1[PriceStatus.OffSale],
            colorStyle = arg2.Color.System.Warning
        }},
        [PriceStatus.Unavailable] = {{
            type = "text",
            text = tbl1[PriceStatus.Unavailable],
            colorStyle = arg2.Color.System.Warning
        }}
    }

    if tbl3[var2] then
        priceLineContent = tbl3[var2]
    end

    return priceLineContent
end

return getPriceLineContent
