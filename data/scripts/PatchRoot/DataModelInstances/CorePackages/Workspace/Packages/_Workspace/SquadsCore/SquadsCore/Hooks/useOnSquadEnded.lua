-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local useCurrentSquadId = require(SquadsCore.Hooks.useCurrentSquadId)

local React = require(SquadsCoreParent.React)
local usePrevious = require(SquadsCoreParent.RoactUtils).Hooks.usePrevious

return function(callback: ((...any) -> (...any))?)
    local var1 = useCurrentSquadId() or ""
    local var2 = usePrevious(var1) or ""
    React.useEffect(function()
        if var1 ~= var2 and var2 ~= "" and callback then
            callback()
        end
    end, { var1, callback })
end
