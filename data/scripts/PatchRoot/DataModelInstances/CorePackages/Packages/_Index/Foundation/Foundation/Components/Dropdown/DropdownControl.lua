-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local _BaseMenu = require(Components.BaseMenu)
local View = require(Components.View)

local Constants = require(Foundation.Constants)
local Icon = require(Components.Icon)
local InputField = require(Components.InputField)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local Text = require(Components.Text)
local _Types = require(Foundation.Components.Types)

local blendTransparencies = require(Foundation.Utility.blendTransparencies)
local getInputTextSize = require(Foundation.Utility.getInputTextSize)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useDropdownVariants = require(script.Parent.useDropdownVariants)

local ControlState = require(Foundation.Enums.ControlState)

local _CursorType = require(Foundation.Enums.CursorType)

local _InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local BuilderIcons = require(FoundationParent.BuilderIcons)
local ChevronLargeUp = BuilderIcons.Icon.ChevronLargeUp
local ChevronLargeDown = BuilderIcons.Icon.ChevronLargeDown

local tbl1 = {
    variant = InputVariant.Standard,
    isMenuOpen = false,
    placeholder = "",
    Selectable = true
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: DropdownControl
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3, onStateChanged = React.useState(ControlState.Initialize)
    local bool1 = var1.item == nil
    local var5 = useDropdownVariants(
        var2,
        var1.size,
        var1.variant,
        var3,
        bool1,
        var1.hasError or false,
        var1.isMenuOpen,
        var3 == ControlState.Hover
    )

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var2.Radius.Small),
            offset = var2.Size.Size_200,
            borderWidth = var2.Stroke.Thicker
        }
    end, { var2 })

    return React.createElement(
        InputField,
        withCommonProps(var1, {
            size = getInputTextSize(var1.size),
            hasError = var1.hasError,
            isDisabled = var1.isDisabled,
            label = var1.label,
            hint = var1.hint,
            ref = ref,
            width = var1.width,
            input = function(_)
                local createElement = React.createElement
                local var7 = View
                local tbl2 = {
                    onStateChanged = onStateChanged,
                    isDisabled = var1.isDisabled,
                    onActivated = var1.onActivated,
                    selection = {
                        Selectable = not var1.isDisabled and var1.Selectable,
                        NextSelectionUp = var1.NextSelectionUp,
                        NextSelectionDown = var1.NextSelectionDown,
                        NextSelectionLeft = var1.NextSelectionLeft,
                        NextSelectionRight = var1.NextSelectionRight
                    },
                    cursor = cursor,
                    stateLayer = {
                        affordance = StateLayerAffordance.None
                    },
                    backgroundStyle = if var5.container.bgStyle then {
                        Color3 = var5.container.bgStyle.Color3,
                        Transparency = if var1.isDisabled then blendTransparencies(var5.container.bgStyle.Transparency, Constants.DISABLED_TRANSPARENCY) else var5.container.bgStyle.Transparency
                    } else nil,
                    stroke = 0,
                    tag = 0,
                    ref = 0,
                    testId = 0
                }
                local tbl4

                if var5.container.strokeStyle then
                    tbl4 = {
                        Color = var5.container.strokeStyle.Color3,
                        Transparency = if var1.isDisabled then blendTransparencies(var5.container.strokeStyle.Transparency, Constants.DISABLED_TRANSPARENCY) else var5.container.strokeStyle.Transparency,
                        Thickness = var5.container.strokeThickness,
                        BorderStrokePosition = Enum.BorderStrokePosition.Inner
                    }
                else
                    tbl4 = nil
                end

                tbl2.stroke = tbl4

                tbl2.tag = var5.container.tag
                tbl2.ref = var1.inputRef
                tbl2.testId = `{var1.testId}--control`
                local tbl5 = {
                    Text = React.createElement(
                        Text,
                        {
                            LayoutOrder = 1,
                            Text = if var1.item then var1.item.text else var1.placeholder,
                            tag = var5.text.tag
                        }
                    ),
                    Arrow = React.createElement(Icon, {
                        LayoutOrder = 2,
                        name = if var1.isMenuOpen then ChevronLargeUp else ChevronLargeDown,
                        size = var5.arrow.size,
                        style = if var1.isDisabled then var2.Color.Content.Muted else nil,
                        tag = var5.text.tag,
                        testId = `{var1.testId}--arrow`
                    })
                }
                return createElement(var7, tbl2, tbl5)
            end
        })
    )
end))
