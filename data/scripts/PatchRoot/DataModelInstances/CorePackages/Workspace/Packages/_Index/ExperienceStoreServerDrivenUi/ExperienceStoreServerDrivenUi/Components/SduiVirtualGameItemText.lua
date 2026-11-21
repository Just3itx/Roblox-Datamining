-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUiParent = script:FindFirstAncestor("ExperienceStoreServerDrivenUi").Parent

local React = require(ExperienceStoreServerDrivenUiParent.React)
local Foundation = require(ExperienceStoreServerDrivenUiParent.Foundation)
local TextSize = require(ExperienceStoreServerDrivenUiParent.TextSize)
local useLocalization = require(ExperienceStoreServerDrivenUiParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Tooltip = Foundation.Tooltip
local useTokens = Foundation.Hooks.useTokens

local IconName = Foundation.Enums.IconName
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local tbl1 = {
    pendingReceiptTooltip = "Purchasing.PurchaseDialog.Message.PendingDeveloperProductOnHome"
}

local function resolveTag(str1: string?, str2: string): string -- Luacid: Inlined by compiler; 13 call sites recovered
    return if typeof(str1) == "string" and str1 ~= "" then str1 else str2
end

local function resolveIconStyle(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 == nil then arg2 else arg1
end

return React.memo(function(tbl2) -- name: SduiVirtualGameItemText
    local var1 = useTokens()
    local var2 = useLocalization(tbl1)
    local pendingReceiptsCountText = tbl2.pendingReceiptsCountText
    local bool1 = typeof(pendingReceiptsCountText) == "string" and pendingReceiptsCountText ~= ""

    if not bool1 then
        pendingReceiptsCountText = nil
    end
    local pendingReceiptsTooltipText = tbl2.pendingReceiptsTooltipText
    if bool1 then
        if typeof(pendingReceiptsTooltipText) ~= "string" or pendingReceiptsTooltipText == "" then
            pendingReceiptsTooltipText = var2.pendingReceiptTooltip
        end
    else
        pendingReceiptsTooltipText = nil
    end
    local bool2 = typeof(tbl2.title) == "string" and tbl2.title ~= ""
    local var3 = if tbl2.titleMaxLines == nil then 2 elseif tbl2.titleMaxLines > 0 then tbl2.titleMaxLines else 2
    local fontStyle = if tbl2.titleFontStyle ~= nil then tbl2.titleFontStyle else var1.Typography.TitleMedium
    local var5 = TextSize.getTextSizeStore(false).getTextSizeOffset(false)
    local yOffset = if bool2 then math.ceil(var3 * (fontStyle.LineHeight * fontStyle.FontSize + var5)) else 0
    local bool3 = typeof(tbl2.priceText) == "string" and tbl2.priceText ~= ""
    local bool4 = bool3 and tbl2.showBasePriceCrossed == true and tbl2.basePriceText ~= nil and tbl2.basePriceText ~= ""
    local bool5 = tbl2.hideRobuxIconInPrice == true

    local bool6 = bool3 or bool1

    local size = if tbl2.priceRobuxIconSize == nil then "Small" else tbl2.priceRobuxIconSize

    local style = resolveIconStyle(tbl2.priceRobuxIconStyle, var1.Color.Content.Emphasis)
    local var4 = if tbl2.basePriceRobuxIconSize == nil then "XSmall" else tbl2.basePriceRobuxIconSize

    local var6 = resolveIconStyle(tbl2.basePriceRobuxIconStyle, var1.Color.Content.Muted)

    local createElement = React.createElement
    local var10 = View
    local tbl3 = {
        LayoutOrder = tbl2.layoutOrder,
        tag = resolveTag(tbl2.tag, "col fill auto-xy"),
        testId = tbl2.testId
    }
    local tbl4 = { Title = 0, PriceRow = 0 }
    local element

    if bool2 then
        element = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl2.title,
            TextWrapped = true,
            TextTruncate = Enum.TextTruncate.AtEnd,
            fontStyle = fontStyle,
            Size = UDim2.new(1, 0, 0, yOffset),
            tag = resolveTag(tbl2.titleTag, "size-full-0 text-wrap text-align-x-left text-truncate-end content-emphasis"),
            testId = if tbl2.testId then `{tbl2.testId}--title` else nil
        })
    else
        element = nil
    end

    tbl4.Title = element
    local var11

    if bool6 then
        local createElement2 = React.createElement
        local var12 = View
        local tbl5 = {
            LayoutOrder = 2,
            tag = resolveTag(tbl2.priceRowTag, "row align-y-center gap-small auto-xy"),
            testId = if tbl2.testId then `{tbl2.testId}--price-row` else nil
        }
        local tbl6 = { CurrentPrice = 0, BasePrice = 0, OwnedCount = 0 }
        local var13

        if bool3 then
            local createElement3 = React.createElement
            local var14 = View
            local tbl7 = {
                LayoutOrder = 1,
                tag = resolveTag(tbl2.currentPriceTag, "row align-y-center gap-xsmall auto-xy"),
                testId = if tbl2.testId then `{tbl2.testId}--current-price` else nil
            }
            local tbl8 = {
                RobuxIcon = if bool5 then nil else React.createElement(Icon, {
                    name = IconName.Robux,
                    size = size,
                    style = style,
                    LayoutOrder = 1,
                    testId = if tbl2.testId then `{tbl2.testId}--price-robux-icon` else nil
                }),
                Price = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl2.priceText,
                    tag = resolveTag(tbl2.priceTextTag, "auto-xy text-align-x-left text-body-medium content-emphasis")
                })
            }
            var13 = createElement3(var14, tbl7, tbl8)
        else
            var13 = nil
        end

        tbl6.CurrentPrice = var13
        local var14

        if bool4 then
            local createElement3 = React.createElement
            local var15 = View
            local tbl7 = {
                LayoutOrder = 2,
                tag = resolveTag(tbl2.basePriceTag, "auto-xy"),
                testId = if tbl2.testId then `{tbl2.testId}--base-price` else nil
            }
            local tbl8 = { Content = 0, Strikethrough = 0 }
            local createElement4 = React.createElement
            local var16 = View
            local tbl9 = {
                tag = resolveTag(tbl2.basePriceContentTag, "row align-y-center gap-xsmall auto-xy")
            }
            local tbl10 = {
                RobuxIcon = React.createElement(Icon, {
                    name = IconName.Robux,
                    size = var4,
                    style = var6,
                    LayoutOrder = 1,
                    testId = if tbl2.testId then `{tbl2.testId}--base-price-robux-icon` else nil
                }),
                Price = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl2.basePriceText,
                    tag = resolveTag(tbl2.basePriceTextTag, "auto-xy text-align-x-left text-body-small content-muted")
                })
            }
            tbl8.Content = createElement4(var16, tbl9, tbl10)

            tbl8.Strikethrough = React.createElement(View, {
                tag = resolveTag(tbl2.strikethroughTag, "bg-system-neutral position-center-center anchor-center-center"),
                Size = UDim2.new(1, 0, 0, 1),
                ZIndex = 2,
                testId = if tbl2.testId then `{tbl2.testId}--base-price-strikethrough` else nil
            })
            var14 = createElement3(var15, tbl7, tbl8)
        else
            var14 = nil
        end

        tbl6.BasePrice = var14
        local var15

        if bool1 then
            local createElement3 = React.createElement
            local var16 = View
            local tbl7 = {
                LayoutOrder = 3,
                tag = resolveTag(tbl2.ownedCountTag, "row align-y-center gap-xsmall auto-xy"),
                testId = if tbl2.testId then `{tbl2.testId}--owned-count` else nil
            }
            local tbl8 = {
                Dot = if bool3 then React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = resolveTag(tbl2.ownedCountSeparatorText, "·"),
                    tag = resolveTag(tbl2.ownedCountSeparatorTag, "auto-xy text-body-medium content-default"),
                    testId = if tbl2.testId then `{tbl2.testId}--owned-count-separator` else nil
                }) else nil,
                Label = 0
            }

            local createElement4 = React.createElement
            local var17 = Tooltip
            local tbl9 = {
                LayoutOrder = 2,
                title = "",
                text = pendingReceiptsTooltipText,
                side = PopoverSide.Top,
                align = PopoverAlign.Center
            }
            local createElement5 = React.createElement
            local var18 = View
            local tbl10 = {
                tag = "auto-xy",
                onStateChanged = function(_) end,
                testId = if tbl2.testId then `{tbl2.testId}--owned-count-tooltip` else nil
            }
            local tbl11 = {
                Text = React.createElement(FoundationText, {
                    Text = pendingReceiptsCountText,
                    tag = resolveTag(tbl2.ownedCountTextTag, "auto-xy text-body-medium content-muted"),
                    testId = if tbl2.testId then `{tbl2.testId}--owned-count-label` else nil
                })
            }
            tbl8.Label = createElement4(var17, tbl9, createElement5(var18, tbl10, tbl11))
            var15 = createElement3(var16, tbl7, tbl8)
        else
            var15 = nil
        end

        tbl6.OwnedCount = var15
        var11 = createElement2(var12, tbl5, tbl6)
    else
        var11 = nil
    end

    tbl4.PriceRow = var11
    return createElement(var10, tbl3, tbl4)
end)
