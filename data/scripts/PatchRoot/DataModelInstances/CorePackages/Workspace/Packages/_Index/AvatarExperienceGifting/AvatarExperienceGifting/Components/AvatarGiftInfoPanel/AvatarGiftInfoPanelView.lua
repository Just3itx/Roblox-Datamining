-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)
local Foundation = require(AvatarExperienceGiftingParent.Foundation)
local InfoTooltip = require(AvatarExperienceGiftingParent.Gifting).Components.InfoTooltip

local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText
local useTokens = Foundation.Hooks.useTokens

local function robuxText(str1: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `{getIconRichText(IconName.Robux)} {str1}`
end

return React.memo(function(tbl1) -- name: AvatarGiftInfoPanelView
    local var1 = useTokens()
    local priceText = tbl1.priceText
    local originalPriceText = tbl1.originalPriceText
    local pricingNote = tbl1.pricingNote
    local var2 = tbl1.thumbnailSize or var1.Size.Size_1600

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "col align-x-center gap-small size-full-0 auto-y padding-large radius-large bg-shift-100",
        testId = "AvatarGiftInfoPanelView",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        Thumbnail = React.createElement(Image, {
            Image = tbl1.thumbnailUrl,
            Size = UDim2.fromOffset(var2, var2),
            tag = "aspect-1-1",
            testId = "avatar-gift-info-panel-thumbnail",
            LayoutOrder = 1
        }),
        Details = 0
    }

    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = { tag = "col align-x-center gap-xsmall size-full-0 auto-y", LayoutOrder = 2 }

    local tbl5 = {
        Title = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-emphasis",
            Text = tbl1.itemName,
            testId = "avatar-gift-info-panel-title",
            LayoutOrder = 1
        }),
        Price = 0,
        PricingNote = 0,
        Caption = 0
    }
    local element

    if priceText then
        element = React.createElement(View, {
            tag = "row align-x-center align-y-center gap-small auto-xy",
            LayoutOrder = 2
        }, {
            Current = React.createElement(FoundationText, {
                tag = "auto-xy text-title-large text-no-wrap content-emphasis",
                Text = robuxText(priceText),
                RichText = true,
                testId = "avatar-gift-info-panel-price",
                LayoutOrder = 1
            }),
            Original = if originalPriceText then React.createElement(FoundationText, {
                tag = "auto-xy text-body-medium text-no-wrap content-muted",
                Text = `<s>{robuxText(originalPriceText)}</s>`,
                RichText = true,
                testId = "avatar-gift-info-panel-original-price",
                LayoutOrder = 2
            }) else nil
        })
    else
        element = nil
    end

    tbl5.Price = element

    tbl5.PricingNote = if pricingNote then React.createElement(InfoTooltip, {
        text = pricingNote.text,
        tooltipTitle = pricingNote.tooltipTitle,
        tooltipText = pricingNote.tooltipText,
        testId = "avatar-gift-info-panel-pricing",
        LayoutOrder = 3
    }) else nil

    tbl5.Caption = if tbl1.captionText then React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-caption-small text-wrap text-align-x-center content-default",
        Text = tbl1.captionText,
        testId = "avatar-gift-info-panel-caption",
        LayoutOrder = 4
    }) else nil
    tbl3.Details = createElement2(var4, tbl4, tbl5)
    return createElement(var3, tbl2, tbl3)
end)
