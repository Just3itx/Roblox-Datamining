-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

return React.memo(React.forwardRef(function(tbl1, _) -- name: Scrim
    local scrim = useTokens().Color.Common.Scrim

    return React.createElement(
        View,
        {
            tag = "size-full",
            backgroundStyle = scrim,
            Visible = tbl1 and tbl1.Visible,
            ZIndex = tbl1 and tbl1.ZIndex
        }
    )
end))
