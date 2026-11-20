-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InternalInputGroup = require(Foundation.Components.InternalInputGroup)
local RadioGroupContext = require(script.Parent.RadioGroupContext)

local InputSize = require(Foundation.Enums.InputSize)

local InputPlacement = require(Foundation.Enums.InputPlacement)

local tbl1 = {
    size = InputSize.Medium,
    placement = InputPlacement.Start,
    Selectable = true,
    testId = "--foundation-radio-group"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: RadioGroup
    local var1 = withDefaults(arg1, tbl1)
    local value, var3 = React.useState(var1.value)

    React.useEffect(function()
        if var1.value ~= nil then
            var3(var1.value)
        end
    end, { var1.value })

    local onValueChanged = React.useCallback(function(str1: string)
        var3(str1)
        var1.onValueChanged(str1)
    end, { var3, var1.onValueChanged })

    local var2 = React.useMemo(function()
        return {
            value = value,
            onValueChanged = onValueChanged,
            Selectable = var1.Selectable,
            testId = var1.testId
        }
    end, {
        value,
        onValueChanged,
        var1.Selectable,
        var1.testId
    })

    return (React.createElement(
        InternalInputGroup,
        withCommonProps(var1, { size = var1.size, placement = var1.placement, legend = var1.legend, ref = ref }),
        {
            RadioGroupContext = React.createElement(RadioGroupContext.Provider, { value = var2 }, var1.children)
        }
    ))
end))
