-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local IconVariant = require(FoundationParent.BuilderIcons).IconVariant

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Accessory = require(script.Parent.Accessory)

local IconPosition = require(Foundation.Enums.IconPosition)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local StateLayerMode = require(Foundation.Enums.StateLayerMode)

local _CursorType = require(Foundation.Enums.CursorType)

local ChipSize = require(Foundation.Enums.ChipSize)

local ChipVariant = require(Foundation.Enums.ChipVariant)

local useChipVariants = require(script.Parent.useChipVariants)

local tbl1 = {
    isChecked = false,
    Selectable = true,
    isDisabled = false,
    size = ChipSize.Medium,
    variant = ChipVariant.Standard,
    testId = "--foundation-chip"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Chip
    local var1 = withDefaults(arg1, tbl1)

    local var2 = useTokens()
    local config, var3 = React.useMemo(function()
        local leading = var1.leading
        local trailing = var1.trailing

        if var1.icon ~= nil then
            if typeof(var1.icon) == "string" then
                leading = {
                    iconName = var1.icon
                }
            else
                local tbl2 = {
                    iconName = var1.icon.name
                }
                if var1.icon.position == IconPosition.Left then
                    leading = tbl2
                else
                    trailing = tbl2
                end
            end
        end

        if typeof(leading) == "table" and leading.isCircular then
            leading.iconVariant = IconVariant.Filled
        end
        if typeof(trailing) == "table" and trailing.isCircular then
            trailing.iconVariant = IconVariant.Filled
        end

        return leading, trailing
    end, { var1.leading, var1.icon, var1.trailing })

    local bool1 = not (var1.text == nil) and var1.text ~= ""
    local isIconOnly = if Flags.FoundationFixChipAccessoryLayout then not bool1 and config == nil ~= (var3 == nil) else nil
    local var5 = useChipVariants(var2, var1.size, var1.variant, var1.isChecked, config ~= nil, var3 ~= nil)
    local borderWidth = math.floor(var2.Stroke.Thicker)

    local value = React.useMemo(function()
        return {
            colorNamespace = if var1.isChecked then ColorNamespace.Inverse else ColorNamespace.Color,
            isIconSize = true
        }
    end, { var1.isChecked })

    local createElement = React.createElement
    local var7 = View
    local var8 = withCommonProps
    local tbl2 = {
        isDisabled = var1.isDisabled,
        selection = {
            Selectable = not var1.isDisabled and var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var1.NextSelectionRight
        },
        onActivated = var1.onActivated,
        stateLayer = var1.isChecked and {
            mode = StateLayerMode.Inverse
        } or nil,
        backgroundStyle = var5.chip.backgroundStyle,
        padding = var5.chip.padding,
        cursor = {
            radius = UDim.new(0, var2.Radius.Circle),
            offset = borderWidth * 2,
            borderWidth = borderWidth
        },
        tag = var5.chip.tag,
        ref = ref,
        GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else 0
    }
    return createElement(
        var7,
        var8(var1, tbl2),
        React.createElement(PresentationContext.Provider, { value = value }, {
            Leading = if config then React.createElement(Accessory, {
                isLeading = true,
                config = config,
                size = var1.size,
                chipBackgroundStyle = var5.chip.backgroundStyle,
                contentStyle = var5.text.contentStyle,
                isDisabled = var1.isDisabled,
                isIconOnly = isIconOnly,
                testId = `{var1.testId}--leading-accessory`
            }) else nil,
            Text = if bool1 then React.createElement(Text, {
                Text = var1.text,
                textStyle = var5.text.contentStyle,
                LayoutOrder = 2,
                tag = var5.text.tag,
                padding = var5.text.padding,
                testId = `{var1.testId}--text`
            }) else nil,
            Trailing = if var3 then React.createElement(Accessory, {
                isLeading = false,
                config = var3,
                size = var1.size,
                chipBackgroundStyle = var5.chip.backgroundStyle,
                contentStyle = var5.text.contentStyle,
                isDisabled = var1.isDisabled,
                isIconOnly = isIconOnly,
                testId = `{var1.testId}--trailing-accessory`
            }) else nil
        })
    )
end))
