-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)

local Localization = require(ExpChat.Localization)

local FStringInExpChatRewriteLabelKey = require(ExpChat.Flags.FStringInExpChatRewriteLabelKey)

local mergeBindableScalar = require(ExpChat.ChatWindow.Helpers.mergeBindableScalar)

return React.memo(function(tbl1) -- name: RewriteToggle
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Localization.useLocalization({
        rewrittenLabelText = FStringInExpChatRewriteLabelKey,
        defaultRewrittenLabelText = "CoreScripts.TextChat.ChatWindow.RewrittenLabel"
    })
    local var3 = if var2.rewrittenLabelText and var2.rewrittenLabelText ~= "" then var2.rewrittenLabelText else var2.defaultRewrittenLabelText

    local var4 = tbl1.textTransparency:map(function(arg1): boolean
        return arg1 < 1
    end)

    local var5 = React.joinBindings({ var4, tbl1.isRewriteMenuOpen }):map(function(arg1)
        return arg1[1] and arg1[2]
    end)

    local var6 = React.joinBindings({ var4, tbl1.isRewriteMenuOpen }):map(function(arg1)
        return arg1[1] and not arg1[2]
    end)

    return React.createElement(
        Foundation.View,
        {
            tag = "row align-y-center gap-xsmall size-full-0 auto-y",
            LayoutOrder = tbl1.LayoutOrder,
            Visible = tbl1.Visible
        },
        {
            Label = React.createElement(Foundation.Text, {
                Text = "(" .. var3 .. ")",
                tag = "size-0-0 auto-xy text-caption-small text-align-x-left",
                LayoutOrder = 1,
                RichText = true,
                textStyle = {
                    Color3 = var1.Color.Content.Muted.Color3,
                    Transparency = mergeBindableScalar(var1.Color.Content.Muted.Transparency, tbl1.textTransparency)
                },
                stroke = {
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = mergeBindableScalar(0.5, tbl1.textTransparency),
                    Thickness = var1.Stroke.Thin
                }
            }),
            IconButtonUp = React.createElement(Foundation.IconButton, {
                size = Foundation.Enums.InputSize.XSmall,
                icon = Foundation.Enums.IconName.ChevronLargeUp,
                variant = Foundation.Enums.ButtonVariant.Utility,
                isCircular = true,
                LayoutOrder = 2,
                Visible = var5,
                onActivated = tbl1.onActivated
            }),
            IconButtonDown = React.createElement(Foundation.IconButton, {
                size = Foundation.Enums.InputSize.XSmall,
                icon = Foundation.Enums.IconName.ChevronLargeDown,
                variant = Foundation.Enums.ButtonVariant.Utility,
                isCircular = true,
                LayoutOrder = 3,
                Visible = var6,
                onActivated = tbl1.onActivated
            })
        }
    )
end)
