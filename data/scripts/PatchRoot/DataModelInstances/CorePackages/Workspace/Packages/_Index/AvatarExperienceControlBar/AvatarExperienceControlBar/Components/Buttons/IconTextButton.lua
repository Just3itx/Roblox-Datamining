-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:10Z
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

local isBuilderIcon = Foundation.Utility.isBuilderIcon

local FFlagAXMigrateBuilderIcons = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons
local FFlagAXResetAvatarButton = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXResetAvatarButton

return (React.forwardRef(function(tbl1, ref)
    local var1 = useSemanticTokens()
    local var2, onStateChanged = useHoverBinding()
    local offset = if tbl1.radius then tbl1.radius else var1.defaultIconTextButtonRadius
    local var4 = useLocalization({ text = tbl1.localizedTextKey })
    local text = if var4.text then var4.text else tbl1.text
    local size = if tbl1.iconSize then tbl1.iconSize else var1.defaultIconSize
    local var6 = FFlagAXMigrateBuilderIcons and isBuilderIcon(tbl1.icon)

    local createElement = React.createElement
    local view = Foundation.View

    local tbl2 = {
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.disabled,
        tag = "auto-xy size-full-0 clip row gap-xsmall items-center",
        ref = ref,
        onStateChanged = onStateChanged,
        GroupTransparency = if FFlagAXResetAvatarButton then if tbl1.disabled then var1.contentDisabledTransparency else var1.contentForegroundStyle.Transparency else nil,
        backgroundStyle = var2:map(function(arg1)
            return {
                Color3 = var1.hoverIconBackgroundStyle.Color3,
                Transparency = if arg1 then var1.hoverIconBackgroundStyle.Transparency else 1
            }
        end),
        cornerRadius = UDim.new(0, offset),
        padding = {
            left = UDim.new(0, var1.textButtonPaddingLeft),
            right = UDim.new(0, var1.textButtonPaddingRight),
            top = UDim.new(0, var1.textButtonPaddingY),
            bottom = UDim.new(0, var1.textButtonPaddingY)
        },
        Visible = tbl1.Visible,
        LayoutOrder = tbl1.LayoutOrder
    }

    local tbl3 = { Icon = 0, Text = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Size = UDim2.new(0, var1.iconTextButtonIconContainerSize, 0, var1.iconTextButtonIconContainerSize),
        tag = FFlagAXMigrateBuilderIcons and {
            ["radius-circle"] = true,
            ["row align-x-center align-y-center"] = var6
        }
            or "radius-circle"
    }

    local tbl5 = { IconImage = 0 }
    local element

    if var6 then
        element = React.createElement(Foundation.Icon, {
            tag = "position-center-center anchor-center-center",
            name = tbl1.icon,
            size = size,
            style = var1.contentForegroundStyle
        })
    else
        element = React.createElement(Foundation.Image, {
            tag = "position-center-center anchor-center-center",
            Image = tbl1.icon,
            Size = UDim2.new(0, size, 0, size),
            imageStyle = var1.contentForegroundStyle
        })
    end

    tbl5.IconImage = element
    tbl3.Icon = createElement2(view2, tbl4, tbl5)

    tbl3.Text = React.createElement(Foundation.Text, { Text = text, tag = "auto-xy text-title-medium content-emphasis" })
    return createElement(view, tbl2, tbl3)
end))
