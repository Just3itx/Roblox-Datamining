-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local React = require(ViewRecyclerReact.Parent.React)
local RectPlacement = require(ViewRecyclerReact.ReactAdapter.Private.RectPlacement)
local useRecyclingScope = require(ViewRecyclerReact.ReactAdapter.Private.useRecyclingScope)

local function useRectPlacement(current)
    local var1 = useRecyclingScope("useRectPlacement")
    local var2 = React.useRef(current)
    var2.current = current
    local var3 = React.useState(function()
        local rectPlacement = RectPlacement.new(var1, function()
            return var2.current
        end)
        return {
            internal = rectPlacement,
            public = table.freeze({ sync = rectPlacement.sync })
        }
    end)

    React.useLayoutEffect(function()
        return var3.internal.releaseAll
    end, { var3 })

    return var3.public
end

return useRectPlacement
