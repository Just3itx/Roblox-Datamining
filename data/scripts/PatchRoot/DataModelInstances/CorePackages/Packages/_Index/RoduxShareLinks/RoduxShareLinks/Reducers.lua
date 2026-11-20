-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxShareLinksParent = script:FindFirstAncestor("RoduxShareLinks").Parent
local Rodux = require(RoduxShareLinksParent.Rodux)

local Invites = require(script.Invites)

return function(arg1)
    return Rodux.combineReducers({ Invites = Invites(arg1) })
end
