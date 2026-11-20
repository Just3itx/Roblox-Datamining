-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local React = require(ViewRecyclerReact.Parent.React)
local RecyclingScopeContext = require(script.Parent.RecyclingScopeContext)

local function useRecyclingScope(str1: string)
    local var1 = React.useContext(RecyclingScopeContext)
    assert(var1 ~= nil, `{str1} requires a RecyclingScope`)
    local var2 = React.useState(function()
        return var1.getScope()
    end)
    React.useEffect(function()
        return var1.registerConsumer()
    end, { var1 })
    return var2
end

return useRecyclingScope
