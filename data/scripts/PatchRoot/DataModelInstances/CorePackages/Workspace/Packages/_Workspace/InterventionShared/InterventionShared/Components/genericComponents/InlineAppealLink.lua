-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local React = require(InterventionSharedParent.React)

local Constants = require(InterventionShared.Utils.Constants)

local Foundation = require(InterventionSharedParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local InlineLayout = require(InterventionSharedParent.InlineLayout)
local InlineLayout2 = InlineLayout.Components.InlineLayout
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement
local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement

local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization

local FFlagUFRDialogContentCutoffFix = require(InterventionShared.Flags.FFlagUFRDialogContentCutoffFix)

local tbl1 = {
    name = "u",
    attributes = {}
}

return React.memo(function(tbl2) -- name: InlineAppealLink
    local var1 = useTokens()
    local disclaimer = useLocalization({ disclaimer = { Constants.localizationKeys.DisclaimerText, startLink = "<a>", endLink = "</a>" } }).disclaimer

    local bodyMedium = var1.Typography.BodyMedium
    local default = var1.Color.Content.Default

    local var2, var3, var4 = disclaimer:match("^(.*)<a>(.*)</a>(.*)$")
    local elements = { TextElement.new({ Text = var2, fontStyle = bodyMedium, textStyle = default }), LinkElement.new(
            { TextElement.new({
                    Text = var3,
                    EngineTags = { tbl1 },
                    fontStyle = bodyMedium,
                    testId = "inline-appeal-link-action-text",
                    textStyle = default
                }) },
            {
                key = "inline-appeal-link-action",
                onActivated = tbl2.onActivated
            }
        ), TextElement.new({ Text = var4, fontStyle = bodyMedium, textStyle = default }) }

    if not FFlagUFRDialogContentCutoffFix then
        return React.createElement(
            View,
            {
                tag = "size-full-0 auto-y",
                testId = "inline-appeal-link",
                LayoutOrder = tbl2.LayoutOrder
            },
            {
                Layout = React.createElement(InlineLayout2, { Elements = elements })
            }
        )
    end

    local var5, var6 = React.useBinding(0)
    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        testId = "inline-appeal-link",
        LayoutOrder = tbl2.LayoutOrder,
        sizeConstraint = {
            MinSize = var5:map(function(y: number): Vector2
                return Vector2.new(0, y)
            end)
        }
    }, {
        MeasuredLayout = React.createElement(View, {
            tag = "size-full-0 auto-y",
            onAbsoluteSizeChanged = function(arg1)
                var6(arg1.AbsoluteSize.Y)
            end
        }, {
            Layout = React.createElement(InlineLayout2, { Elements = elements })
        })
    })
end)
