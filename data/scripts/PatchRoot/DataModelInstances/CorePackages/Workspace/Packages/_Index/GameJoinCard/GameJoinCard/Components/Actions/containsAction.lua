-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local _DataHydration = require(GameJoinCardParent.DataHydration)

local function containsAction(arg1, type: string)
    if arg1 == nil or arg1.actions == nil then
        return false
    end
    for _, action in arg1.actions do
        if action.type == type then
            return true
        end
    end
    return false
end

return containsAction
