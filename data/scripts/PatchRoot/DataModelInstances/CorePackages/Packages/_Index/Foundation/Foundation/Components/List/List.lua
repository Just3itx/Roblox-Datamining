-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _InputSize = require(Foundation.Enums.InputSize)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local ListContext = require(script.Parent.ListContext)

local tbl1 = {
    hasDivider = { hasDivider = true, isInset = true },
    isContained = { isContained = false, hasMargin = true },
    testId = "--foundation-list"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: List
    local var1 = withDefaults(arg1, tbl1)

    local hasDivider = if type(var1.hasDivider) == "boolean" then var1.hasDivider else var1.hasDivider.hasDivider
    local num1 = 0
    if hasDivider then
        React.Children.forEach(var1.children, function(arg2)
            if arg2 and arg2.props and arg2.props.LayoutOrder then
                num1 = math.max(num1, arg2.props.LayoutOrder)
            end
        end)
    end

    local isContained = if type(var1.isContained) == "boolean" then var1.isContained else var1.isContained.isContained
    local var2 = if isContained then true else type(var1.isContained) ~= "table" or var1.isContained.hasMargin
    local isInset = if type(var1.hasDivider) == "boolean" then var1.hasDivider else var1.hasDivider.isInset

    local value = React.useMemo(function()
        return {
            hasDivider = var1.hasDivider,
            isContained = isContained,
            isInset = isInset,
            hasMargin = var2,
            lastLayoutOrder = num1,
            size = var1.size,
            testId = var1.testId
        }
    end, {
        hasDivider,
        isContained,
        isInset,
        var2,
        num1,
        var1.size,
        var1.testId
    })

    return React.createElement(
        View,
        withCommonProps(
            var1,
            {
                tag = {
                    ["col size-full-0 auto-y"] = true,
                    ["stroke-default radius-large"] = isContained
                },
                ref = ref
            }
        ),
        {
            ListContext = React.createElement(ListContext.Provider, { value = value }, var1.children)
        }
    )
end))
