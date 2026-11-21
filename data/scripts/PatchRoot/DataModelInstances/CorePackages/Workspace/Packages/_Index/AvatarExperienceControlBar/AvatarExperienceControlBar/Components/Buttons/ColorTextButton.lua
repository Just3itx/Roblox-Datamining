-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local Localization = require(AvatarExperienceControlBarParent.Localization)

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)
local useLocalization = Localization.Hooks.useLocalization
local useHoverBinding = require(AvatarExperienceControlBar.Hooks.useHoverBinding)

local ColorItem = require(AvatarExperienceControlBar.Components.Items.ColorItem)

return (React.forwardRef(function(tbl1, ref)
    local var1 = useSemanticTokens()
    local var2, onStateChanged = useHoverBinding()
    local offset = if tbl1.radius then tbl1.radius else var1.defaultIconTextButtonRadius
    local var4 = useLocalization({ text = tbl1.localizedTextKey })
    local text = if var4.text then var4.text else tbl1.text

    return React.createElement(Foundation.View, {
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.disabled,
        tag = "auto-xy size-full-0 clip row gap-xsmall items-center",
        ref = ref,
        onStateChanged = onStateChanged,
        backgroundStyle = var2:map(function(arg1)
            return {
                Color3 = var1.hoverIconBackgroundStyle.Color3,
                Transparency = if arg1 then var1.hoverIconBackgroundStyle.Transparency else 1
            }
        end),
        padding = {
            left = UDim.new(0, var1.textButtonPaddingLeft),
            right = UDim.new(0, var1.textButtonPaddingRight),
            top = UDim.new(0, var1.textButtonPaddingY),
            bottom = UDim.new(0, var1.textButtonPaddingY)
        },
        cornerRadius = UDim.new(0, offset),
        Visible = tbl1.Visible,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Color = React.createElement(ColorItem, {
            colors = tbl1.colors,
            size = tbl1.size,
            colorSize = tbl1.colorSize,
            disabled = true,
            onActivated = tbl1.onActivated,
            Selectable = false
        }),
        Text = React.createElement(Foundation.Text, { Text = text, tag = "auto-xy text-title-medium content-emphasis" })
    })
end))
