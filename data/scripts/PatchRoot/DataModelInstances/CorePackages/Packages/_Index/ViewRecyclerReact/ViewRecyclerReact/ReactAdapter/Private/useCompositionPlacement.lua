-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local CompositionPlacement = require(ViewRecyclerReact.ReactAdapter.Private.CompositionPlacement)
local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local React = require(ViewRecyclerReact.Parent.React)
local _RecyclingRoot = require(script.Parent.RecyclingRoot)

local function useCompositionPlacement(arg1, maxPoolSize: number?, diagnostics)
    local var1 = React.useState(function()
        local scope = arg1.getScope({ maxPoolSize = maxPoolSize, diagnostics = diagnostics })

        return CompositionPlacement.new(scope)
    end)

    React.useLayoutEffect(function()
        return function()
            var1.destroy()
        end
    end, { var1 })

    return var1
end

return useCompositionPlacement
