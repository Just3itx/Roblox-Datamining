-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization
local LocalizationRoactContext = require(BulkPurchaseAppParent.Localization).LocalizationRoactContext
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel
local ReactFocusNavigation = require(BulkPurchaseAppParent.ReactFocusNavigation)

local FullPagePrompt = require(BulkPurchaseApp.Components.FullPagePrompt)
local PriceBox = require(BulkPurchaseApp.Components.PriceBox)
local LineItemLayout = require(BulkPurchaseApp.Components.LineItemLayout)
local FullPagePromptTwoPanelLayout = require(BulkPurchaseApp.Components.FullPagePromptTwoPanelLayout)
local Divider = require(BulkPurchaseApp.Components.Divider)
local FullPagePromptScrollList = require(BulkPurchaseApp.Components.FullPagePromptScrollList)
local FFlagFixVP8143 = require(BulkPurchaseApp.Flags.FFlagFixVP8143)
local FFlagBulkPurchaseEnablePurchaseOptions = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseEnablePurchaseOptions)
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)
local FFlagBulkPurchaseTestPurchaseHint = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseTestPurchaseHint)

local ItemList = require(BulkPurchaseApp.Components.ItemList)
local _AvatarExperienceCommon = require(BulkPurchaseAppParent.AvatarExperienceCommon)
local _RobloxSubscriptionPurchaseApp = require(BulkPurchaseAppParent.RobloxSubscriptionPurchaseApp)
local ItemStatusKeyToLocalizationKey = require(BulkPurchaseApp.Enums.ItemStatusKeyToLocalizationKey)
local _Types = require(BulkPurchaseApp.Store.Types)

local _BulkPurchaseRequestItem = require(script.Parent.BulkPurchaseRequestItem)
local _BulkPurchaseRequestOwnedItem = require(script.Parent.BulkPurchaseRequestOwnedItem)
local _BulkPurchaseRequestUnpurchasableItem = require(script.Parent.BulkPurchaseRequestUnpurchasableItem)

local ItemPresentationMapper = require(script.Parent.ItemPresentationMapper)
local mapItemsToRowPresentation = ItemPresentationMapper.mapItemsToRowPresentation
local mapOwnedItemsToRowPresentation = ItemPresentationMapper.mapOwnedItemsToRowPresentation
local mapUnpurchasableItemsToRowPresentation = ItemPresentationMapper.mapUnpurchasableItemsToRowPresentation

local tbl1 = {
    heading = "CoreScripts.BulkPurchasePrompt.RequestPrompt.Heading",
    listHeading = "CoreScripts.BulkPurchasePrompt.RequestPrompt.ItemListPurchaseHeading",
    itemCount = "CoreScripts.BulkPurchasePrompt.RequestPrompt.ItemListPurchaseCount",
    itemOwned = "CoreScripts.BulkPurchasePrompt.RequestPrompt.ItemOwned"
}

