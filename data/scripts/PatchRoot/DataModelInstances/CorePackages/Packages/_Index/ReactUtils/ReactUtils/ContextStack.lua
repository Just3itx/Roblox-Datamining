-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function ContextStack(tbl1)
    local children = tbl1.children

    for i = #tbl1.providers, 1, -1 do
        local provider = tbl1.providers[i]
        children = React.cloneElement(provider, nil, children)
    end

    return children
end

return ContextStack
