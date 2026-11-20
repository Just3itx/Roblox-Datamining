-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

return React.memo(function(tbl1) -- name: StyleRule
    local ref = React.useCallback(function(arg1)
        if arg1 ~= nil then
            arg1:SetProperties(tbl1.properties)
        end
    end, { tbl1.properties })

    return React.createElement("StyleRule", { Priority = tbl1.Priority or 1, Selector = tbl1.Selector, ref = ref })
end)
