-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local GiftSheetLayoutView = require(script.Parent.Parent.GiftSheetLayout.GiftSheetLayoutView)
local GiftStateView = require(script.Parent.Parent.GiftState.GiftStateView)
local UserInfoPanelView = require(script.Parent.Parent.UserInfoPanel.UserInfoPanelView)

local Button = Foundation.Button
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant

return React.memo(function(arg1) -- name: GiftAcceptView
    local element

    if arg1.state then
        element = React.createElement(GiftStateView, arg1.state)
    else
        element = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, {
            UserInfo = React.createElement(
                View,
                { tag = "col size-full-0 auto-y", LayoutOrder = 1 },
                {
                    Panel = React.createElement(UserInfoPanelView, arg1.userInfoProps)
                }
            ),
            GiftPresentation = React.createElement(
                View,
                {
                    tag = "col size-full-0 auto-y",
                    testId = "gift-accept-presentation",
                    LayoutOrder = 2
                },
                arg1.giftPresentation
            )
        })
    end

    local element2

    if arg1.state then
        element2 = nil
    else
        element2 = React.createElement(View, { tag = "row gap-small size-full-0 auto-y" }, {
            Accept = React.createElement(Button, {
                text = arg1.acceptLabel,
                variant = ButtonVariant.Emphasis,
                width = UDim.new(0.5, -4),
                isLoading = arg1.isAcceptLoading,
                isDisabled = arg1.isAcceptDisabled,
                onActivated = arg1.onAccept,
                testId = "gift-accept-accept",
                LayoutOrder = 1
            }),
            Reject = React.createElement(Button, {
                text = arg1.rejectLabel,
                variant = ButtonVariant.Alert,
                width = UDim.new(0.5, -4),
                isLoading = arg1.isRejectLoading,
                isDisabled = arg1.isRejectDisabled,
                onActivated = arg1.onReject,
                testId = "gift-accept-reject",
                LayoutOrder = 2
            })
        })
    end

    return React.createElement(GiftSheetLayoutView, {
        isOpen = arg1.isOpen,
        titleText = arg1.titleText,
        content = element,
        actions = element2,
        captionText = if arg1.state then nil else arg1.disclaimerText,
        onClose = arg1.onClose
    })
end)
