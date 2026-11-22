-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local FFlagMomentsTextOverlayColorPickerIcon = require(MomentsCreation.Flags.FFlagMomentsTextOverlayColorPickerIcon)

local Image = Foundation.Image
local IconButton = Foundation.IconButton
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function TextColorButton(tbl1)
    local var1 = useTokens()

    if not FFlagMomentsTextOverlayColorPickerIcon then
        return React.createElement(View, {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "auto-xy radius-circle"
        }, {
            Icon = React.createElement(IconButton, {
                icon = BuilderIcons.Icon.PaintBucket,
                onActivated = tbl1.onToggle,
                size = Foundation.Enums.InputSize.Medium,
                isCircular = true
            }),
            Highlight = if tbl1.expanded then React.createElement(View, { ZIndex = 2, tag = "size-full radius-circle", backgroundStyle = var1.Color.State.Hover }) else nil
        })
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
        tag = "radius-circle",
        onActivated = tbl1.onToggle,
        cursor = {
            radius = UDim.new(0, var1.Radius.Circle),
            offset = var1.Size.Size_150,
            borderWidth = var1.Stroke.Thicker
        }
    }, {
        Highlight = if tbl1.expanded then React.createElement(View, { ZIndex = 1, tag = "size-full radius-circle", backgroundStyle = var1.Color.State.Hover }) else nil,
        Icon = React.createElement(Image, {
            ZIndex = 2,
            Image = "rbxasset://textures/ui/Moments/text-color-picker.png",
            Size = UDim2.fromOffset(var1.Size.Size_600, var1.Size.Size_600),
            tag = "position-center-center anchor-center-center"
        })
    })
end

return TextColorButton
