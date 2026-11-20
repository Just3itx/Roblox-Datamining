-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCallParent = script:FindFirstAncestor("RoduxCall").Parent
local Rodux = require(RoduxCallParent.Rodux)

local currentCall = require(script.currentCall)
local suggestedCallees = require(script.suggestedCallees)

return function(arg1)
    return Rodux.combineReducers({ currentCall = currentCall(), suggestedCallees = suggestedCallees(arg1) })
end
