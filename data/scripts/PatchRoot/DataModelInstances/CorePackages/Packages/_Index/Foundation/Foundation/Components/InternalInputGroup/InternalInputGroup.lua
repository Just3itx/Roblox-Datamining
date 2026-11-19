-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Components = Foundation.Components
local Text = require(Components.Text)
local _Types = require(Components.Types)
local View = require(Components.View)

local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputPlacement = require(Foundation.Enums.InputPlacement)
local InputSize = require(Foundation.Enums.InputSize)

local InputGroupContext = require(script.Parent.InputGroupContext)
local useInputGroupVariants = require(script.Parent.useInputGroupVariants)

local tbl1 = {
    size = InputSize.Medium,
    placement = InputPlacement.Start,
    testId = "--foundation-internal-input-group"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalInputGroup
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useInputGroupVariants(var2, var1.size)

    local value = React.useMemo(function()
        return {
            size = var1.size,
            placement = var1.placement
        }
    end, { var1.size, var1.placement })

    local createElement = React.createElement
    local var5 = View
    local var6 = withCommonProps(var1, { tag = var3.container.tag, ref = ref })

    local tbl2 = {
        InputGroupContext = React.createElement(InputGroupContext.Provider, { value = value }, {
            GroupLabel = if var1.legend == nil or var1.legend == "" then nil else React.createElement(
                Text,
                {
                    Text = var1.legend,
                    tag = var3.legend.tag,
                    testId = `{var1.testId}--label`,
                    LayoutOrder = 0
                }
            ),
            Children = React.createElement(View, { tag = var3.children.tag, LayoutOrder = 1 }, var1.children)
        })
    }
    return createElement(var5, var6, tbl2)
end))
