-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local Foundation = require(AvatarExperienceSlotBasedEditorParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local Constants = require(script.Parent.Parent.Constants)
local FoundationText = Foundation.Text

local FFlagAXMigrateBuilderIcons = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons

local function ClearCategoryButton(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = tbl1.Size or UDim2.fromOffset(var1.Size.Size_2500, var1.Size.Size_2500),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, -var1.Padding.XSmall)
        }),
        Icon = React.createElement(Icon, {
            name = if FFlagAXMigrateBuilderIcons then Constants.Icons.Reset.name else Constants.Icons.Reset,
            variant = if FFlagAXMigrateBuilderIcons then Constants.Icons.Reset.variant else nil,
            size = IconSize.Medium,
            style = {
                Color3 = var1.Color.Content.Muted.Color3,
                Transparency = 0
            }
        }),
        Text = 0
    }
    local element

    if tbl1.text then
        element = React.createElement(FoundationText, {
            Size = tbl1.textStyles and tbl1.textStyles.Size or UDim2.fromScale(1, 0),
            Text = tbl1.text,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            fontStyle = tbl1.textStyles and tbl1.textStyles.fontStyle or var1.Typography.CaptionMedium,
            padding = UDim.new(0, var1.Padding.Small)
        })
    else
        element = nil
    end

    tbl4.Text = element
    return createElement(str1, tbl2, { createElement2(str2, tbl3, tbl4) })
end

return ClearCategoryButton
