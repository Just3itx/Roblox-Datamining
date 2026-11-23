-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local Image, _ = require(AppChat.Utils.loadFoundationCloudAsset)("pictograms/alert")

return React.memo(function() -- name: MomentShareCardUnavailable
    local var2 = useLocalization({ momentUnavailable = "Feature.Moments.Label.MomentUnavailableDefault" })

    return React.createElement(Foundation.View, {
        tag = "col align-x-center size-full-0 auto-xy padding-xxlarge bg-action-subtle",
        testId = "MomentShareCardUnavailable"
    }, {
        UnavailableImage = React.createElement(Foundation.Image, {
            Image = Image,
            tag = "size-1600 content-system-contrast",
            ScaleType = Enum.ScaleType.Fit,
            testId = "MomentShareCardUnavailableImage",
            LayoutOrder = 1
        }),
        UnavailableText = React.createElement(Foundation.Text, {
            tag = "auto-xy text-body-large text-wrap text-align-x-center content-system-contrast",
            Text = var2.momentUnavailable,
            LayoutOrder = 2
        })
    })
end)