local function BulkPurchaseRequest(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = React.useContext(LocalizationRoactContext)
    local var3, ref = ReactFocusNavigation.useDefaultFocusBehavior()

    local var5 = if FFlagFixVP8143 then React.useCallback(function(current)
        if typeof(tbl2.purchaseButtonRef) == "table" then
            tbl2.purchaseButtonRef.current = current
        end
        if typeof(var3) == "function" then
            var3(current)
        elseif typeof(var3) == "table" then
            var3.current = current
        end
    end, { tbl2.purchaseButtonRef }) else nil

    local var6 = useDesignTokens()
    local fontStyle = {
        LineHeight = var6.Typography.BodyLarge.LineHeight,
        Font = var6.Typography.TitleLarge.Font,
        FontSize = var6.Typography.BodyLarge.FontSize,
        LetterSpacing = var6.Typography.BodyLarge.LetterSpacing
    }
    local emphasis = var6.Color.Content.Emphasis

    local var7, var8 = React.useBinding(Vector2.new(0, 0))

    local var9 = useLocalization(ItemStatusKeyToLocalizationKey)
    local success = var6.Color.System.Success
    local alert = var6.Color.System.Alert

    local var10 = mapItemsToRowPresentation
    local items = tbl2.items

    if not FFlagBulkPurchaseEnablePurchaseOptions then
        var2 = nil
    end

    local var4 = var10(items, var2)
    local tbl3 = {}
    local var12 = mapOwnedItemsToRowPresentation(tbl2.ownedItems, emphasis, var1)

    local var13 = mapUnpurchasableItemsToRowPresentation(tbl2.unpurchasableItems, var9, success, alert)
    table.move(var12, 1, #var12, #tbl3 + 1, tbl3)
    table.move(var13, 1, #var13, #tbl3 + 1, tbl3)

    local bool1 = #tbl3 > 0

    local createElement = React.createElement
    local var14 = FullPagePrompt
    local tbl5 = {
        onClose = tbl2.onClose,
        title = var1.heading,
        ref = ref
    }
    local createElement2 = React.createElement
    local var15 = FullPagePromptTwoPanelLayout
    local tbl6 = {
        size = React.createBinding(UDim2.fromScale(1, 1)),
        startSlot = 0,
        endSlot = 0
    }
    local createElement3 = React.createElement
    local str1 = "Frame"
    local tbl7 = {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }
    local element = React.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, var6.Size.Size_600)
    })
    local createElement4 = React.createElement

    local tbl8 = {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1
    }

    tbl8[React.Change.AbsoluteSize] = function(arg1)
        var8(arg1.AbsoluteSize)
    end

    local element2 = React.createElement("UIPadding", { PaddingRight = UDim.new(0, var6.Size.Size_250) })

    local createElement5 = React.createElement
    local var16 = LineItemLayout
    local tbl9 = {
        startSlot = React.createElement(StyledTextLabel, { fontStyle = fontStyle, colorStyle = emphasis, text = var1.listHeading }),
        endSlot = 0,
        LayoutOrder = 1
    }
    local createElement6 = React.createElement
    local var17 = StyledTextLabel
    local tbl10 = { fontStyle = fontStyle, colorStyle = emphasis, text = 0 }
    local itemCount = var1.itemCount
    local itemsLen = #tbl2.items
    tbl10.text = itemCount:gsub("{.*}", tostring(itemsLen))
    tbl9.endSlot = createElement6(var17, tbl10)
    local element4 = createElement4("Frame", tbl8, element2, createElement5(var16, tbl9))

    tbl6.startSlot = createElement3(
        str1,
        tbl7,
        element,
        element4,
        React.createElement(FullPagePromptScrollList, {
            LayoutOrder = 2,
            size = var7:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, 0, 1, -(vector2.Y + var6.Size.Size_600))
            end)
        }, React.createElement(ItemList, { items = var4 }), if bool1 then React.createElement(Divider) else nil, if bool1 then React.createElement(ItemList, { items = tbl3 }) else nil)
    )

    local createElement7 = React.createElement
    local var18 = PriceBox
    local tbl11 = {
        currentBalance = tbl2.currentBalance,
        totalCost = tbl2.totalCost,
        discountInformation = tbl2.discountInformation,
        missingRobux = tbl2.currentBalance - tbl2.totalCost < 0,
        onAccept = tbl2.onAccept,
        buttonRef = 0,
        isDisabled = 0,
        shouldShowBlackbirdUpsellBanner = 0,
        blackbirdUpsellBannerProductInfo = 0,
        onBlackbirdUpsellActivated = 0,
        offerData = 0,
        toggleOfferSelected = 0,
        isTestPurchase = 0
    }

    if not FFlagFixVP8143 then
        var5 = var3
    end

    tbl11.buttonRef = var5
    tbl11.isDisabled = tbl2.isDisabled
    tbl11.shouldShowBlackbirdUpsellBanner = if FFlagAXAddPlusUpsellToBulkPurchase then tbl2.shouldShowBlackbirdUpsellBanner else nil

    tbl11.blackbirdUpsellBannerProductInfo = if FFlagAXAddPlusUpsellToBulkPurchase then tbl2.blackbirdUpsellBannerProductInfo else nil

    tbl11.onBlackbirdUpsellActivated = if FFlagAXAddPlusUpsellToBulkPurchase then tbl2.onBlackbirdUpsellActivated else nil

    tbl11.offerData = if FFlagAXAddOffersToBulkPurchase then tbl2.offerData else nil
    tbl11.toggleOfferSelected = if FFlagAXAddOffersToBulkPurchase then tbl2.toggleOfferSelected else nil
    tbl11.isTestPurchase = if FFlagBulkPurchaseTestPurchaseHint then tbl2.isTestPurchase else nil
    tbl6.endSlot = createElement7(var18, tbl11)
    return createElement(var14, tbl5, createElement2(var15, tbl6))
end

return BulkPurchaseRequest
