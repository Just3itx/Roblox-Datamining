-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SongbirdParent = script:FindFirstAncestor("Songbird").Parent

local React = require(SongbirdParent.React)
local Foundation = require(SongbirdParent.Foundation)

local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local Icon = Foundation.Icon
local View = Foundation.View
local FoundationText = Foundation.Text
local withDefaults = Foundation.Utility.withDefaults
local withCommonProps = Foundation.Utility.withCommonProps

local IconSize = Foundation.Enums.IconSize
local IconPosition = Foundation.Enums.IconPosition
local StateLayerMode = Foundation.Enums.StateLayerMode
local CursorType = Foundation.Enums.CursorType

local tbl1 = { isDisabled = false, isChecked = false }

return React.memo(React.forwardRef(function(arg1, ref) -- name: Chip
    local var1 = withDefaults(arg1, tbl1)

    local var2 = useTokens()
    local selectionImageObject = useCursor(CursorType.SmallPill)

    local var4 = React.useMemo(function()
        return if typeof(var1.icon) == "string" then {
            name = var1.icon,
            position = IconPosition.Left
        } else var1.icon
    end, { var1.icon })

    local var5 = if var1.isChecked then var2.Color.ActionSubEmphasis.Foreground else var2.Color.Content.Emphasis
    return React.createElement(
        View,
        withCommonProps(var1, {
            GroupTransparency = if var1.isDisabled then 0.5 else nil,
            selection = {
                Selectable = not var1.isDisabled,
                SelectionImageObject = selectionImageObject
            },
            onActivated = var1.onActivated,
            isDisabled = var1.isDisabled,
            stateLayer = {
                mode = StateLayerMode.Inverse
            },
            tag = {
                ["row gap-xsmall size-0-800 padding-medium auto-x align-y-center align-x-center clip radius-circle"] = true,
                ["bg-action-sub-emphasis"] = var1.isChecked,
                ["bg-shift-200"] = not var1.isChecked
            },
            ref = ref
        }),
        {
            Icon = if var4 then React.createElement(Icon, {
                name = var4.name,
                size = IconSize.Small,
                style = var5,
                LayoutOrder = if var4.position == IconPosition.Left then 1 else 3
            }) else nil,
            Text = if var1.text and var1.text ~= "" then React.createElement(FoundationText, {
                Text = var1.text,
                textStyle = var5,
                LayoutOrder = 2,
                tag = "auto-x size-0-full shrink text-caption-large text-truncate-end"
            }) else nil
        }
    )
end))
