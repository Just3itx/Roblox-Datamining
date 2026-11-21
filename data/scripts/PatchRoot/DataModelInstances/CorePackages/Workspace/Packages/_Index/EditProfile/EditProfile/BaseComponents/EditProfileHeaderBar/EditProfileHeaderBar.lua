-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent

local React = require(EditProfileParent.React)

local Foundation = require(EditProfileParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens

local function EditProfileHeaderBar(tbl1)
    local var1 = useTokens()
    return React.createElement(View, {
        tag = "row flex-between align-y-center gap-small size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge",
        padding = {
            top = UDim.new(0, var1.Margin.Large)
        }
    }, {
        HeaderBar = React.createElement(View, {
            tag = "row align-y-center size-0-1800 auto-x gap-small"
        }, {
            BackButton = React.createElement(IconButton, {
                icon = IconName.ChevronLargeLeft,
                size = IconSize.Medium,
                variant = ButtonVariant.Utility,
                onActivated = tbl1.onClose,
                isCircular = true,
                LayoutOrder = 1
            }),
            HeaderText = React.createElement(FoundationText, { tag = "text-heading-small auto-xy", Text = tbl1.headerText, LayoutOrder = 2 })
        }),
        SaveButton = if tbl1.onSave then React.createElement(IconButton, {
            icon = IconName.CheckLarge,
            size = IconSize.Medium,
            variant = ButtonVariant.Utility,
            onActivated = tbl1.onSave,
            isDisabled = tbl1.isLoading or tbl1.isDisabled == true,
            isCircular = true
        }) else nil
    })
end

return EditProfileHeaderBar
