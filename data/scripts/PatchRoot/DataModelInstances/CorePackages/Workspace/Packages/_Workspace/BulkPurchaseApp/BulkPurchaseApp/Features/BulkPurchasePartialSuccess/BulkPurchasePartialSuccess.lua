-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local UIBlox = require(BulkPurchaseAppParent.UIBlox)

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local FullPagePrompt = require(BulkPurchaseApp.Components.FullPagePrompt)
local FullPagePromptTwoPanelLayout = require(BulkPurchaseApp.Components.FullPagePromptTwoPanelLayout)
local Divider = require(BulkPurchaseApp.Components.Divider)
local ItemListHeader = require(BulkPurchaseApp.Components.ItemListHeader)
local FullPagePromptScrollList = require(BulkPurchaseApp.Components.FullPagePromptScrollList)
local Box = require(BulkPurchaseApp.Components.Box)
local PriceBoxLine_DEPRECATED = require(BulkPurchaseApp.Components.PriceBoxLine_DEPRECATED)

local _Style = require(BulkPurchaseAppParent.Style)
local ItemCardThumbnail = require(BulkPurchaseAppParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local ItemList = require(BulkPurchaseApp.Components.ItemList)
local _AvatarExperienceCommon = require(BulkPurchaseAppParent.AvatarExperienceCommon)

local ItemStatusToItemStatusKey = require(BulkPurchaseApp.Enums.ItemStatusToItemStatusKey)
local ItemStatusKeyToLocalizationKey = require(BulkPurchaseApp.Enums.ItemStatusKeyToLocalizationKey)

local function toCardPropsWithId(tbl1: {presentationSlot: number, priceLineContent: number, title: number}, id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tbl1)
    var1.id = id
    return var1
end

local tbl1 = {
    heading = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.Heading",
    unsuccessfulHeading = "CoreScripts.BulkPurchasePrompt.CompletedPrompt.ErrorHeading",
    notice = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.Notice",
    itemListSuccessfulCount = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.ItemListSuccessfulCount",
    itemListUnsuccessfulCount = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.ItemListUnsuccessfulCount",
    itemListSuccessfulHeading = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.ItemListSuccessfulHeading",
    itemListUnsuccessfulHeading = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.ItemListUnsuccessfulHeading",
    robuxSpent = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.PriceBox.RobuxSpent",
    currentBalance = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.PriceBox.CurrentBalance",
    dismissCTA = "CoreScripts.BulkPurchasePrompt.PartialPurchaseCompletedPrompt.PriceBox.DismissCTA"
}

local function mapTokens(arg1)
    return {
        boxBackground = arg1.Color.Surface.Surface_100.Color3,
        boxPadding = arg1.Size.Size_600,
        boxCornerRadius = arg1.Radius.Medium,
        buttonMarginTop = arg1.Size.Size_400,
        buttonHeight = arg1.Size.Size_900,
        lineItemSpacing = arg1.Size.Size_100,
        noticeFontStyle = arg1.Typography.BodyLarge,
        noticeColorStyle = arg1.Color.Content.Muted,
        noticeMarginBottom = arg1.Size.Size_600,
        successColor = arg1.Color.System.Success,
        failureColor = arg1.Color.System.Alert
    }
end

local function mapBulkPurchasePartialSuccessItemsToRowPresentation(tbl2, tbl3, successColor, failureColor)
    local result = {}
    for _, value in tbl2 do
        local text = tbl3[ItemStatusToItemStatusKey[value.status]]
        local colorStyle = if value.status == Enum.MarketplaceItemPurchaseStatus.Success then successColor else failureColor
        local tbl4 = {
            presentationSlot = React.createElement(ItemCardThumbnail, { url = value.image }),
            title = value.name,
            priceLineContent = {{ type = "text", text = text, colorStyle = colorStyle }}
        }
        table.insert(result, (toCardPropsWithId(tbl4, value.id)))
    end
    return result
end

local function BulkPurchasePartialSuccess(tbl2)
    local var1 = useDesignTokens(mapTokens)
    local var2 = useLocalization(tbl1)
    local var3 = useLocalization(ItemStatusKeyToLocalizationKey)
    local var4, var5 = React.useBinding(Vector2.new(0, 0))
    local bool1 = #tbl2.successfulItems > 0

    local createElement = React.createElement
    local var6 = FullPagePrompt
    local tbl3 = {
        onClose = tbl2.onDismiss,
        title = if bool1 then var2.heading else var2.unsuccessfulHeading
    }
    local element = React.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, var1.noticeMarginBottom)
    })
    local createElement2 = React.createElement

    local tbl4 = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var5(arg1.AbsoluteSize)
    end

    local element2 = createElement2(
        "Frame",
        tbl4,
        React.createElement(StyledTextLabel, {
            fontStyle = var1.noticeFontStyle,
            colorStyle = var1.noticeColorStyle,
            text = var2.notice,
            layoutOrder = 1,
            automaticSize = Enum.AutomaticSize.XY
        })
    )
    local createElement3 = React.createElement
    local var7 = FullPagePromptTwoPanelLayout

    local tbl5 = {
        LayoutOrder = 2,
        size = var4:map(function(vector2: Vector2): UDim2
            return UDim2.new(1, 0, 1, -(vector2.Y + var1.noticeMarginBottom))
        end),
        startSlot = 0,
        endSlot = 0
    }
    local createElement4 = React.createElement
    local var8 = FullPagePromptScrollList
    local tbl6 = {
        LayoutOrder = 1,
        size = React.createBinding(UDim2.fromScale(1, 1))
    }
    local createElement5 = React.createElement
    local var9 = ItemListHeader
    local tbl7 = {
        heading = var2.itemListUnsuccessfulHeading,
        itemCount = 0,
        LayoutOrder = 1
    }
    local itemListUnsuccessfulCount = var2.itemListUnsuccessfulCount
    local unsuccessfulItemsLen = #tbl2.unsuccessfulItems
    tbl7.itemCount = itemListUnsuccessfulCount:gsub("{.*}", tostring(unsuccessfulItemsLen))
    local element5 = createElement5(var9, tbl7)

    local element3 = React.createElement(ItemList, {
        items = mapBulkPurchasePartialSuccessItemsToRowPresentation(tbl2.unsuccessfulItems, var3, var1.successColor, var1.failureColor),
        LayoutOrder = 2
    })
    local element4 = if bool1 then React.createElement(Divider, { LayoutOrder = 3 }) else nil
    local var10

    if bool1 then
        local createElement6 = React.createElement
        local var11 = ItemListHeader
        local tbl8 = {
            heading = var2.itemListSuccessfulHeading,
            itemCount = 0,
            LayoutOrder = 4
        }
        local itemListSuccessfulCount = var2.itemListSuccessfulCount
        local successfulItemsLen = #tbl2.successfulItems
        tbl8.itemCount = itemListSuccessfulCount:gsub("{.*}", tostring(successfulItemsLen))
        var10 = createElement6(var11, tbl8)
    else
        var10 = nil
    end

    tbl5.startSlot = createElement4(
        var8,
        tbl6,
        element5,
        element3,
        element4,
        var10,
        if bool1 then React.createElement(ItemList, {
            items = mapBulkPurchasePartialSuccessItemsToRowPresentation(tbl2.successfulItems, var3, var1.successColor, var1.failureColor),
            LayoutOrder = 5
        }) else nil
    )

    tbl5.endSlot = React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        },
        React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.buttonMarginTop)
        }),
        React.createElement(Box, {
            padding = var1.boxPadding,
            cornerRadius = UDim.new(0, var1.boxCornerRadius),
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = var1.boxBackground,
            BorderSizePixel = 0
        }, {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, var1.lineItemSpacing)
            }),
            RobuxSpent = React.createElement(
                PriceBoxLine_DEPRECATED,
                {
                    text = var2.robuxSpent,
                    amount = tbl2.robuxSpent,
                    highlight = true,
                    LayoutOrder = 1
                }
            ),
            CurrentBalance = React.createElement(
                PriceBoxLine_DEPRECATED,
                {
                    text = var2.currentBalance,
                    amount = tbl2.currentBalance,
                    LayoutOrder = 2
                }
            )
        }),
        React.createElement(Button, {
            text = var2.dismissCTA,
            onActivated = tbl2.onDismiss,
            buttonType = ButtonType.PrimarySystem,
            size = UDim2.new(1, 0, 0, var1.buttonHeight)
        })
    )
    return createElement(var6, tbl3, element, element2, createElement3(var7, tbl5))
end

return BulkPurchasePartialSuccess
