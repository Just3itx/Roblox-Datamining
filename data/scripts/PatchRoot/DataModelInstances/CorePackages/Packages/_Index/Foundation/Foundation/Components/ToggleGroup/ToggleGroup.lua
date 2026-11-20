-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local InternalInputGroup = require(Foundation.Components.InternalInputGroup)
local _Types = require(Foundation.Components.Types)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-toggle-group" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: ToggleGroup
    local var1 = withDefaults(arg1, tbl1)

    return React.createElement(
        InternalInputGroup,
        withCommonProps(var1, { legend = var1.legend, size = var1.size, placement = var1.placement, ref = ref }),
        var1.children
    )
end))
