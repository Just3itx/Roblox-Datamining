-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local FoundationText = Foundation.Text
local shouldShowPriceLabel = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).shouldShowPriceLabel
local _PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)

local function SubheaderLabelPrice(tbl1)
    local var1 = React.useMemo(function()
        return shouldShowPriceLabel(tbl1.priceStatus)
    end, { tbl1.priceStatus })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-xy row align-y-center align-x-left gap-xxsmall",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        LeftSlotLabel = if tbl1.subheaderText.leftSlotLabel then React.createElement(FoundationText, {
            tag = "auto-xy text-align-x-left text-body-large content-default text-truncate-split",
            LayoutOrder = 1,
            Text = tbl1.subheaderText.leftSlotLabel
        }) else nil,
        Spacer = if var1 and tbl1.subheaderText.leftSlotLabel and tbl1.subheaderText.leftSlotLabel ~= "" then React.createElement(Icon, { name = "icons/controls/keys/period", size = IconSize.Small, LayoutOrder = 2 }) else nil,
        RightSlotLabel = 0
    }
    local element

    if var1 and tbl1.subheaderText.rightSlotPrice then
        element = React.createElement(Foundation.View, {
            tag = "auto-xy row align-y-center align-x-left gap-xxsmall",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 3
        }, {
            Icon = React.createElement(Icon, { name = "icons/common/robux", size = IconSize.Small, LayoutOrder = 1 }),
            RightSlotLabel = React.createElement(FoundationText, {
                tag = "auto-xy text-align-x-left text-body-large content-default text-truncate-split",
                LayoutOrder = 2,
                Text = tbl1.subheaderText.rightSlotPrice
            })
        })
    else
        element = nil
    end

    tbl3.RightSlotLabel = element
    return createElement(view, tbl2, tbl3)
end

return SubheaderLabelPrice
