-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local GiftAllowanceView = require(script.Parent.Parent.GiftAllowance.GiftAllowanceView)
local GiftSheetLayoutView = require(script.Parent.Parent.GiftSheetLayout.GiftSheetLayoutView)
local GiftStateView = require(script.Parent.Parent.GiftState.GiftStateView)
local UserInfoPanelView = require(script.Parent.Parent.UserInfoPanel.UserInfoPanelView)

local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant

return React.memo(function(arg1) -- name: GiftSendView
    local allowance = arg1.allowance
    local savingsPresentation = arg1.savingsPresentation
    local element

    if arg1.state then
        element = React.createElement(GiftStateView, arg1.state)
    else
        element = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, {
            Allowance = if allowance then React.createElement(
                View,
                { tag = "col size-full-0 auto-y", LayoutOrder = 1 },
                {
                    Panel = React.createElement(GiftAllowanceView, allowance)
                }
            ) else nil,
            UserInfo = React.createElement(
                View,
                { tag = "col size-full-0 auto-y", LayoutOrder = 2 },
                {
                    Panel = React.createElement(UserInfoPanelView, arg1.userInfoProps)
                }
            ),
            GiftPresentation = React.createElement(
                View,
                {
                    tag = "col size-full-0 auto-y",
                    testId = "gift-send-presentation",
                    LayoutOrder = 3
                },
                arg1.giftPresentation
            ),
            Savings = if savingsPresentation then React.createElement(
                View,
                {
                    tag = "col size-full-0 auto-y padding-top-small",
                    testId = "gift-send-savings",
                    LayoutOrder = 4
                },
                savingsPresentation
            ) else nil
        })
    end

    local actions = if arg1.state then nil else React.createElement(Button, {
        text = arg1.buyLabel,
        variant = ButtonVariant.Emphasis,
        width = UDim.new(1, 0),
        isLoading = arg1.isBuyLoading,
        isDisabled = arg1.isBuyDisabled,
        onActivated = arg1.onBuy,
        testId = "gift-send-buy"
    })
    return React.createElement(GiftSheetLayoutView, {
        isOpen = arg1.isOpen,
        titleText = arg1.titleText,
        onBack = arg1.onBack,
        content = element,
        actions = actions,
        captionText = if arg1.state then nil else arg1.disclaimerText,
        onClose = arg1.onClose
    })
end)
