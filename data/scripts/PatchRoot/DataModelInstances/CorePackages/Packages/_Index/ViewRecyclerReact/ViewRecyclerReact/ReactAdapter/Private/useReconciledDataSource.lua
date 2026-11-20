-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local DataSource = require(ViewRecyclerReact.Parent.ViewRecycler).DataSource
local React = require(ViewRecyclerReact.Parent.React)

local function useReconciledDataSource<T>(tbl1, arg1: T): T
    local var1 = React.useState(function()
        return DataSource.sequence(FFlagViewRecyclerReact084 and (tbl1 or {}) or tbl1, arg1)
    end)
    local var2 = React.useRef(nil)
    if var2.current == nil then
        var2.current = table.clone(FFlagViewRecyclerReact084 and not tbl1 and {} or tbl1)
    end

    React.useLayoutEffect(function()
        if FFlagViewRecyclerReact084 and (tbl1 == nil or arg1 == nil) then
            return
        end

        DataSource.reconcileSnapshot(var1, var2.current, tbl1, arg1)
        var2.current = table.clone(tbl1)
    end, { var1, tbl1, arg1 })

    return var1
end

return useReconciledDataSource
