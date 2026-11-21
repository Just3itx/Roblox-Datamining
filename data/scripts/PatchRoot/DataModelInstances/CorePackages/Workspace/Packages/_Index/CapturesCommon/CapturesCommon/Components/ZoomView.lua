-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local View = Foundation.View

local useZoomController = require(scriptParentParent.Hooks.useZoomController)

return function(tbl1)
    local var1 = tbl1.active == nil or tbl1.active

    local var2, ref = useZoomController(var1)

    React.useEffect(function()
        if tbl1.onZoomStatusChanged then
            tbl1.onZoomStatusChanged(var2)
        end
    end, { var2, tbl1.onZoomStatusChanged })

    return React.createElement(
        View,
        {
            ref = ref,
            tag = "anchor-center-center position-center-center size-full bg-action-subtle",
            ZIndex = 1
        },
        {
            ZoomItem = React.createElement(React.Fragment, nil, tbl1.children)
        }
    )
end
