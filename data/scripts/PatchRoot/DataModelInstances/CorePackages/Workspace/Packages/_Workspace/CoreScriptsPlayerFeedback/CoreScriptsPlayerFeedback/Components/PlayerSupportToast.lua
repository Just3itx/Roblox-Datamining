-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedbackParent = script:FindFirstAncestor("CoreScriptsPlayerFeedback").Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)
local Foundation = require(CoreScriptsPlayerFeedbackParent.Foundation)
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local BuilderIcons = require(CoreScriptsPlayerFeedbackParent.BuilderIcons)

return (React.memo(function(tbl1)
    local var1 = useTokens()

    React.useEffect(function()
        local bool1 = false
        task.delay(4, function()
            if not bool1 then
                tbl1.onDismiss()
            end
        end)
        return function()
            bool1 = true
        end
    end, { tbl1.onDismiss })

    return React.createElement(View, {
        Position = UDim2.new(0.5, 0, 1, -var1.Padding.XLarge * 4),
        AnchorPoint = Vector2.new(0.5, 1),
        tag = "row align-y-center gap-medium auto-xy bg-system-contrast",
        padding = {
            left = UDim.new(0, var1.Padding.Large),
            right = UDim.new(0, var1.Padding.Large),
            top = UDim.new(0, var1.Padding.Medium),
            bottom = UDim.new(0, var1.Padding.Medium)
        },
        cornerRadius = UDim.new(0, var1.Radius.Large)
    }, {
        CheckIcon = React.createElement(
            Icon,
            {
                name = BuilderIcons.Icon.CircleCheck,
                size = IconSize.Medium,
                style = var1.Inverse.Content.Emphasis,
                LayoutOrder = 1
            }
        ),
        Label = React.createElement(FoundationText, {
            Text = tbl1.text,
            tag = "auto-xy text-title-medium text-align-x-left",
            textStyle = var1.Inverse.Content.Emphasis,
            LayoutOrder = 2
        })
    })
end))
