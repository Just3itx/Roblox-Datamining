-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local useLocalization = require(BulkPurchaseAppParent.Localization).Hooks.useLocalization
local StyledTextLabel = require(BulkPurchaseAppParent.UIBlox).App.Text.StyledTextLabel
local ItemStatusToItemStatusKey = require(BulkPurchaseApp.Enums.ItemStatusToItemStatusKey)
local ItemStatusKeyToLocalizationKey = require(BulkPurchaseApp.Enums.ItemStatusKeyToLocalizationKey)

local function mapTokens(arg1)
    return {
        successColor = arg1.Color.System.Success,
        failureColor = arg1.Color.System.Alert,
        fontStyle = arg1.Typography.BodySmall
    }
end

local function ItemStatus(arg1)
    local var1 = useDesignTokens(mapTokens)
    local var2 = useLocalization(ItemStatusKeyToLocalizationKey)
    local colorStyle = if arg1.status == Enum.MarketplaceItemPurchaseStatus.Success then var1.successColor else var1.failureColor
    local text = var2[ItemStatusToItemStatusKey[arg1.status]]
    return React.createElement(StyledTextLabel, {
        fontStyle = var1.fontStyle,
        colorStyle = colorStyle,
        text = text,
        textWrapped = true,
        size = UDim2.fromScale(1, 1),
        textXAlignment = Enum.TextXAlignment.Right,
        textYAlignment = Enum.TextYAlignment.Top,
        lineHeight = var1.fontStyle.LineHeight
    })
end
return ItemStatus
