-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getGridSizeTag = require(Foundation.Utility.getGridSizeTag)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { size = 1, testId = "--foundation-grid--cell" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: GridCell
    local var1 = withDefaults(arg1, tbl1)
    local var2 = Dash.omit(var1, { "size" })

    local var3 = React.useMemo(function()
        return getGridSizeTag(var1.size)
    end, { var1.size })

    return React.createElement(View, Dash.assign(var2, { tag = table.concat({ var3, var1.tag }, " "), ref = ref }), var1.children)
end))
