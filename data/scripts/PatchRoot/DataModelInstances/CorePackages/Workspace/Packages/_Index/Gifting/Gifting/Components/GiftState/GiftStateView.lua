-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)
local FoundationCloudAssets = require(GiftingParent.FoundationCloudAssets)

local Button = Foundation.Button
local Image = Foundation.Image
local Loading = Foundation.Loading
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens

local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset

preloadAsset("pictograms/collaborators")
preloadAsset("pictograms/alert")

local GiftStateEnum = require(script.Parent.GiftStateEnum)

return React.memo(function(tbl1) -- name: GiftStateView
    local bool1 = not (tbl1.retryLabel == nil) and tbl1.onRetry ~= nil
    local var1 = useTokens()
    local state = tbl1.state
    local var2 = if state == GiftStateEnum.Empty then Assets["pictograms/collaborators"] elseif state == GiftStateEnum.Error or state == GiftStateEnum.Blocked then Assets["pictograms/alert"] else nil
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "col align-x-center gap-medium size-full-0 auto-y padding-y-xxlarge",
        testId = `gift-state-{string.lower(state)}`
    }
    local tbl3 = {
        Loading = if state == GiftStateEnum.Loading then React.createElement(Loading, { testId = "gift-state-loading-indicator", LayoutOrder = 1 }) else nil,
        Illustration = 0,
        Title = 0,
        Body = 0,
        Retry = 0
    }
    local element

    if var2 then
        element = React.createElement(Image, {
            Image = var2.assetId,
            imageStyle = var1.Color.Content.Emphasis,
            ScaleType = Enum.ScaleType.Fit,
            Size = UDim2.fromOffset(320 * var1.Config.UI.Scale, 180 * var1.Config.UI.Scale),
            testId = "gift-state-illustration",
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl3.Illustration = element

    tbl3.Title = if tbl1.titleText then React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-emphasis",
        Text = tbl1.titleText,
        testId = "gift-state-title",
        LayoutOrder = 2
    }) else nil

    tbl3.Body = if tbl1.bodyText then React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default",
        Text = tbl1.bodyText,
        testId = "gift-state-body",
        LayoutOrder = 3
    }) else nil

    tbl3.Retry = if bool1 then React.createElement(Button, {
        text = tbl1.retryLabel,
        variant = ButtonVariant.Standard,
        onActivated = tbl1.onRetry,
        testId = "gift-state-retry",
        LayoutOrder = 4
    }) else nil
    return createElement(var3, tbl2, tbl3)
end)
