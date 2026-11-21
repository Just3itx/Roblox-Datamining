-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local _Types = require(ChatUIPrimitives.Types)

return React.memo(function(tbl1) -- name: RewriteToggle
    local var1 = Foundation.Hooks.useTokens()
    local icon = if tbl1.showOriginal then Foundation.Enums.IconName.ChevronLargeUp else Foundation.Enums.IconName.ChevronLargeDown

    local var3 = tbl1.messageBinding:map(function(arg1): boolean
        return not (arg1 == nil) and arg1.wasRewritten == true
    end)

    local var4 = tbl1.messageBinding:map(function(arg1): string
        if not (arg1 and arg1.originalText) then
            return ""
        end
        return `<s>{arg1.originalText}</s>`
    end)

    local var5 = tbl1.messageBinding:map(function(arg1)
        return not (arg1 == nil or arg1.wasRewritten ~= true) and tbl1.showOriginal
    end)

    return React.createElement(Foundation.View, {
        tag = "col gap-xsmall auto-y",
        Size = UDim2.new(1, 0, 0, 0),
        backgroundStyle = {
            Color3 = Color3.new(0, 0, 0),
            Transparency = 1
        },
        LayoutOrder = tbl1.LayoutOrder
    }, {
        toggleRow = React.createElement(Foundation.View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            backgroundStyle = {
                Color3 = Color3.new(0, 0, 0),
                Transparency = 1
            },
            Visible = var3,
            LayoutOrder = 1
        }, {
            label = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy text-caption-small text-align-x-left content-muted",
                    Text = "(rephrased)",
                    LayoutOrder = 1
                }
            ),
            caret = React.createElement(Foundation.IconButton, {
                icon = icon,
                variant = Foundation.Enums.ButtonVariant.Utility,
                size = Foundation.Enums.InputSize.XSmall,
                isCircular = true,
                onActivated = tbl1.onToggle,
                LayoutOrder = 2
            })
        }),
        dropdown = React.createElement(Foundation.View, {
            tag = "col gap-xxsmall size-full-0 auto-y padding-small radius-medium",
            backgroundStyle = {
                Color3 = var1.Color.Common.Scrim.Color3,
                Transparency = 0.7
            },
            Visible = var5,
            LayoutOrder = 2
        }, {
            original = React.createElement(Foundation.Text, {
                tag = "text-caption-medium text-wrap text-align-x-left content-muted",
                Text = var4,
                RichText = true,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            }),
            explanation = React.createElement(Foundation.Text, {
                tag = "text-caption-medium text-wrap text-align-x-left content-muted",
                Text = "Roblox rephrases messages that break safety rules.",
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2
            })
        })
    })
end)
