-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)

local Components = Foundation.Components
local InternalInput = require(Components.InternalInput)
local Knob = require(Components.Knob)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local _Types = require(Components.Types)
local useUncontrolledState = require(Components.InternalInput.useUncontrolledState)

local BuilderIcons = require(FoundationParent.BuilderIcons)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local _ControlState = require(Foundation.Enums.ControlState)

local useToggleVariants = require(script.Parent.useToggleVariants)

local InputSize = require(Foundation.Enums.InputSize)

local _InputLabelSize = require(Foundation.Enums.InputLabelSize)

local InputPlacement = require(Foundation.Enums.InputPlacement)

local useInputGroupDefaults = require(Components.InternalInputGroup.useInputGroupDefaults)

local tbl1 = { frequency = 4 }

local tbl2 = {
    size = InputSize.Medium,
    placement = InputPlacement.Start,
    Selectable = true,
    testId = "--foundation-toggle"
}

local value = {
    colorNamespace = ColorNamespace.Color
}
return React.memo(React.forwardRef(function(arg1, ref) -- name: Toggle
    local var1 = useInputGroupDefaults(arg1, tbl2)
    local var2 = useTokens()
    local var3 = useToggleVariants(var2, var1.size)
    local isChecked, onActivated = useUncontrolledState(var1.isChecked, var1.onActivated)
    local size = if var1.size == InputSize.Large then InputSize.Medium else var1.size
    local num1 = if isChecked then 1 else 0
    local var7, var8 = React.useBinding(num1)
    local var9 = React.useRef(nil)

    local var10 = var7:map(function(arg2)
        return var3.knob.offPosition:Lerp(var3.knob.onPosition, arg2)
    end)

    React.useEffect(function()
        local current = Otter.createSingleMotor(num1)
        var9.current = current
        current:start()

        current:onStep(function(arg2)
            var8(arg2)
        end)

        return function()
            current:destroy()
        end
    end, {})

    React.useEffect(function()
        local num2 = if isChecked then 1 else 0
        if var9.current then
            var9.current:setGoal(Otter.spring(num2, tbl1))
        end
    end, { isChecked })

    return React.createElement(
        InternalInput,
        withCommonProps(var1, {
            isChecked = isChecked,
            isDisabled = var1.isDisabled,
            onActivated = onActivated,
            label = {
                text = var1.label,
                position = Constants.INPUT_PLACEMENT_TO_LABEL_ALIGNMENT[var1.placement],
                hint = var1.hint
            },
            customVariantProps = var3.input,
            size = var1.size,
            Selectable = var1.Selectable,
            NextSelectionUp = var1.NextSelectionUp,
            NextSelectionDown = var1.NextSelectionDown,
            NextSelectionLeft = var1.NextSelectionLeft,
            NextSelectionRight = var1.NextSelectionRight,
            ref = ref
        }),
        React.createElement(PresentationContext.Provider, { value = value }, {
            Knob = React.createElement(Knob, {
                size = size,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = var10,
                hasShadow = false,
                icon = isChecked and {
                    name = BuilderIcons.Icon.Check,
                    variant = BuilderIcons.IconVariant.Regular
                } or nil,
                testId = `{var1.testId}--knob`
            })
        })
    )
end))
