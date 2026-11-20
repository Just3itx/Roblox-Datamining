-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local AccordionContext = require(script.Parent.AccordionContext)
local _useAccordion = require(script.Parent.useAccordion)

local InputPlacement = require(Foundation.Enums.InputPlacement)
local InputSize = require(Foundation.Enums.InputSize)

local tbl1 = {
    chevronPosition = InputPlacement.End,
    isContained = false,
    size = InputSize.Medium,
    width = UDim.new(1, 0),
    testId = "--foundation-accordion"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Accordion
    local var1 = withDefaults(arg1, tbl1)

    local value = React.useMemo(function()
        return {
            onAccordionItemActivated = var1.onActivated,
            itemSize = var1.size,
            isContained = var1.isContained,
            chevronPosition = var1.chevronPosition,
            testId = var1.testId
        }
    end, {
        var1.onActivated,
        var1.size,
        var1.isContained,
        var1.chevronPosition,
        var1.testId
    })

    return React.createElement(
        View,
        withCommonProps(var1, { tag = "col flex-y-evenly auto-y", Size = UDim2.new(var1.width, UDim.new(0, 0)), ref = ref }),
        {
            AccordionContext = React.createElement(AccordionContext.Provider, { value = value }, var1.children)
        }
    )
end))
