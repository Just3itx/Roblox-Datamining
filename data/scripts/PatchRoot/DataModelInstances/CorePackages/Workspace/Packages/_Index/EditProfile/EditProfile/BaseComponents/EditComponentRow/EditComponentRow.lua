-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent

local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function EditComponentRow(tbl1)
    local var1 = useTokens()
    local var2 = string.gsub(tbl1.currentValue, "\n", " ")

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "row size-full-1100 padding-medium align-y-center flex-x-between gap-medium",
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onActivated,
        ref = tbl1.forwardRef
    }
    local tbl3 = {
        TitleText = React.createElement(
            FoundationText,
            {
                tag = "text-title-medium content-emphasis auto-xy",
                Text = tbl1.label,
                LayoutOrder = 1
            }
        ),
        EditButton = 0
    }
    local element

    if tbl1.shouldShimmer then
        element = React.createElement(
            Skeleton,
            {
                LayoutOrder = 3,
                Size = UDim2.new(0.3, 0, 0, var1.Size.Size_400),
                radius = Radius.Medium
            }
        )
    else
        element = React.createElement(
            View,
            {
                tag = "row size-0-full fill align-y-center align-x-right gap-xsmall",
                LayoutOrder = 2
            },
            {
                CurrentText = React.createElement(
                    View,
                    { tag = "row size-0-full fill align-y-center align-x-right", LayoutOrder = 1 },
                    { React.createElement(FoundationText, { tag = "text-body-small text-truncate-end size-0-full auto-x", Text = var2 }) }
                ),
                EditIcon = React.createElement(Icon, { name = IconName.ChevronLargeRight, size = IconSize.Medium, LayoutOrder = 2 })
            }
        )
    end

    tbl3.EditButton = element
    return createElement(var3, tbl2, tbl3)
end

return EditComponentRow
